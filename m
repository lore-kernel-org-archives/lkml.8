Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C19C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C662B20870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WPeErd9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgCEWJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:09:01 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44229 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgCEWJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:09:01 -0500
Received: by mail-pg1-f195.google.com with SMTP id n24so71123pgk.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 14:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oDdCfltD2QaBSAFFf+wWMswJOlfqgPRuLkEZFJgGNrM=;
        b=WPeErd9hhzVZX/Waac4idjpF5e1w/9TGIpnu0CXQ7llkO14XJgGYKzMw8QZ3O6Ir8R
         +7SC8GCkS6eBCJp9sfV05tfmssFengeJa4nq6nYNiJb6hw5SVjCDYOtH/29BdMnRRIxO
         020BrKHkDlcKIGl/YMOB9r7MjXc4STIqzJgJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oDdCfltD2QaBSAFFf+wWMswJOlfqgPRuLkEZFJgGNrM=;
        b=YUyJzh0SqICaSMAdKYPQIWz+ALR0BZOoAwmTM7USVF68DjPWORltqMo3rpX0gJjrP6
         ul30MpBXOfrumNLL1Nsq5MA9xAnEgTKpe8GpFTFcnNCnsqFDjm9hhAgxZDLQt9h+YOX5
         o1OMyM5NGrAsnTAkgzbDR9Qywy9kYxyDJtDf4EeqjDIJ9jaUG8U69q9rwyQH1NNuy7ur
         VRF6YOXO2vrneoqGTDv4BZijiVSHznN2gwQrP23SONmm81rYAQ1ubglVdke/qgdiml7b
         sKn9d4YDfrBn4eYJkiPMAyC63q8PTgIawI5XnmKV4elkZL+1CLzY4ocnPxpPkJclWK6e
         PTew==
X-Gm-Message-State: ANhLgQ2lhHypA+v4W063ks6xNT2n7UvNZyY4X2SbhSRu1Dtd18FxV93m
        7r50aIh+j2URZg44atPw6tgxBA==
X-Google-Smtp-Source: ADFU+vvU72LTPP3n2h4iIkGJpSr/n1ItEYb7KzzsHSYvy/pBi8VxFb8CAvwLZIcp8ImLRyUJBPU+nA==
X-Received: by 2002:aa7:8392:: with SMTP id u18mr484796pfm.41.1583446139767;
        Thu, 05 Mar 2020 14:08:59 -0800 (PST)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id q21sm34620995pff.105.2020.03.05.14.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 14:08:59 -0800 (PST)
Date:   Thu, 5 Mar 2020 14:08:58 -0800
From:   Prashant Malani <pmalani@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
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
Subject: Re: [PATCH v2] dt-bindings: Convert usb-connector to YAML format.
Message-ID: <20200305220858.GD142502@google.com>
References: <20200305030135.210675-1-pmalani@chromium.org>
 <158344320452.25912.4758137777863945655@swboyd.mtv.corp.google.com>
 <CAL_JsqJ3UVG=pVqZyju1qis_Y3dVT6swLEAkK=Myi331Pomvyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ3UVG=pVqZyju1qis_Y3dVT6swLEAkK=Myi331Pomvyg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Rob for reviewing this patch. Kindly see my responses inline.

Best regards,

-Prashant

On Thu, Mar 05, 2020 at 03:40:18PM -0600, Rob Herring wrote:
> On Thu, Mar 5, 2020 at 3:20 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Prashant Malani (2020-03-04 19:01:30)
> > > diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > new file mode 100644
> > > index 0000000000000..b386e2880405c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > @@ -0,0 +1,203 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/connector/usb-connector.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: USB Connector
> > > +
> > > +maintainers:
> > > +  - linux-usb@vger.kernel.org
> > > +
> > > +description:
> > > +  A USB connector node represents a physical USB connector. It should be a child
> > > +  of a USB interface controller.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - usb-a-connector
> > > +      - usb-b-connector
> > > +      - usb-c-connector
> > > +
> > > +  label:
> > > +    description: Symbolic name for the connector.
> > > +
> > > +  type:
> > > +    description: Size of the connector, should be specified in case of USB-A,
> > > +      USB-B non-fullsize connectors.
> >
> > Maybe "should be specified in case of non-fullsize 'usb-a-connector' or
> > 'usb-b-connector' compatible connectors"?
> >
> > > +    $ref: /schemas/types.yaml#definitions/string
> > > +    enum:
> > > +      - mini
> > > +      - micro
> > > +
> > > +  self-powered:
> > > +    description: Set this property if the USB device has its own power source.
> > > +    type: boolean
> > > +
> > > +  # The following are optional properties for "usb-b-connector".
> > > +  id-gpios:
> > > +    description: An input gpio for USB ID pin.
> > > +    maxItems: 1
> > > +
> > > +  vbus-gpios:
> > > +    description: An input gpio for USB VBus pin, used to detect presence of
> > > +      VBUS 5V. See gpio/gpio.txt.
> >
> > Can this be written as bindings/gpio/gpio.txt?
> 
> Or just drop the reference so we don't have to fix it later.

Dropped the reference.
> 
> > > +    maxItems: 1
> > > +
> > > +  vbus-supply:
> > > +    description: A phandle to the regulator for USB VBUS if needed when host
> > > +      mode or dual role mode is supported.
> > > +      Particularly, if use an output GPIO to control a VBUS regulator, should
> > > +      model it as a regulator. See regulator/fixed-regulator.yaml
> >
> > And bindings/regulator/fixed-regulator.yaml? The idea is to
> > disambiguate from kernel Documentation/ directory.
> >
> > > +
> > > +  # The following are optional properties for "usb-c-connector".
> >
> > Is there a way to constrain the binding so that this can't be put in a
> > connector that doesn't have the usb-c-connector compatible string?
> 
> Yes, with if/then and setting excluded properties to 'false'.
> Personally, I don't think it is worth the messiness. I'm not too
> worried if folks put in properties that are going to be ignored.

Leaving this as is for now, based on the above comment.
> 
> Rob
> 
> > > +  power-role:
> > > +    description: Determines the power role that the Type C connector will
> > > +      support. "dual" refers to Dual Role Port (DRP).
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#definitions/string
> > > +    enum:
> > > +      - source
> > > +      - sink
> > > +      - dual
> > > +
> > > +  try-power-role:
> > > +    description: Preferred power role.
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#definitions/string
> > > +    enum:
> > > +     - source
> > > +     - sink
> > > +     - dual
> > > +
> > > +  data-role:
> > > +    description: Data role if Type C connector supports USB data. "dual" refers
> > > +      Dual Role Device (DRD).
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#definitions/string
> > > +    enum:
> > > +      - host
> > > +      - device
> > > +      - dual
> >
> > Is there a way to maintain a description for each possible string
> > property? Then we could move the last sentence in the description above
> > to be attached to '- dual' here.
> >
> > > +
> > > +  # The following are optional properties for "usb-c-connector" with power
> > > +  # delivery support.
> > > +  source-pdos:
> > > +    description: An array of u32 with each entry providing supported power
> > > +      source data object(PDO), the detailed bit definitions of PDO can be found
> > > +      in "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.2
> > > +      Source_Capabilities Message, the order of each entry(PDO) should follow
> > > +      the PD spec chapter 6.4.1. Required for power source and power dual role.
> > > +      User can specify the source PDO array via PDO_FIXED/BATT/VAR/PPS_APDO()
> > > +      defined in dt-bindings/usb/pd.h.
> > > +    minItems: 1
> > > +    maxItems: 7
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +
> > > +  sink-pdos:
> > > +    description: An array of u32 with each entry providing supported power sink
> > > +      data object(PDO), the detailed bit definitions of PDO can be found in
> > > +      "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.3
> > > +      Sink Capabilities Message, the order of each entry(PDO) should follow the
> > > +      PD spec chapter 6.4.1. Required for power sink and power dual role. User
> > > +      can specify the sink PDO array via PDO_FIXED/BATT/VAR/PPS_APDO() defined
> > > +      in dt-bindings/usb/pd.h.
> > > +    minItems: 1
> > > +    maxItems: 7
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +
> > > +  op-sink-microwatt:
> > > +    description: Sink required operating power in microwatt, if source can't
> > > +      offer the power, Capability Mismatch is set. Required for power sink and
> > > +      power dual role.
> > > +
> > > +  ports:
> > > +    description: OF graph bindings (specified in bindings/graph.txt) that model
> > > +      any data bus to the connector unless the bus is between parent node and
> > > +      the connector. Since a single connector can have multiple data buses every
> > > +      bus has assigned OF graph port number as described below.
> >
> > has an assigned?
> >
> > > +    type: object
> > > +    properties:
> > > +      port@0:
> > > +        type: object
> > > +        description: High Speed (HS), present in all connectors.
> > > +
> > > +      port@1:
> > > +        type: object
> > > +        description: Super Speed (SS), present in SS capable connectors.
> > > +
> > > +      port@2:
> > > +        type: object
> > > +        description: Sideband Use (SBU), present in USB-C.
> >
> > Likewise, is it possible to constrain this to only usb-c-connector
> > compatible string based bindings? And if so, does it become required for
> > that compatible string?
> 
> Not required as alternate modes are not required. (BTW, it should
> probably be clarified this is supposed to be the alternate mode
> connection of which SBU is part of).

I've changed the description text for port@2 to:
"Sideband Use (SBU), present in USB-C. This describes the alternate mode connection of which SBU is a part. "
> 
> Rob
