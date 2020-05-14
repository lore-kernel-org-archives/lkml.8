Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43706C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FC2E20671
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgENJb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 05:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725878AbgENJb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 05:31:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDF1C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 02:31:26 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1jZACz-0001LV-Mi; Thu, 14 May 2020 11:31:17 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1jZACy-0005WE-PV; Thu, 14 May 2020 11:31:16 +0200
Date:   Thu, 14 May 2020 11:31:16 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Fengping Yu <fengping.yu@mediatek.com>
Cc:     Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] dt-bindings: Add keypad devicetree documentation
Message-ID: <20200514093116.coiz5ofsjmxhafma@pengutronix.de>
References: <20200514061747.25466-1-fengping.yu@mediatek.com>
 <20200514061747.25466-2-fengping.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514061747.25466-2-fengping.yu@mediatek.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:26:01 up 181 days, 44 min, 197 users,  load average: 0.03, 0.10,
 0.14
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20-05-14 14:17, Fengping Yu wrote:
> From: "fengping.yu" <fengping.yu@mediatek.com>
> 
> Add Mediatek matrix keypad dt-binding doc as yaml schema.
> 
> Signed-off-by: fengping.yu <fengping.yu@mediatek.com>
> ---
>  .../devicetree/bindings/input/mtk-kpd.yaml    | 102 ++++++++++++++++++
>  1 file changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/mtk-kpd.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/mtk-kpd.yaml b/Documentation/devicetree/bindings/input/mtk-kpd.yaml
> new file mode 100644
> index 000000000000..8f594fe0bfc2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/mtk-kpd.yaml
> @@ -0,0 +1,102 @@
> +%YAML 1.2
> +---
> +version: 1
> +
> +$id: http://devicetree.org/schemas/input/mtk-keypad.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek's Keypad Controller device tree bindings
> +
> +maintainer:
> +  - Fengping Yu <fengping.yu@mediatek.com>
> +
> +description: |
> +  Mediatek's Keypad controller is used to interface a SoC with a matrix-type
> +  keypad device. The keypad controller supports multiple row and column lines.
> +  A key can be placed at each intersection of a unique row and a unique column.
> +  The keypad controller can sense a key-press and key-release and report the
> +  event using a interrupt to the cpu.
> +
> +properties:
> +  compatible:
> +      constraint: |

enum or const ?

> +        "mediatek,mt6779-keypad"
> +        "mediatek, kp"
> +
> +    clock-names:
> +	description: Names of the clocks listed in clocks property in the same order
> +
> +    clocks:
> +	description: Must contain one entry, for the module clock
> +	refs: devicetree/bindings/clocks/clock-bindings.txt for details.
> +
> +    interrupts:
> +	description: A single interrupt specifier
> +
> +    linux,keymap:
> +	description: The keymap for keys as described in the binding document
> +	refs: devicetree/bindings/input/matrix-keymap.txt
> +
> +    pinctrl-0:
> +	description: Specify pin control groups used for this controller
> +	refs: devicetree/bindings/pinctrl/pinctrl-bindings.txt
> +
> +    pinctrl-names:
> +	description: Names for optional pin modes
> +
> +    reg:
> +	description: The base address of the Keypad register bank
> +
> +    wakeup-source:
> +	description: use any event on keypad as wakeup event
> +
> +    keypad,num-columns:
> +	description: Number of column lines connected to the keypad controller,
> + 	it is not equal to PCB columns number, instead you should add required value
> + 	for each IC
> +
> +    keypad,num-rows:
> +	description: Number of row lines connected to the keypad controller, it is
> + 	not equal to PCB rows number, instead you should add required value for each IC
> +
> +    mediatek,debounce-us:
> +	description: Debounce interval in microseconds
> +	maximum: 256000

I think that you are missing the maxItems on all your properties so we
can't make any validation. Also the indent looks wrong.

> +
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - mediatek,debounce-us
> +  - keypad,num-rows
> +  - keypad,num-columns
> +  - linux,keymap
> +  - pinctrl
> +  - clocks
> +  - clock-names
> +
> +optional:
> +  - wakeup-source:

I think the optional can be dropped.

> +examples:
> +  - |
> +
> +    keypad: kp@10010000 {
> +	compatible = "mediatek,kp";
> +	reg = <0 0x10010000 0 0x1000>;
> +	wakeup-source;
> +	interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_FALLING>;
> +	clocks = <&clk26m>;
> +	clock-names = "kpd";
> +    };
> +
> +    &keypad {
> +	mediatek,debounce-us = <32000>;
> +	keypad,num-rows = <8>;
> +	keypad,num-columns = <9>;
> +	linux,keymap = < MATRIX_KEY(0x00, 0x00, KEY_VOLUMEDOWN) >;
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&kpd_gpios_def_cfg>;
> +    };

Pls squash those nodes.

Regards,
  Marco

> -- 
> 2.18.0
