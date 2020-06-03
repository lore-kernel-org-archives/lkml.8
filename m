Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588FCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 00:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3183A206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 00:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="S8qECI/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgFCAgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 20:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgFCAgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 20:36:08 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99318C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 17:36:08 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z1so642241qtn.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 17:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZDyu11+uzJ9R+6JCcZBH8+VKsi1c+9TLG+xONMv+Rm4=;
        b=S8qECI/akVQWNTmF1OlK/qSV0xbddTynf0excoMRnoWTuQYOrMZ41fk/m6beJ1GD6+
         2RpqWdKWzZdrFPFsDxBUpUt4ZjP2keuRW9t2lsjRPs4eHHHknWj93boD4/oxb9lwkojN
         XfdQdMx4A+PXVd9ml9kyj++gVsaRL4ktNvOIWmWyNzzpx5gSTb3NdCegU+Mj65zQQisk
         CUujStwVfb4ecmDvAabeRoeUzq3a0nKH0tVHed6UP6Hh0Qr8rpHMkS/D5a4ZhfAI/AUr
         HfYHDXJf5oWzsIitW/bwP4mxd3V+Jqde2ikX3vk+0j4Q1Wez7lltlh+zS2/VaeIVA8i0
         yYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZDyu11+uzJ9R+6JCcZBH8+VKsi1c+9TLG+xONMv+Rm4=;
        b=nJrVDQtdJ06h4Z9t7SeynLXSdQOlJgF1KN4C58wCShqcnPfNx4WHqkGJiEk9/kuKM8
         DcPLAmz/6BkrLxDg9wxiZ9W4jsx0u34V16ApL48KWpDa0m05Py9xbOcsfdzQOXLfQeTt
         8t9qNT+x2o5q/AvRhOqSszl9rxGLeCHLzrhFMPug3zY7BcTc8jHzH5IBWidNP9SbhLT0
         NcbEXxPVcOcypZZDy3AJWzyltZ8zgDWcoBiMMWpvXaPzOpeoWqhycwlG7aRrYrMbhXui
         s7KTPFejoHMhCgY5Xzdgs4KYSumKEIEeKfC3Er2JrKCW2bq/02dvaDAFqSyYXzMxriDs
         74MQ==
X-Gm-Message-State: AOAM531XZc/zQMPxnwprLryq2LkNO7YDzi7t2/sUBITSNWl37AsU2MeI
        +5jTaY9rTlKdf+SoLMP/fgia4A==
X-Google-Smtp-Source: ABdhPJw+NP9vqZzh5B4ezhB8Uc90ff1uDKVcWJiS5ZWSOvk4f8fyWHsBExI+P/HHGJdm566y5qdL5g==
X-Received: by 2002:aed:3aa3:: with SMTP id o32mr31597656qte.364.1591144567614;
        Tue, 02 Jun 2020 17:36:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id m53sm530387qtb.64.2020.06.02.17.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 17:36:06 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jgHO2-000YYG-8d; Tue, 02 Jun 2020 21:36:06 -0300
Date:   Tue, 2 Jun 2020 21:36:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     mike.marciniszyn@intel.com, dennis.dalessandro@intel.com,
        dledford@redhat.com, sadanand.warrier@intel.com,
        grzegorz.andrejczuk@intel.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.carpenter@oracle.com,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] IB/hfi1: Use free_netdev() in hfi1_netdev_free()
Message-ID: <20200603003606.GA132773@ziepe.ca>
References: <20200601135644.GD4872@ziepe.ca>
 <20200602061635.31224-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602061635.31224-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 02:16:35PM +0800, YueHaibing wrote:
> dummy_netdev shold be freed by free_netdev() instead of
> kfree(). Also remove unneeded variable 'priv'
> 
> Fixes: 4730f4a6c6b2 ("IB/hfi1: Activate the dummy netdev")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> ---
>  drivers/infiniband/hw/hfi1/netdev_rx.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Applied to for-next, thanks

Jason
