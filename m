Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55432C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A59A206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="RUtGBy/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgG0RMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:12:45 -0400
Received: from crapouillou.net ([89.234.176.41]:57330 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728939AbgG0RMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595869961; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QQPLs8G7xnlp4G++Lxr0CaXPWeOA/xM0miRvxkULoFU=;
        b=RUtGBy/i4V/XNluTUdmDFr74yRTLWR7L1GRbbP9w7yddGXxuLrCUkfhlvzs4CPyU6AYG5P
        lSEix0m2n1AsiO3Ft1WNq/ulI22WuJxsx+PDi0yGmbG6tWTwJ7HQApZL8etJXeDW8n3Z51
        HR3qTj0qqZoxYAjpBwCmrB8+rbnG1h4=
Date:   Mon, 27 Jul 2020 19:12:32 +0200
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
Message-Id: <W415EQ.VPN8W77YD4D13@crapouillou.net>
In-Reply-To: <20200727170302.GA3507@kozik-lap>
References: <CAJKOXPc2w0QHQDEwqoeg9Nm361MszM4LRaCoJD2En-fPgPp+4Q@mail.gmail.com>
        <IBDZDQ.K28R5FAI0BXI2@crapouillou.net> <20200724155436.GA7460@kozik-lap>
        <K5Y0EQ.WYAK00ADM46F3@crapouillou.net>
        <CAK8P3a0HDu15u5dREd6gk_e9D6mrZ9JqT0DJs9AeC9C2602nAw@mail.gmail.com>
        <20200726160616.GA2662@kozik-lap> <RO33EQ.546WD84D5N7K2@crapouillou.net>
        <20200726161545.GA6058@kozik-lap> <B243EQ.VEXGA7ZL5JAE2@crapouillou.net>
        <CAK8P3a1r6AMz2wKBEosAqn7qkuJY4LGFYK7o85sO++d+TSVOgQ@mail.gmail.com>
        <20200727170302.GA3507@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le lun. 27 juil. 2020 =E0 19:03, Krzysztof Kozlowski <krzk@kernel.org> a=20
=E9crit :
> On Mon, Jul 27, 2020 at 09:55:54AM +0200, Arnd Bergmann wrote:
>>  On Sun, Jul 26, 2020 at 6:20 PM Paul Cercueil=20
>> <paul@crapouillou.net> wrote:
>>  > Le dim. 26 juil. 2020 =E0 18:15, Krzysztof Kozlowski=20
>> <krzk@kernel.org> a =E9crit :
>>  > > On Sun, Jul 26, 2020 at 06:12:27PM +0200, Paul Cercueil wrote:
>>  > >>  Le dim. 26 juil. 2020 =E0 18:06, Krzysztof Kozlowski=20
>> <krzk@kernel.org> a =E9crit
>>   >
>>  > > OK, that's true. Anyway, I don't have strong opinion on any of=20
>> this. I
>>  > > just followed Arnd's hint.
>>  > >
>>  > > For the memory driver (and MTD NAND as well) which one you=20
>> prefer:
>>  > > 1.=20
>> https://lore.kernel.org/lkml/20200724074038.5597-6-krzk@kernel.org/
>>  > > 2. depends on MACH_INGENIC || MIPS_GENERIC || COMPILE_TEST
>>  > >
>>  > > ?
>>  >
>>  > I'd say a slightly modified #1. The driver shouldn't be "default=20
>> y" in
>>  > the first place, so the patch could be to disable it by default.
>>=20
>>  If it defaults to 'n' even for MACH_INGENIC, you may have to enable
>>  it in the four defconfig files for these machines to avoid=20
>> surprises.
>=20
> Exactly. Nothing else selects JZ4780_NEMC, so either we keep default y
> ("if MACH_INGENIC || MIPS_GENERIC"), or you select it directly from
> MACH_INGENIC/MIPS_GENERIC.
>=20
> A related question is how essential are these drivers? At least for=20
> ARM
> platforms, all essential SoC blocks/IPs are selected by default, if
> support for chosen SoC is enabled. Only non-essential stuff is left,
> e.g. DRM, cpufreq, devfreq, ADC, crypto, video, USB, eMMC (although=20
> one
> could argue that it is essential), IOMMU.

They are only used for NAND access, which is not really essential (some
boards only use MMC storage), that's why I said they shouldn't have been
enabled by default in the first place.

-Paul

>=20
>>  > And when the Ingenic code is merged into the MIPS generic=20
>> framework, I'll
>>  > send a set of patches to change all driver dependencies on MIPS to
>>  > MIPS_GENERIC.
>>=20
>>  The way we do it on Arm, the machine Kconfig identifiers stay around
>>  even for multiplatform targets (which now make up basically actively
>>  maintained machines).
>>=20
>>  I don't think it makes any sense for a driver to depend on=20
>> MIPS_GENERIC:
>>  either it is a generic driver that should always be visible or it=20
>> is specific
>>  to a set of SoCs and should depend on some corresponding vendor
>>  specific identifiers.
>=20
> If support for Ingenic is provided also by MIPS_GENERIC (without
> selecting MACH_INGENIC), then it makes sense. This would be just a
> different way than ARM of building multi-platform kernel.
>=20
> Best regards,
> Krzysztof


