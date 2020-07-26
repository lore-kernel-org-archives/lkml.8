Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D2FC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 16:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 939402073E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 16:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="bPgAF82U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgGZQGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 12:06:25 -0400
Received: from crapouillou.net ([89.234.176.41]:47986 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgGZQGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 12:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595779582; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d/PZVTcv9XrEDcYY/++e3Teye8k7bnbbZV/Cr5UVzy8=;
        b=bPgAF82UdLVnLdfUjsPgthYqEap5z1iDg/vjuXj6N456wugpclWOY0YZ3kzPZue4Tn1Ayk
        OStaiEu+djv0OyQZJr1RkXKj3UvE3XnStlDxd2UXiCAoVGLt22b2BSJUbdYOwxfJgq/EEO
        RXFikV31lzuZFk8CbOgd4cBd2fs2aK4=
Date:   Sun, 26 Jul 2020 18:06:13 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 2/2] mtd: rawnand: ingenic: Limit MTD_NAND_JZ4780 to
 architecture only
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org,
        linux-mtd <linux-mtd@lists.infradead.org>
Message-Id: <DE33EQ.XSK1UTONAHU61@crapouillou.net>
In-Reply-To: <CAK8P3a0HDu15u5dREd6gk_e9D6mrZ9JqT0DJs9AeC9C2602nAw@mail.gmail.com>
References: <20200724145401.2566-1-krzk@kernel.org>
        <20200724145401.2566-3-krzk@kernel.org>
        <PWBZDQ.D1XCW6N2YMRA@crapouillou.net>
        <CAJKOXPc2w0QHQDEwqoeg9Nm361MszM4LRaCoJD2En-fPgPp+4Q@mail.gmail.com>
        <IBDZDQ.K28R5FAI0BXI2@crapouillou.net> <20200724155436.GA7460@kozik-lap>
        <K5Y0EQ.WYAK00ADM46F3@crapouillou.net>
        <CAK8P3a0HDu15u5dREd6gk_e9D6mrZ9JqT0DJs9AeC9C2602nAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le sam. 25 juil. 2020 =E0 20:30, Arnd Bergmann <arnd@arndb.de> a =E9crit :
> On Sat, Jul 25, 2020 at 2:17 PM Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>  Le ven. 24 juil. 2020 =E0 17:54, Krzysztof Kozlowski=20
>> <krzk@kernel.org> a
>>  =E9crit :
>>  > On Fri, Jul 24, 2020 at 05:50:06PM +0200, Paul Cercueil wrote:
>>  >>  Le ven. 24 juil. 2020 =E0 17:33, Krzysztof Kozlowski
>>  >> <krzk@kernel.org> a =E9crit:
>>  >>  > On Fri, 24 Jul 2020 at 17:19, Paul Cercueil=20
>> <paul@crapouillou.net>
>>  >>  > wrote:
>>  >>
>>  >>  On MIPS, the SoC selection is a Kconfig "choice", so you can=20
>> only
>>  >> support
>>  >>  one SoC family, unfortunately.
>>  >
>>  > Let's say someone selected then some other architecture
>>  > (MIPS_ALCHEMY).
>>  > They could select this MTD driver.
>>  >
>>  > Does it mean they would be able to run it on Ingenic hardware?
>>=20
>>  In *theory* yes, as long as the Kconfig options that MACH_INGENIC
>>  selects are enabled, the kernel should boot and work on Ingenic=20
>> SoCs.
>=20
> Right now, this won't work yet, because there are platform specific
> functions that are implemented by each of the platforms in arch/mips,
> e.g. arch/mips/generic/init.c and arch/mips/jz4740/setup.c.
>=20
> A lot of the newer platforms are part of arch/mips/generic
> (CONFIG_MIPS_GENERIC), which roughly corresponds to
> CONFIG_ARCH_MULTIPLATFORM on in arch/arm/.
> Similarly, there are header files in arch/mips/include/asm/mach-*/
> that conflict and you need to have the right one.
>=20
> To have more than one platform enabled, each one needs to
> have all of that platform code converted to fit into the
> MIPS_GENERIC framework. This can be a lot of work, but
> I suppose the ingenic platform would be a candidate for
> which this makes sense, as long as new SoCs of that family
> still come out.

It should be much less work now that the vast majority of=20
arch/mips/jz4740 is gone. The code left is pretty much generic. I can=20
have a look to convert it to the MIPS_GENERIC framework.

Although the code there is scary. Have a look at=20
arch/mips/include/asm/{machine,mips_machine}.h, you'll see what I mean.

Anyway, I think we're way past the scope of this patch, so for this one:
Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul


