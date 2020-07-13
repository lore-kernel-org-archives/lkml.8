Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF622C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5827206F5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgGMTw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:52:29 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:58310 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGMTw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 15:52:28 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 4C99B8030866;
        Mon, 13 Jul 2020 19:52:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hCNLeNlOrJwS; Mon, 13 Jul 2020 22:52:21 +0300 (MSK)
Date:   Mon, 13 Jul 2020 22:52:19 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 5/8] dt-bindings: snps,dw-apb-ssi: Add sparx5 support,
 plus snps,rx-sample-delay-ns property
Message-ID: <20200713195219.xfvqknioqw7yyr74@mobilestation>
References: <20200702101331.26375-1-lars.povlsen@microchip.com>
 <20200702101331.26375-6-lars.povlsen@microchip.com>
 <20200713192259.GA553903@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200713192259.GA553903@bogus>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 01:22:59PM -0600, Rob Herring wrote:
> On Thu, Jul 02, 2020 at 12:13:28PM +0200, Lars Povlsen wrote:
...
> 
> > +
> >  patternProperties:
> >    "^.*@[0-9a-f]+$":
> >      type: object
> > @@ -107,6 +122,14 @@ patternProperties:
> >        spi-tx-bus-width:
> >          const: 1
> > 
> > +      snps,rx-sample-delay-ns:
> 

> We already have 'rx-sample-delay-ns' from Rockchip SPI, so use that. But 
> note that it applies to the SPI node. Does this need to be per SPI 
> child?

It was me, who suggested to Lars to have that parameter moved to the SPI
sub-nodes. As I see it the property is highly dependent on the SPI slave device
the controller is communicating to. Some of the them may need the delay some
may not. It's not always the capacitance thing, but also depends on how good
the MISO signal a particular slave generates. So IMO the Rockchip SPI driver
developer should have moved that property to the sub-nodes too.

On the other hand if the Rx errors are caused by the MISO lane capacitance,
then it will be cumbersome to have the same property duplicated for each
sub-node. Then what about having the property supported by both the SPI
controller and the SPI-child nodes? For instance the SPI-controller
"rx-sample-delay-ns" will provide a default sample delay for each sub-node
instead of zero by default, while the individual sub-node "rx-sample-delay-ns"
property can be used to override the default value.

-Sergey

> 
> BTW, the Rockchip controller appears to be a version of the DW 
> controller.
> 
> > +        description: SPI Rx sample delay offset, unit is nanoseconds.
> > +          The delay from the default sample time before the actual
> > +          sample of the rxd input signal occurs. The "rx_sample_delay"
> > +          is an optional feature of the designware controller, and the
> > +          upper limit is also subject to controller configuration.
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +
> >  unevaluatedProperties: false
> > 
> >  required:
> > @@ -129,5 +152,10 @@ examples:
> >        num-cs = <2>;
> >        cs-gpios = <&gpio0 13 0>,
> >                   <&gpio0 14 0>;
> > +      spi-flash@1 {
> > +        compatible = "spi-nand";
> > +        reg = <1>;
> > +        snps,rx-sample-delay-ns = <7>;
> > +      };
> >      };
> >  ...
> > --
> > 2.27.0
