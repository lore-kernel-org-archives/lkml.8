Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7261C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C65F02075E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAASn2fh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgEFUNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 16:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgEFUNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 16:13:04 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4B5C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 13:13:04 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id y24so4196017wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 13:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CQXu6qiBdsMbiwQs775wLdxHmIoYyYCw2HkkXI8iCiM=;
        b=oAASn2fhX1d3fS49Xxknj9yfTPO8EnNtsxycBdCmDaz2giaGlhBUl+TEQ+eLSHsRfI
         SJkK96frJS5FeUw4N92TIkhpAsJ4oqkP05mQFjWKvgaliut6re99sRdYevKEnwoy0mpQ
         wCTSLcWCrVx5rdu9TQB178NxpHnDZNpKXoFMoT27QAAYzMvf7cX5RZQzF5t7w7csCaa/
         LtczzmVONdcX62q2D4DLg3vfvndOpdnH249U9yAVawxFQFhj7/ImXr0fsOP4OPtG/JDx
         Tgh849qZ0dwHSczdxxLL7XnBwTFS3wCaOBHlYfm/RmjLMsQu13RyvdhgBn6AfazZDNbY
         2OLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CQXu6qiBdsMbiwQs775wLdxHmIoYyYCw2HkkXI8iCiM=;
        b=Mh5HUzNzM25qEaHliOPB/qPxlQZbd/Kkwk1ci0cXpuIno3Ns43DwpMJJHK9bZWzOG1
         T6xpbbktLOqeZaTLCOQbIBalTPt7uG1pZiBiFWPLkJWV/yHsBKduSB7sKJyAWudc7goH
         jI5C47oXHx0FQlfY868ChBIDq4XYdaL4WiKbhYB7qykprBlizk88lNsAVKQx9NBXS6eV
         D2zxPoFPtE9XEjTVPBZPMbW3j4He4LOucCL7+/IILyyRTwgCc0zOMsxwCeqOVkBNfa9v
         pUu7CvW0fOX10YbgPc/ivvIq11cxeMTrmxT7iLdwDbaYu265iZlzVWdGFcZDDV+Q82yH
         LhfQ==
X-Gm-Message-State: AGi0PuaK0ADuJ5NW4mRAn7AbRi16aKVuhWPWBRPsnIWFdEvbA/Q/CAuY
        YTjjiK9qZyzVsMIQx/Q9q+f30dXqt7H50tRu7zJOTQ==
X-Google-Smtp-Source: APiQypKRQKO3Q2/p/FaxM8K5gRA/oIF6pQM3VKqfrTZiKjtlPwJ6lWke1sLNT//hyz8pZpScmcU3O3TUJH3cHKy4kUk=
X-Received: by 2002:a05:600c:243:: with SMTP id 3mr2490507wmj.73.1588795982735;
 Wed, 06 May 2020 13:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200506051113.223327-1-chentao107@huawei.com>
In-Reply-To: <20200506051113.223327-1-chentao107@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 6 May 2020 16:12:51 -0400
Message-ID: <CADnq5_Nz4LjOwfgA6---RSQmMjXOPjii4M-3qYmXW7ECbjdcwg@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu/navi10: fix unsigned comparison with 0
To:     ChenTao <chentao107@huawei.com>
Cc:     Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 3:03 AM ChenTao <chentao107@huawei.com> wrote:
>
> Fixes warning because size is uint32_t and can never be negtative
>
> drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:1296:12: warning:
> comparison of unsigned expression < 0 is always false [-Wtype-limits]
>    if (size < 0)
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: ChenTao <chentao107@huawei.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index 2184d247a9f7..0c9be864d072 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -1293,8 +1293,6 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
>         }
>
>         if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
> -               if (size < 0)
> -                       return -EINVAL;
>
>                 ret = smu_update_table(smu,
>                                        SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
> --
> 2.22.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
