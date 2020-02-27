Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED69C3F34F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EFB20578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="QXHFFlll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbgB0Nsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:48:43 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:37276 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730653AbgB0Nsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1582811318; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U8EHEG3UQNjA4HaBYXHdmP9NqhqX3Zb9Ia6fEhNQAAY=;
        b=QXHFFllloRMGuXUtT013hAbV7mOi6b8FP0crwe0A2LqOyhYISrobkuNR2Sddb1NF1NVWTu
        +GfqibsyfI9SALRcPXQmofyYFrCNykCVCDEsu53F9K4Pw41x1nZuSDcOCzaS+JL3+I20Nl
        5HwNlNJmBDGgF8QiT+KFMQPJPH3YSY8=
Date:   Thu, 27 Feb 2020 10:48:15 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v6 5/7] dt-bindings: MIPS: Document Ingenic SoCs binding.
To:     =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
Cc:     Rob Herring <robh@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, tglx@linutronix.de,
        ralf@linux-mips.org, paulburton@kernel.org,
        jiaxun.yang@flygoat.com, chenhc@lemote.com, sboyd@kernel.org,
        mturquette@baylibre.com, mark.rutland@arm.com,
        daniel.lezcano@linaro.org, geert+renesas@glider.be,
        krzk@kernel.org, ebiederm@xmission.com, miquel.raynal@bootlin.com,
        keescook@chromium.org, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, dongsheng.qiu@ingenic.com
Message-Id: <1582811295.3.1@crapouillou.net>
In-Reply-To: <20200226162907.GA13489@bogus>
References: <1582215889-113034-1-git-send-email-zhouyanjie@wanyeetech.com>
        <1582215889-113034-7-git-send-email-zhouyanjie@wanyeetech.com>
        <20200226162907.GA13489@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mer., f=C3=A9vr. 26, 2020 at 10:29, Rob Herring <robh@kernel.org> a=20
=C3=A9crit :
> On Fri, Feb 21, 2020 at 12:24:47AM +0800, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zh=
ou Yanjie)=20
> wrote:
>>  Document the available properties for the SoC root node and the
>>  CPU nodes of the devicetree for the Ingenic XBurst SoCs.
>>=20
>>  Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
>>  Tested-by: Paul Boddie <paul@boddie.org.uk>
>>  Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wa=
nyeetech.com>
>>  ---
>>=20
>>  Notes:
>>      v1->v2:
>>      Change the two Document from txt to yaml.
>>=20
>>      v2->v3:
>>      Fix formatting errors.
>>=20
>>      v3->v4:
>>      Fix bugs in the two yaml files.
>>=20
>>      v4->v5:
>>      No change.
>>=20
>>      v5->v6:
>>      Rewrite the two yaml files.
>>=20
>>   .../bindings/mips/ingenic/ingenic,cpu.yaml         | 61=20
>> ++++++++++++++++++++++
>>   .../bindings/mips/ingenic/ingenic,soc.yaml         | 34=20
>> ++++++++++++
>>   2 files changed, 95 insertions(+)
>>   create mode 100644=20
>> Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.yaml
>>   create mode 100644=20
>> Documentation/devicetree/bindings/mips/ingenic/ingenic,soc.yaml
>>=20
>>  diff --git=20
>> a/Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.yaml=20
>> b/Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.yaml
>>  new file mode 100644
>>  index 00000000..ad1fd86
>>  --- /dev/null
>>  +++=20
>> b/Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.yaml
>>  @@ -0,0 +1,61 @@
>>  +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>  +%YAML 1.2
>>  +---
>>  +$id: http://devicetree.org/schemas/mips/ingenic/ingenic,cpu.yaml#
>>  +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>  +
>>  +title: Bindings for Ingenic XBurst family CPUs
>>  +
>>  +maintainers:
>>  +  - =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wanyeetech.c=
om>
>=20
> Blank line here.
>=20
>>  +description: |
>=20
> Drop the '|'.
>=20
>>  +  Ingenic XBurst family CPUs shall have the following properties.
>>  +
>>  +properties:
>>  +  compatible:
>>  +    oneOf:
>>  +
>>  +      - description: Ingenic XBurst=C2=AE1 CPU Core
>>  +        items:
>>  +          - const: ingenic,xburst
>>  +
>>  +      - description: Ingenic XBurst=C2=AE2 CPU Core
>>  +        items:
>>  +          - const: ingenic,xburst2
>=20
> enum:
>   - ingenic,xburst  # Ingenic XBurst=C2=AE1 CPU Core
>   - ingenic,xburst2 # Ingenic XBurst=C2=AE2 CPU Core
>=20
> Though I don't find the description really adds much.

About the enum values: shouldn't they be a bit more descriptive? There=20
has been various versions of the Xburst1 chip, with slightly different=20
instruction sets and hardware (FPU).

-Paul

>>  +
>>  +  reg:
>>  +    description: |
>>  +      The number of the CPU.
>=20
> Drop this.
>=20
> Add:
>=20
> maxItems: 1
>=20
>>  +
>>  +required:
>>  +  - device_type
>>  +  - compatible
>>  +  - reg
>>  +
>>  +examples:
>>  +  - |
>>  +    #include <dt-bindings/clock/jz4780-cgu.h>
>>  +
>>  +    cpus {
>>  +    	#address-cells =3D <1>;
>>  +    	#size-cells =3D <0>;
>>  +
>>  +    	cpu0: cpu@0 {
>>  +    		device_type =3D "cpu";
>>  +    		compatible =3D "ingenic,xburst";
>>  +    		reg =3D <0>;
>>  +
>=20
>>  +    		clocks =3D <&cgu JZ4780_CLK_CPU>;
>>  +    		clock-names =3D "cpu";
>=20
> Not documented.
>=20
>>  +    	};
>>  +
>>  +    	cpu1: cpu@1 {
>>  +    		device_type =3D "cpu";
>>  +    		compatible =3D "ingenic,xburst";
>>  +    		reg =3D <1>;
>>  +
>>  +    		clocks =3D <&cgu JZ4780_CLK_CORE1>;
>>  +    		clock-names =3D "cpu";
>>  +    	};
>>  +    };
>>  +...
>>  diff --git=20
>> a/Documentation/devicetree/bindings/mips/ingenic/ingenic,soc.yaml=20
>> b/Documentation/devicetree/bindings/mips/ingenic/ingenic,soc.yaml
>>  new file mode 100644
>>  index 00000000..8943e73
>>  --- /dev/null
>>  +++=20
>> b/Documentation/devicetree/bindings/mips/ingenic/ingenic,soc.yaml
>>  @@ -0,0 +1,34 @@
>>  +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>  +%YAML 1.2
>>  +---
>>  +$id: http://devicetree.org/schemas/mips/ingenic/ingenic,soc.yaml#
>>  +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>  +
>>  +title: Bindings for Ingenic SoCs with XBurst CPU inside.
>>  +
>>  +maintainers:
>>  +  - =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wanyeetech.c=
om>
>=20
> Blank line.
>=20
>>  +description: |
>>  +  Ingenic SoCs with XBurst CPU inside shall have the following=20
>> properties.
>>  +
>>  +properties:
>>  +  $nodename:
>>  +    const: '/'
>>  +  compatible:
>>  +    oneOf:
>>  +
>>  +      - description: Ingenic JZ47 Series Mobile Application=20
>> Processor
>>  +        items:
>>  +          - const: ingenic,jz4740
>>  +          - const: ingenic,jz4725b
>>  +          - const: ingenic,jz4760
>>  +          - const: ingenic,jz4760b
>>  +          - const: ingenic,jz4770
>>  +          - const: ingenic,jz4780
>=20
> This is defining the root compatible is 6 strings. You want a enum=20
> here
> I think.
>=20
>>  +
>>  +      - description: Ingenic X Series IoT Application Processor
>>  +        items:
>>  +          - const: ingenic,x1000
>>  +          - const: ingenic,x1000e
>>  +          - const: ingenic,x1500
>=20
> Same here.
>=20
> Did you validate your dts file with this schema using 'make=20
> dtbs_check'?
>=20
> Rob

=

