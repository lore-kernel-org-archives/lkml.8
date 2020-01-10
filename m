Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C30C33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 03:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF56520709
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 03:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YtagBkPG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbgAJDah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 22:30:37 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33573 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731008AbgAJDag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 22:30:36 -0500
Received: by mail-qk1-f196.google.com with SMTP id d71so713281qkc.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 19:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQSajeOAQfVGeFbN5aHcCZ8GjF58hqwqXqYUY48IJUk=;
        b=YtagBkPGR/UTlV1mAAOaFxHMOljHsjjiS2wQLirMR2Fzgxv6EW7TTC4r9B+TL9B1yq
         NWaVFRmAza0aOTXho3BLgyNMOaEUD5rAO+3dadDuLCze91GP2O/xAblQ4Bar8WbQ9n5I
         VHRd0aIuhya384Fv6ydYl7ih39paziVR+/mn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQSajeOAQfVGeFbN5aHcCZ8GjF58hqwqXqYUY48IJUk=;
        b=qNrlDRGnhcXQVqRA4oEOq4qwHOm/hqpqBAaGRTLbD9ohwaXk7ch+gGHhaZu0PklJ7D
         YvbdmUtmzkx+fxcB04c8x9kwl0VLfjL6MSFK/U7W3pDYHcg/dpkwTNZQXXVJOK3OIioe
         aQqZ+at8M0wKm9AIAJ9+nEfN1Naz3IqwADyWJC3npYFqnQfDx4qgyzEkHXl8r1imTKVm
         w4a3zLJFzOwBakQnb4DZzzmkUjASi8Ra/6o7Ws42QfxPx9Wpa0KAeRbc8UNDwwEP0O9a
         76XcSb0BQX7mHz9XUK1wiR8GDpqGj+EroGnL+7LRLCBkIazkrlATlBpon6Q2guxkphX1
         izfQ==
X-Gm-Message-State: APjAAAVgIHvgg/O9CZFRkXRFGhOzKIrBJ1/mm08Ho7DDu+JFcYbMc2Wu
        Doy/eS24AqO3UyPY3dMDJt477GM82SI4quN9AUGme4Gq0jg=
X-Google-Smtp-Source: APXvYqyqYae4Ty6/L3KiMnTOZde/4YuvyLf3n5AY0yto3QcHInG86cTI8HzNsXZrvYXKhV3etEXZdfnWPOf1RinGOSs=
X-Received: by 2002:a37:4bc6:: with SMTP id y189mr1174229qka.18.1578627035990;
 Thu, 09 Jan 2020 19:30:35 -0800 (PST)
MIME-Version: 1.0
References: <20200109133104.11661-1-steven.price@arm.com> <20200109134351.GA3053@kevin>
In-Reply-To: <20200109134351.GA3053@kevin>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 10 Jan 2020 11:30:25 +0800
Message-ID: <CANMq1KBHu6CWsF0hhhxjWK81B+K0BbrVzbKvuwVgcDGO8SBUVg@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Remove core stack power management
To:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     Steven Price <steven.price@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 9:44 PM Alyssa Rosenzweig
<alyssa.rosenzweig@collabora.com> wrote:
>
> A-b
>
> On Thu, Jan 09, 2020 at 01:31:04PM +0000, Steven Price wrote:
> > Explict management of the GPU's core stacks is only necessary in the
> > case of a broken integration with the PDC. Since there are no known
> > platforms which have such a broken integration let's remove the explict
> > control from the driver since this apparently causes problems on other
> > platforms and will have a small performance penality.
> >
> > The out of tree mali_kbase driver contains this text regarding
> > controlling the core stack (CONFIGMALI_CORESTACK):
> >
> >   Enabling this feature on supported GPUs will let the driver powering
> >   on/off the GPU core stack independently without involving the Power
> >   Domain Controller. This should only be enabled on platforms which
> >   integration of the PDC to the Mali GPU is known to be problematic.
> >   This feature is currently only supported on t-Six and t-HEx GPUs.
> >
> >   If unsure, say N.
> >

Work on my G-72 Bifrost, no more errors on power on!

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
Tested-by: Nicolas Boichat <drinkcat@chromium.org>

> > Signed-off-by: Steven Price <steven.price@arm.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_gpu.c | 5 -----
> >  1 file changed, 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> > index 8822ec13a0d6..460fc190de6e 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> > @@ -309,10 +309,6 @@ void panfrost_gpu_power_on(struct panfrost_device *pfdev)
> >       ret = readl_relaxed_poll_timeout(pfdev->iomem + L2_READY_LO,
> >               val, val == pfdev->features.l2_present, 100, 1000);
> >
> > -     gpu_write(pfdev, STACK_PWRON_LO, pfdev->features.stack_present);
> > -     ret |= readl_relaxed_poll_timeout(pfdev->iomem + STACK_READY_LO,
> > -             val, val == pfdev->features.stack_present, 100, 1000);
> > -
> >       gpu_write(pfdev, SHADER_PWRON_LO, pfdev->features.shader_present);
> >       ret |= readl_relaxed_poll_timeout(pfdev->iomem + SHADER_READY_LO,
> >               val, val == pfdev->features.shader_present, 100, 1000);
> > @@ -329,7 +325,6 @@ void panfrost_gpu_power_off(struct panfrost_device *pfdev)
> >  {
> >       gpu_write(pfdev, TILER_PWROFF_LO, 0);
> >       gpu_write(pfdev, SHADER_PWROFF_LO, 0);
> > -     gpu_write(pfdev, STACK_PWROFF_LO, 0);
> >       gpu_write(pfdev, L2_PWROFF_LO, 0);
> >  }
> >
> > --
> > 2.20.1
> >
