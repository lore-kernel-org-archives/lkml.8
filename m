Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A5BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A4D3204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyXkGltY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgHSNl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgHSNlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:41:24 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98735C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 06:41:22 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id j22so12094906lfm.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 06:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3uRot0J1Di9E+0e7vb+dEOT/StlUzO3fYMSg8aMNhC8=;
        b=cyXkGltYkaC0McaUgHwD/5OoYZHYrz1MPdgnHwimVl0oxwnZEOo3utozL+huPGOMnK
         fJlPFllGiLVBlhgztZ0pLPpqCK/EfPGn3tk9YTs7zoTwdUzDgGx8ia2bxbxU9c5el5Hg
         OuzIPd5cymAEH4QTUDRThsbB/qYzXRuptB2DXU1jA4UbP8aCfUH5CcYOC8+FzOlfAdtE
         Pr3N3yqcFoc23rjyPWsUncxefwaccKDSZ/GYgy+G5zTwoOerpp7bIX7B89EhCUtwYwSd
         Fho4czVHifLsI7yjvGbE0t/5hWexJp3XAUsa0vPi9+403ADvKUmAnAWzIVvrjRcJCU6x
         F40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3uRot0J1Di9E+0e7vb+dEOT/StlUzO3fYMSg8aMNhC8=;
        b=SlZQEWNvr+xvmdFXU2o+U0dIc9wpQmJsXckSzm9F6RGMzCYYfRlWbrfDzdrC+2h6Mu
         lo6RSCqBIzbiYDEzKj9qHY/mkk5VomZDuoJXIc6vNozuRoBUdokpDzIcHGVVZj353b6h
         rwqqX+7DHehfDlKCvuHb4Fsurr1Yg8ILPWyc4xWc8oDeSSHez2VkeYXOvR0pXZEHAH29
         7oeEs7r6MIy+UM8RZmPZjOAbArRvZvCGLH2BtWTPF+1IbLfQZaaUjIq4F03HYsBwSShw
         0alUxAFW9Fl7UlouhliQCCNSROP0m/L37oP/WB+ZjGiF2BGsvRVkJhtCG9Wnc5YFAM97
         ThLA==
X-Gm-Message-State: AOAM533klZvSPAujIqNyryaJ8tF2MaqMphpjKQ/25p94//iplCX/jUUo
        nnfpLYWkD8Vy12zRh+qvt0f1uJ067r0bKac7O2s=
X-Google-Smtp-Source: ABdhPJzVwh/eBPB/toCwEXC1n2x1b6nK7nRhjxc6nhA1rUb5IApOF8C7HR2OqQXVcWiQDBmwt/Wd3ey06LZXHWJ+En0=
X-Received: by 2002:a19:ae06:: with SMTP id f6mr12088967lfc.42.1597844479512;
 Wed, 19 Aug 2020 06:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200805205911.20927-1-trix@redhat.com>
In-Reply-To: <20200805205911.20927-1-trix@redhat.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Wed, 19 Aug 2020 15:41:08 +0200
Message-ID: <CAMeQTsbQP+hsVtPRJdehwS3yULP0Mif1T8e9G18mJp7dpH77Lg@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: fix error check
To:     trix@redhat.com
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>, yakui.zhao@intel.com,
        Alan Cox <alan@linux.intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 10:59 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> Reviewing this block of code in cdv_intel_dp_init()
>
> ret = cdv_intel_dp_aux_native_read(gma_encoder, DP_DPCD_REV, ...
>
> cdv_intel_edp_panel_vdd_off(gma_encoder);
> if (ret == 0) {
>         /* if this fails, presume the device is a ghost */
>         DRM_INFO("failed to retrieve link info, disabling eDP\n");
>         drm_encoder_cleanup(encoder);
>         cdv_intel_dp_destroy(connector);
>         goto err_priv;
> } else {
>
> The (ret == 0) is not strict enough.
> cdv_intel_dp_aux_native_read() returns > 0 on success
> otherwise it is failure.
>
> So change to <=

Thanks for the patch. Looks correct.

Will apply to drm-misc-next

-Patrik

>
> Fixes: d112a8163f83 ("gma500/cdv: Add eDP support")
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/gma500/cdv_intel_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> index f41cbb753bb4..720a767118c9 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> @@ -2078,7 +2078,7 @@ cdv_intel_dp_init(struct drm_device *dev, struct psb_intel_mode_device *mode_dev
>                                                intel_dp->dpcd,
>                                                sizeof(intel_dp->dpcd));
>                 cdv_intel_edp_panel_vdd_off(gma_encoder);
> -               if (ret == 0) {
> +               if (ret <= 0) {
>                         /* if this fails, presume the device is a ghost */
>                         DRM_INFO("failed to retrieve link info, disabling eDP\n");
>                         drm_encoder_cleanup(encoder);
> --
> 2.18.1
>
