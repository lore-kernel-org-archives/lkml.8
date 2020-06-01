Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DF5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA0A206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="P6RwgixO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgFAR14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgFAR1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:27:55 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41F7C08C5C9
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 10:27:55 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n11so9815408qkn.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 10:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rP96bP6VHS9TeHJeGdUoDEYfJkP4LQceFnB5HubYOzw=;
        b=P6RwgixOqC5RlNfT20WL62Ws8X15jXEXiYG64uhAbucpL33u5vtJoUEQ+vhWwb/BLg
         nPUbefHIHHz4vloQwBdHF42RLvCON4P9RY+a6+HcHOB3dtnff1ucgwzuvmrMc8POyPYd
         2DF11x97dgLv6p6caGHu3EQtYFhUa42OvErXkxSJrSroVv7SFeQdUJvuF/OxEFO15Kbp
         dtcJAwBUaReA3EKXLqvi8v2keF0+bM1KofZ/ZIT7bet5v0VK+LcjfCQXgJCJgWIqAxKC
         Y9pEUXySMbKyDrhL5xjwRwFIXN7GuiMJB7GeTDACsWKs3i2WKUvgSpuQlsVl6Ka6DAtq
         l+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rP96bP6VHS9TeHJeGdUoDEYfJkP4LQceFnB5HubYOzw=;
        b=D32ahq+NfyMcZEn7VFQNsTf0cnaJPcsmHdoILDdRXKoL6Ci8VivbyaBM1Q+fiL+GmZ
         InDi3MXyoccMmM9LuZ/G6lsRGMA03DOTmBPVqghXadxhZ/4gJBkrIWbc33HPAgsd14Xk
         C/74Vsu0QxenW4koCGghw1waN/HE4x/xCeQnPyyYchYrYpHzSNaqPXhWArHLPjJhADlb
         RlcIniZ9GayANFMT+bCaLoxoJ33sPacqWK6TdSArV33ZRNXrqdx4txEKRPQaWqRWySM6
         BLEcFUYIt/KdgOuzHdhhQ2IipAd9B//V8/FtyZmgNnFgpf0PTV6y3cWzODREs5nzgzXt
         481w==
X-Gm-Message-State: AOAM530aSuGzEPb9UQwAhPmZV9FflBaPGokq5bMxxqGIfXoKUaKjwuBR
        Y29Vzv5syk9vFvNe7gsftuisBg==
X-Google-Smtp-Source: ABdhPJy7SpZKGc58CsHzwAOBldOQ4MAAWziUZt1G+tpGs58ZA+wKk+DQJiAKvZg5YfHWsky8RXbvJQ==
X-Received: by 2002:a37:a08e:: with SMTP id j136mr16395613qke.415.1591032474756;
        Mon, 01 Jun 2020 10:27:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id o3sm15575276qkj.97.2020.06.01.10.27.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Jun 2020 10:27:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jfoE5-0000fL-JB; Mon, 01 Jun 2020 14:27:53 -0300
Date:   Mon, 1 Jun 2020 14:27:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lijun Ou <oulijun@huawei.com>, Xi Wang <wangxi11@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Weihang Li <liweihang@huawei.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: Uninitialized variable in
 modify_qp_init_to_rtr()
Message-ID: <20200601172753.GA2538@ziepe.ca>
References: <20200529083918.GA1298465@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529083918.GA1298465@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 11:39:18AM +0300, Dan Carpenter wrote:
> The "dmac" variable is used before it is initialized.
> 
> Fixes: 494c3b312255 ("RDMA/hns: Refactor the QP context filling process related to WQE buffer configure")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
