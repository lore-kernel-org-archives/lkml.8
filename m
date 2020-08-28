Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65289C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3699720848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ePlq+ZOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgH1Lde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 07:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbgH1Lb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 07:31:56 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5E1C061233
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 04:13:53 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id y65so416361qtd.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 04:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=32sBIlpUGk5LnmxTM+iNsN5KMR/Rzjt0J7MtR+Fkgiw=;
        b=ePlq+ZOd4IoJvZySdZLYGHVkE+RCMy2SkfOxe7T4ZAKdfb6Cv1c6yS5XNO4OdaoFTo
         NytkZB6cIFOHyljA+BdV2LjkOJyJBKw1Sx4f+LTziOvCpLwBPwLPXcxj5Zk2Imjhvwca
         NPQ1jBrB1dCbYbr2M/vbOxY+HeKV5WN+4QmLbQqwT4MHWF56/o+rj0IfyZIvt0H+UYg7
         2y0pzb/7e3qDArFq01pc3GBgCqUgCCbANbjg8Wt6u81NJCdsK6SNpNg6t7HqV79GgCgg
         EZoVZoabH50o9Q3umwPjm/B1m6Nl5Nwr7lZDe9UwKqKZvVy2pRPAxL1O29nQY0+/wiDK
         NvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=32sBIlpUGk5LnmxTM+iNsN5KMR/Rzjt0J7MtR+Fkgiw=;
        b=sY7njIdB/ZxtFGSG/luOfb3YlbnepxGOKqxhonvdf+Ofb1+bIDTeNxbpNzTodyviGv
         VYVs7xd9EAPlu/TE4plh6p1w39ksyqew4roq3ocKz5h9Uw537QAGhRYEy7JWZV8mkO0U
         O0Mbdz+gHqI7BG+DRpPpCcvc4GCCgvxPVKA9ORZIk+QRGRYUZwJZk6ADqZduOdb/NpP+
         aWzVnpdbfCMClaI5Ilccw9LI/j5p32d3DmutadyWJ1g4Tt5WIGtcOCTEMbTZTxISbPSC
         lrJhPPM+7GezUA1tFK63SnXXHDv9sRO9WHGPD1hjwnW9eqF/BvUan/ataExXW9HvuWRI
         nvQw==
X-Gm-Message-State: AOAM5339yZoAigSIiAu1Xmt+u+kKROMJ85kXUam2HgGNTLskSJ+CaQNk
        6Mv8KmYUZvczx9eeuzRkmfRrbQ==
X-Google-Smtp-Source: ABdhPJxpXN6rsxUxGSDPN8kmIWEnIqnuWgPMuxvwgvIrsG4AQxq55i5Kv/JIkR0TMvI6qPRuhfZlBw==
X-Received: by 2002:ac8:67d2:: with SMTP id r18mr1055812qtp.179.1598613232859;
        Fri, 28 Aug 2020 04:13:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id o16sm473754qkj.18.2020.08.28.04.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 04:13:52 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kBcKN-000OR2-Ij; Fri, 28 Aug 2020 08:13:51 -0300
Date:   Fri, 28 Aug 2020 08:13:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/migrate: remove obsolete comment about device public
Message-ID: <20200828111351.GV24045@ziepe.ca>
References: <20200827190735.12752-1-rcampbell@nvidia.com>
 <20200827190735.12752-2-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827190735.12752-2-rcampbell@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 12:07:35PM -0700, Ralph Campbell wrote:
> Device public memory never had an in tree consumer and was removed in
> commit 25b2995a35b6 ("mm: remove MEMORY_DEVICE_PUBLIC support").
> Delete the obsolete comment.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
> 
> This applies to linux-mm and is for Andrew Morton's tree.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
