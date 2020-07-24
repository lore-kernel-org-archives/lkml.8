Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33665C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10552206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="VvX6/7bg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgGXPTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 11:19:50 -0400
Received: from crapouillou.net ([89.234.176.41]:48558 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbgGXPTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 11:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595603986; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yY2mSWGinvjgTNeh7YWWVKQZmHFDXNi71wQPqYSlDZg=;
        b=VvX6/7bgcPTOLqqKlyAXWf/NK+RZUV58KP9A+f9O6IuizKR9arED+yv52Il1dmfRqt1fEg
        q2Dp9hr34bi0dWJA5gxIAq4shfyduACqNBJIBsbBqc5I5hbC4eg7bgwrfoewtrks0w3Ao9
        a+8bHQw+fBzuW1/AFzSXIU1ym/9ipmg=
Date:   Fri, 24 Jul 2020 17:19:37 +0200
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
Message-Id: <PWBZDQ.D1XCW6N2YMRA@crapouillou.net>
In-Reply-To: <20200724145401.2566-3-krzk@kernel.org>
References: <20200724145401.2566-1-krzk@kernel.org>
        <20200724145401.2566-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,


Le ven. 24 juil. 2020 =E0 16:54, Krzysztof Kozlowski <krzk@kernel.org> a=20
=E9crit :
> Enabling the MTD_NAND_JZ4780 driver makes sense only for specific
> hardware - the Ingenic SoC architecture.  Set it's dependency to
> MACH_INGENIC so it will not appear on unrelated architectures (easier
> job for downstream/distro kernel engineers).

Disagreed. It was done this way so that distro kernels can support=20
multiple SoCs.

-Paul

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>=20
> ---
>=20
> Changes since v2:
> 1. New patch
> ---
>  drivers/mtd/nand/raw/ingenic/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/nand/raw/ingenic/Kconfig=20
> b/drivers/mtd/nand/raw/ingenic/Kconfig
> index 96c5ae8b1bbc..2e3936543ba6 100644
> --- a/drivers/mtd/nand/raw/ingenic/Kconfig
> +++ b/drivers/mtd/nand/raw/ingenic/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config MTD_NAND_JZ4780
>  	tristate "JZ4780 NAND controller"
> -	depends on MIPS || COMPILE_TEST
> +	depends on MACH_INGENIC || COMPILE_TEST
>  	depends on JZ4780_NEMC
>  	help
>  	  Enables support for NAND Flash connected to the NEMC on JZ4780 SoC
> --
> 2.17.1
>=20


