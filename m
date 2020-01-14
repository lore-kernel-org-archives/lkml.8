Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9756EC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63ACC2187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Qpn+Nc+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgANIEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 03:04:31 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36926 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgANIEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 03:04:31 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00E84Nnt023901;
        Tue, 14 Jan 2020 02:04:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578989063;
        bh=cbHr/XtYl1ScNrcV2l/fytPkg8e7XLp+hKaJC5xcA5M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Qpn+Nc+hZAYmCuYJmhvuT3utn0oZSLH5/pT4T5QQK5Ayyz7T6IG9dp6ab1FPifyMI
         ixt3kOM9ESJNfQNxUskldwRJnaEK5yb2UhAofqAE5qW4UHGJHMZKCs9T486LB4PUOc
         qyjHJRdvdVB44GMF7i9b51YzGkKLKVaSHNgg5CqQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00E84Nmo048181
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Jan 2020 02:04:23 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 14
 Jan 2020 02:04:23 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 14 Jan 2020 02:04:23 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00E84JKi050975;
        Tue, 14 Jan 2020 02:04:21 -0600
Subject: Re: [PATCH v5 13/14] dt-bindings: phy: Document WIZ (SERDES wrapper)
 bindings
To:     Rob Herring <robh+dt@kernel.org>
CC:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>,
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20191216095712.13266-14-kishon@ti.com>
 <20200102095631.1165-1-kishon@ti.com>
 <CAL_JsqJVmyXirczaWJb4hCsnVjXYt6ki22sBLe5D0240x4Xtzw@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <41a76196-827b-52dc-5d72-46b8e21f2107@ti.com>
Date:   Tue, 14 Jan 2020 13:36:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJVmyXirczaWJb4hCsnVjXYt6ki22sBLe5D0240x4Xtzw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 13/01/20 11:29 PM, Rob Herring wrote:
> On Thu, Jan 2, 2020 at 3:54 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> Add DT binding documentation for WIZ (SERDES wrapper). WIZ is *NOT* a
>> PHY but a wrapper used to configure some of the input signals to the
>> SERDES. It is used with both Sierra(16G) and Torrent(10G) serdes.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> [jsarha@ti.com: Add separate compatible for Sierra(16G) and Torrent(10G)
>>  SERDES]
>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>> ---
>> Changes from v4:
>> *) Fixed the indentation as suggested by Rob v4
>>
>>  .../bindings/phy/ti,phy-j721e-wiz.yaml        | 204 ++++++++++++++++++
>>  1 file changed, 204 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
>> new file mode 100644
>> index 000000000000..e010ea46b88d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
>> @@ -0,0 +1,204 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/phy/ti,phy-j721e-wiz.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: TI J721E WIZ (SERDES Wrapper)
>> +
>> +maintainers:
>> +  - Kishon Vijay Abraham I <kishon@ti.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,j721e-wiz-16g
>> +      - ti,j721e-wiz-10g
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 3
>> +    description: clock-specifier to represent input to the WIZ
>> +
>> +  clock-names:
>> +    items:
>> +      - const: fck
>> +      - const: core_ref_clk
>> +      - const: ext_ref_clk
>> +
>> +  num-lanes:
>> +    minimum: 1
>> +    maximum: 4
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 1
>> +
>> +  "#reset-cells":
>> +    const: 1
>> +
>> +  ranges: true
>> +
>> +  assigned-clocks:
>> +    maxItems: 2
>> +
>> +  assigned-clock-parents:
>> +    maxItems: 2
>> +
>> +patternProperties:
>> +  "^pll[0|1]-refclk$":
>> +    type: object
>> +    description: |
>> +      WIZ node should have subnodes for each of the PLLs present in
>> +      the SERDES.
>> +    properties:
>> +      clocks:
>> +        maxItems: 2
>> +        description: Phandle to clock nodes representing the two inputs to PLL.
>> +
>> +      "#clock-cells":
>> +        const: 0
>> +
>> +      assigned-clocks:
>> +        maxItems: 1
>> +
>> +      assigned-clock-parents:
>> +        maxItems: 1
>> +
>> +    required:
>> +      - clocks
>> +      - "#clock-cells"
>> +      - assigned-clocks
>> +      - assigned-clock-parents
>> +
>> +  "^cmn-refclk1?-dig-div$":
>> +    type: object
>> +    description:
>> +      WIZ node should have subnodes for each of the PMA common refclock
>> +      provided by the SERDES.
>> +    properties:
>> +      clocks:
>> +        maxItems: 1
>> +        description: Phandle to the clock node representing the input to the
>> +          divider clock.
>> +
>> +      "#clock-cells":
>> +        const: 0
>> +
>> +    required:
>> +      - clocks
>> +      - "#clock-cells"
>> +
>> +  "^refclk-dig$":
>> +    type: object
>> +    description: |
>> +      WIZ node should have subnode for refclk_dig to select the reference
>> +      clock source for the reference clock used in the PHY and PMA digital
>> +      logic.
>> +    properties:
>> +      clocks:
>> +        maxItems: 4
>> +        description: Phandle to four clock nodes representing the inputs to
>> +          refclk_dig
>> +
>> +      "#clock-cells":
>> +        const: 0
>> +
>> +      assigned-clocks:
>> +        maxItems: 1
>> +
>> +      assigned-clock-parents:
>> +        maxItems: 1
>> +
>> +    required:
>> +      - clocks
>> +      - "#clock-cells"
>> +      - assigned-clocks
>> +      - assigned-clock-parents
>> +
>> +  "^serdes@[0-9a-f]+$":
>> +    type: object
>> +    description: |
>> +      WIZ node should have '1' subnode for the SERDES. It could be either
>> +      Sierra SERDES or Torrent SERDES. Sierra SERDES should follow the
>> +      bindings specified in
>> +      Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
>> +      Torrent SERDES should follow the bindings specified in
>> +      Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
>> +
>> +required:
>> +  - compatible
>> +  - power-domains
>> +  - clocks
>> +  - clock-names
>> +  - num-lanes
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +  - "#reset-cells"
>> +  - ranges
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
>> +
>> +    wiz@5000000 {
>> +           compatible = "ti,j721e-wiz-16g";
>> +           #address-cells = <1>;
>> +           #size-cells = <1>;
>> +           power-domains = <&k3_pds 292 TI_SCI_PD_EXCLUSIVE>;
>> +           clocks = <&k3_clks 292 5>, <&k3_clks 292 11>, <&dummy_cmn_refclk>;
>> +           clock-names = "fck", "core_ref_clk", "ext_ref_clk";
>> +           assigned-clocks = <&k3_clks 292 11>, <&k3_clks 292 0>;
>> +           assigned-clock-parents = <&k3_clks 292 15>, <&k3_clks 292 4>;
>> +           num-lanes = <2>;
>> +           #reset-cells = <1>;
>> +           ranges = <0x5000000 0x0 0x5000000 0x10000>;
> 
> This fails in linux-next:
> 
> Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.example.dts:30.16-59:
> Warning (ranges_format): /example-0/wiz@50
> 00000:ranges: "ranges" property has invalid length (16 bytes) (parent
> #address-cells == 1, child #address-cells == 1, #
> size-cells == 1)
> 
> Please fix.

Fixed and pushed.

Thanks
Kishon
> 
> Rob
> 
