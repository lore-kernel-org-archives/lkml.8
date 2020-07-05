Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E5AC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 12:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE4A2065D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 12:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="RlW6be7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgGEMzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 08:55:11 -0400
Received: from crapouillou.net ([89.234.176.41]:33820 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbgGEMzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 08:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1593953708; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GTPMEvsZhARXxNOyjrRI0PJyLdaonOJqaNXwjFD9zYI=;
        b=RlW6be7w4d31xll91sPXO5Vaef4AO8mr0/u7dW7vmeKwhuu218gKJerMr8677TFknGYAQC
        hCvZDa9qt4OCTs6d1m8mU1Ro2wcnWyHudyjMs1EQqYpbp57C7eeJ42Vu7Vv6Xnto61qwKB
        r5Bpzds9nCK4MPu07I76vONcQsFzNqw=
Date:   Sun, 05 Jul 2020 14:54:58 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 1/2] dt-bindings: timer: Add Ingenic X1000 OST
 bindings.
To:     =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org
Message-Id: <MJYZCQ.FA7B2P44XOPM1@crapouillou.net>
In-Reply-To: <20200705123420.20045-2-zhouyanjie@wanyeetech.com>
References: <20200705123420.20045-1-zhouyanjie@wanyeetech.com>
        <20200705123420.20045-2-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhou,

Le dim. 5 juil. 2020 =C3=A0 20:34, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie=
)=20
<zhouyanjie@wanyeetech.com> a =C3=A9crit :
> Add the OST bindings for the X10000 SoC from Ingenic.
>=20
> Tested-by: =E5=91=A8=E6=AD=A3 (Zhou Zheng) <sernia.zhou@foxmail.com>
> Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wany=
eetech.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>=20
> Notes:
>     v1->v2:
>     No change.
>=20
>     v2->v3:
>     Fix wrong parameters in "clocks".
>=20
>     v3->v4:
>     1.Rename "ingenic,ost.yaml" to "ingenic,sysost.yaml".
>     2.Rename "ingenic,ost.h" to "ingenic,sysost.h".
>     3.Modify the description in "ingenic,sysost.yaml".
>=20
>  .../devicetree/bindings/timer/ingenic,sysost.yaml  | 60=20
> ++++++++++++++++++++++
>  include/dt-bindings/clock/ingenic,sysost.h         | 12 +++++
>  2 files changed, 72 insertions(+)
>  create mode 100644=20
> Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
>  create mode 100644 include/dt-bindings/clock/ingenic,sysost.h
>=20
> diff --git=20
> a/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml=20
> b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
> new file mode 100644
> index 000000000000..03257ed806fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/ingenic,sysost.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bindings for SYSOST in Ingenic XBurst family SoCs
> +
> +maintainers:
> +  - =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wanyeetech.com=
>
> +
> +description:
> +  The SYSOST in an Ingenic SoC provides one 64bit timer for=20
> clocksource
> +  and one or more 32bit timers for clockevent.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +
> +      - enum:
> +          - ingenic,x1000-ost
> +          - ingenic,x2000-ost
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: ost
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - "#clock-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/x1000-cgu.h>
> +
> +    ost: timer@12000000 {
> +    		compatible =3D "ingenic,x1000-ost";
> +    		reg =3D <0x12000000 0x3c>;
> +
> +    		#clock-cells =3D <1>;
> +
> +    		clocks =3D <&cgu X1000_CLK_OST>;
> +    		clock-names =3D "ost";
> +
> +    		interrupt-parent =3D <&cpuintc>;
> +    		interrupts =3D <3>;
> +    	};
> +...
> diff --git a/include/dt-bindings/clock/ingenic,sysost.h=20
> b/include/dt-bindings/clock/ingenic,sysost.h
> new file mode 100644
> index 000000000000..9ac88e90babf
> --- /dev/null
> +++ b/include/dt-bindings/clock/ingenic,sysost.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This header provides clock numbers for the ingenic,tcu DT binding.
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_INGENIC_OST_H__
> +#define __DT_BINDINGS_CLOCK_INGENIC_OST_H__
> +
> +#define OST_CLK_PERCPU_TIMER	0
> +#define OST_CLK_GLOBAL_TIMER	1
> +
> +#endif /* __DT_BINDINGS_CLOCK_INGENIC_OST_H__ */
> --
> 2.11.0
>=20


