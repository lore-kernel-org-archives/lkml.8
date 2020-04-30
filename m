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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14B4C83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 04:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF0242073E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 04:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ii1k25Ep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgD3ENs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 00:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725280AbgD3ENs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 00:13:48 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062B1C035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 21:13:47 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id o139so2459534ybc.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 21:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nCPU1gorl1WvKPs1iOzqt5NnAoZZ0QjF1DsfHjpy8kM=;
        b=Ii1k25Ep82LJUh9M/ERKSLRZZMHzCZJcAt1rSs48NIWvUSPIXd3KhGWlVDHwrm5Huf
         DZ3WA2/yrmDAKjQVyP7BVi/sT24Qys5QhodRggUD/ZFgNVQ+9SuBtohrETk5cm1T2k07
         bwu9aGGLxLtJt7z9Q5kECnBm4yy1dQppTyeJbcIAPnvqj7oX3AF36w737sJV9FJdNkUk
         u9WorZUm7UmGWo2Vp6eoWQH+zM3looOdqR2BUBjj935PPz+gcOTehJxmrKIV0BFnIb/6
         voEB5HXLF96MrHmV+MtIVLoT/M+A1//If9kYfDokBjfBacPK31PLHp/C72neuG2ioqlv
         m9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nCPU1gorl1WvKPs1iOzqt5NnAoZZ0QjF1DsfHjpy8kM=;
        b=JmHTqTCigZTDo25x64kXTiQyRHTmUsu686NlclRXbIj04/gOaeh4QJcla5vcACgqbd
         +1QJp/SdDdYDWJG3tLJmnnBMPMZoA7HN5CrfbylfiXJY+4I/ijh3fOUPm7GAaU6ogjbD
         RihZ/aFiOMgJ6+AjbVTGDL7s4TvCTy2hSUmP+6kb5CGWgp1CNSzG3iZyLGQNh0rDb1EC
         FxT3LtN1MzlAo0tPMlxxzF7AAXyaJXFzm9CjrofleL9K8dPRXTmdffICUKiuOPT6/BTa
         UHTmxtpofUTcWPC9tsTmUvGL86caap9IdbWql2IKr7fACqgty/qMDBiYmp4G5sr0f6YT
         sznQ==
X-Gm-Message-State: AGi0PuaEpCdPkXD2D5sAcIU9nvTsIB2IpCF1U+PkizRXjZNptKjGPhQj
        EDnkD4EyXJsjtQXgZO0Boet7QDrLrxtaFridY20=
X-Google-Smtp-Source: APiQypJ+S/o2UH998viYT0pSpKOLZuxf89e5j2PIAZQncI/FHYU5+W9PA0cNSif2Ta7PceldqOcWJlZm7TxLCyUqKLc=
X-Received: by 2002:a25:8b02:: with SMTP id i2mr2565409ybl.283.1588220027294;
 Wed, 29 Apr 2020 21:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200416075428.25521-1-tiwai@suse.de>
In-Reply-To: <20200416075428.25521-1-tiwai@suse.de>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Thu, 30 Apr 2020 14:13:36 +1000
Message-ID: <CACAvsv7pZX+h_JqWeu=0yK1u2nwzDGODKWpHarzB-80u89JLZg@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau: Fix regression by audio component transition
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Ben Skeggs <bskeggs@redhat.com>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good catch!  The OR is definitely a far better choice than the head
here, as it's what we use to select the GPU-side HDA registers too.

Merged.

On Thu, 16 Apr 2020 at 17:54, Takashi Iwai <tiwai@suse.de> wrote:
>
> Since the commit 742db30c4ee6 ("drm/nouveau: Add HD-audio component
> notifier support"), the nouveau driver notifies and pokes the HD-audio
> HPD and ELD via audio component, but this seems broken.  The culprit
> is the naive assumption that crtc->index corresponds to the HDA pin.
> Actually this rather corresponds to the MST dev_id (alias "pipe" in
> the audio component framework) while the actual port number is given
> from the output ior id number.
>
> This patch corrects the assignment of port and dev_id arguments in the
> audio component ops to recover from the HDMI/DP audio regression.
>
> Fixes: 742db30c4ee6 ("drm/nouveau: Add HD-audio component notifier support")
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207223
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index a3dc2ba19fb2..3a9fd565079d 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -481,15 +481,16 @@ nv50_dac_create(struct drm_connector *connector, struct dcb_output *dcbe)
>   * audio component binding for ELD notification
>   */
>  static void
> -nv50_audio_component_eld_notify(struct drm_audio_component *acomp, int port)
> +nv50_audio_component_eld_notify(struct drm_audio_component *acomp, int port,
> +                               int dev_id)
>  {
>         if (acomp && acomp->audio_ops && acomp->audio_ops->pin_eld_notify)
>                 acomp->audio_ops->pin_eld_notify(acomp->audio_ops->audio_ptr,
> -                                                port, -1);
> +                                                port, dev_id);
>  }
>
>  static int
> -nv50_audio_component_get_eld(struct device *kdev, int port, int pipe,
> +nv50_audio_component_get_eld(struct device *kdev, int port, int dev_id,
>                              bool *enabled, unsigned char *buf, int max_bytes)
>  {
>         struct drm_device *drm_dev = dev_get_drvdata(kdev);
> @@ -505,7 +506,8 @@ nv50_audio_component_get_eld(struct device *kdev, int port, int pipe,
>                 nv_encoder = nouveau_encoder(encoder);
>                 nv_connector = nouveau_encoder_connector_get(nv_encoder);
>                 nv_crtc = nouveau_crtc(encoder->crtc);
> -               if (!nv_connector || !nv_crtc || nv_crtc->index != port)
> +               if (!nv_connector || !nv_crtc || nv_encoder->or != port ||
> +                   nv_crtc->index != dev_id)
>                         continue;
>                 *enabled = drm_detect_monitor_audio(nv_connector->edid);
>                 if (*enabled) {
> @@ -599,7 +601,8 @@ nv50_audio_disable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc)
>
>         nvif_mthd(&disp->disp->object, 0, &args, sizeof(args));
>
> -       nv50_audio_component_eld_notify(drm->audio.component, nv_crtc->index);
> +       nv50_audio_component_eld_notify(drm->audio.component, nv_encoder->or,
> +                                       nv_crtc->index);
>  }
>
>  static void
> @@ -633,7 +636,8 @@ nv50_audio_enable(struct drm_encoder *encoder, struct drm_display_mode *mode)
>         nvif_mthd(&disp->disp->object, 0, &args,
>                   sizeof(args.base) + drm_eld_size(args.data));
>
> -       nv50_audio_component_eld_notify(drm->audio.component, nv_crtc->index);
> +       nv50_audio_component_eld_notify(drm->audio.component, nv_encoder->or,
> +                                       nv_crtc->index);
>  }
>
>  /******************************************************************************
> --
> 2.16.4
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
