Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E8DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 16:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D0612065F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 16:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="QUIbvw8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgGZQUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 12:20:46 -0400
Received: from crapouillou.net ([89.234.176.41]:58792 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgGZQUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 12:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595780444; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k9fIRGUZsDc5QSYHsqk9mi+m1nvILWliO5qoklHXvpo=;
        b=QUIbvw8DxF/MhBtGGWBxJkLggcDdT5GyntWyl+JIGJ3rv7nrS4uwKT5NPL0Pj90fI85ha5
        jB1eYCFSuWJ6hxsvf85VSnKHSqLYB9o5I/q2B1nnCAur4NHizz7Hu5Z3Qxn+lXkUpHWk4+
        cWPBsoTzBwhlJufg56uPrvQPEIPCg1Y=
Date:   Sun, 26 Jul 2020 18:20:35 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 2/2] mtd: rawnand: ingenic: Limit MTD_NAND_JZ4780 to
 architecture only
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org,
        linux-mtd <linux-mtd@lists.infradead.org>
Message-Id: <B243EQ.VEXGA7ZL5JAE2@crapouillou.net>
In-Reply-To: <20200726161545.GA6058@kozik-lap>
References: <20200724145401.2566-1-krzk@kernel.org>
        <20200724145401.2566-3-krzk@kernel.org>
        <PWBZDQ.D1XCW6N2YMRA@crapouillou.net>
        <CAJKOXPc2w0QHQDEwqoeg9Nm361MszM4LRaCoJD2En-fPgPp+4Q@mail.gmail.com>
        <IBDZDQ.K28R5FAI0BXI2@crapouillou.net> <20200724155436.GA7460@kozik-lap>
        <K5Y0EQ.WYAK00ADM46F3@crapouillou.net>
        <CAK8P3a0HDu15u5dREd6gk_e9D6mrZ9JqT0DJs9AeC9C2602nAw@mail.gmail.com>
        <20200726160616.GA2662@kozik-lap> <RO33EQ.546WD84D5N7K2@crapouillou.net>
        <20200726161545.GA6058@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le dim. 26 juil. 2020 =E0 18:15, Krzysztof Kozlowski <krzk@kernel.org> a=20
=E9crit :
> On Sun, Jul 26, 2020 at 06:12:27PM +0200, Paul Cercueil wrote:
>>=20
>>=20
>>  Le dim. 26 juil. 2020 =E0 18:06, Krzysztof Kozlowski=20
>> <krzk@kernel.org> a =E9crit
>>  :
>>  > On Sat, Jul 25, 2020 at 08:30:56PM +0200, Arnd Bergmann wrote:
>>  > >  On Sat, Jul 25, 2020 at 2:17 PM Paul Cercueil
>>  > > <paul@crapouillou.net> wrote:
>>  > >  > Le ven. 24 juil. 2020 =E0 17:54, Krzysztof Kozlowski
>>  > > <krzk@kernel.org> a
>>  > >  > =E9crit :
>>  > >  > > On Fri, Jul 24, 2020 at 05:50:06PM +0200, Paul Cercueil=20
>> wrote:
>>  > >  > >>  Le ven. 24 juil. 2020 =E0 17:33, Krzysztof Kozlowski
>>  > >  > >> <krzk@kernel.org> a =E9crit:
>>  > >  > >>  > On Fri, 24 Jul 2020 at 17:19, Paul Cercueil
>>  > > <paul@crapouillou.net>
>>  > >  > >>  > wrote:
>>  > >  > >>
>>  > >  > >>  On MIPS, the SoC selection is a Kconfig "choice", so you=20
>> can
>>  > > only
>>  > >  > >> support
>>  > >  > >>  one SoC family, unfortunately.
>>  > >  > >
>>  > >  > > Let's say someone selected then some other architecture
>>  > >  > > (MIPS_ALCHEMY).
>>  > >  > > They could select this MTD driver.
>>  > >  > >
>>  > >  > > Does it mean they would be able to run it on Ingenic=20
>> hardware?
>>  > >  >
>>  > >  > In *theory* yes, as long as the Kconfig options that=20
>> MACH_INGENIC
>>  > >  > selects are enabled, the kernel should boot and work on=20
>> Ingenic
>>  > > SoCs.
>>  > >
>>  > >  Right now, this won't work yet, because there are platform=20
>> specific
>>  > >  functions that are implemented by each of the platforms in
>>  > > arch/mips,
>>  > >  e.g. arch/mips/generic/init.c and arch/mips/jz4740/setup.c.
>>  >
>>  > I would say even more - no DTS would be provided for such=20
>> configuration.
>>  > All Ingenic DTSes are included only with MACH_INGENIC.  You=20
>> cannot build
>>  > a kernel working on Ingenic without MACH_INGENIC. Even in theory.
>>=20
>>  But the devicetree doesn't have to be built-in.
>>=20
>=20
> OK, that's true. Anyway, I don't have strong opinion on any of this. I
> just followed Arnd's hint.
>=20
> For the memory driver (and MTD NAND as well) which one you prefer:
> 1. https://lore.kernel.org/lkml/20200724074038.5597-6-krzk@kernel.org/
> 2. depends on MACH_INGENIC || MIPS_GENERIC || COMPILE_TEST
>=20
> ?

I'd say a slightly modified #1. The driver shouldn't be "default y" in=20
the first place, so the patch could be to disable it by default. And=20
when the Ingenic code is merged into the MIPS generic framework, I'll=20
send a set of patches to change all driver dependencies on MIPS to=20
MIPS_GENERIC.

-Paul


