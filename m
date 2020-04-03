Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0105FC2BA17
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 11:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4DA2078C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 11:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403807AbgDCLwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 07:52:36 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:36018 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgDCLwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 07:52:36 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 1D5F1800146A;
        Fri,  3 Apr 2020 11:52:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tAA3R6TKth_y; Fri,  3 Apr 2020 14:52:26 +0300 (MSK)
Date:   Fri, 3 Apr 2020 14:52:38 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>
List-Id: <soc.lore.kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] dt-bindings: Add Baikal-T1 L2-cache Control Block
 dts bindings file
Message-ID: <20200403115238.4cvlz4fxldw7knsh@ubsrv2.baikal.int>
References: <20200306130721.10347-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130734.194288030794@mail.baikalelectronics.ru>
 <20200312212335.GA27332@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200312212335.GA27332@bogus>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 04:23:35PM -0500, Rob Herring wrote:
> On Fri, Mar 06, 2020 at 04:07:18PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > There is a single register provided by the SoC system controller,
> > which can be used to tune the L2-cache up. It only provides a way
> > to change the L2-RAM access latencies. So aside from the MMIO region
> > with that setting and "be,bt1-l2-ctl" compatible string the device
> > node can be optionally equipped with the properties of Tag/Data/WS
> > latencies.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Paul Burton <paulburton@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Olof Johansson <olof@lixom.net>
> > Cc: soc@kernel.org
> > ---
> >  .../bindings/soc/baikal-t1/be,bt1-l2-ctl.yaml | 108 ++++++++++++++++++
> >  1 file changed, 108 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/baikal-t1/be,bt1-l2-ctl.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/baikal-t1/be,bt1-l2-ctl.yaml b/Documentation/devicetree/bindings/soc/baikal-t1/be,bt1-l2-ctl.yaml
> > new file mode 100644
> > index 000000000000..8769b3fa517c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/baikal-t1/be,bt1-l2-ctl.yaml
> > @@ -0,0 +1,108 @@
> > +# SPDX-License-Identifier: GPL-2.0
> 
> Dual license

Ok.

> 
> > +#
> > +# Copyright (C) 2020 BAIKAL ELECTRONICS, JSC
> > +#
> > +# Baikal-T1 L2-cache Control Block Device Tree Bindings.
> > +#
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/baikal-t1/be,bt1-l2-ctl.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Baikal-T1 L2-cache Control Block
> > +
> > +maintainers:
> > +  - Serge Semin <fancer.lancer@gmail.com>
> > +
> > +description: |
> > +  Baikal-T1 exposes a few settings to tune the MIPS P5600 CM2 L2-cache
> > +  performance up. In particular it's possible to change the Tag, Data and
> > +  Way-select RAM access latencies. This bindings file describes the system
> > +  controller block, which provides an interface to set the tuning up.
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: syscon
> > +    then:
> > +      $ref: ../../mfd/syscon.yaml#
> > +    else:
> > +      properties:
> > +        reg-io-width: false
> > +
> > +        little-endian: false
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - description: P5600 CM2 L2-cache RAM external configuration block.
> > +        const: be,bt1-l2-ctl
> > +      - description: P5600 CM2 L2-cache RAM system controller block.
> > +        items:
> > +          - const: be,bt1-l2-ctl
> > +          - const: syscon
> 
> Why is this conditional? Different h/w?
> 

Seeing the config register has got a few other CPU parameters to tune
I meant to have both syscon and syscon-less compatible nodes supported
For the same reason there is "allOf" with "syscon.yaml" reference above.

This P5600 CM2 L2-Cach RAM setting is a part of the Baikal-T1 System
Control Module, in particular the register lives someplace amongst Clock
Control Unit and System-specific settings. Seeing the clock and
system-specific parameters are almost always redistributed to a
dedicated registers set, in my first System Control Module DT node design
I was going to split the functionality up into the dedicated sub-nodes.
If there are some mixed parameters declared in the corresponding
registers set, I marked these nodes with additional "syscon". I
thoroughly described that design in RFC: https://lkml.org/lkml/2020/3/22/393
sent To: you.

Seeing there are others indirectly related to the System Controller DT node
design issues I've been addressed in the framework of other patchsets, I
also suggested an alternative design in that RFC text. So should you have
any comments, please send your response right there. I am currently in a bit
of frustration, since noone has sent any comments to the RFC, which stops me
from moving on with fixing the patchsets issues. Though I am pretty sure,
that the alternative design would be better accepted by you and community,
so if no comments pop up in the RFC soon, I'll start implementing it.
The alternative solution "/* System Controller DT Nodes II */" in the
RFC includes having a common "syscon"-compatible node representing the
Baikal-T1 System Controller, while sub-nodes like Clocks Control Units and this
L2-cache RAM control block would import a regmap from that "syscon"
(using a standard syscon_node_to_regmap()-like method). This will solve a
multiple issues raised in others patchsets and the problem you noted here.

Please also note, that following Arnd Bergmann suggestion, I'll move
this driver to the drivers/memory subsystem. So the binding file will be
also moved to Documentation/devicetree/bindings/memory-controllers.
Similarly the ehb-drivers and bindings will be moved to the drivers/bus
and Documentation/devicetree/bindings/bus/ directories respectively.

> > +
> > +  reg:
> > +    description: MMIO register with MIPS P5600 CM2 L2-cache RAM settings.
> 
> You can drop this.

Ok.

> 
> > +    maxItems: 1
> > +
> > +  be,l2-ws-latency:
> > +    description: Cycles of latency for Way-select RAM accesses.
> > +    default: 0
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +      - minimum: 0
> > +        maximum: 3
> 
> These should be at the same level as 'default' or default moved here (I 
> prefer the former). IOW, only $ref has to be under 'allOf'.

Ok.

> 
> > +
> > +  be,l2-tag-latency:
> > +    description: Cycles of latency for Tag RAM accesses.
> > +    default: 0
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +      - minimum: 0
> > +        maximum: 3
> > +
> > +  be,l2-data-latency:
> > +    description: Cycles of latency for Data RAM accesses.
> > +    default: 1
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +      - minimum: 0
> > +        maximum: 3
> > +
> > +  reg-io-width:
> > +    const: 4
> > +
> > +  little-endian: true
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +    l2_ctl1: l2@1F04D028 {
> 
> lowercase hex.

Ok. I'll do this to the next example case as well.

Regards,
-Sergey

> 
> > +      compatible = "be,bt1-l2-ctl";
> > +      reg = <0x1F04D028 0x004>;
> > +
> > +      be,l2-ws-latency = <0>;
> > +      be,l2-tag-latency = <0>;
> > +      be,l2-data-latency = <1>;
> > +    };
> > +  - |
> > +    l2_ctl2: l2@1F04D028 {
> > +      compatible = "be,bt1-l2-ctl", "syscon";
> > +      reg = <0x1F04D028 0x004>;
> > +
> > +      be,l2-ws-latency = <0>;
> > +      be,l2-tag-latency = <0>;
> > +      be,l2-data-latency = <1>;
> > +
> > +      little-endian;
> > +      reg-io-width = <4>;
> > +    };
> > +...
> > -- 
> > 2.25.1
> > 
