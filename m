Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F11C4BA35
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 01:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF70724672
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 01:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="JezkskDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgB0Bct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 20:32:49 -0500
Received: from vps.xff.cz ([195.181.215.36]:44934 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728146AbgB0Bct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 20:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582767167; bh=WVRy76LC7XiiMA2ZecSI+IWUDn0bUblprAlu9loucFU=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=JezkskDUQCEiG532IBF9XyFgGd66FEgc8MoMom3aeNEk8/V9m9HW0TMzvoP26dDKG
         ulkoJoiXBMHuMqtnsyI0gCfL2z36xJlfJHG13IFgonRq3Ig452NyKrkLeke6pgIhSo
         +3OJtd6LcG+GwkynYDcuVwJ0IDXRtCDk6PIHjivk=
Date:   Thu, 27 Feb 2020 02:32:47 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Georgii Staroselskii <georgii.staroselskii@emlid.com>,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: sunxi: Add PinePhone 1.0 and
 1.1 bindings
Message-ID: <20200227013247.mufbxd4gsc5c6g6p@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Georgii Staroselskii <georgii.staroselskii@emlid.com>,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200227012650.1179151-1-megous@megous.com>
 <20200227012650.1179151-3-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227012650.1179151-3-megous@megous.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Feb 27, 2020 at 02:26:49AM +0100, megous hlavni wrote:
> Document board compatible names for Pine64 PinePhone:
> 
> - 1.0 - Developer variant
> - 1.1 - Braveheart variant
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>

This also got:

Reviewed-by: Rob Herring <robh@kernel.org>

short time ago on v1. I didn't catch that before sending v2 out.

regards,
	o.

> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
> index 5b22b77e4bb73..abf2d97fb7ae3 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -642,6 +642,16 @@ properties:
>            - const: pine64,pinebook
>            - const: allwinner,sun50i-a64
>  
> +      - description: Pine64 PinePhone Developer Batch (1.0)
> +        items:
> +          - const: pine64,pinephone-1.0
> +          - const: allwinner,sun50i-a64
> +
> +      - description: Pine64 PinePhone Braveheart (1.1)
> +        items:
> +          - const: pine64,pinephone-1.1
> +          - const: allwinner,sun50i-a64
> +
>        - description: Pine64 PineTab
>          items:
>            - const: pine64,pinetab
> -- 
> 2.25.1
> 
