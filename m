Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D6CC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F335F20735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOiS5WDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgEEOuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729332AbgEEOuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:50:22 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A03CC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:50:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id y3so3131937wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dHepXFxm8qKHZID5kZyNoKgDmU94PQ15EAtVlnqLnZc=;
        b=ZOiS5WDZ29akAAdhXXjRyV9fc7RyNOba7PtkNLWbxfDNix6an+NowR7TG1FUmceDGN
         d2mGDFxqAzFXQ3A/Sh+/5I6gksRVJ2iBSy5DwBGqKvAyQFQzTxTr1f5TFT//tKvkacrg
         co5MDwjpKX8AWidgmGyKrY81h96fzAKv2s0iekzaImHBd8HyxyOOiXZ/k8EfGoFQhYv5
         OoAhguuEm9AD/WlRnWX/NX5WQmGd/6lLAFW+fL5sjWZQ1bP5QYPsMSIbkd2NGbkn+pZ2
         FSoKSYDaPZenxrArHC8CuJ/zJNw+Z5LH7KpAE1JdWk2LqiK+a977uYM3R2iS0fdG9Ky7
         ZFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dHepXFxm8qKHZID5kZyNoKgDmU94PQ15EAtVlnqLnZc=;
        b=M78/MYxWa8chb4kbVT+PjWgPoN/GJmAqFx5+e6XOO5peZVZm18x2P+WslF/ZITfkHB
         6lKgEAO9en7LFA3yGZHfPdC04h1gtublbtbK01KjC16jfto4jcIhFuHIRnauma6ufeur
         C020VRbGxg8byhWgnSAdYdmAzD/AxaNS4DJf/pppFA4XhcPQam50Ce/Y21WPSSqRJrmU
         j/YVPFHwi/wtGY3Wvyv7GuLWaXp44sYBqinAUuKr6IS/OjMZGLH6NRdWaP5u/m66UvY5
         09FX/Ta3yNfp23Oj7Jl3zWAStnRPbJ3AbW9XP3kkB06k8lT/OsPF81n4+Ujy29U02piR
         VU2Q==
X-Gm-Message-State: AGi0PubGcNMZOnVuDvRbuhoh3H3bp1y7YWIWOrSTKMOt67miL1pXksVv
        Wh5JIK3BxrqXespGTcYq7yhlziSc+uIcPwMGjHg=
X-Google-Smtp-Source: APiQypKRd0rRv5AlYry2/DMCroz5gD5QAeb2dAeVT/fSJiTtWXfU71yf5+eaVpo/MT0MYQqxwtrxF5IIwiy/RQH+Gbs=
X-Received: by 2002:adf:9264:: with SMTP id 91mr4033682wrj.362.1588690219762;
 Tue, 05 May 2020 07:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200505045737.185143-1-chentao107@huawei.com>
In-Reply-To: <20200505045737.185143-1-chentao107@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 5 May 2020 10:50:08 -0400
Message-ID: <CADnq5_Nmdt-tAsBa4AgQ70eP0b55xLTQKQmDCoSxUXihSjXk9g@mail.gmail.com>
Subject: Re: [PATCH -next] drm/radeon: fix unsigned comparison with 0
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

On Tue, May 5, 2020 at 2:59 AM ChenTao <chentao107@huawei.com> wrote:
>
> Fixes warning because pipe is unsigned long and can never be negtative
>
> vers/gpu/drm/radeon/radeon_kms.c:831:11: warning:
> comparison of unsigned expression < 0 is always false [-Wtype-limits]
>   if (pipe < 0 || pipe >= rdev->num_crtc) {
> drivers/gpu/drm/radeon/radeon_kms.c:857:11: warning:
> comparison of unsigned expression < 0 is always false [-Wtype-limits]
>   if (pipe < 0 || pipe >= rdev->num_crtc) {
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: ChenTao <chentao107@huawei.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_kms.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
> index 372962358a18..c5d1dc9618a4 100644
> --- a/drivers/gpu/drm/radeon/radeon_kms.c
> +++ b/drivers/gpu/drm/radeon/radeon_kms.c
> @@ -828,7 +828,7 @@ int radeon_enable_vblank_kms(struct drm_crtc *crtc)
>         unsigned long irqflags;
>         int r;
>
> -       if (pipe < 0 || pipe >= rdev->num_crtc) {
> +       if (pipe >= rdev->num_crtc) {
>                 DRM_ERROR("Invalid crtc %d\n", pipe);
>                 return -EINVAL;
>         }
> @@ -854,7 +854,7 @@ void radeon_disable_vblank_kms(struct drm_crtc *crtc)
>         struct radeon_device *rdev = dev->dev_private;
>         unsigned long irqflags;
>
> -       if (pipe < 0 || pipe >= rdev->num_crtc) {
> +       if (pipe >= rdev->num_crtc) {
>                 DRM_ERROR("Invalid crtc %d\n", pipe);
>                 return;
>         }
> --
> 2.22.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
