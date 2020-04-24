Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1271C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 11:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89EF320728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 11:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDvl6Cex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgDXLCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 07:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgDXLCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 07:02:46 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB14C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 04:02:46 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id s5so8999325uad.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 04:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HEQC+zc6DWadDrh+ZHzHbWKwoF6aqL0hIqOxLyw9TN4=;
        b=ZDvl6CexW9fr1PbbL25d535OAPCYxO6vtZW8yb8cFa320y0xvW9nIsS4c7zd1NneSU
         aICxZkyFjDhuvRoxmverJSmKpl5PSdJ/n/X+hibs462m8q5C0TlGaw7b5F525uF3aOtx
         5jWoKFvuOjy97HTuPJK+w/vLGwDEhc69m24Wzr+KobWn9BrUd0wEV7PJldo4TieQfcsr
         xjACtTZIaiBVLtcLsRIDw5HVXY8i9L9Af5MzfiK2UVifTOIxMrtSIJmyOiUPHWtbVaQX
         +KAgXCA3PP1uLJeypXU6efRjwOl/NeCFVNBCi4S4UD11vhW/feKCYa6ayHwE+xHwYVQS
         gAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HEQC+zc6DWadDrh+ZHzHbWKwoF6aqL0hIqOxLyw9TN4=;
        b=KRqf3ZukW4n6TwKZD6dsy+ROXNTG0DUVq1CcsQ/mfX/dJqjO2h2By87WAis1QyWt2z
         s9QO9lMScFKkIh4JGwlHZnwcA8wjGdlGxmhfLkwll5vUlfgR+No8klLypzh1DRmM/CUE
         9jDN6EOaE9BL9aha7KkJ/qPGNh4bM7Y/2KmtN7qnuH54rcQ2mE7L1p+wjnNCZ3BkaHst
         vn6RXClxWHV0uSh1zh7urM9ZWUQ8TehhB3VFPgRA4TmY0C+mpEynNMcsDrTna7F/3kUI
         CM0dlDyLUpw4YOdmHPYbLc1g0lphk9aw5cSUERJYa/TYx4RdL8Y9U4cOdRl33Ozs39ae
         Yk7g==
X-Gm-Message-State: AGi0PuYXyucPrE1gZchy/OucEBWZ2kTrorbh2SETqaKUq5u5f3fHd+CI
        5rKRV23rdzWtyMKWZ5Ij6TBHmrQo0JIZwchA2i8=
X-Google-Smtp-Source: APiQypLAYP3M4WTMMbrtv0TIPLbSsl/+ylxPbD0Q59Fu36Wsny2ulaATuujzPdSegWiEfvjpsGf3JZtfeLx+bm3i0a4=
X-Received: by 2002:ab0:1ea:: with SMTP id 97mr4835744ual.106.1587726165361;
 Fri, 24 Apr 2020 04:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200424063551.14336-1-bernard@vivo.com>
In-Reply-To: <20200424063551.14336-1-bernard@vivo.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Fri, 24 Apr 2020 12:00:38 +0100
Message-ID: <CACvgo53s8YM4rt1=1o+w1PbBeG54RRbg=Qpcmc66WXUtoe92Xw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/arm: fixes pixel clock enabled with wrong format
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bernard,

On Fri, 24 Apr 2020 at 08:15, Bernard Zhao <bernard@vivo.com> wrote:
>
> The pixel clock is still enabled when the format is wrong.
> no error branch handle, and also some register is not set
> in this case, e.g: HDLCD_REG_<color>_SELECT. Maybe we
> should disable this clock and throw an warn message when
> this happened.
> With this change, the code maybe a bit more readable.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
>
> Changes since V1:
> *add format error handle, if format is not correct, throw
> an warning message and disable this clock.
>
> Link for V1:
> *https://lore.kernel.org/patchwork/patch/1228501/
> ---
>  drivers/gpu/drm/arm/hdlcd_crtc.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
> index af67fefed38d..f3945dee2b7d 100644
> --- a/drivers/gpu/drm/arm/hdlcd_crtc.c
> +++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
> @@ -96,7 +96,7 @@ static int hdlcd_set_pxl_fmt(struct drm_crtc *crtc)
>         }
>
>         if (WARN_ON(!format))
> -               return 0;
> +               return -EINVAL;
>
>         /* HDLCD uses 'bytes per pixel', zero means 1 byte */
>         btpp = (format->bits_per_pixel + 7) / 8;
> @@ -125,7 +125,7 @@ static int hdlcd_set_pxl_fmt(struct drm_crtc *crtc)
>         return 0;
>  }
>
> -static void hdlcd_crtc_mode_set_nofb(struct drm_crtc *crtc)
> +static int hdlcd_crtc_mode_set_nofb(struct drm_crtc *crtc)
>  {
>         struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
>         struct drm_display_mode *m = &crtc->state->adjusted_mode;
> @@ -162,9 +162,10 @@ static void hdlcd_crtc_mode_set_nofb(struct drm_crtc *crtc)
>
>         err = hdlcd_set_pxl_fmt(crtc);
>         if (err)
> -               return;
> +               return err;
>
>         clk_set_rate(hdlcd->clk, m->crtc_clock * 1000);
> +       return 0;
>  }
>
>  static void hdlcd_crtc_atomic_enable(struct drm_crtc *crtc,
> @@ -173,7 +174,11 @@ static void hdlcd_crtc_atomic_enable(struct drm_crtc *crtc,
>         struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
>
>         clk_prepare_enable(hdlcd->clk);
> -       hdlcd_crtc_mode_set_nofb(crtc);
> +       if (hdlcd_crtc_mode_set_nofb(crtc)) {
> +               DRM_DEBUG_KMS("Invalid format, pixel clock enable failed!\n");
> +               clk_disable_unprepare(hdlcd->clk);
> +               return;
> +       }
This doesn't seem right. As far as I can tell, the state must be
checked in the .atomic_check since .atomic_enable, intentionally,
"cannot" fail.

HTH
Emil


>         hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 1);
>         drm_crtc_vblank_on(crtc);
>  }
> --
> 2.26.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
