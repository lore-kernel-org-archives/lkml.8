Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68CEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C08D220899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbgE0OFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:05:12 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33692 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730268AbgE0OFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:05:11 -0400
Received: by mail-vs1-f67.google.com with SMTP id t4so11928104vsq.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 07:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nj7qsg4lKpnXPmI42ZYb6Reb6qM87EHYaYTe65h4s+w=;
        b=ZS5fiymfh9guG1y+Ntu3goKMlaSmcLckXyhvL/vC2a6vhdELLF8mhnHeBgOq8llJKM
         NagHyEJwCcKD79U9bU29hgcmE4Xn02Yasf1C4zXok8SeKEeyXPWYADy4WQLVyX0//xyb
         x8LjF5GRRRGWEaKXBjFtebkVqxR176++RsDLHwxyDmJwhGWAyblccNpIHJzhSQtv09kU
         AUiu5D4e/afG2IPln8lqOQ0A8qTvx2x+ZJequMwt6H3HeX4/HtEzKy2gOJAfTzq66F2m
         bdAGsQnFOVzSjvQlOtyIvBSItyP74nj+RnULUt9xpJYiPOxj3Xal1X3Od8XV3Us5mrN2
         dTkQ==
X-Gm-Message-State: AOAM531IJaC/15m6XRfgN9Ov0Id51jLa77Yl57xQxUIncfAT2KWf8lYi
        XKVUXfhzs2QYnjYQpLCia8wZwYbSvyuWCIajCmSAPfLYB54=
X-Google-Smtp-Source: ABdhPJzjUNA5cBcjelNudJyr52VcrEFlfHkWiSwTL0xX6LhIgjVleYcL1OkZCrnF9Q5f0ausMduTpZf0X77n+8opYSQ=
X-Received: by 2002:a67:e9d3:: with SMTP id q19mr4667144vso.220.1590588310389;
 Wed, 27 May 2020 07:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200527134254.854672-1-arnd@arndb.de>
In-Reply-To: <20200527134254.854672-1-arnd@arndb.de>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Wed, 27 May 2020 10:04:59 -0400
Message-ID: <CAKb7Uvhh2JKck524D9S14uNSLykFj+U48AgR+sd2uwchsH_wEQ@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] nouveau: add fbdev dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Isn't this already fixed by

https://cgit.freedesktop.org/drm/drm/commit/?id=7dbbdd37f2ae7dd4175ba3f86f4335c463b18403

On Wed, May 27, 2020 at 9:43 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Calling directly into the fbdev stack only works when the
> fbdev layer is built into the kernel as well, or both are
> loadable modules:
>
> drivers/gpu/drm/nouveau/nouveau_drm.o: in function `nouveau_drm_probe':
> nouveau_drm.c:(.text+0x1f90): undefined reference to `remove_conflicting_pci_framebuffers'
>
> The change seems to have been intentional, so add an explicit
> dependency here but allow it to still be compiled if FBDEV
> is completely disabled.
>
> Fixes: 2dd4d163cd9c ("drm/nouveau: remove open-coded version of remove_conflicting_pci_framebuffers()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/nouveau/Kconfig       | 1 +
>  drivers/gpu/drm/nouveau/nouveau_drm.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
> index 980ed09bd7f6..8c640f003358 100644
> --- a/drivers/gpu/drm/nouveau/Kconfig
> +++ b/drivers/gpu/drm/nouveau/Kconfig
> @@ -18,6 +18,7 @@ config DRM_NOUVEAU
>         select THERMAL if ACPI && X86
>         select ACPI_VIDEO if ACPI && X86
>         select SND_HDA_COMPONENT if SND_HDA_CORE
> +       depends on FBDEV || !FBDEV
>         help
>           Choose this option for open-source NVIDIA support.
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index eb10c80ed853..e8560444ab57 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -697,7 +697,8 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
>         nvkm_device_del(&device);
>
>         /* Remove conflicting drivers (vesafb, efifb etc). */
> -       ret = remove_conflicting_pci_framebuffers(pdev, "nouveaufb");
> +       if (IS_ENABLED(CONFIG_FBDEV))
> +               ret = remove_conflicting_pci_framebuffers(pdev, "nouveaufb");
>         if (ret)
>                 return ret;
>
> --
> 2.26.2
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
