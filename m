Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F02C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 16:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D44F206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 16:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595780157;
	bh=YSqcHrNmE1AbjO75gijvWV6Joe60SeEGA/uoClNmbIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m3uOqbkDtsBRCp1b0JejdS0cnElLHuG5BpyA5xCb2U+lAPrKCHMobBhnybc+x/8qA
	 XP2Uq53R2expck+MT1VR0ecDUgNVL21fDCSld12B3hLq4+4t+oZ2q/wOwbaXxhHKzF
	 wRaftSa3lUcrH5xfPOEKvukkaDtm9A3O/Pijy8yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgGZQPw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 12:15:52 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:33240 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgGZQPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 12:15:52 -0400
Received: by mail-ej1-f67.google.com with SMTP id g11so2869268ejr.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 09:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LHCX779xDCziv9cINGPr791+zRjJyZ0k/sQQBFyJUkU=;
        b=G8nB0iX+lJo0Vr/MpaE9Cwo3v7bcGamQ6LtTq5XliKv/mP+L/VM3Lbf+bJu9m2cO4w
         Pvukah5lgoB6UkDBJdRu7lYKsrabCBO0+UxwNS/9pWUcCNIt63EhNRvIjxXSsDPGCFWn
         s4W0BiRMeAPlF2ZyPrC9SvYopYTm4u9ukrG8pQio8p3+h4ou8Kwxp7i10Ol5Q8lIXSJM
         Yqfh2GkqfgOtMVbOokzq37RhUhRu89YXzbj/tScv1sfc5qrn9iR58VHINrp8HBlRZYYv
         GZ/cYSjBmYHE201Q1yhs6NzEvqdxr/9yqjP9STOg0vtw5v5l9wcNuGEBuNPUqeKh53XZ
         KbBg==
X-Gm-Message-State: AOAM530FfAaFp1IuIYj46SZt7cV35MOiqMxhy+Ct1PJg97njFWpp8ypL
        Lk9J0MXasJS7kmqzqHzJzWU=
X-Google-Smtp-Source: ABdhPJxnTcSNTUSMfMTn0La6YPwuFCw4PQ75kCsUb7roUhlRYj3yttARKH7FOWYbz6r5ML3+mFGUoQ==
X-Received: by 2002:a17:906:970a:: with SMTP id k10mr2114160ejx.189.1595780148915;
        Sun, 26 Jul 2020 09:15:48 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
        by smtp.googlemail.com with ESMTPSA id i5sm5055198ejg.121.2020.07.26.09.15.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jul 2020 09:15:47 -0700 (PDT)
Date:   Sun, 26 Jul 2020 18:15:45 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org,
        linux-mtd <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v3 2/2] mtd: rawnand: ingenic: Limit MTD_NAND_JZ4780 to
 architecture only
Message-ID: <20200726161545.GA6058@kozik-lap>
References: <20200724145401.2566-1-krzk@kernel.org>
 <20200724145401.2566-3-krzk@kernel.org>
 <PWBZDQ.D1XCW6N2YMRA@crapouillou.net>
 <CAJKOXPc2w0QHQDEwqoeg9Nm361MszM4LRaCoJD2En-fPgPp+4Q@mail.gmail.com>
 <IBDZDQ.K28R5FAI0BXI2@crapouillou.net>
 <20200724155436.GA7460@kozik-lap>
 <K5Y0EQ.WYAK00ADM46F3@crapouillou.net>
 <CAK8P3a0HDu15u5dREd6gk_e9D6mrZ9JqT0DJs9AeC9C2602nAw@mail.gmail.com>
 <20200726160616.GA2662@kozik-lap>
 <RO33EQ.546WD84D5N7K2@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <RO33EQ.546WD84D5N7K2@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 06:12:27PM +0200, Paul Cercueil wrote:
> 
> 
> Le dim. 26 juil. 2020 à 18:06, Krzysztof Kozlowski <krzk@kernel.org> a écrit
> :
> > On Sat, Jul 25, 2020 at 08:30:56PM +0200, Arnd Bergmann wrote:
> > >  On Sat, Jul 25, 2020 at 2:17 PM Paul Cercueil
> > > <paul@crapouillou.net> wrote:
> > >  > Le ven. 24 juil. 2020 à 17:54, Krzysztof Kozlowski
> > > <krzk@kernel.org> a
> > >  > écrit :
> > >  > > On Fri, Jul 24, 2020 at 05:50:06PM +0200, Paul Cercueil wrote:
> > >  > >>  Le ven. 24 juil. 2020 à 17:33, Krzysztof Kozlowski
> > >  > >> <krzk@kernel.org> a écrit:
> > >  > >>  > On Fri, 24 Jul 2020 at 17:19, Paul Cercueil
> > > <paul@crapouillou.net>
> > >  > >>  > wrote:
> > >  > >>
> > >  > >>  On MIPS, the SoC selection is a Kconfig "choice", so you can
> > > only
> > >  > >> support
> > >  > >>  one SoC family, unfortunately.
> > >  > >
> > >  > > Let's say someone selected then some other architecture
> > >  > > (MIPS_ALCHEMY).
> > >  > > They could select this MTD driver.
> > >  > >
> > >  > > Does it mean they would be able to run it on Ingenic hardware?
> > >  >
> > >  > In *theory* yes, as long as the Kconfig options that MACH_INGENIC
> > >  > selects are enabled, the kernel should boot and work on Ingenic
> > > SoCs.
> > > 
> > >  Right now, this won't work yet, because there are platform specific
> > >  functions that are implemented by each of the platforms in
> > > arch/mips,
> > >  e.g. arch/mips/generic/init.c and arch/mips/jz4740/setup.c.
> > 
> > I would say even more - no DTS would be provided for such configuration.
> > All Ingenic DTSes are included only with MACH_INGENIC.  You cannot build
> > a kernel working on Ingenic without MACH_INGENIC. Even in theory.
> 
> But the devicetree doesn't have to be built-in.
>

OK, that's true. Anyway, I don't have strong opinion on any of this. I
just followed Arnd's hint.

For the memory driver (and MTD NAND as well) which one you prefer:
1. https://lore.kernel.org/lkml/20200724074038.5597-6-krzk@kernel.org/
2. depends on MACH_INGENIC || MIPS_GENERIC || COMPILE_TEST

?

Best regards,
Krzysztof
