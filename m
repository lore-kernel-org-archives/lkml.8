Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644FEC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3018D208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FvsPrdXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgCEVUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 16:20:08 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46079 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgCEVUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:20:07 -0500
Received: by mail-pg1-f193.google.com with SMTP id m15so13356pgv.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 13:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=loNKzfZ2WYLORcMWCHnowkSlwOV4uJb56BC4cjXOiZU=;
        b=FvsPrdXRRh3QO/+s411g5ODMr7nz7JNzHdZUNqmf3I0YSid7pOy9SG8unIaxB7I8qK
         0b1WIMrjkovcf2oUrO1UOt4ur/E6lhmkDoUhoGLeuB76SYdb8URghyBAbaZcvdZvGCfd
         9mr95A9Hcj0CUdd2H9PuSaS7ktdpityBgJ8rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=loNKzfZ2WYLORcMWCHnowkSlwOV4uJb56BC4cjXOiZU=;
        b=q8gPnEYnVsQoS4WM7YQ70cRI6XLixyW0AOXTD5fVCR9lGypTcoz4fT4nFQdOJApQvg
         iZQACqYbNIPrnQkBbot4FgXjOU/+CAipyc3eOYjDDR7pkiMm9ln8zE/kXVT0N8V7OoWL
         8R42Vg2FtLlMrzl/wo7/BcUeBANIG6r6JiARB6+oEykX1sBbKkeL+d45KDDl+vWjG1av
         27wRIrLuIZ2K2TVesQrYqxJvmwjljRh9bX5x3GPT+TsEBq25sk6X33OHW2w+8XDOvDDH
         4F7nOTbDOnbFw6Biu15Poqj0kzBs7jzgfhWiMTydF8g5aba8w4lWvJhlm5p/LBPwijTq
         NBOg==
X-Gm-Message-State: ANhLgQ2SZQK6e7j/wxOLhtYk4txSnJBwO/bMJrDrednguoHj4tRnA/J3
        OLKa2M+IQBgFQ/KkQdQld/OTWA==
X-Google-Smtp-Source: ADFU+vvOwKIZrmY5TmSyaDSc10dmgGfZMXiDaur2s6Rjr8CpcpphDf6IrHTFxblTEIC0/8jRjSIHOA==
X-Received: by 2002:aa7:8ad9:: with SMTP id b25mr342124pfd.70.1583443206190;
        Thu, 05 Mar 2020 13:20:06 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q187sm32819052pfq.185.2020.03.05.13.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 13:20:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200305030135.210675-1-pmalani@chromium.org>
References: <20200305030135.210675-1-pmalani@chromium.org>
Subject: Re: [PATCH v2] dt-bindings: Convert usb-connector to YAML format.
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     bleung@chromium.org, heikki.krogerus@linux.intel.com,
        enric.balletbo@collabora.com,
        Prashant Malani <pmalani@chromium.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>, devicetree@vger.kernel.org
Date:   Thu, 05 Mar 2020 13:20:04 -0800
Message-ID: <158344320452.25912.4758137777863945655@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prashant Malani (2020-03-04 19:01:30)
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.ya=
ml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> new file mode 100644
> index 0000000000000..b386e2880405c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -0,0 +1,203 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/connector/usb-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: USB Connector
> +
> +maintainers:
> +  - linux-usb@vger.kernel.org
> +
> +description:
> +  A USB connector node represents a physical USB connector. It should be=
 a child
> +  of a USB interface controller.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - usb-a-connector
> +      - usb-b-connector
> +      - usb-c-connector
> +
> +  label:
> +    description: Symbolic name for the connector.
> +
> +  type:
> +    description: Size of the connector, should be specified in case of U=
SB-A,
> +      USB-B non-fullsize connectors.

Maybe "should be specified in case of non-fullsize 'usb-a-connector' or
'usb-b-connector' compatible connectors"?

> +    $ref: /schemas/types.yaml#definitions/string
> +    enum:
> +      - mini
> +      - micro
> +
> +  self-powered:
> +    description: Set this property if the USB device has its own power s=
ource.
> +    type: boolean
> +
> +  # The following are optional properties for "usb-b-connector".
> +  id-gpios:
> +    description: An input gpio for USB ID pin.
> +    maxItems: 1
> +
> +  vbus-gpios:
> +    description: An input gpio for USB VBus pin, used to detect presence=
 of
> +      VBUS 5V. See gpio/gpio.txt.

Can this be written as bindings/gpio/gpio.txt?

> +    maxItems: 1
> +
> +  vbus-supply:
> +    description: A phandle to the regulator for USB VBUS if needed when =
host
> +      mode or dual role mode is supported.
> +      Particularly, if use an output GPIO to control a VBUS regulator, s=
hould
> +      model it as a regulator. See regulator/fixed-regulator.yaml

And bindings/regulator/fixed-regulator.yaml? The idea is to
disambiguate from kernel Documentation/ directory.

> +
> +  # The following are optional properties for "usb-c-connector".

Is there a way to constrain the binding so that this can't be put in a
connector that doesn't have the usb-c-connector compatible string?

> +  power-role:
> +    description: Determines the power role that the Type C connector will
> +      support. "dual" refers to Dual Role Port (DRP).
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/string
> +    enum:
> +      - source
> +      - sink
> +      - dual
> +
> +  try-power-role:
> +    description: Preferred power role.
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/string
> +    enum:
> +     - source
> +     - sink
> +     - dual
> +
> +  data-role:
> +    description: Data role if Type C connector supports USB data. "dual"=
 refers
> +      Dual Role Device (DRD).
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/string
> +    enum:
> +      - host
> +      - device
> +      - dual

Is there a way to maintain a description for each possible string
property? Then we could move the last sentence in the description above
to be attached to '- dual' here.

> +
> +  # The following are optional properties for "usb-c-connector" with pow=
er
> +  # delivery support.
> +  source-pdos:
> +    description: An array of u32 with each entry providing supported pow=
er
> +      source data object(PDO), the detailed bit definitions of PDO can b=
e found
> +      in "Universal Serial Bus Power Delivery Specification" chapter 6.4=
.1.2
> +      Source_Capabilities Message, the order of each entry(PDO) should f=
ollow
> +      the PD spec chapter 6.4.1. Required for power source and power dua=
l role.
> +      User can specify the source PDO array via PDO_FIXED/BATT/VAR/PPS_A=
PDO()
> +      defined in dt-bindings/usb/pd.h.
> +    minItems: 1
> +    maxItems: 7
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +  sink-pdos:
> +    description: An array of u32 with each entry providing supported pow=
er sink
> +      data object(PDO), the detailed bit definitions of PDO can be found=
 in
> +      "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.3
> +      Sink Capabilities Message, the order of each entry(PDO) should fol=
low the
> +      PD spec chapter 6.4.1. Required for power sink and power dual role=
. User
> +      can specify the sink PDO array via PDO_FIXED/BATT/VAR/PPS_APDO() d=
efined
> +      in dt-bindings/usb/pd.h.
> +    minItems: 1
> +    maxItems: 7
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +  op-sink-microwatt:
> +    description: Sink required operating power in microwatt, if source c=
an't
> +      offer the power, Capability Mismatch is set. Required for power si=
nk and
> +      power dual role.
> +
> +  ports:
> +    description: OF graph bindings (specified in bindings/graph.txt) tha=
t model
> +      any data bus to the connector unless the bus is between parent nod=
e and
> +      the connector. Since a single connector can have multiple data bus=
es every
> +      bus has assigned OF graph port number as described below.

has an assigned?

> +    type: object
> +    properties:
> +      port@0:
> +        type: object
> +        description: High Speed (HS), present in all connectors.
> +
> +      port@1:
> +        type: object
> +        description: Super Speed (SS), present in SS capable connectors.
> +
> +      port@2:
> +        type: object
> +        description: Sideband Use (SBU), present in USB-C.

Likewise, is it possible to constrain this to only usb-c-connector
compatible string based bindings? And if so, does it become required for
that compatible string?

> +
> +    required:
> +      - port@0
> +
> +required:
> +  - compatible
> +
> +examples:
> +  # Micro-USB connector with HS lines routed via controller (MUIC).
> +  - |+
> +    muic-max77843@66 {

Add a reg =3D <0x66>; here? Or drop the unit address above.

> +      usb_con1: connector {
> +        compatible =3D "usb-b-connector";
> +        label =3D "micro-USB";
> +        type =3D "micro";
> +      };
> +    };
> +
> +  # USB-C connector attached to CC controller (s2mm005), HS lines routed
> +  # to companion PMIC (max77865), SS lines to USB3 PHY and SBU to Displa=
yPort.
> +  # DisplayPort video lines are routed to the connector via SS mux in US=
B3 PHY.
> +  - |+
> +    ccic: s2mm005@33 {

Same unit address comment.

> +      usb_con2: connector {
> +        compatible =3D "usb-c-connector";
> +        label =3D "USB-C";
> +
> +        ports {
> +          #address-cells =3D <1>;
> +          #size-cells =3D <0>;
> +
> +          port@0 {
> +            reg =3D <0>;
> +            usb_con_hs: endpoint {
> +              remote-endpoint =3D <&max77865_usbc_hs>;
> +            };
> +          };
> +          port@1 {
> +            reg =3D <1>;
> +            usb_con_ss: endpoint {
> +            remote-endpoint =3D <&usbdrd_phy_ss>;
> +            };
> +          };
> +          port@2 {
> +            reg =3D <2>;
> +            usb_con_sbu: endpoint {
> +            remote-endpoint =3D <&dp_aux>;
> +            };

Tabs should be replaced with spaces.

> +          };
> +        };
> +      };
> +    };
> +
> +  # USB-C connector attached to a typec port controller(ptn5110), which =
has
> +  # power delivery support and enables drp.
> +  - |+
> +    #include <dt-bindings/usb/pd.h>
> +    typec: ptn5110@50 {

Same unit address comment.

> +      usb_con3: connector {
> +        compatible =3D "usb-c-connector";
> +        label =3D "USB-C";
> +        power-role =3D "dual";
> +        try-power-role =3D "sink";
> +        source-pdos =3D <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)>;
> +        sink-pdos =3D <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)
> +                     PDO_VAR(5000, 12000, 2000)>;
> +        op-sink-microwatt =3D <10000000>;
> +      };
> +    };
