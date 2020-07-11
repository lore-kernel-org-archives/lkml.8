Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D306CC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 18:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEEEA20748
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 18:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0fjdQ81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgGKSQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 14:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbgGKSQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 14:16:28 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB6AC08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 11:16:28 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id h16so7800373ilj.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 11:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=geu2kZgahNe9b5KHjjbh7SFWlsAj55pE2E75iM1ych0=;
        b=X0fjdQ810z3wTjdJay1KUkowDb+URPCThXgTUgZ5mxV3PJ/aSIF+bJ8IUiYLEQk/hj
         rmwx5PF05Q+ZQtt3tlCafxCUtsZjGcrC2pjuB0JUr250pGqXsjAXx3JQKtnFs2ptrq+m
         6TFqO0jMjPL/6Mw8cqInWtgJZ3VV2qOubS1m6JnkIPszLALgig0co7MQ6npyfWtRSjJp
         cnWUSkaVlNuZYU40L8cyKAL2ozPDGuX9wuu/6+QfsfmxYgJE2oED3KA8HDmi65MtO50d
         18j7CRCshuNJMX43CGDQj2UJ4gdPJadD8xOg1/CYUI6/h3NGL3EsQhY2ofFCVdgpagSt
         YMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=geu2kZgahNe9b5KHjjbh7SFWlsAj55pE2E75iM1ych0=;
        b=RWh6s22NMU0lcgTefezj+EjSzNTVd08EQnKcX3sFxcsoyyCEuHLKe7NZ5vjw85+LRX
         UhCtcepZ5Y1ujZlQfv5Tcxvc8QWFqwsrCT4FJruu4/Y81GudDl4c8ChAoR/Xy2NvFdth
         iZ8OsNQnsmKpxGBqIS4UxlWamNOVyYAh6Y5CnXZQJ/W6Fwj5t8pTbnQeWP34dHrrEaPT
         c9QJiCba5balDN4A6IO4VieYUfvfngZ++aKv+6MjFBqnV/Uuv4I+bP3XPaduUJryaMSL
         odiKrv80z1tyAYmAA6Q09c3Cibkeesy6FCQ6n3IKyGW8Y1lqR9vi7mCVIEDRFqAqfS0U
         VVuA==
X-Gm-Message-State: AOAM532c0BNadh82rTbFp/jK0Pv6lMu+SpcHB2bJ10O7kDFJ4vvhhrSv
        GhsenGDl7m1iCw08WK7JeO0V1mgdC6ZRuC8yQug=
X-Google-Smtp-Source: ABdhPJwpw5572tWDlCz5wNVisy7er9T7PNOSVi4wAApd2GV67UhMooli2i5OYJk6kw5hqHKV56lQtFIw/W/A+/L8awY=
X-Received: by 2002:a92:1547:: with SMTP id v68mr28974624ilk.294.1594491387694;
 Sat, 11 Jul 2020 11:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200711070835.4855-1-navid.emamdoost@gmail.com> <s5htuye2zjn.wl-tiwai@suse.de>
In-Reply-To: <s5htuye2zjn.wl-tiwai@suse.de>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Sat, 11 Jul 2020 13:16:16 -0500
Message-ID: <CAEkB2ESiSEt6Rhs7iyni7C79LEUSCiKvtfxXRHzHU+dmkSag0A@mail.gmail.com>
Subject: Re: [PATCH] ALSA: trident: Fix a memory leak in snd_trident_create
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 11, 2020 at 4:04 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Sat, 11 Jul 2020 09:08:30 +0200,
> Navid Emamdoost wrote:
> >
> > In the implementation of snd_trident_create(), the allocated trident is
> > leaked if snd_trident_mixer() fails. Release via snd_trident_free().
>
> No, this patch would result in double-free.
>
> The manual release of trident object isn't needed once after it gets
> added via snd_device_new().  Then it'll be automatically released at
> the error path (via snd_trident_dev_free()).

Thanks for the clarification.

>
>
> thanks,
>
> Takashi
>
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> >  sound/pci/trident/trident_main.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
> > index 6e50376163a2..e98c692f6aa9 100644
> > --- a/sound/pci/trident/trident_main.c
> > +++ b/sound/pci/trident/trident_main.c
> > @@ -3582,8 +3582,11 @@ int snd_trident_create(struct snd_card *card,
> >               return err;
> >       }
> >
> > -     if ((err = snd_trident_mixer(trident, pcm_spdif_device)) < 0)
> > +     err = snd_trident_mixer(trident, pcm_spdif_device);
> > +     if (err < 0) {
> > +             snd_trident_free(trident);
> >               return err;
> > +     }
> >
> >       /* initialise synth voices */
> >       for (i = 0; i < 64; i++) {
> > --
> > 2.17.1
> >



-- 
Navid.
