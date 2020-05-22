Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5047AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2298C20723
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590168168;
	bh=+UXZQwfEnFZd4EW9Ome4HVj9Xjqma2zwTir5fmlya1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FkYQsZlerGme6KZ8WFYeUiXjE1R3c0t9r5UeyAC9t8Lgaq3Pezjh7PVE9CVXsK6Wg
	 qgEx5hfryBOIeFGgVHMVh7qPfJ2+IRVQIPxm2/vdSlk+TqBDVoGYCD2SHxC1SntN5G
	 189iZYoyqWmnnw8tC/+1V2GpKMpH3j2yVbBuEqO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbgEVRWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 13:22:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730471AbgEVRWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:22:46 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C958D206C3;
        Fri, 22 May 2020 17:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590168166;
        bh=+UXZQwfEnFZd4EW9Ome4HVj9Xjqma2zwTir5fmlya1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E0fxmFlzEjIQFqm/XLuLZvBvgmZZ4P/r2dua4DmOBSPbSD//Lr5grBTuGCOLt0oy7
         Yxq1H2WPFmVsh040JvskRu3TzA0OKNNkNDgdvYN0UKf+aZAMe4Yw0pSMn069BVHpZK
         Cz80vznWgKwkFQY+psno6S4FND+imLrvVZh03MI4=
Date:   Fri, 22 May 2020 12:27:36 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] drm/radeon/dpm: Replace one-element array and use
 struct_size() helper
Message-ID: <20200522172736.GE29907@embeddedor>
References: <20200522012547.GA6783@embeddedor>
 <753faa45-247c-536c-d85a-5c1385ed0049@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <753faa45-247c-536c-d85a-5c1385ed0049@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 09:00:09AM +0200, Christian König wrote:
> > +++ b/drivers/gpu/drm/radeon/ni_dpm.c
> > @@ -2685,11 +2685,12 @@ static int ni_upload_sw_state(struct radeon_device *rdev,
> >   	struct rv7xx_power_info *pi = rv770_get_pi(rdev);
> >   	u16 address = pi->state_table_start +
> >   		offsetof(NISLANDS_SMC_STATETABLE, driverState);
> > -	u16 state_size = sizeof(NISLANDS_SMC_SWSTATE) +
> > -		((NISLANDS_MAX_SMC_PERFORMANCE_LEVELS_PER_SWSTATE - 1) * sizeof(NISLANDS_SMC_HW_PERFORMANCE_LEVEL));
> > +	NISLANDS_SMC_SWSTATE *smc_state;
> > +	u16 state_size = struct_size(smc_state, levels,
> > +			NISLANDS_MAX_SMC_PERFORMANCE_LEVELS_PER_SWSTATE);
> 
> Probably better to use size_t instead of u16 here. With that fixed feel free
> to stick my rb on the patch.
> 

Sure thing. I'll send v2, shortly.

Thanks, Christian.
--
Gustavo
