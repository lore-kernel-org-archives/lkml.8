Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAACC3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA9F2166E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S9o23N9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCEWGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:06:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39241 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgCEWGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:06:01 -0500
Received: by mail-pf1-f195.google.com with SMTP id l7so42618pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 14:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IX8YVBG4p5k2QAbGer4G96xm3Z8NgKYITeF73HxiwoQ=;
        b=S9o23N9G7dy68xECMQim9toy0bN5fZeup+7EJEjxkpq+VK5XUc65vI4l3O2YZKdpkQ
         gvA9npnGGhuiu0rZ0dDbA9D8ltdVcaCSy2DvHupfA2qXEYDL66i9t6sipSByz8uIm1mo
         dNf4lwirNVWsg+ZSVFVC9Qcq5cSWDHKVE2njM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IX8YVBG4p5k2QAbGer4G96xm3Z8NgKYITeF73HxiwoQ=;
        b=Kend54Yf03kbF3C+ujlzLxSUX/ETlUSiIS7l+eOn6JkjPAjA4ymqEutm8muzpy/f+a
         TcS5sjsk4tn4gjPHVY2kswM7lQTYGfmpsOapO/f+m9Y5ALZt3FsezfAF+tklLkfa+UzK
         ynBLnXlIdDC395uEPH9Ht78pImEAOiyKrSGnRJQ5z9PHkeG43L0QSW2xfLsXJ5Zv4oDa
         sUt9ZzrDxIm4v76UYMtiiIEH7o7oAqOZTP2NtaQ0R0XYlaAUDbDfHNdeaugMdg71cYzO
         yBUiygKdQNq/B4ivX6khFfaPtzvJ0SXSlqnrbhrk1RqKQT9S6DrDoYoqnqfDvk9WT1f5
         GmdQ==
X-Gm-Message-State: ANhLgQ0LYiiQ6ua6YFZ6lqqigJ4hubg+R0jPRZDvtmelIN0LTpeglACt
        ARQBlujxC1SRDOgKQWXmdBJZrg==
X-Google-Smtp-Source: ADFU+vuvZPa1OmI4ocX3yUSt0BjsEQf0N7rTtxK6vihyroJfBvCM0Z34TqdrRfy8RitMUWttAdCs1Q==
X-Received: by 2002:a63:9dc2:: with SMTP id i185mr243179pgd.240.1583445960052;
        Thu, 05 Mar 2020 14:06:00 -0800 (PST)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id w14sm32400569pgi.22.2020.03.05.14.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 14:05:59 -0800 (PST)
Date:   Thu, 5 Mar 2020 14:05:58 -0800
From:   Prashant Malani <pmalani@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     devicetree@vger.kernel.org, bleung@chromium.org,
        heikki.krogerus@linux.intel.com, enric.balletbo@collabora.com,
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
Subject: Re: [PATCH v2] dt-bindings: Convert usb-connector to YAML format.
Message-ID: <20200305220558.GC142502@google.com>
References: <20200305030135.210675-1-pmalani@chromium.org>
 <158344320452.25912.4758137777863945655@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158344320452.25912.4758137777863945655@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thanks for reviewing the patch. Kindly see my responses inline.

Best regards,

-Prashant

On Thu, Mar 05, 2020 at 01:20:04PM -0800, Stephen Boyd wrote:
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
Done.

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

Dropping it based on Rob's later comment.
> 
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

Done.
> 
> > +
> > +  # The following are optional properties for "usb-c-connector".
> 
> Is there a way to constrain the binding so that this can't be put in a
> connector that doesn't have the usb-c-connector compatible string?
> 
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
I'm not sure of a way to do this, so leaving this as is for now.
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

Done.
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
> 
> > +
> > +    required:
> > +      - port@0
> > +
> > +required:
> > +  - compatible
> > +
> > +examples:
> > +  # Micro-USB connector with HS lines routed via controller (MUIC).
> > +  - |+
> > +    muic-max77843@66 {
> 
> Add a reg = <0x66>; here? Or drop the unit address above.

Dropped the unit address.
> 
> > +      usb_con1: connector {
> > +        compatible = "usb-b-connector";
> > +        label = "micro-USB";
> > +        type = "micro";
> > +      };
> > +    };
> > +
> > +  # USB-C connector attached to CC controller (s2mm005), HS lines routed
> > +  # to companion PMIC (max77865), SS lines to USB3 PHY and SBU to DisplayPort.
> > +  # DisplayPort video lines are routed to the connector via SS mux in USB3 PHY.
> > +  - |+
> > +    ccic: s2mm005@33 {
> 
> Same unit address comment.
Dropped the unit address.
> 
> > +      usb_con2: connector {
> > +        compatible = "usb-c-connector";
> > +        label = "USB-C";
> > +
> > +        ports {
> > +          #address-cells = <1>;
> > +          #size-cells = <0>;
> > +
> > +          port@0 {
> > +            reg = <0>;
> > +            usb_con_hs: endpoint {
> > +              remote-endpoint = <&max77865_usbc_hs>;
> > +            };
> > +          };
> > +          port@1 {
> > +            reg = <1>;
> > +            usb_con_ss: endpoint {
> > +            remote-endpoint = <&usbdrd_phy_ss>;
> > +            };
> > +          };
> > +          port@2 {
> > +            reg = <2>;
> > +            usb_con_sbu: endpoint {
> > +            remote-endpoint = <&dp_aux>;
> > +            };
> 
> Tabs should be replaced with spaces.

Fixed the spacing here.
> 
> > +          };
> > +        };
> > +      };
> > +    };
> > +
> > +  # USB-C connector attached to a typec port controller(ptn5110), which has
> > +  # power delivery support and enables drp.
> > +  - |+
> > +    #include <dt-bindings/usb/pd.h>
> > +    typec: ptn5110@50 {
> 
> Same unit address comment.

Dropped the unit address.
> 
> > +      usb_con3: connector {
> > +        compatible = "usb-c-connector";
> > +        label = "USB-C";
> > +        power-role = "dual";
> > +        try-power-role = "sink";
> > +        source-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)>;
> > +        sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)
> > +                     PDO_VAR(5000, 12000, 2000)>;
> > +        op-sink-microwatt = <10000000>;
> > +      };
> > +    };
