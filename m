Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84290C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6153E2063A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSgUQGtc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgGHUhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 16:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGHUhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 16:37:03 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADACEC061A0B;
        Wed,  8 Jul 2020 13:37:03 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cm21so69347pjb.3;
        Wed, 08 Jul 2020 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=52LwTTDHL52CPmera1ICXK0GwQWLs0yw6h+bAZf5d58=;
        b=eSgUQGtcqxtuwNGKTm8IGyagExgEIIsl3RfoodxZdaHUHC779bDDYtygQeDVaBgOKU
         +Zpcea+zd9LvHitAfpecn5O71GBpZMCuiVTDsQv3EPBjLObqKOMKhUr6Kz8LpWm/KyZr
         uhATACY3Nz19pWQsFnE/7JRpsTISoWkS+lwMbaLjnhCTl/dvfQV7mk9jj1nwVnXn3rUK
         zyDn7cJej0CAY4HDcymwpULukYtRh54U0mtg+/b+HSDP7cgyY79TTcOcumVyMdzN2ELD
         ccP4c4sSKJ+Kc/kPW/rFESldew00EQJHYwk7Mw1BYwVfwBN8nuNNf4EXf45qFTYfYzIp
         DZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=52LwTTDHL52CPmera1ICXK0GwQWLs0yw6h+bAZf5d58=;
        b=hVxTtkivvhVhFfCxQJcnn1XMjLhHdlzCbcrtFKKqQj9LnJL+gx77aKUegRfqWrd9sb
         vlSmtsF11zgNHjB4U4hOvooVUTwNEGua/xkxhpF0Hv/iGvM5PnSLOwbu9MIKkIH1xTmE
         oLL/p+HrSD+j6ydqxN5dRMt0QOIQYpZt7/y8xFwhzLRMCegMtkNAYOqZEGman+dF3gxj
         hkQe0L8AmHxbl3ePul6egUUJ6Z/qPUH8PO4CtJWOoBrKSkKWfN1M7JRFXAAH1LpccK89
         QAeZ4ivFYjaWHiGUcCVFqPt/kbOFFWRVAiqE+LqBCb5e2K8aDBLXIwN2rFikxHa4luTj
         Bo5g==
X-Gm-Message-State: AOAM532N7DmR70Zws0ywpBvEMnGSfCSma0OEpQYpeJRYMAAaMa1U8AzJ
        fubRBluEd1kRGza3QOSGQOc=
X-Google-Smtp-Source: ABdhPJwpGTiYJO8gpyu5euUywT+qnBK5iXzDI6Lx7kwvqto2YeAirm6kvWXwpcqnXfnmyFf0w2RclA==
X-Received: by 2002:a17:902:9a4b:: with SMTP id x11mr44361319plv.150.1594240623210;
        Wed, 08 Jul 2020 13:37:03 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id y17sm577996pfe.30.2020.07.08.13.37.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jul 2020 13:37:02 -0700 (PDT)
Date:   Wed, 8 Jul 2020 13:36:50 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        robh+dt@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, yhsu@nvidia.com, snikam@nvidia.com,
        praithatha@nvidia.com, talho@nvidia.com, bbiswas@nvidia.com,
        mperttunen@nvidia.com, nicolinc@nvidia.com, bhuntsman@nvidia.com
Subject: Re: [PATCH v10 3/5] iommu/arm-smmu: add NVIDIA implementation for
 ARM MMU-500 usage
Message-ID: <20200708203648.GB28080@Asurada-Nvidia>
References: <20200708050017.31563-1-vdumpa@nvidia.com>
 <20200708050017.31563-4-vdumpa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708050017.31563-4-vdumpa@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 10:00:15PM -0700, Krishna Reddy wrote:
> NVIDIA's Tegra194 SoC has three ARM MMU-500 instances.
> It uses two of the ARM MMU-500s together to interleave IOVA
> accesses across them and must be programmed identically.
> This implementation supports programming the two ARM MMU-500s
> that must be programmed identically.
> 
> The third ARM MMU-500 instance is supported by standard
> arm-smmu.c driver itself.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
