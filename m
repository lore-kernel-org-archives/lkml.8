Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF276C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFE120870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583444433;
	bh=2TbDtdzQLVrZkBATqyMst6WKIUAWhg4hkW93/u9hnxw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oaaZoSVIRnJV49FYY4Ok+xvUgRtQeo2AXw7vqpsJA1NThGf7FgXe1KSG5RrOOsct0
	 4nb9294v+9SWFzlV8vMeSbAK0wJlAfclQBtWh8OoYrNAaMZwnA/f2I/iRiJ0ZhY7hj
	 oUmcmAfgt1M31TTcyder4le4nhEWIvkGnofIlv8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgCEVkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 16:40:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:41018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbgCEVkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:40:32 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E207217F4;
        Thu,  5 Mar 2020 21:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583444430;
        bh=2TbDtdzQLVrZkBATqyMst6WKIUAWhg4hkW93/u9hnxw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jwmBRSLZS6+pu3brX7GBPDp8uiFUnw3oAp8b+jRAPpnnUNj9UDUx8NRgW/8lw0DLo
         4KTbl6wQVU/UIkiO7pHPSb5gK1YuqwOC6xtTLVX1JI4ZAUtf88ErmZIaC6wJXs3SpG
         VoLBCKdodtLm4bH4OcKzJSPAaF/xK8XzSD0DKSRY=
Received: by mail-qt1-f177.google.com with SMTP id e20so246353qto.5;
        Thu, 05 Mar 2020 13:40:30 -0800 (PST)
X-Gm-Message-State: ANhLgQ28hK/b7e1yg2iih4GXSMbJaO1J2YfZe78vxeedE+6boLPFA3k1
        MzbUxV4zmHSLAg65PfXgzDtYuzK52T14nV36qA==
X-Google-Smtp-Source: ADFU+vsM3Zz2YnwpidfFVp0E2ZVb1W7rDIBPO7Klgy7wRQmho3zKSSTbk7Gr8mOWfUebGtfkIeXgsLh1WpiWKutdx9Y=
X-Received: by 2002:aed:3461:: with SMTP id w88mr223503qtd.143.1583444429367;
 Thu, 05 Mar 2020 13:40:29 -0800 (PST)
MIME-Version: 1.0
References: <20200305030135.210675-1-pmalani@chromium.org> <158344320452.25912.4758137777863945655@swboyd.mtv.corp.google.com>
In-Reply-To: <158344320452.25912.4758137777863945655@swboyd.mtv.corp.google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 5 Mar 2020 15:40:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ3UVG=pVqZyju1qis_Y3dVT6swLEAkK=Myi331Pomvyg@mail.gmail.com>
Message-ID: <CAL_JsqJ3UVG=pVqZyju1qis_Y3dVT6swLEAkK=Myi331Pomvyg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: Convert usb-connector to YAML format.
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Prashant Malani <pmalani@chromium.org>, devicetree@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 3:20 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Prashant Malani (2020-03-04 19:01:30)
> > diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > new file mode 100644
> > index 0000000000000..b386e2880405c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > @@ -0,0 +1,203 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/connector/usb-connector.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: USB Connector
> > +
> > +maintainers:
> > +  - linux-usb@vger.kernel.org
> > +
> > +description:
> > +  A USB connector node represents a physical USB connector. It should be a child
> > +  of a USB interface controller.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - usb-a-connector
> > +      - usb-b-connector
> > +      - usb-c-connector
> > +
> > +  label:
> > +    description: Symbolic name for the connector.
> > +
> > +  type:
> > +    description: Size of the connector, should be specified in case of USB-A,
> > +      USB-B non-fullsize connectors.
>
> Maybe "should be specified in case of non-fullsize 'usb-a-connector' or
> 'usb-b-connector' compatible connectors"?
>
> > +    $ref: /schemas/types.yaml#definitions/string
> > +    enum:
> > +      - mini
> > +      - micro
> > +
> > +  self-powered:
> > +    description: Set this property if the USB device has its own power source.
> > +    type: boolean
> > +
> > +  # The following are optional properties for "usb-b-connector".
> > +  id-gpios:
> > +    description: An input gpio for USB ID pin.
> > +    maxItems: 1
> > +
> > +  vbus-gpios:
> > +    description: An input gpio for USB VBus pin, used to detect presence of
> > +      VBUS 5V. See gpio/gpio.txt.
>
> Can this be written as bindings/gpio/gpio.txt?

Or just drop the reference so we don't have to fix it later.

> > +    maxItems: 1
> > +
> > +  vbus-supply:
> > +    description: A phandle to the regulator for USB VBUS if needed when host
> > +      mode or dual role mode is supported.
> > +      Particularly, if use an output GPIO to control a VBUS regulator, should
> > +      model it as a regulator. See regulator/fixed-regulator.yaml
>
> And bindings/regulator/fixed-regulator.yaml? The idea is to
> disambiguate from kernel Documentation/ directory.
>
> > +
> > +  # The following are optional properties for "usb-c-connector".
>
> Is there a way to constrain the binding so that this can't be put in a
> connector that doesn't have the usb-c-connector compatible string?

Yes, with if/then and setting excluded properties to 'false'.
Personally, I don't think it is worth the messiness. I'm not too
worried if folks put in properties that are going to be ignored.

Rob

> > +  power-role:
> > +    description: Determines the power role that the Type C connector will
> > +      support. "dual" refers to Dual Role Port (DRP).
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#definitions/string
> > +    enum:
> > +      - source
> > +      - sink
> > +      - dual
> > +
> > +  try-power-role:
> > +    description: Preferred power role.
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#definitions/string
> > +    enum:
> > +     - source
> > +     - sink
> > +     - dual
> > +
> > +  data-role:
> > +    description: Data role if Type C connector supports USB data. "dual" refers
> > +      Dual Role Device (DRD).
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#definitions/string
> > +    enum:
> > +      - host
> > +      - device
> > +      - dual
>
> Is there a way to maintain a description for each possible string
> property? Then we could move the last sentence in the description above
> to be attached to '- dual' here.
>
> > +
> > +  # The following are optional properties for "usb-c-connector" with power
> > +  # delivery support.
> > +  source-pdos:
> > +    description: An array of u32 with each entry providing supported power
> > +      source data object(PDO), the detailed bit definitions of PDO can be found
> > +      in "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.2
> > +      Source_Capabilities Message, the order of each entry(PDO) should follow
> > +      the PD spec chapter 6.4.1. Required for power source and power dual role.
> > +      User can specify the source PDO array via PDO_FIXED/BATT/VAR/PPS_APDO()
> > +      defined in dt-bindings/usb/pd.h.
> > +    minItems: 1
> > +    maxItems: 7
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> > +
> > +  sink-pdos:
> > +    description: An array of u32 with each entry providing supported power sink
> > +      data object(PDO), the detailed bit definitions of PDO can be found in
> > +      "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.3
> > +      Sink Capabilities Message, the order of each entry(PDO) should follow the
> > +      PD spec chapter 6.4.1. Required for power sink and power dual role. User
> > +      can specify the sink PDO array via PDO_FIXED/BATT/VAR/PPS_APDO() defined
> > +      in dt-bindings/usb/pd.h.
> > +    minItems: 1
> > +    maxItems: 7
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> > +
> > +  op-sink-microwatt:
> > +    description: Sink required operating power in microwatt, if source can't
> > +      offer the power, Capability Mismatch is set. Required for power sink and
> > +      power dual role.
> > +
> > +  ports:
> > +    description: OF graph bindings (specified in bindings/graph.txt) that model
> > +      any data bus to the connector unless the bus is between parent node and
> > +      the connector. Since a single connector can have multiple data buses every
> > +      bus has assigned OF graph port number as described below.
>
> has an assigned?
>
> > +    type: object
> > +    properties:
> > +      port@0:
> > +        type: object
> > +        description: High Speed (HS), present in all connectors.
> > +
> > +      port@1:
> > +        type: object
> > +        description: Super Speed (SS), present in SS capable connectors.
> > +
> > +      port@2:
> > +        type: object
> > +        description: Sideband Use (SBU), present in USB-C.
>
> Likewise, is it possible to constrain this to only usb-c-connector
> compatible string based bindings? And if so, does it become required for
> that compatible string?

Not required as alternate modes are not required. (BTW, it should
probably be clarified this is supposed to be the alternate mode
connection of which SBU is part of).

Rob
