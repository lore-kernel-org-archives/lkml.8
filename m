Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422B1C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 11:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BD502081A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 11:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="JcNP/sXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgEQLGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 07:06:51 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:43824 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgEQLGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 07:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1589713609; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+8uUs3KZErtQFYLwRFcI4Y9Qu/GahR4WBEx76kMicU=;
        b=JcNP/sXXR5LlAQyGgIDVT84jR1N8QUsQZViSBBi4neVMfuz8zSKI3xrAbm6Kt4hZTkGpY8
        oANNPgIIs9BhTuh23iqoxGTXZyOnEhbUrzyq5kOrxlI15KXhg6XigZB2qW1jydrd/+UJ55
        TLLg3EO0buSMfIKZ5hHd8H+D4AJM7O8=
Date:   Sun, 17 May 2020 13:06:38 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 02/12] dt-bindings: display: Add ingenic,ipu.yaml
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, od@zcrc.me,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Message-Id: <2V2HAQ.FED0YBJJAZ7D2@crapouillou.net>
In-Reply-To: <20200517061710.GB609600@ravnborg.org>
References: <20200516215057.392609-1-paul@crapouillou.net>
        <20200516215057.392609-2-paul@crapouillou.net>
        <20200517061710.GB609600@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Le dim. 17 mai 2020 =E0 8:17, Sam Ravnborg <sam@ravnborg.org> a =E9crit :
> Hi Paul.
> On Sat, May 16, 2020 at 11:50:47PM +0200, Paul Cercueil wrote:
>>  Add documentation of the Device Tree bindings for the Image=20
>> Processing
>>  Unit (IPU) found in most Ingenic SoCs.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>=20
> For me it fails like this:

Oops. I missed the 'const:' in the item list. Will fix when I send a=20
V2, and verify it this time.

Cheers,
-Paul

> /Documentation/devicetree/bindings/display/ingenic,ipu.yaml:=20
> ignoring, error in schema: properties: compatible: oneOf: 1: items
> warning: no schema found in file:=20
> Documentation/devicetree/bindings/display/ingenic,ipu.yaml
> make[2]: *** [Documentation/devicetree/bindings/Makefile:42:=20
> Documentation/devicetree/bindings/processed-schema.yaml] Error 255
> make[2]: *** Waiting for unfinished jobs....
> Documentation/devicetree/bindings/display/ingenic,ipu.yaml:=20
> properties:compatible:oneOf:1:items: ['ingenic,jz4770-ipu',=20
> 'ingenic,jz4760-ipu'] is not valid under any of the given schemas=20
> (Possible causes of the failure):
> 	Documentation/devicetree/bindings/display/ingenic,ipu.yaml:=20
> properties:compatible:oneOf:1:items: ['ingenic,jz4770-ipu',=20
> 'ingenic,jz4760-ipu'] is not of type 'object', 'boolean'
> 	Documentation/devicetree/bindings/display/ingenic,ipu.yaml:=20
> properties:compatible:oneOf:1:items:0: 'ingenic,jz4770-ipu' is not of=20
> type 'object', 'boolean'
> 	Documentation/devicetree/bindings/display/ingenic,ipu.yaml:=20
> properties:compatible:oneOf:1:items:1: 'ingenic,jz4760-ipu' is not of=20
> type 'object', 'boolean'
>=20
>=20
> 	Sam
>=20
>>  ---
>>   .../bindings/display/ingenic,ipu.yaml         | 65=20
>> +++++++++++++++++++
>>   1 file changed, 65 insertions(+)
>>   create mode 100644=20
>> Documentation/devicetree/bindings/display/ingenic,ipu.yaml
>>=20
>>  diff --git=20
>> a/Documentation/devicetree/bindings/display/ingenic,ipu.yaml=20
>> b/Documentation/devicetree/bindings/display/ingenic,ipu.yaml
>>  new file mode 100644
>>  index 000000000000..22fe02ca866d
>>  --- /dev/null
>>  +++ b/Documentation/devicetree/bindings/display/ingenic,ipu.yaml
>>  @@ -0,0 +1,65 @@
>>  +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>  +%YAML 1.2
>>  +---
>>  +$id: http://devicetree.org/schemas/display/ingenic,ipu.yaml#
>>  +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>  +
>>  +title: Ingenic SoCs Image Processing Unit (IPU) devicetree bindings
>>  +
>>  +maintainers:
>>  +  - Paul Cercueil <paul@crapouillou.net>
>>  +
>>  +properties:
>>  +  compatible:
>>  +    oneOf:
>>  +      - enum:
>>  +        - ingenic,jz4725b-ipu
>>  +        - ingenic,jz4760-ipu
>>  +      - items:
>>  +        - ingenic,jz4770-ipu
>>  +        - ingenic,jz4760-ipu
>>  +
>>  +  reg:
>>  +    maxItems: 1
>>  +
>>  +  interrupts:
>>  +    maxItems: 1
>>  +
>>  +  clocks:
>>  +    maxItems: 1
>>  +
>>  +  clock-names:
>>  +    const: ipu
>>  +
>>  +patternProperties:
>>  +  "^ports?$":
>>  +    description: OF graph bindings (specified in=20
>> bindings/graph.txt).
>>  +
>>  +required:
>>  +  - compatible
>>  +  - reg
>>  +  - interrupts
>>  +  - clocks
>>  +  - clock-names
>>  +
>>  +additionalProperties: false
>>  +
>>  +examples:
>>  +  - |
>>  +    #include <dt-bindings/clock/jz4770-cgu.h>
>>  +    ipu@13080000 {
>>  +      compatible =3D "ingenic,jz4770-ipu", "ingenic,jz4760-ipu";
>>  +      reg =3D <0x13080000 0x800>;
>>  +
>>  +      interrupt-parent =3D <&intc>;
>>  +      interrupts =3D <29>;
>>  +
>>  +      clocks =3D <&cgu JZ4770_CLK_IPU>;
>>  +      clock-names =3D "ipu";
>>  +
>>  +      port {
>>  +        ipu_ep: endpoint {
>>  +          remote-endpoint =3D <&lcdc_ep>;
>>  +        };
>>  +      };
>>  +    };
>>  --
>>  2.26.2
>>=20
>>  _______________________________________________
>>  dri-devel mailing list
>>  dri-devel@lists.freedesktop.org
>>  https://lists.freedesktop.org/mailman/listinfo/dri-devel


