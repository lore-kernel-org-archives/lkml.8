Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C58C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE222073E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YB9p4P04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbgCKRmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:42:47 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36355 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbgCKRmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:42:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id g12so1432935plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QBqZBgo8j8oxlP5EJ9nLRo0e2YIhm4fAQzuidAy5ELQ=;
        b=YB9p4P04JhICAYpotgqrabR2R1qaDP/IZTgVPCdW3Ivu0MsWyDqBk5EOm059bqBp7C
         DUpNyQWPOGAc8nz/+zr8qmeLNXJC15b6KmDa5D6JiwU0XZi/fRI34WbUqThr++VGp9rC
         bTTGSUBGTRI9glazBJgA/YhKafS5fAq9FniMS/Wm2q17BIwliMWcIRCxPvAu8eLUCDDO
         PQWjQcLdgkHjk6PJE9sYcpE8jIH6cCRnZe9SX97aVDXBeXxJ6WmnM9vHrWzY7gyiywEB
         gx56cB7aKJ8D3LKo4TNpYyfLvm/PHSH8OJNOfNsRV6qyHpTVGlr47FqKdikQcWgFXGKL
         YylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QBqZBgo8j8oxlP5EJ9nLRo0e2YIhm4fAQzuidAy5ELQ=;
        b=stwKlIx0ayVyNXKJIGe+x8CoTqvOaQfKSaRFySoe6nresrEImEjryeb6kQA2J9xj9C
         KlP5ZRQMybGy1qWide34oCgoqUs64RWLTiqgUq2W649X+rezMkOG17si9sbNK3PuE1jT
         tdeyMuQH75zSjsHSheGi2oWMQ7N1+Ke+v1Gz4wtYUU46iXetJY7B4ytdEM6LQVUmRScq
         SsKZnqZZCeBLCsGaEYuXdO5gHGWf5XXuJGd3MkB6/V3kSkW0diLPxFjJkugCVsC2FpQh
         milwcCd8gjGY5COMVh7xLgOA3Ep2EBCEA4G0rCPGtZABntvkeDZ9tKfb6rQsxxw3GT6C
         aBrg==
X-Gm-Message-State: ANhLgQ1nbwuADQQvDEz5xN55AXK6EYQwIld/IkYozOUZe4PrMCIbwYaA
        778KzS4gwmjXqq9DK2E7lmQ/Ig==
X-Google-Smtp-Source: ADFU+vuDCT42JUZJEoKa/xP/dHirK/GQnZ/cISd0wGnVBbBq91RtTpYw3HYqUDLHCE57zy7nw74v8g==
X-Received: by 2002:a17:90a:d988:: with SMTP id d8mr2923510pjv.179.1583948564499;
        Wed, 11 Mar 2020 10:42:44 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id t6sm20435037pfb.172.2020.03.11.10.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 10:42:43 -0700 (PDT)
Date:   Wed, 11 Mar 2020 10:42:38 -0700
From:   Benson Leung <bleung@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     devicetree@vger.kernel.org, bleung@chromium.org,
        swboyd@chromium.org, heikki.krogerus@linux.intel.com,
        enric.balletbo@collabora.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3] dt-bindings: Convert usb-connector to YAML format.
Message-ID: <20200311174238.GA155346@google.com>
References: <20200305222732.133047-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20200305222732.133047-1-pmalani@chromium.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Prashant,

On Thu, Mar 05, 2020 at 02:27:28PM -0800, Prashant Malani wrote:
> Convert the usb-connector.txt bindings file to YAML format. This allows
> it to be used in dt_bindings_check verification. This patch was
> born out of a patch series for the addition of a Type C connector
> class port driver[1].
>=20
> An attempt has been made to maintain the same documentation text and
> example structure as was in the .txt file, but wherever needed
> modifications have been made to satisfy dt_bindings_check.
>=20
> Also, update all references to usb-connector.txt to now use
> usb-connector.yaml.
>=20
> [1]: https://lkml.org/lkml/2020/2/19/1232
>=20
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>=20
> Changes in v3:
> - Updated maintainer list.
> - Fixed grammatical errors in descriptions.
> - Reworded "type" description based on review comments.
> - Added more info to OF graph binding for port@2.
> - Removed address from DT nodes in examples.
>=20
> Changes in v2:
> - Added type references for some properties.
> - Removed pinctrl properties.
> - Updated power-role, try-power-role and data-role properties to be in
>   valid schema format.
> - Added OF graph data bus binding property according to reviewer
>   suggestions.
>=20
>  .../connector/samsung,usb-connector-11pin.txt |   2 +-
>  .../bindings/connector/usb-connector.txt      | 135 ------------
>  .../bindings/connector/usb-connector.yaml     | 206 ++++++++++++++++++
>  .../devicetree/bindings/usb/fcs,fusb302.txt   |   2 +-
>  .../devicetree/bindings/usb/generic.txt       |   2 +-
>  .../devicetree/bindings/usb/mediatek,mtu3.txt |   2 +-
>  .../devicetree/bindings/usb/mediatek,musb.txt |   2 +-
>  .../bindings/usb/richtek,rt1711h.txt          |   2 +-
>  .../devicetree/bindings/usb/ti,hd3ss3220.txt  |   2 +-
>  .../devicetree/bindings/usb/typec-tcpci.txt   |   2 +-
>  .../devicetree/bindings/usb/usb-conn-gpio.txt |   4 +-
>  11 files changed, 216 insertions(+), 145 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/connector/usb-conne=
ctor.txt
>  create mode 100644 Documentation/devicetree/bindings/connector/usb-conne=
ctor.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/connector/samsung,usb-conn=
ector-11pin.txt b/Documentation/devicetree/bindings/connector/samsung,usb-c=
onnector-11pin.txt
> index 22256e295a7a1..3dd8961154abf 100644
> --- a/Documentation/devicetree/bindings/connector/samsung,usb-connector-1=
1pin.txt
> +++ b/Documentation/devicetree/bindings/connector/samsung,usb-connector-1=
1pin.txt
> @@ -19,7 +19,7 @@ Required nodes:
>      0: High Speed (HS),
>      3: Mobile High-Definition Link (MHL), specific to 11-pin Samsung mic=
ro-USB.
> =20
> -[1]: bindings/connector/usb-connector.txt
> +[1]: bindings/connector/usb-connector.yaml
> =20
>  Example
>  -------
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.tx=
t b/Documentation/devicetree/bindings/connector/usb-connector.txt
> deleted file mode 100644
> index 88578ac1a8a76..0000000000000
> --- a/Documentation/devicetree/bindings/connector/usb-connector.txt
> +++ /dev/null
> @@ -1,135 +0,0 @@
> -USB Connector
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -A USB connector node represents a physical USB connector. It should be
> -a child of a USB interface controller.
> -
> -Required properties:
> -- compatible: describes type of the connector, must be one of:
> -    "usb-a-connector",
> -    "usb-b-connector",
> -    "usb-c-connector".
> -
> -Optional properties:
> -- label: symbolic name for the connector,
> -- type: size of the connector, should be specified in case of USB-A, USB=
-B
> -  non-fullsize connectors: "mini", "micro".
> -- self-powered: Set this property if the usb device that has its own pow=
er
> -  source.
> -
> -Optional properties for usb-b-connector:
> -- id-gpios: an input gpio for USB ID pin.
> -- vbus-gpios: an input gpio for USB VBUS pin, used to detect presence of
> -  VBUS 5V.
> -  see gpio/gpio.txt.
> -- vbus-supply: a phandle to the regulator for USB VBUS if needed when ho=
st
> -  mode or dual role mode is supported.
> -  Particularly, if use an output GPIO to control a VBUS regulator, should
> -  model it as a regulator.
> -  see regulator/fixed-regulator.yaml
> -- pinctrl-names : a pinctrl state named "default" is optional
> -- pinctrl-0 : pin control group
> -  see pinctrl/pinctrl-bindings.txt
> -
> -Optional properties for usb-c-connector:
> -- power-role: should be one of "source", "sink" or "dual"(DRP) if typec
> -  connector has power support.
> -- try-power-role: preferred power role if "dual"(DRP) can support Try.SNK
> -  or Try.SRC, should be "sink" for Try.SNK or "source" for Try.SRC.
> -- data-role: should be one of "host", "device", "dual"(DRD) if typec
> -  connector supports USB data.
> -
> -Required properties for usb-c-connector with power delivery support:
> -- source-pdos: An array of u32 with each entry providing supported power
> -  source data object(PDO), the detailed bit definitions of PDO can be fo=
und
> -  in "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.2
> -  Source_Capabilities Message, the order of each entry(PDO) should follow
> -  the PD spec chapter 6.4.1. Required for power source and power dual ro=
le.
> -  User can specify the source PDO array via PDO_FIXED/BATT/VAR/PPS_APDO()
> -  defined in dt-bindings/usb/pd.h.
> -- sink-pdos: An array of u32 with each entry providing supported power
> -  sink data object(PDO), the detailed bit definitions of PDO can be found
> -  in "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.3
> -  Sink Capabilities Message, the order of each entry(PDO) should follow
> -  the PD spec chapter 6.4.1. Required for power sink and power dual role.
> -  User can specify the sink PDO array via PDO_FIXED/BATT/VAR/PPS_APDO() =
defined
> -  in dt-bindings/usb/pd.h.
> -- op-sink-microwatt: Sink required operating power in microwatt, if sour=
ce
> -  can't offer the power, Capability Mismatch is set. Required for power
> -  sink and power dual role.
> -
> -Required nodes:
> -- any data bus to the connector should be modeled using the OF graph bin=
dings
> -  specified in bindings/graph.txt, unless the bus is between parent node=
 and
> -  the connector. Since single connector can have multiple data buses eve=
ry bus
> -  has assigned OF graph port number as follows:
> -    0: High Speed (HS), present in all connectors,
> -    1: Super Speed (SS), present in SS capable connectors,
> -    2: Sideband use (SBU), present in USB-C.
> -
> -Examples
> ---------
> -
> -1. Micro-USB connector with HS lines routed via controller (MUIC):
> -
> -muic-max77843@66 {
> -	...
> -	usb_con: connector {
> -		compatible =3D "usb-b-connector";
> -		label =3D "micro-USB";
> -		type =3D "micro";
> -	};
> -};
> -
> -2. USB-C connector attached to CC controller (s2mm005), HS lines routed
> -to companion PMIC (max77865), SS lines to USB3 PHY and SBU to DisplayPor=
t.
> -DisplayPort video lines are routed to the connector via SS mux in USB3 P=
HY.
> -
> -ccic: s2mm005@33 {
> -	...
> -	usb_con: connector {
> -		compatible =3D "usb-c-connector";
> -		label =3D "USB-C";
> -
> -		ports {
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -
> -			port@0 {
> -				reg =3D <0>;
> -				usb_con_hs: endpoint {
> -					remote-endpoint =3D <&max77865_usbc_hs>;
> -				};
> -			};
> -			port@1 {
> -				reg =3D <1>;
> -				usb_con_ss: endpoint {
> -					remote-endpoint =3D <&usbdrd_phy_ss>;
> -				};
> -			};
> -			port@2 {
> -				reg =3D <2>;
> -				usb_con_sbu: endpoint {
> -					remote-endpoint =3D <&dp_aux>;
> -				};
> -			};
> -		};
> -	};
> -};
> -
> -3. USB-C connector attached to a typec port controller(ptn5110), which h=
as
> -power delivery support and enables drp.
> -
> -typec: ptn5110@50 {
> -	...
> -	usb_con: connector {
> -		compatible =3D "usb-c-connector";
> -		label =3D "USB-C";
> -		power-role =3D "dual";
> -		try-power-role =3D "sink";
> -		source-pdos =3D <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)>;
> -		sink-pdos =3D <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)
> -			     PDO_VAR(5000, 12000, 2000)>;
> -		op-sink-microwatt =3D <10000000>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.ya=
ml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> new file mode 100644
> index 0000000000000..4638d7adb806a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -0,0 +1,206 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/connector/usb-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: USB Connector
> +
> +maintainers:
> +  - Rob Herring <robh@kernel.org>
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
> +    description: Size of the connector, should be specified in case of
> +      non-fullsize 'usb-a-connector' or 'usb-b-connector' compatible
> +      connectors.
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/string
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
> +      VBUS 5V.
> +    maxItems: 1
> +
> +  vbus-supply:
> +    description: A phandle to the regulator for USB VBUS if needed when =
host
> +      mode or dual role mode is supported.
> +      Particularly, if use an output GPIO to control a VBUS regulator, s=
hould
> +      model it as a regulator. See bindings/regulator/fixed-regulator.ya=
ml
> +
> +  # The following are optional properties for "usb-c-connector".
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
=2E1.2
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
=2E User
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
> +      bus has an assigned OF graph port number as described below.
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
> +        description: Sideband Use (SBU), present in USB-C. This describe=
s the
> +          alternate mode connection of which SBU is a part.
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
> +    muic-max77843 {
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
> +    ccic: s2mm005 {
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
> +              remote-endpoint =3D <&usbdrd_phy_ss>;
> +            };
> +          };
> +          port@2 {
> +            reg =3D <2>;
> +            usb_con_sbu: endpoint {
> +              remote-endpoint =3D <&dp_aux>;
> +            };
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
> +    typec: ptn5110 {
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
> diff --git a/Documentation/devicetree/bindings/usb/fcs,fusb302.txt b/Docu=
mentation/devicetree/bindings/usb/fcs,fusb302.txt
> index ba2e32d500c02..60e4654297af7 100644
> --- a/Documentation/devicetree/bindings/usb/fcs,fusb302.txt
> +++ b/Documentation/devicetree/bindings/usb/fcs,fusb302.txt
> @@ -9,7 +9,7 @@ Required sub-node:
>  - connector : The "usb-c-connector" attached to the FUSB302 IC. The bind=
ings
>    of the connector node are specified in:
> =20
> -	Documentation/devicetree/bindings/connector/usb-connector.txt
> +	Documentation/devicetree/bindings/connector/usb-connector.yaml
> =20
> =20
>  Example:
> diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Document=
ation/devicetree/bindings/usb/generic.txt
> index e6790d2a4da9b..474e74c06522d 100644
> --- a/Documentation/devicetree/bindings/usb/generic.txt
> +++ b/Documentation/devicetree/bindings/usb/generic.txt
> @@ -34,7 +34,7 @@ Optional properties:
>   - usb-role-switch: boolean, indicates that the device is capable of ass=
igning
>  			the USB data role (USB host or USB device) for a given
>  			USB connector, such as Type-C, Type-B(micro).
> -			see connector/usb-connector.txt.
> +			see connector/usb-connector.yaml.
> =20
>  This is an attribute to a USB controller such as:
> =20
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt b/Do=
cumentation/devicetree/bindings/usb/mediatek,mtu3.txt
> index e0ae6096f7ac8..a82ca438aec1f 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
> @@ -34,7 +34,7 @@ Optional properties:
>  	dual-role mode.
>  	it's considered valid for compatibility reasons, not allowed for
>  	new bindings, and put into a usb-connector node.
> -	see connector/usb-connector.txt.
> +	see connector/usb-connector.yaml.
>   - pinctrl-names : a pinctrl state named "default" is optional, and need=
 be
>  	defined if auto drd switch is enabled, that means the property dr_mode
>  	is set as "otg", and meanwhile the property "mediatek,enable-manual-drd"
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.txt b/Do=
cumentation/devicetree/bindings/usb/mediatek,musb.txt
> index 2b8a87c90d9ea..5eedb02965622 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> +++ b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> @@ -23,7 +23,7 @@ Optional properties:
>                       MTCMOS
> =20
>  Required child nodes:
> - usb connector node as defined in bindings/connector/usb-connector.txt
> + usb connector node as defined in bindings/connector/usb-connector.yaml
>  Optional properties:
>   - id-gpios        : input GPIO for USB ID pin.
>   - vbus-gpios      : input GPIO for USB VBUS pin.
> diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt b/=
Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
> index e3fc57e605ed6..6f8115db2ea9b 100644
> --- a/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
> +++ b/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
> @@ -9,7 +9,7 @@ Required properties:
>  Required sub-node:
>  - connector: The "usb-c-connector" attached to the tcpci chip, the bindi=
ngs
>    of connector node are specified in
> -  Documentation/devicetree/bindings/connector/usb-connector.txt
> +  Documentation/devicetree/bindings/connector/usb-connector.yaml
> =20
>  Example :
>  rt1711h@4e {
> diff --git a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.txt b/Doc=
umentation/devicetree/bindings/usb/ti,hd3ss3220.txt
> index 25780e945b154..2bd21b22ce95b 100644
> --- a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.txt
> +++ b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.txt
> @@ -9,7 +9,7 @@ Required sub-node:
>   - connector: The "usb-c-connector" attached to the hd3ss3220 chip. The
>     bindings of the connector node are specified in:
> =20
> -	Documentation/devicetree/bindings/connector/usb-connector.txt
> +	Documentation/devicetree/bindings/connector/usb-connector.yaml
> =20
>  Example:
>  hd3ss3220@47 {
> diff --git a/Documentation/devicetree/bindings/usb/typec-tcpci.txt b/Docu=
mentation/devicetree/bindings/usb/typec-tcpci.txt
> index 0dd1469e73180..2082522b1c326 100644
> --- a/Documentation/devicetree/bindings/usb/typec-tcpci.txt
> +++ b/Documentation/devicetree/bindings/usb/typec-tcpci.txt
> @@ -13,7 +13,7 @@ Required properties:
>  Required sub-node:
>  - connector: The "usb-c-connector" attached to the tcpci chip, the bindi=
ngs
>    of connector node are specified in
> -  Documentation/devicetree/bindings/connector/usb-connector.txt
> +  Documentation/devicetree/bindings/connector/usb-connector.yaml
> =20
>  Example:
> =20
> diff --git a/Documentation/devicetree/bindings/usb/usb-conn-gpio.txt b/Do=
cumentation/devicetree/bindings/usb/usb-conn-gpio.txt
> index 3d05ae56cb0dc..ec80641208a53 100644
> --- a/Documentation/devicetree/bindings/usb/usb-conn-gpio.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-conn-gpio.txt
> @@ -8,11 +8,11 @@ Required properties:
>  - compatible : should include "gpio-usb-b-connector" and "usb-b-connecto=
r".
>  - id-gpios, vbus-gpios : input gpios, either one of them must be present,
>  	and both can be present as well.
> -	see connector/usb-connector.txt
> +	see connector/usb-connector.yaml
> =20
>  Optional properties:
>  - vbus-supply : can be present if needed when supports dual role mode.
> -	see connector/usb-connector.txt
> +	see connector/usb-connector.yaml
> =20
>  - Sub-nodes:
>  	- port : can be present.
> --=20
> 2.25.0.265.gbab2e86ba0-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXmkjDgAKCRBzbaomhzOw
wroIAQDRCl4ySzBeGZJPa5rvzAV5PUCqQaOga6Q0EockG1XEmAD/U9xut3eFITRi
Vr5Dw+WT/3nNdJc3ddMOpU4jLghV7go=
=X4eD
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
