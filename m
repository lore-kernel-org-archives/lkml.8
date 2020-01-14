Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0072BC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C596F24680
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579012281;
	bh=ltNTT7RiHNRvJDhXbTG1yx/yztuULV7Lt6pnInxI2BY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=N2zxwWkDUFLtac4w9/oUKowOc1mdzqghHsZrfxqpLcGikH9Dic5tW+XJOuniweINQ
	 JM/6fR9EX0lKA6Fz1k3+xaC4d3SbnJy4Xvtn2fmPSjAJyhTYxBpXbKJPi7or4+qgDD
	 OUrEgTPVHNJu+0gbcvP/T4Tdf2CqUxRrHngMhjlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgANObV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:31:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgANObU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:31:20 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 975F024680;
        Tue, 14 Jan 2020 14:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579012279;
        bh=ltNTT7RiHNRvJDhXbTG1yx/yztuULV7Lt6pnInxI2BY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Dc5+rT4RNXSFPG3OnQmB6tf3E9+mNy1H7HwAJI+gLODbH4nHhWwAi0X9wAZQ6EhXb
         DFmYwtbkIa0PxUp0Xe2BuLmY1T/vWsjZfO5qzPvTkbzZkUp+eXVzDscS4JPJ/xxKXW
         AmMQrEoQXnmVvKjzcWu1lhivwAmKOzcVrxlWcB7o=
Received: by mail-qv1-f46.google.com with SMTP id dc14so5708309qvb.9;
        Tue, 14 Jan 2020 06:31:19 -0800 (PST)
X-Gm-Message-State: APjAAAXkEdZXlK3vRZc6OIJ3KS6fDJ8qHDb9cfPe4+QmMl1GQwUZg208
        WWy6QA96db+KXeYEZGrpoWs4nVOi2z3cBRTxTQ==
X-Google-Smtp-Source: APXvYqyLIK7ZfgZ+SgWmXIFGw6X2n5ZzHbdU5PcEL44Gy0RrqrBGZdAoe626mP8KGLwUFhTn2exZaDT5VFSVEmwNN5o=
X-Received: by 2002:ad4:450a:: with SMTP id k10mr19871231qvu.136.1579012278704;
 Tue, 14 Jan 2020 06:31:18 -0800 (PST)
MIME-Version: 1.0
References: <9f3df8c403bba3633391551fc601cbcd2f950959.1576824311.git.eswara.kota@linux.intel.com>
 <20200108141855.GA14868@bogus> <0e797d57-66a6-39ec-6388-5af47e9b0726@linux.intel.com>
In-Reply-To: <0e797d57-66a6-39ec-6388-5af47e9b0726@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Jan 2020 08:31:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLaiiYxaWjWRr3S7Q8j5YCxB_v2Lt_m5fwHnZU1e27MdA@mail.gmail.com>
Message-ID: <CAL_JsqLaiiYxaWjWRr3S7Q8j5YCxB_v2Lt_m5fwHnZU1e27MdA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add YAML schemas for Intel Combo phy
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 3:18 AM Dilip Kota <eswara.kota@linux.intel.com> wrote:
>
>
> On 1/8/2020 10:18 PM, Rob Herring wrote:
> > On Fri, Dec 20, 2019 at 03:28:27PM +0800, Dilip Kota wrote:
> >> Combo phy subsystem provides PHY support to number of
> >> controllers, viz. PCIe, SATA and EMAC.
> >> Adding YAML schemas for the same.
> >>
> >> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> >> ---
> >>   .../devicetree/bindings/phy/intel,combo-phy.yaml   | 147 +++++++++++++++++++++
> >>   1 file changed, 147 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
> >> new file mode 100644
> >> index 000000000000..fc9cbad9dd88
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
> >> @@ -0,0 +1,147 @@
> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/phy/intel,combo-phy.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Intel Combo phy Subsystem
> >> +
> >> +maintainers:
> >> +  - Dilip Kota <eswara.kota@linux.intel.com>
> >> +
> >> +description: |
> >> +  Intel combo phy subsystem supports PHYs for PCIe, EMAC and SATA
> >> +  controllers. A single combo phy provides two PHY instances.
> >> +
> >> +properties:
> >> +  $nodename:
> >> +    pattern: "^combophy@[0-9]+$"
> >> +
> >> +  compatible:
> >> +    items:
> >> +      - const: intel,combo-phy
> >> +      - const: simple-bus
> > This will cause the schema to be applied to every 'simple-bus'. You need
> > a custom 'select' to prevent that. There's several examples in the tree.
>
> Ok, i will add as below:
>
> # We need a select here so we don't match all nodes with 'simple-bus'
> select:
>    properties:
>      compatible:
>        contains:
>          const: intel,combo-phy
>    required:
>      - compatible
>
> >
> > Though I'm not sure you need child nodes here.
> >
> >> +
> >> +  cell-index:
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +    description: Index of Combo phy hardware instance.
> > Drop this. Not used for FDT.
> Ok, I will remove this and use the 'aliases' to get the hardware instance.
> >
> >> +
> >> +  resets:
> >> +    maxItems: 2
> >> +
> >> +  reset-names:
> >> +    items:
> >> +      - const: phy
> >> +      - const: core
> >> +
> >> +  intel,syscfg:
> >> +    $ref: /schemas/types.yaml#/definitions/phandle
> >> +    description: Chip configuration registers handle
> >> +
> >> +  intel,hsio:
> >> +    $ref: /schemas/types.yaml#/definitions/phandle
> >> +    description: HSIO registers handle
> >> +
> >> +  intel,bid:
> >> +    description: Index of HSIO bus
> >> +    allOf:
> >> +      - $ref: /schemas/types.yaml#/definitions/uint32
> >> +      - minimum: 0
> >> +      - maximum: 1
> > If this is related to intel,hsio, just make it an args cell for
> > intel,hsio.
> No. Actually, this is specific to the combophy instance on the HSIO bus.
> I see , this can be removed and value can be derived from the hardware
> instance value mentioned through 'aliases'

Generally, 'aliases' should be optional. Why do you need an index?
What's the difference between the blocks?

If it wasn't clear, I was suggesting doing:

intel,hsio = <&hsio 1>;

Rob
