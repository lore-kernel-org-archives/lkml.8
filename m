Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D843C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 032B120702
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="gKHdRUe5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgF3TPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:15:36 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52892 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgF3TPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1593544533; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zyzWH6/6MTK+rTxq8XDIprmsIZUC3mOvx5/gSWX5RU8=;
        b=gKHdRUe5icVdTNy4SwD7Ti8ml9qLxB56EZX3c9BlcAZGFT1A0WA2UptnBHuIvikc8nsN8N
        qtzWKUrU1a2gYB8NlYn0gGotbADHD3N6M5scnB0RXSysaepRpjN4bWig3mKo2ddOkJDwSy
        HeD9n6CYSII4P6FpvlinY6Z+0YlajSM=
Date:   Tue, 30 Jun 2020 21:15:21 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 1/2] dt-bindings: timer: Add Ingenic X1000 OST
 bindings.
To:     =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Message-Id: <LT6RCQ.V5ANBLLSA4OD3@crapouillou.net>
In-Reply-To: <20200630171553.70670-2-zhouyanjie@wanyeetech.com>
References: <20200630171553.70670-1-zhouyanjie@wanyeetech.com>
        <20200630171553.70670-2-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhou,

Le mer. 1 juil. 2020 =C3=A0 1:15, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie)=
=20
<zhouyanjie@wanyeetech.com> a =C3=A9crit :
> Add the OST bindings for the X10000 SoC from Ingenic.
>=20
> Tested-by: =E5=91=A8=E6=AD=A3 (Zhou Zheng) <sernia.zhou@foxmail.com>
> Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wany=
eetech.com>
> ---
>=20
> Notes:
>     v1->v2:
>     No change.
>=20
>     v2->v3:
>     Fix wrong parameters in "clocks".
>=20
>  .../devicetree/bindings/timer/ingenic,ost.yaml     | 61=20
> ++++++++++++++++++++++
>  include/dt-bindings/clock/ingenic,ost.h            | 12 +++++

Please name them ingenic,sysost.yaml and ingenic,sysost.h, to=20
differenciate with the OST that is in the JZ SoCs.

>  2 files changed, 73 insertions(+)
>  create mode 100644=20
> Documentation/devicetree/bindings/timer/ingenic,ost.yaml
>  create mode 100644 include/dt-bindings/clock/ingenic,ost.h
>=20
> diff --git a/Documentation/devicetree/bindings/timer/ingenic,ost.yaml=20
> b/Documentation/devicetree/bindings/timer/ingenic,ost.yaml
> new file mode 100644
> index 000000000000..459dd3d161c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/ingenic,ost.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/ingenic,ost.yaml#
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
> +  and one or more than one 32bit timers for clockevent.

"and one or more than one" -> "and one or more"

> +
> +properties:
> +  compatible:
> +    oneOf:
> +
> +      - description: SYSOST in Ingenic XBurst family SoCs

XBurst is the name of the CPU, not a SoC family, so you would just=20
write 'Ingenic SoCs'. But just drop the description alltogether, it=20
does not add anything valuable.

> +        enum:
> +          - ingenic,x1000-ost
> +          - ingenic,x2000-ost

You have "ingenic,x2000-ost" as a compatible string, but your driver=20
(in patch [2/2]) only handles the first compatible string. Either they=20
are different, in this case the driver should handle both, or they work=20
the same, and in the case the "ingenic,x2000-ost" string should use=20
"ingenic,x1000-ost" as a fallback string.

Cheers,
-Paul

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
> diff --git a/include/dt-bindings/clock/ingenic,ost.h=20
> b/include/dt-bindings/clock/ingenic,ost.h
> new file mode 100644
> index 000000000000..9ac88e90babf
> --- /dev/null
> +++ b/include/dt-bindings/clock/ingenic,ost.h
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


