Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C98CC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 12:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03306206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 12:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="SV4m4sV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgGYMR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 08:17:57 -0400
Received: from crapouillou.net ([89.234.176.41]:54990 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbgGYMR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 08:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595679474; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wtjs9oz1J8j+LAftrjDeBoK7mRdXj3uB7dc2tv4J+8s=;
        b=SV4m4sV10yvBP+o7Wh0Oh1KVAdbLXfM9h4DPNfVo5RUy32+HNMFiS2U6G1Xk9v64icxXxa
        vIaaH7lffvJ85wzbEIirinP72c8nVaDFBBlmB2ojIFEmFU7J+gPR2jrYoWr820RM3uVRIX
        sv4ybxk1MVhWVYVgF4ekUcCaCcAl3O4=
Date:   Sat, 25 Jul 2020 14:17:44 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 2/2] mtd: rawnand: ingenic: Limit MTD_NAND_JZ4780 to
 architecture only
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>
Message-Id: <K5Y0EQ.WYAK00ADM46F3@crapouillou.net>
In-Reply-To: <20200724155436.GA7460@kozik-lap>
References: <20200724145401.2566-1-krzk@kernel.org>
        <20200724145401.2566-3-krzk@kernel.org>
        <PWBZDQ.D1XCW6N2YMRA@crapouillou.net>
        <CAJKOXPc2w0QHQDEwqoeg9Nm361MszM4LRaCoJD2En-fPgPp+4Q@mail.gmail.com>
        <IBDZDQ.K28R5FAI0BXI2@crapouillou.net> <20200724155436.GA7460@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le ven. 24 juil. 2020 =E0 17:54, Krzysztof Kozlowski <krzk@kernel.org> a=20
=E9crit :
> On Fri, Jul 24, 2020 at 05:50:06PM +0200, Paul Cercueil wrote:
>>=20
>>=20
>>  Le ven. 24 juil. 2020 =E0 17:33, Krzysztof Kozlowski=20
>> <krzk@kernel.org> a =E9crit
>>  :
>>  > On Fri, 24 Jul 2020 at 17:19, Paul Cercueil <paul@crapouillou.net>
>>  > wrote:
>>  > >
>>  > >  Hi Krzysztof,
>>  > >
>>  > >
>>  > >  Le ven. 24 juil. 2020 =E0 16:54, Krzysztof Kozlowski
>>  > > <krzk@kernel.org> a
>>  > >  =E9crit :
>>  > >  > Enabling the MTD_NAND_JZ4780 driver makes sense only for=20
>> specific
>>  > >  > hardware - the Ingenic SoC architecture.  Set it's=20
>> dependency to
>>  > >  > MACH_INGENIC so it will not appear on unrelated architectures
>>  > > (easier
>>  > >  > job for downstream/distro kernel engineers).
>>  > >
>>  > >  Disagreed. It was done this way so that distro kernels can=20
>> support
>>  > >  multiple SoCs.
>>  >
>>  > They will still be able to support multiple SoCs. Nothing changed
>>  > here. The same we do for all ARM drivers (SoCs are=20
>> multiplatform)...
>>  > Unless you want to say that it is possible to support Ingenic SoC
>>  > without MACH_INGENIC?
>>=20
>>  On MIPS, the SoC selection is a Kconfig "choice", so you can only=20
>> support
>>  one SoC family, unfortunately.
>=20
> Let's say someone selected then some other architecture=20
> (MIPS_ALCHEMY).
> They could select this MTD driver.
>=20
> Does it mean they would be able to run it on Ingenic hardware?

In *theory* yes, as long as the Kconfig options that MACH_INGENIC=20
selects are enabled, the kernel should boot and work on Ingenic SoCs.

-Paul

>>  I'm the one to blame for using "depends on
>>  MIPS || COMPILE_TEST" on ingenic drivers, maybe it should depend on
>>  MACH_INGENIC indeed, but then it should be made possible to support=20
>> more
>>  than one SoC family.
>>=20
>>  That's something that should be pointed out to the MIPS mailing=20
>> list, I
>>  believe.
>=20
> Somehow JZ4780 entries in Maintainers do not mention MIPS list...
>=20
>>=20
>>  Btw: Does that mean you are the new maintainer for drivers/memory/?
>=20
> Yes, that's the coming change.
>=20
> https://lore.kernel.org/lkml/20200724140345.GB13472@kozik-lap/T/#m91ca209=
20a7ec5f228a595f1816c15b6c85b6a09
>=20
> Best regards,
> Krzysztof
>=20


