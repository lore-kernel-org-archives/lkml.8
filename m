Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1B0C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 16:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5EF0206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 16:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595779583;
	bh=Gl7iSTibNUB7GRrS0iTlaHgsYF/I80M3BOGJzEYFzjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h5pYjVQ7XW9TzQAfEAiuJVT/TMm9+ZVXa0XVeui9j7IICvBD8GExs0VqyCnumBykE
	 fIGKKUDAj5TQeAX/ghUDW/XVw9Yb8MEcw7O2w4czd0vMU9C+siITa2uJTO5EWXSiPa
	 zi53b+qH26IvLzTnn0UfsIbrFQxE5O7Z32PGJ4c4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgGZQGW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 12:06:22 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33508 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgGZQGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 12:06:21 -0400
Received: by mail-ed1-f68.google.com with SMTP id h28so10376073edz.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 09:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HVDed5GzTM+SeS9A/Yc6EBjUf1WiDYt+EY8Pko2sA2k=;
        b=JDIgHO/hlos2sii4e5GAuOrMURx4Mkj/4l9IE4a6sFdU5FWKRVR8eShm/7WPyPfFd0
         3lEps0R8Yz2kZQ6hHVrCSaHtn0nN6PhIbng5PRjXvi0L9633sRd24/0DIjeazOptpOwR
         MnbsNmEn83H+SplqkVsvp0Ttait8ue9NOLsOcYyrJRBXqXeA1ozRFCIFCLdQFpvHBgcs
         0C91pvYT18Pk12x4bP0/Ikz5+1MF08CRDjPFH9mzRgzzP5F0yAksuT42rBl4I6Gd04gz
         DPIKmB3fX6TELHp4II1BscQjTJHQInU0MUdmFIt8ShvLtTuCXXVCov/7qHhSq1ZddjWb
         KWsg==
X-Gm-Message-State: AOAM532c8syEeuQvRv3HjmW8nW0fDlgGWepDBqZJhLYQbjWCsroIF80p
        3mUHFRAvhT4kQcJ79nJ8liw=
X-Google-Smtp-Source: ABdhPJyLPyzKwOXAsWWyhP51C8gBvqiTT4WGC2guizxtQvvG0OGK4bGBtl2FjRWkQqAcoQwV1gtvvw==
X-Received: by 2002:aa7:d8cf:: with SMTP id k15mr17211563eds.250.1595779579782;
        Sun, 26 Jul 2020 09:06:19 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
        by smtp.googlemail.com with ESMTPSA id sd8sm3385328ejb.58.2020.07.26.09.06.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jul 2020 09:06:18 -0700 (PDT)
Date:   Sun, 26 Jul 2020 18:06:16 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v3 2/2] mtd: rawnand: ingenic: Limit MTD_NAND_JZ4780 to
 architecture only
Message-ID: <20200726160616.GA2662@kozik-lap>
References: <20200724145401.2566-1-krzk@kernel.org>
 <20200724145401.2566-3-krzk@kernel.org>
 <PWBZDQ.D1XCW6N2YMRA@crapouillou.net>
 <CAJKOXPc2w0QHQDEwqoeg9Nm361MszM4LRaCoJD2En-fPgPp+4Q@mail.gmail.com>
 <IBDZDQ.K28R5FAI0BXI2@crapouillou.net>
 <20200724155436.GA7460@kozik-lap>
 <K5Y0EQ.WYAK00ADM46F3@crapouillou.net>
 <CAK8P3a0HDu15u5dREd6gk_e9D6mrZ9JqT0DJs9AeC9C2602nAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAK8P3a0HDu15u5dREd6gk_e9D6mrZ9JqT0DJs9AeC9C2602nAw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 08:30:56PM +0200, Arnd Bergmann wrote:
> On Sat, Jul 25, 2020 at 2:17 PM Paul Cercueil <paul@crapouillou.net> wrote:
> > Le ven. 24 juil. 2020 à 17:54, Krzysztof Kozlowski <krzk@kernel.org> a
> > écrit :
> > > On Fri, Jul 24, 2020 at 05:50:06PM +0200, Paul Cercueil wrote:
> > >>  Le ven. 24 juil. 2020 à 17:33, Krzysztof Kozlowski
> > >> <krzk@kernel.org> a écrit:
> > >>  > On Fri, 24 Jul 2020 at 17:19, Paul Cercueil <paul@crapouillou.net>
> > >>  > wrote:
> > >>
> > >>  On MIPS, the SoC selection is a Kconfig "choice", so you can only
> > >> support
> > >>  one SoC family, unfortunately.
> > >
> > > Let's say someone selected then some other architecture
> > > (MIPS_ALCHEMY).
> > > They could select this MTD driver.
> > >
> > > Does it mean they would be able to run it on Ingenic hardware?
> >
> > In *theory* yes, as long as the Kconfig options that MACH_INGENIC
> > selects are enabled, the kernel should boot and work on Ingenic SoCs.
> 
> Right now, this won't work yet, because there are platform specific
> functions that are implemented by each of the platforms in arch/mips,
> e.g. arch/mips/generic/init.c and arch/mips/jz4740/setup.c.

I would say even more - no DTS would be provided for such configuration.
All Ingenic DTSes are included only with MACH_INGENIC.  You cannot build
a kernel working on Ingenic without MACH_INGENIC. Even in theory.

> 
> A lot of the newer platforms are part of arch/mips/generic
> (CONFIG_MIPS_GENERIC), which roughly corresponds to
> CONFIG_ARCH_MULTIPLATFORM on in arch/arm/.
> Similarly, there are header files in arch/mips/include/asm/mach-*/
> that conflict and you need to have the right one.
> 
> To have more than one platform enabled, each one needs to
> have all of that platform code converted to fit into the
> MIPS_GENERIC framework. This can be a lot of work, but
> I suppose the ingenic platform would be a candidate for
> which this makes sense, as long as new SoCs of that family
> still come out.

I can therefore change the patch to:
depends on MACH_INGENIC || MIPS_GENERIC || COMPILE_TEST

Other solution is to leave MTD driver as is and for the memory driver go
with my v2 approach:
https://lore.kernel.org/lkml/20200724074038.5597-6-krzk@kernel.org/

Best regards,
Krzysztof

