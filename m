Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0057C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988F9222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579117914;
	bh=t1JnoZZrMdB6dpZrnIPFBwIvNPCHtQXyso+T3PBvqbA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DqNK65ZBRRooA5js1w7iXOvuVZqLzjidHTAq6eJfnYBGypA41kBh3E7f2ubsT6MvB
	 myUC9TR86qvaP0Betbo7xphQvOQlf57R12W1ERFn1ctBhkPAxLj4voXkUiEZgTlLcv
	 AhD8woTtwkndcyYah3TQaOnIM5lFv69sd9dZLuWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbgAOTvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 14:51:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgAOTvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 14:51:53 -0500
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D525224671;
        Wed, 15 Jan 2020 19:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579117912;
        bh=t1JnoZZrMdB6dpZrnIPFBwIvNPCHtQXyso+T3PBvqbA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sMUtP1YVqLLAuMwtuWkZBe1Xby7Drbt2MLQHUzEvQklQsBeDrWOCn8UW5MhkQ6xkD
         SUde5Fv9yeP/ZyOKG3wYDyd0zLMdvHFUXqjfLrNA9wv90E2M+ISROLIMwIZzG9kfxK
         5tReUEXYC2usl8mfI23kVtX+F441xos2igT/8OaE=
Received: by mail-qk1-f177.google.com with SMTP id x1so16824836qkl.12;
        Wed, 15 Jan 2020 11:51:51 -0800 (PST)
X-Gm-Message-State: APjAAAXiDi8ThY1TKVP7fCwp4pRQx9h8q2uuUUFfTL7R6WFduSSIB/LN
        D1GGxvCXmoiy8Q+QaDCBoHusJ4BxdY1mrFfHyA==
X-Google-Smtp-Source: APXvYqwCKmmU8EBSjmHQt7piH3JvQrLULOrnWdxDuTYEHjP8bk1VpgkonsdNmkK30/2AtmyI260TpQJ5CJK2ex/nW6A=
X-Received: by 2002:a37:85c4:: with SMTP id h187mr29934418qkd.223.1579117910889;
 Wed, 15 Jan 2020 11:51:50 -0800 (PST)
MIME-Version: 1.0
References: <9f3df8c403bba3633391551fc601cbcd2f950959.1576824311.git.eswara.kota@linux.intel.com>
 <20200108141855.GA14868@bogus> <0e797d57-66a6-39ec-6388-5af47e9b0726@linux.intel.com>
 <CAL_JsqLaiiYxaWjWRr3S7Q8j5YCxB_v2Lt_m5fwHnZU1e27MdA@mail.gmail.com> <bee95b99-027e-45eb-d2f2-bfa5bbfda9cd@linux.intel.com>
In-Reply-To: <bee95b99-027e-45eb-d2f2-bfa5bbfda9cd@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 15 Jan 2020 13:51:39 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK9_EKsrkd3anmwZ062+a0sEmVTwKa1EZRpeLjmfwi7zg@mail.gmail.com>
Message-ID: <CAL_JsqK9_EKsrkd3anmwZ062+a0sEmVTwKa1EZRpeLjmfwi7zg@mail.gmail.com>
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

On Wed, Jan 15, 2020 at 1:52 AM Dilip Kota <eswara.kota@linux.intel.com> wrote:
>
>
> On 1/14/2020 10:31 PM, Rob Herring wrote:
> > On Tue, Jan 14, 2020 at 3:18 AM Dilip Kota <eswara.kota@linux.intel.com> wrote:
> >>
> >> On 1/8/2020 10:18 PM, Rob Herring wrote:
> >>> On Fri, Dec 20, 2019 at 03:28:27PM +0800, Dilip Kota wrote:
> >>>> Combo phy subsystem provides PHY support to number of
> >>>> controllers, viz. PCIe, SATA and EMAC.
> >>>> Adding YAML schemas for the same.
> >>>>
> >>>> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> >>>> ---
> >>>>    .../devicetree/bindings/phy/intel,combo-phy.yaml   | 147 +++++++++++++++++++++
> >>>>    1 file changed, 147 insertions(+)
> >>>>    create mode 100644 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
> >>>> new file mode 100644
> >>>> index 000000000000..fc9cbad9dd88
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
> >>>> @@ -0,0 +1,147 @@
> >>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>>> +%YAML 1.2
> >>>> +---
> >>>> +$id: http://devicetree.org/schemas/phy/intel,combo-phy.yaml#
> >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>> +
> >>>> +title: Intel Combo phy Subsystem
> >>>> +
> >>>> +maintainers:
> >>>> +  - Dilip Kota <eswara.kota@linux.intel.com>
> >>>> +
> >>>> +description: |
> >>>> +  Intel combo phy subsystem supports PHYs for PCIe, EMAC and SATA
> >>>> +  controllers. A single combo phy provides two PHY instances.
> >>>> +
> >>>> +properties:
> >>>> +  $nodename:
> >>>> +    pattern: "^combophy@[0-9]+$"
> >>>> +
> >>>> +  compatible:
> >>>> +    items:
> >>>> +      - const: intel,combo-phy
> >>>> +      - const: simple-bus
> >>> This will cause the schema to be applied to every 'simple-bus'. You need
> >>> a custom 'select' to prevent that. There's several examples in the tree.
> >> Ok, i will add as below:
> >>
> >> # We need a select here so we don't match all nodes with 'simple-bus'
> >> select:
> >>     properties:
> >>       compatible:
> >>         contains:
> >>           const: intel,combo-phy
> >>     required:
> >>       - compatible
> >>
> >>> Though I'm not sure you need child nodes here.
> >>>
> >>>> +
> >>>> +  cell-index:
> >>>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>>> +    description: Index of Combo phy hardware instance.
> >>> Drop this. Not used for FDT.
> >> Ok, I will remove this and use the 'aliases' to get the hardware instance.
> >>>> +
> >>>> +  resets:
> >>>> +    maxItems: 2
> >>>> +
> >>>> +  reset-names:
> >>>> +    items:
> >>>> +      - const: phy
> >>>> +      - const: core
> >>>> +
> >>>> +  intel,syscfg:
> >>>> +    $ref: /schemas/types.yaml#/definitions/phandle
> >>>> +    description: Chip configuration registers handle
> >>>> +
> >>>> +  intel,hsio:
> >>>> +    $ref: /schemas/types.yaml#/definitions/phandle
> >>>> +    description: HSIO registers handle
> >>>> +
> >>>> +  intel,bid:
> >>>> +    description: Index of HSIO bus
> >>>> +    allOf:
> >>>> +      - $ref: /schemas/types.yaml#/definitions/uint32
> >>>> +      - minimum: 0
> >>>> +      - maximum: 1
> >>> If this is related to intel,hsio, just make it an args cell for
> >>> intel,hsio.
> >> No. Actually, this is specific to the combophy instance on the HSIO bus.
> >> I see , this can be removed and value can be derived from the hardware
> >> instance value mentioned through 'aliases'
> > Generally, 'aliases' should be optional. Why do you need an index?
> > What's the difference between the blocks?
> >
> > If it wasn't clear, I was suggesting doing:
> >
> > intel,hsio = <&hsio 1>;
> On the SoC, total 4 combophy (0,1,2 and 3) instances are present ->
> 'cell-index'
> 2 instances (0,1) are present on the HSIOL NoC
> Other 2 instances (2,3) are present on the HSIOR NoC
> On the both HSIO NoCs, combophy instances are referred as 0 and 1 -> 'bid'

So you would have:

<&hsiol 0>
<&hsiol 1>
<&hsior 0>
<&hsior 1>

However, if HSIO is a bus and the combo phys are not on any other bus,
then perhaps you should be describing the buses in DT and then this
property goes away as these would be child nodes of the bus and
whatever addressing identifiers there are would go in 'reg'.

> 'bid' is required while accessing the registers in hsio block, to
> configure the COMBOPHY mode and clock
> 'cell-index' is required while accessing sysconfig registers to enable
> the pcie phy pad ref clock.

Do the same thing for the sysconfig handle:

<&sysconfig 0|1>

This is the common pattern for these types of properties with misc
extra register bits to go configure. Though more typically the cell
value is a register offset and bit position.

> <&hsio 1>
> 'bid' is specific to the combophy, not all the DT nodes using &hsio has
> a need.
> I think it is better to pass the bid value as a entry of combophy DT node.

intel,hsio is an entry in the combo phy. The meaning of any arg cells
is defined by the combo phy binding (and driver).

> I will add dt entry something like 'hw-instance-id' instead of
> cell-index or aliases.

As I said, we don't do h/w index properties.

Rob
