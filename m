Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D80DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22A4620782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593783461;
	bh=h4AWXK1OzAabGjzRp78Qq4E/Pvb4iF6SmMTMkbta69E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SrkuL6YsTTtiYthQ4FzS0W4ZHbpP3inwgwu/GJFFUBGMqPUwz70KrwP8laFe7kxUK
	 KpxqXVREeqQCRgpuoWMKPZ1MLFBAVk1qpAuUGQLOoZI/1MYaZuG0lhBc30Y3eKILgH
	 5F1oVF3ZLu6dyBkiddY5z6+bnG8CNIx28vzUJgIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgGCNhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:37:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgGCNhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:37:39 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EF09206A1;
        Fri,  3 Jul 2020 13:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593783459;
        bh=h4AWXK1OzAabGjzRp78Qq4E/Pvb4iF6SmMTMkbta69E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zsco0pFHiu8uFn++3g+2aWZOGtMeDwXe2RdiKWXSiB1NAwLZTkzuswi6E4rPfoFgc
         zQygwRBRrnKJMJ6YgutuQW39JaKYOgP2fttYqHsRZiFYssPejgjJ+6IYnBSkwhnVMp
         cs70jkYqgCEvqEZxEg9urRaC6/8frYrllSxaMCbY=
Date:   Fri, 3 Jul 2020 14:37:33 +0100
From:   Will Deacon <will@kernel.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.velikov@collabora.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        "Kristian H . Kristensen" <hoegsberg@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCHv3 7/7] drm/msm/a6xx: Add support for using system
 cache(LLC)
Message-ID: <20200703133732.GD18953@willie-the-truck>
References: <cover.1593344119.git.saiprakash.ranjan@codeaurora.org>
 <449a6544b10f0035d191ac52283198343187c153.1593344120.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449a6544b10f0035d191ac52283198343187c153.1593344120.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 09:22:50PM +0530, Sai Prakash Ranjan wrote:
> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> index f455c597f76d..bd1d58229cc2 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> @@ -218,6 +218,9 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
>  		iova |= GENMASK_ULL(63, 49);
>  
>  
> +	if (mmu->features & MMU_FEATURE_USE_SYSTEM_CACHE)
> +		prot |= IOMMU_SYS_CACHE_ONLY;

Given that I think this is the only user of IOMMU_SYS_CACHE_ONLY, then it
looks like it should actually be a property on the domain because we never
need to configure it on a per-mapping basis within a domain, and therefore
it shouldn't be exposed by the IOMMU API as a prot flag.

Do you agree?

Will
