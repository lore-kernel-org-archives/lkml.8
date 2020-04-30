Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09691C8300B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E87602173E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgD3KFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 06:05:17 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48000 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgD3KFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 06:05:15 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 436302007CC;
        Thu, 30 Apr 2020 12:05:13 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3644B2007CB;
        Thu, 30 Apr 2020 12:05:13 +0200 (CEST)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 2124E20397;
        Thu, 30 Apr 2020 12:05:13 +0200 (CEST)
Date:   Thu, 30 Apr 2020 13:05:12 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V4 1/5] dt-bindings: clock: Convert i.MX6Q clock to
 json-schema
Message-ID: <20200430100512.lzvuxzcardw5uwi2@fsr-ub1664-175>
References: <1588207921-20604-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588207921-20604-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-04-30 08:51:57, Anson Huang wrote:
> Convert the i.MX6Q clock binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Great effort taking care of these. 

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
> Changes since V3:
> 	- update license to be with (GPL-2.0-only OR BSD-2-Clause);
> 	- remove unnecessary minItem for interrupts;
> 	- remove label in example.
> ---
>  .../devicetree/bindings/clock/imx6q-clock.txt      | 41 --------------
>  .../devicetree/bindings/clock/imx6q-clock.yaml     | 66 ++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 41 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/imx6q-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> deleted file mode 100644
> index 13d36d4..0000000
> --- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -* Clock bindings for Freescale i.MX6 Quad
> -
> -Required properties:
> -- compatible: Should be "fsl,imx6q-ccm"
> -- reg: Address and length of the register set
> -- interrupts: Should contain CCM interrupt
> -- #clock-cells: Should be <1>
> -
> -Optional properties:
> -- fsl,pmic-stby-poweroff: Configure CCM to assert PMIC_STBY_REQ signal
> -  on power off.
> -  Use this property if the SoC should be powered off by external power
> -  management IC (PMIC) triggered via PMIC_STBY_REQ signal.
> -  Boards that are designed to initiate poweroff on PMIC_ON_REQ signal should
> -  be using "syscon-poweroff" driver instead.
> -- clocks: list of clock specifiers, must contain an entry for each entry
> -          in clock-names
> -- clock-names: valid names are "osc", "ckil", "ckih1", "anaclk1" and "anaclk2"
> -
> -The clock consumer should specify the desired clock by having the clock
> -ID in its "clocks" phandle cell.  See include/dt-bindings/clock/imx6qdl-clock.h
> -for the full list of i.MX6 Quad and DualLite clock IDs.
> -
> -Examples:
> -
> -#include <dt-bindings/clock/imx6qdl-clock.h>
> -
> -clks: ccm@20c4000 {
> -	compatible = "fsl,imx6q-ccm";
> -	reg = <0x020c4000 0x4000>;
> -	interrupts = <0 87 0x04 0 88 0x04>;
> -	#clock-cells = <1>;
> -};
> -
> -uart1: serial@2020000 {
> -	compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
> -	reg = <0x02020000 0x4000>;
> -	interrupts = <0 26 0x04>;
> -	clocks = <&clks IMX6QDL_CLK_UART_IPG>, <&clks IMX6QDL_CLK_UART_SERIAL>;
> -	clock-names = "ipg", "per";
> -};
> diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> new file mode 100644
> index 0000000..0dc96ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fclock%2Fimx6q-clock.yaml%23&amp;data=02%7C01%7Cabel.vesa%40nxp.com%7Ca9ea8978c18a400f965d08d7eca1eec5%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637238052550722964&amp;sdata=vZmcBuigGFCbh1doAasvlXKFltD%2Fu9T4i88KWRoxck8%3D&amp;reserved=0
> +$schema: https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=02%7C01%7Cabel.vesa%40nxp.com%7Ca9ea8978c18a400f965d08d7eca1eec5%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637238052550722964&amp;sdata=RyT292O7qdkbmKrSMXEuHCo%2Fezm98n%2FAAYpansFL3%2BY%3D&amp;reserved=0
> +
> +title: Clock bindings for Freescale i.MX6 Quad
> +
> +maintainers:
> +  - Anson Huang <Anson.Huang@nxp.com>
> +
> +properties:
> +  compatible:
> +    const: fsl,imx6q-ccm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 2
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  clocks:
> +    items:
> +      - description: 24m osc
> +      - description: 32k osc
> +      - description: ckih1 clock input
> +      - description: anaclk1 clock input
> +      - description: anaclk2 clock input
> +
> +  clock-names:
> +    items:
> +      - const: osc
> +      - const: ckil
> +      - const: ckih1
> +      - const: anaclk1
> +      - const: anaclk2
> +
> +  fsl,pmic-stby-poweroff:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Use this property if the SoC should be powered off by external power
> +      management IC (PMIC) triggered via PMIC_STBY_REQ signal.
> +      Boards that are designed to initiate poweroff on PMIC_ON_REQ signal should
> +      be using "syscon-poweroff" driver instead.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - '#clock-cells'
> +
> +examples:
> +  # Clock Control Module node:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    clock-controller@20c4000 {
> +        compatible = "fsl,imx6q-ccm";
> +        reg = <0x020c4000 0x4000>;
> +        interrupts = <0 87 IRQ_TYPE_LEVEL_HIGH>,
> +                     <0 88 IRQ_TYPE_LEVEL_HIGH>;
> +        #clock-cells = <1>;
> +    };
> -- 
> 2.7.4
> 
