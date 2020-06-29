Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C33DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5DFD2078A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xh/Vue0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgF2Xw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgF2Xw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:52:56 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA9EC061755;
        Mon, 29 Jun 2020 16:52:56 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d194so5678222pga.13;
        Mon, 29 Jun 2020 16:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZGfMUVHQlxfLiTJM1WLol0nRk5sgJRj1wqf4MkKus5s=;
        b=Xh/Vue0q76LlXZ1IVtyp0plcHCg+yS3sou6eCNEplyeHb1RBascLD5jXemJu3z6ioE
         PEQnSUC8EAaBfx1BtSvvbgAwQNJJ2ucrQrroIdlGPAQQv/7jpS25OnRr1gUi9wsK/b8D
         RXvb9lS0v+ikbVT8ubeL0uwKOXgpuTQlKgq3cZGlJyHIg97a4iDob4bDoRx23oRNdD4r
         xS4iFrH3Nj5YbxJ5wrinYNGmgIzT/kcoFq6Q4gZt8F4LDM8PTotHdQ34JLVbDkoMMSoG
         EZmJRILAhOY7EzQ4a7o/NpFeYhXMbTo5ogcOKUxCV0/o/kqWxbIp7d4kZl3BvTlhgcMg
         2qdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZGfMUVHQlxfLiTJM1WLol0nRk5sgJRj1wqf4MkKus5s=;
        b=MCdDxk6znqwe10ULoeIK9zxpv+9kknCBqBP+OgAl+eU0q+ghPPpob7I4nLVipw+RqF
         nFoI2fI8a35kne8C5/OrQx/cUoyaQw7b6Ra7UL39dw/kwQgwjbaheDdHUQSfx1ZSHTt7
         j2S2WIkf3MABuDfNIUDqvHiUSxMRLHLCdz7hayWRIOI7IDW5aWTzmEMCSZw8/uO16XbD
         q1gZggCztZGxmfWh2tCg5QW7IMQYSqZf2vI4gaOOJn9zEfyj6pFmUhux9WZrWVqhGvJS
         /h90BHzMzb8ce2FH5EXII2zLXa9BzxuBQnhWgzFuv1W44fM7ZDE+yduphhvgtoj3egWE
         n7CQ==
X-Gm-Message-State: AOAM5316Ri26Il5nEFtjVMUXv64dqCp+13wWtj+b6degyLh2WOtLCAzz
        mta5P9ahJfvIK5A/Nztq++SP3jRNag8=
X-Google-Smtp-Source: ABdhPJyHRiIXYw7M7C5K2woDsZLaiq4jmATiThuvEjJzM6tygMJ9vTs50c26tg/Ye6SHSxXi2HFHdA==
X-Received: by 2002:aa7:988f:: with SMTP id r15mr7658817pfl.2.1593474775473;
        Mon, 29 Jun 2020 16:52:55 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id y18sm662361pff.10.2020.06.29.16.52.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jun 2020 16:52:55 -0700 (PDT)
Date:   Mon, 29 Jun 2020 16:52:20 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Yu-Huan Hsu <YHsu@nvidia.com>,
        Sachin Nikam <Snikam@nvidia.com>,
        Pritesh Raithatha <praithatha@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Bryan Huntsman <bhuntsman@nvidia.com>
Subject: Re: [PATCH v7 1/3] iommu/arm-smmu: add NVIDIA implementation for
 dual ARM MMU-500 usage
Message-ID: <20200629235219.GA14616@Asurada-Nvidia>
References: <20200629022838.29628-1-vdumpa@nvidia.com>
 <20200629022838.29628-2-vdumpa@nvidia.com>
 <20200629215124.GD27967@Asurada-Nvidia>
 <BYAPR12MB2822B08564C7BD7212DCCEFEB36E0@BYAPR12MB2822.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR12MB2822B08564C7BD7212DCCEFEB36E0@BYAPR12MB2822.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 10:49:31PM +0000, Krishna Reddy wrote:
> >> +     if (!nvidia_smmu->bases[0])
> >> +             nvidia_smmu->bases[0] = smmu->base;
> >> +
> >> +     return nvidia_smmu->bases[inst] + (page << smmu->pgshift); }
> 
> >Not critical -- just a nit: why not put the bases[0] in init()?
> 
> smmu->base is not available during nvidia_smmu_impl_init() call. It is set afterwards in arm-smmu.c.
> It can't be avoided without changing the devm_ioremap() and impl_init() call order in arm-smmu.c. 

I see...just checked arm_ssmu_impl_init().
