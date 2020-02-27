Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E912C4BA06
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 04:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA5C24685
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 04:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgB0EFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 23:05:06 -0500
Received: from kernel.crashing.org ([76.164.61.194]:36516 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbgB0EFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 23:05:06 -0500
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 01R44L0D022388
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Feb 2020 22:04:24 -0600
Message-ID: <26dccd7310f07c6dfe322ba0ea5dd1a980007563.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 7/7] dt-bindings: usb: add documentation for aspeed
 usb-vhub
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     rentao.bupt@gmail.com, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Date:   Thu, 27 Feb 2020 15:04:20 +1100
In-Reply-To: <20200226230346.672-8-rentao.bupt@gmail.com>
References: <20200226230346.672-1-rentao.bupt@gmail.com>
         <20200226230346.672-8-rentao.bupt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-26 at 15:03 -0800, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Add device tree binding documentation for aspeed usb-vhub driver.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
>  No change in v2/v3/v4:
>    - the patch is added to the patch series since v4.
> 
>  .../bindings/usb/aspeed,usb-vhub.yaml         | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> new file mode 100644
> index 000000000000..6ebae46641e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2020 Facebook Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/aspeed,usb-vhub.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED USB 2.0 Virtual Hub Controller
> +
> +maintainers:
> +  - Felipe Balbi <balbi@kernel.org>

Actually I mantain that one, so make this Benjamin Herrenschmidt <
benh@kernel.crashing.org>. Felipe is the overall maintainer of the USB
gadget subsystem afaik.

> +description: |+
> +  The ASPEED USB 2.0 Virtual Hub Controller implements 1 set of USB Hub
> +  register and several sets of Device and Endpoint registers to support
> +  the Virtual Hub's downstream USB devices.
> +
> +  Supported number of devices and endpoints vary depending on hardware
> +  revisions. AST2400 and AST2500 Virtual Hub supports 5 downstream devices
> +  and 15 generic endpoints, while AST2600 Virtual Hub supports 7 downstream
> +  devices and 21 generic endpoints.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2400-usb-vhub
> +      - aspeed,ast2500-usb-vhub
> +      - aspeed,ast2600-usb-vhub
> +
> +  reg:
> +    maxItems: 1
> +    description: Common configuration registers
> +
> +  clocks:
> +    maxItems: 1
> +    description: The Virtual Hub Controller clock gate
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  aspeed,vhub-downstream-ports:
> +    description: Number of downstream ports supported by the Virtual Hub
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  aspeed,vhub-generic-endpoints:
> +    description: Number of generic endpoints supported by the Virtual Hub
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +  - aspeed,vhub-downstream-ports
> +  - aspeed,vhub-generic-endpoints
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    vhub: usb-vhub@1e6a0000 {
> +            compatible = "aspeed,ast2500-usb-vhub";
> +            reg = <0x1e6a0000 0x300>;
> +            interrupts = <5>;
> +            clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&pinctrl_usb2ad_default>;
> +    };

