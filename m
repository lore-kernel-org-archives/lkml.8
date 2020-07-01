Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91853C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6756E20771
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="PAr96xZA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="pa/FN35O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732722AbgGARVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 13:21:45 -0400
Received: from relay5.mymailcheap.com ([159.100.248.207]:55362 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgGARVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 13:21:44 -0400
X-Greylist: delayed 340 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Jul 2020 13:21:42 EDT
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.199.117])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id C4C8E2634F;
        Wed,  1 Jul 2020 17:16:00 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id 70A263F1D0;
        Wed,  1 Jul 2020 19:15:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 38A662A514;
        Wed,  1 Jul 2020 19:15:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1593623714;
        bh=INLbBUm6KCC6ep5sjzH746qIHvSD5JWXu0vO2Bff8Es=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=PAr96xZARsThxj/DqTEWzFDQ40ZNuRmKqr4bvVeYU84lUurcynUnkimqlt/t3Up/V
         OS7YLwngUbgqvnMiZ72MIFQHvctzD5CxisuHp/us9hOFROlEIyQCc99dwaOxaPwMYf
         6gk1RypDwTuf4wcvZoeDQZvVd1hMboSj8ERyajgA=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QBz6TygpYTK1; Wed,  1 Jul 2020 19:15:12 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Wed,  1 Jul 2020 19:15:12 +0200 (CEST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 45B6040842;
        Wed,  1 Jul 2020 17:15:04 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="pa/FN35O";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [172.19.0.1] (unknown [64.225.114.122])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 6E11140842;
        Wed,  1 Jul 2020 17:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1593623681; bh=INLbBUm6KCC6ep5sjzH746qIHvSD5JWXu0vO2Bff8Es=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=pa/FN35Om/1LGd9F8uy1es7wSm/UHgN2AvfkQBAn9u6MJBHr5prBeY3A7+Yv5in9C
         R1XARGiF76TKknam84nUcCoLja/BgALU6z3VaVRQo4U+WFI30Wq0PW0rfNyn487tG7
         e5M0AJu4kZWb44Zb2slBWqzN6/D64FIqZEtcyYvQ=
Date:   Wed, 01 Jul 2020 20:01:14 +0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20200701103126.1512615-14-megous@megous.com>
References: <20200701103126.1512615-1-megous@megous.com> <20200701103126.1512615-14-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 13/13] arm64: dts: sun50i-a64-pinephone: Add touchscreen support
To:     Ondrej Jirman <megous@megous.com>, linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?ISO-8859-1?Q?Guido_G=FCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <78C72279-99DB-4FDE-81B3-1CF6BEF80BBF@aosc.io>
X-Rspamd-Queue-Id: 45B6040842
X-Spamd-Result: default: False [1.40 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_TWELVE(0.00)[20];
         RCVD_IN_DNSWL_NONE(0.00)[213.133.102.83:from];
         FREEMAIL_TO(0.00)[megous.com,googlegroups.com,gmail.com,ravnborg.org,linux.ie,ffwll.ch,sigxcpu.org,puri.sm,kernel.org,csie.org,linaro.org];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Server: mail20.mymailcheap.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2020=E5=B9=B47=E6=9C=881=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=886:=
31:26, Ondrej Jirman <megous@megous=2Ecom> =E5=86=99=E5=88=B0:
>Pinephone has a Goodix GT917S capacitive touchscreen controller on
>I2C0 bus=2E Add support for it=2E
>
>Signed-off-by: Ondrej Jirman <megous@megous=2Ecom>
>Acked-by: Linus Walleij <linus=2Ewalleij@linaro=2Eorg>
>---
> =2E=2E=2E/dts/allwinner/sun50i-a64-pinephone=2Edtsi   | 19 +++++++++++++=
++++++
> 1 file changed, 19 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone=2Edtsi
>b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone=2Edtsi
>index 85a7aa5efd32=2E=2E2d5694446d17 100644
>--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone=2Edtsi
>+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone=2Edtsi
>@@ -123,6 +123,25 @@ &ehci1 {
> 	status =3D "okay";
> };
>=20
>+&i2c0 {
>+	pinctrl-names =3D "default";
>+	pinctrl-0 =3D <&i2c0_pins>;
>+	status =3D "okay";
>+
>+	touchscreen@5d {
>+		compatible =3D "goodix,gt917s", "goodix,gt911";

Please drop gt911 here=2E GT917S belong to the GT1x product line, not the =
same line with GT911=2E

You will see this in the driver=2E

>+		reg =3D <0x5d>;
>+		interrupt-parent =3D <&pio>;
>+		interrupts =3D <7 4 IRQ_TYPE_LEVEL_HIGH>; /* PH4 */
>+		irq-gpios =3D <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
>+		reset-gpios =3D <&pio 7 11 GPIO_ACTIVE_HIGH>; /* PH11 */
>+		AVDD28-supply =3D <&reg_ldo_io0>;
>+		VDDIO-supply =3D <&reg_ldo_io0>;
>+		touchscreen-size-x =3D <720>;
>+		touchscreen-size-y =3D <1440>;
>+	};
>+};
>+
> &i2c1 {
> 	status =3D "okay";
>=20
