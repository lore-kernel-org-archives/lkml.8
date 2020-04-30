Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EA6C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CCA0208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQBB70FT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgD3Q2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726415AbgD3Q2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:28:07 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED40C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:28:07 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b11so7729855wrs.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+fLMnUMUsPkmSvT0kvVOGp9BzEZPMOJ5XFQJkVIA9QM=;
        b=RQBB70FTKz8X+ddbM5dnt6rrKCg+XxEhIWD6MQTLU1Wjoh1d7cGWWdULt0ij0F3g2j
         IPrvKRoeYr7220Odl14eUY0lLlHFNY2H/rjh5iCRudWkAJnVJeX/vFccPhbwj8IcedC7
         3mK2PQVqVzDMMlWoiE/i2fzFeqmxxVMOOYX5ErV84Rkg4TGw97wc2AnQFgVs/dU7N0Ks
         VIPDezFVm7flWw90msCt4Y9+8UBkSs0H7RIFdoW7kFwczZV9Y95Ztq7rznwNUjEaKKOD
         KDfGLoRifyL4AcUJmya/CsPyn+3Q4oO4PR0qh2seoKJhtHm0JSJus0+xYx3+r3tGrd4Z
         CM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+fLMnUMUsPkmSvT0kvVOGp9BzEZPMOJ5XFQJkVIA9QM=;
        b=TSiZr0BWSH62jYuzik6vt6ObzoOkLhDCbN9E88cRDJ5Waef7yHyheRjAdyIG3MaAnc
         DIEJhu/rjnZNU1LzM9bpnHOIURRiocspZGOBz2l11zMQ6oSD0gxRFbg7t98ovhgoXWFg
         dCbcR81s4trQVlytCbQ9+30QqNbVc+4KjO08hqnKs17ytBgsxOfQ57hHIRWKbiEmyJPG
         2yam3kSN92IVwv20D9I6DefiLwpLLb0Wt0zrkirW7zuk+lVvCg79qNGKgwyPUirWfiRW
         /I/T7tRaGY61ARNwmMgjMOIHzSkXuyOhlOSuJdfpGT+7qj44Sr3W7rFexzWjZQeY8iI0
         194Q==
X-Gm-Message-State: AGi0Pub/A+X31DuXj4rQ8vs3O+ykzmFZ7cBW/ChQUdssTFFy86Ud132w
        28Lq+l4IM56WAFM0dcXHpHRKA5AMJgwcN0ucvsj73g==
X-Google-Smtp-Source: APiQypKxdWq6TcQWUfjQVg93ONjnBTqIqmPXLEeVuKpLfk+kVhslqEuWc1M9uiC4aVm3X61WiacMj7qfJdjcyGOhI4Y=
X-Received: by 2002:adf:cd8c:: with SMTP id q12mr5048810wrj.419.1588264086292;
 Thu, 30 Apr 2020 09:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <1588228709-13512-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1588228709-13512-1-git-send-email-zou_wei@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 30 Apr 2020 12:27:55 -0400
Message-ID: <CADnq5_NcOeCaBY7exuepMC+vtqmdrDbptUxmoq3Xzf3R-g1=_w@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu: Fix warning Comparison to bool
To:     Zou Wei <zou_wei@huawei.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 3:32 AM Zou Wei <zou_wei@huawei.com> wrote:
>
> fix below warnings reported by coccicheck
>
> drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c:630:5-11: WARNING: Comparison to bool

This seems incorrect.  enable is a bool.

Alex

>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index b544baf..10080e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -627,7 +627,7 @@ static void sdma_v5_0_enable(struct amdgpu_device *adev, bool enable)
>         u32 f32_cntl;
>         int i;
>
> -       if (enable == false) {
> +       if (!enable) {
>                 sdma_v5_0_gfx_stop(adev);
>                 sdma_v5_0_rlc_stop(adev);
>         }
> --
> 2.6.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
