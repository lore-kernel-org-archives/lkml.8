Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1062BC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F5224081
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gkc0L1z8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbgCKOVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:21:37 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34024 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729584AbgCKOVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:21:37 -0400
Received: by mail-vs1-f68.google.com with SMTP id t10so1434206vsp.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 07:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AA36Z3gXSwJUntGmt4TTG30h5qvPXt0r2XDT/8zcsfI=;
        b=Gkc0L1z8chPU37ylfxfld8kL1758g6oY0Td7cWlPBhRSaljv0nEP9i+wF1FJLm0Drg
         7zQLQnQGtshFfkBxcXQOD8UJjfPEBJlxiQbOQQRDjlQyYcs4GHopCD3WQpPexAJCvhto
         8XN93qTBP25DLXymYoqMYfRDFiCDl00Tu7l7HwjPGS2KJhr2hl68CUYN42965CRUP9pQ
         ZDPNq0D/OlBZjkMIJz112kgpsvq2mG8Y0bHAG6O4T5kI9wyjM5tx9FQxhltw0y0ATKH4
         ttb7rdiO3me+gomGLr9dPZ6NNBAkBHLub4H4YSPSffAKhD/PJ/7fQfqhDsJtoj4Mb2vw
         xi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AA36Z3gXSwJUntGmt4TTG30h5qvPXt0r2XDT/8zcsfI=;
        b=Q1eJ4oiRAr7zKxXdybM0zvlmPQc7NMBd/a7waeDQxZXbkqOu1t9HbwooP5RkmHMvts
         /j/HS6JtGNqyNvDPWpOKNlZMnKniqED4QiWi4jPkpb1jp4cOd9mo+EJ87RyaqXw/jeYN
         QIfAHGWHy7j6d+PyjuweI/aTg9oOPjkJtuMV5xezt0cqvh8ujW9A1vm1cXh8ElxE1+pn
         Bo1YIkyQEAhTyWA3YkHIgJPUQ/SjO38hnSmdZK+DwU8+tpRzpr5VxazFGQrNqSsu+Fhh
         MB5n1LpgOeH/Kh70+p8tnIyvaeytbdjvn9PRF8vhNwiYgYkPB5Hgo68k/yZU/C5XmhwN
         IVcg==
X-Gm-Message-State: ANhLgQ3zGPPIMPJLRPJ5KIv90eG6WlEOe8D8Cpk8Aq/In0qUjRf1eM1Y
        kYEof7Vb4EfCQyx9tDBLMfnC4nAOsi0d76oLFofN1Q==
X-Google-Smtp-Source: ADFU+vvAwSiaVqdqSV80/n9skavFztB4aCTDjE1foC884CVvIqJg8m9aPx1YictIGAray0JPA7so3t3+znzsKWxY1WY=
X-Received: by 2002:a05:6102:2051:: with SMTP id q17mr2225224vsr.165.1583936495390;
 Wed, 11 Mar 2020 07:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583896344.git.joe@perches.com> <ad408ff8dc4e5fae0884312cb0aa618664e546e5.1583896348.git.joe@perches.com>
 <20200311084052.3ca3c331@xps13>
In-Reply-To: <20200311084052.3ca3c331@xps13>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Mar 2020 15:20:59 +0100
Message-ID: <CAPDyKFo2UensmH_gYkH+u22bs=K9Xn0q3Dr9v6tq6GPNRg_Lew@mail.gmail.com>
Subject: Re: [PATCH -next 013/491] INGENIC JZ47xx SoCs: Use fallthrough;
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Joe Perches <joe@perches.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020 at 08:40, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Joe,
>
> Joe Perches <joe@perches.com> wrote on Tue, 10 Mar 2020 21:51:27 -0700:
>
> > Convert the various uses of fallthrough comments to fallthrough;
> >
> > Done via script
> > Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/
> >
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >  drivers/gpu/drm/ingenic/ingenic-drm.c           | 2 +-
> >  drivers/mmc/host/jz4740_mmc.c                   | 6 ++----
> >  drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c | 2 +-
> >  drivers/mtd/nand/raw/ingenic/jz4725b_bch.c      | 4 ++--
> >  drivers/mtd/nand/raw/ingenic/jz4780_bch.c       | 4 ++--
> >  sound/soc/codecs/jz4770.c                       | 2 +-
> >  6 files changed, 9 insertions(+), 11 deletions(-)
>
> I like very much the new way to advertise for fallthrough statements,
> but I am not willing to take any patch converting a single driver
> anymore. I had too many from Gustavo when these comments had to be
> inserted. I would really prefer a MTD-wide or a NAND-wide or at least a
> raw-NAND-wide single patch (anything inside drivers/mtd/nand/raw/).
>
> Hope you'll understand!

I fully agree (for mmc). One patch please.

Another option is to make a big fat tree wide patch and ask Linus if
he want to pick up immediately after an rc1. That should cause less
disturbance for everyone, no?

Kind regards
Uffe
