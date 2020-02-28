Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD7DC3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994CD246AC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="QINoukEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgB1Odl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:33:41 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:35800 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgB1Odl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1582900419; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8SCnzfPW1vtyIWO9dKs1lMmXQSFuS73NbDZ68WEiYZ4=;
        b=QINoukEGp3GbYEJwQJ3N66Uueu0GrA4clstl3HXfMsyxiwLozWVsSypSAZZM+7M1JcfB9P
        px1qrdYbbkdjFqSXEzz1L1DtUaaXq6gJ+6z9geyXRW2SUIoJZuO6VF0l7PleuOo7VaR2Ij
        j5Bwj9zOQU03IP+YhPts/SBx25IXxjo=
Date:   Fri, 28 Feb 2020 11:33:19 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 1/6] MIPS: DTS: jz4780: add #includes for irq.h and
 gpio.h
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Paul Boddie <paul@boddie.org.uk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Message-Id: <1582900399.3.0@crapouillou.net>
In-Reply-To: <043d2e1f931ea85769c0932657e18f2808caa35b.1581884459.git.hns@goldelico.com>
References: <cover.1581884459.git.hns@goldelico.com>
        <043d2e1f931ea85769c0932657e18f2808caa35b.1581884459.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus,


Le dim., f=E9vr. 16, 2020 at 21:20, H. Nikolaus Schaller=20
<hns@goldelico.com> a =E9crit :
> The constants from irq.h and gpio.h can and should be
> used in the jz4780.dtsi and derived DTS like ci20.dts.
>=20
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/mips/boot/dts/ingenic/jz4780.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi=20
> b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> index f928329b034b..112a24deff71 100644
> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <dt-bindings/clock/jz4780-cgu.h>
>  #include <dt-bindings/dma/jz4780-dma.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>

I don't think you need an extra patch for that - just add each include=20
in the patch that first use them.

-Paul

>=20
>  / {
>  	#address-cells =3D <1>;
> --
> 2.23.0
>=20

=

