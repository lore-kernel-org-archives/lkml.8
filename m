Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD22AC3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9730924649
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="G8gmToLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgBMVUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 16:20:12 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42864 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbgBMVUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 16:20:11 -0500
Received: by mail-io1-f66.google.com with SMTP id z1so7592730iom.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 13:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XdJ6+t4v4gVXqPsGTcbuSZf1Op16CguWcTM5QAh4j/U=;
        b=G8gmToLcQ2GFr3Y2iihCmtCqN880870+huCEXmbYkzc4kqMgx0DFgLVf5owrVKSJdq
         T3sspw4dUH7dRtfq9qK3Qtdzlr+Nb0VYW7gEpcEfpIt8Gd+hdNvImZiiLO8JBTuO5YSL
         sreEu0f5mc5VYvgSHI+8Ev87E0/UEmAAPbAkPYxidgPRv004E2tMNAjyhda7MAgYCXT1
         2aZVYqkV9bX95wSXGhBaPQGklVhYvTs8xDjAQysaq2BiTprcXDrAzcZRPNAfTdznNcUL
         4fMWBQSb7pJOAG/mGsA1C0PCEItW30l/7m6RmU9E6fipvpS1pL2Aq2QkeWwu939nvHov
         LDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XdJ6+t4v4gVXqPsGTcbuSZf1Op16CguWcTM5QAh4j/U=;
        b=GjB+RSYCMN/h/ADzrS64oOzux488fiC0KFyIe7EzR+YJvZn/nqKVdX6LsiW1u0JNf2
         mqOvw5gBouDJupEGrED2Y+5QMtrLEOuijlWUwVYtwlhImJfudwib/BRb+rodvM8QbNpD
         V1S+kSnjCECpPSexyZXlmKWczwbx79abfWJcor2mWW0NAgZTiGsrVtNaLIq8A0CyOrWp
         u3ghTrDWnUUgW6nwBBanYyBUjUq7jtycgBh1vsJID8TjmegPc4hV3llXM41hJewVuTcT
         4ga56lFtjOXe4bYtH0cpuJBX/YRCz4PEWMAiBZWdgLeeEH39OagLJ/tOMoV5e223R3E5
         sIEw==
X-Gm-Message-State: APjAAAXuedNlCccsQDiBNPytBo+9mUw52c/fhANZHRiODwJ+V1NhBvzY
        6xC9wgkdk4J26yW3bfZCS5TGScg0LAwyijSm0Ohxhg==
X-Google-Smtp-Source: APXvYqyAYEUq6eh8DqbFibK/wL7zPASyagcfAHQ0v8tMT+756eMpAPKA3VbtFHzpcWobjF8F0ZqDqoo+BtMlz0XOUZk=
X-Received: by 2002:a5d:8cc4:: with SMTP id k4mr21678723iot.2.1581628810752;
 Thu, 13 Feb 2020 13:20:10 -0800 (PST)
MIME-Version: 1.0
References: <20200213200137.745029-1-robdclark@gmail.com>
In-Reply-To: <20200213200137.745029-1-robdclark@gmail.com>
From:   Sean Paul <sean@poorly.run>
Date:   Thu, 13 Feb 2020 16:19:35 -0500
Message-ID: <CAMavQK+8un0eD1X2n+ej3oViqCP1q0bLPAV=B9XqNd906MXkSA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: fix BGR565 vs RGB565 confusion
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Fritz Koenig <frkoenig@google.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 3:03 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> The component order between the two was swapped, resulting in incorrect
> color when games with 565 visual hit the overlay path instead of GPU
> composition.
>
> Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Sean Paul <seanpaul@chromium.org>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
> index 24ab6249083a..6f420cc73dbd 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
> @@ -255,13 +255,13 @@ static const struct dpu_format dpu_format_map[] = {
>
>         INTERLEAVED_RGB_FMT(RGB565,
>                 0, COLOR_5BIT, COLOR_6BIT, COLOR_5BIT,
> -               C2_R_Cr, C0_G_Y, C1_B_Cb, 0, 3,
> +               C1_B_Cb, C0_G_Y, C2_R_Cr, 0, 3,
>                 false, 2, 0,
>                 DPU_FETCH_LINEAR, 1),
>
>         INTERLEAVED_RGB_FMT(BGR565,
>                 0, COLOR_5BIT, COLOR_6BIT, COLOR_5BIT,
> -               C1_B_Cb, C0_G_Y, C2_R_Cr, 0, 3,
> +               C2_R_Cr, C0_G_Y, C1_B_Cb, 0, 3,
>                 false, 2, 0,
>                 DPU_FETCH_LINEAR, 1),
>
> --
> 2.24.1
>
