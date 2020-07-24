Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F11EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5797A2063A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ljCMd2Vy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgGXPuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 11:50:18 -0400
Received: from crapouillou.net ([89.234.176.41]:43606 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgGXPuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 11:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595605815; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zmYxQg3f44Gfe54sWwR6EKuiFSXTitHQSi3iS2LUHMI=;
        b=ljCMd2Vyh931R/TRz1ZpNR7/h5hBRDE8SPkdu7K6wxZAieSUbmNLXHIlRNzVRfeB/hjPoK
        WC/7xa8njLPe8EOnWTMYromP+DMBap7kbCiEdgd7frSt54TkOTDtmeuqnT/NVtwdtZuWXB
        z7/IcqTQnVt5tPsr9sNXlciRxL46a8U=
Date:   Fri, 24 Jul 2020 17:50:06 +0200
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
Message-Id: <IBDZDQ.K28R5FAI0BXI2@crapouillou.net>
In-Reply-To: <CAJKOXPc2w0QHQDEwqoeg9Nm361MszM4LRaCoJD2En-fPgPp+4Q@mail.gmail.com>
References: <20200724145401.2566-1-krzk@kernel.org>
        <20200724145401.2566-3-krzk@kernel.org>
        <PWBZDQ.D1XCW6N2YMRA@crapouillou.net>
        <CAJKOXPc2w0QHQDEwqoeg9Nm361MszM4LRaCoJD2En-fPgPp+4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le ven. 24 juil. 2020 =E0 17:33, Krzysztof Kozlowski <krzk@kernel.org> a=20
=E9crit :
> On Fri, 24 Jul 2020 at 17:19, Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>=20
>>  Hi Krzysztof,
>>=20
>>=20
>>  Le ven. 24 juil. 2020 =E0 16:54, Krzysztof Kozlowski=20
>> <krzk@kernel.org> a
>>  =E9crit :
>>  > Enabling the MTD_NAND_JZ4780 driver makes sense only for specific
>>  > hardware - the Ingenic SoC architecture.  Set it's dependency to
>>  > MACH_INGENIC so it will not appear on unrelated architectures=20
>> (easier
>>  > job for downstream/distro kernel engineers).
>>=20
>>  Disagreed. It was done this way so that distro kernels can support
>>  multiple SoCs.
>=20
> They will still be able to support multiple SoCs. Nothing changed
> here. The same we do for all ARM drivers (SoCs are multiplatform)...
> Unless you want to say that it is possible to support Ingenic SoC
> without MACH_INGENIC?

On MIPS, the SoC selection is a Kconfig "choice", so you can only=20
support one SoC family, unfortunately. I'm the one to blame for using=20
"depends on MIPS || COMPILE_TEST" on ingenic drivers, maybe it should=20
depend on MACH_INGENIC indeed, but then it should be made possible to=20
support more than one SoC family.

That's something that should be pointed out to the MIPS mailing list, I=20
believe.

Btw: Does that mean you are the new maintainer for drivers/memory/?

Cheers,
-Paul

> Best regards,
> Krzysztof


