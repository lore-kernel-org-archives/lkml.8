Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC81C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 12:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 481CD206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 12:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ghKqg4gz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgGYMiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 08:38:22 -0400
Received: from crapouillou.net ([89.234.176.41]:42190 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbgGYMiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 08:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595680698; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7/K1S5tO51vq/D+dmrYz3As5SIimWsQTOvR+jAS/StA=;
        b=ghKqg4gz7SdSK24i50kGFGHfl0MbRKgPV2np40eRUeza0f0TdUyz45XbZpXG5OlPfgznXU
        sG6U+iHaq0jl/vWp1adyDthxFqD1UGwCDFSZLJjhHYIUrHRgNmqW4KcWGUvsmphNv0mMtZ
        prdsEhlSIza2jpawcun6cR9uVHf9VnU=
Date:   Sat, 25 Jul 2020 14:38:07 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] MAINTAINERS: Add linux-mips mailing list to JZ47xx
 entries
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org
Message-Id: <J3Z0EQ.V70YLMM6L6RR2@crapouillou.net>
In-Reply-To: <20200724155816.8125-1-krzk@kernel.org>
References: <20200724155816.8125-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Le ven. 24 juil. 2020 =E0 17:58, Krzysztof Kozlowski <krzk@kernel.org> a=20
=E9crit :
> The entries for JZ47xx SoCs and its drivers lacked MIPS mailing list.
> Only MTD NAND driver pointed linux-mtd.  Add linux-mips so the=20
> relevant
> patches will get attention of MIPS developers.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cba0ed77775b..f41fc775a3c9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8543,17 +8543,20 @@ F:	samples/bpf/ibumad_user.c
>=20
>  INGENIC JZ4780 DMA Driver
>  M:	Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> +L:	linux-mips@vger.kernel.org
>  S:	Maintained
>  F:	drivers/dma/dma-jz4780.c

This entry can be removed completely, Zubair specified that he does not=20
maintain this driver anymore. Besides this e-mail address is no more=20
valid.

With that said:
Acked-by: Paul Cercueil <paul@crapouillou.net>

>=20
>  INGENIC JZ4780 NAND DRIVER
>  M:	Harvey Hunt <harveyhuntnexus@gmail.com>
>  L:	linux-mtd@lists.infradead.org
> +L:	linux-mips@vger.kernel.org
>  S:	Maintained
>  F:	drivers/mtd/nand/raw/ingenic/
>=20
>  INGENIC JZ47xx SoCs
>  M:	Paul Cercueil <paul@crapouillou.net>
> +L:	linux-mips@vger.kernel.org
>  S:	Maintained
>  F:	arch/mips/boot/dts/ingenic/
>  F:	arch/mips/include/asm/mach-jz4740/
> --
> 2.17.1
>=20


