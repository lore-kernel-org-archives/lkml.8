Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A95C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 793AE2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgERJlq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgERJlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:41:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439CAC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 02:41:46 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jacHE-0001oF-9i; Mon, 18 May 2020 11:41:40 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jacHD-00015B-CV; Mon, 18 May 2020 11:41:39 +0200
Message-ID: <719ed778a36e7edfea080d42e9b837432e595d15.camel@pengutronix.de>
Subject: Re: [PATCH] dt-bindings: reset: Convert i.MX reset to json-schema
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Anson Huang <Anson.Huang@nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Date:   Mon, 18 May 2020 11:41:39 +0200
In-Reply-To: <1589250194-29441-1-git-send-email-Anson.Huang@nxp.com>
References: <1589250194-29441-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Tue, 2020-05-12 at 10:23 +0800, Anson Huang wrote:
> Convert the i.MX reset binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

thank you for the conversion.

> ---
>  .../devicetree/bindings/reset/fsl,imx-src.txt      | 49 ------------------
>  .../devicetree/bindings/reset/fsl,imx-src.yaml     | 58 ++++++++++++++++++++++
>  2 files changed, 58 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reset/fsl,imx-src.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/fsl,imx-src.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/fsl,imx-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx-src.txt
> deleted file mode 100644
> index 6ed79e6..0000000
> --- a/Documentation/devicetree/bindings/reset/fsl,imx-src.txt
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -Freescale i.MX System Reset Controller
> -======================================
> -
> -Please also refer to reset.txt in this directory for common reset
> -controller binding usage.
> -
> -Required properties:
> -- compatible: Should be "fsl,<chip>-src"
> -- reg: should be register base and length as documented in the
> -  datasheet
> -- interrupts: Should contain SRC interrupt and CPU WDOG interrupt,
> -  in this order.
> -- #reset-cells: 1, see below
> -
> -example:
> -
> -src: src@20d8000 {
> -        compatible = "fsl,imx6q-src";
> -        reg = <0x020d8000 0x4000>;
> -        interrupts = <0 91 0x04 0 96 0x04>;
> -        #reset-cells = <1>;
> -};
> -
> -Specifying reset lines connected to IP modules
> -==============================================
> -
> -The system reset controller can be used to reset the GPU, VPU,
> -IPU, and OpenVG IP modules on i.MX5 and i.MX6 ICs. Those device
> -nodes should specify the reset line on the SRC in their resets
> -property, containing a phandle to the SRC device node and a
> -RESET_INDEX specifying which module to reset, as described in
> -reset.txt
> -
> -example:
> -
> -        ipu1: ipu@2400000 {
> -                resets = <&src 2>;
> -        };
> -        ipu2: ipu@2800000 {
> -                resets = <&src 4>;
> -        };
> -
> -The following RESET_INDEX values are valid for i.MX5:
> -GPU_RESET     0
> -VPU_RESET     1
> -IPU1_RESET    2
> -OPEN_VG_RESET 3
> -The following additional RESET_INDEX value is valid for i.MX6:
> -IPU2_RESET    4
> diff --git a/Documentation/devicetree/bindings/reset/fsl,imx-src.yaml b/Documentation/devicetree/bindings/reset/fsl,imx-src.yaml
> new file mode 100644
> index 0000000..276a533
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/fsl,imx-src.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/fsl,imx-src.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX System Reset Controller
> +
> +maintainers:
> +  - Philipp Zabel <p.zabel@pengutronix.de>
> +
> +description: |
> +  The system reset controller can be used to reset the GPU, VPU,
> +  IPU, and OpenVG IP modules on i.MX5 and i.MX6 ICs. Those device
> +  nodes should specify the reset line on the SRC in their resets
> +  property, containing a phandle to the SRC device node and a
> +  RESET_INDEX specifying which module to reset, as described in
> +  reset.txt
> +
> +  The following RESET_INDEX values are valid for i.MX5:
> +    GPU_RESET     0
> +    VPU_RESET     1
> +    IPU1_RESET    2
> +    OPEN_VG_RESET 3
> +  The following additional RESET_INDEX value is valid for i.MX6:
> +    IPU2_RESET    4
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: "fsl,imx51-src"

"fsl,imx51-src" is the only compatible the driver matches on, but we
have these combinations on compatible SRCs in the device trees:

  "fsl,imx50-src", "fsl,imx51-src"
  "fsl,imx51-src"
  "fsl,imx53-src", "fsl,imx51-src"
  "fsl,imx6q-src", "fsl,imx51-src"
  "fsl,imx6sl-src", "fsl,imx51-src"
  "fsl,imx6sll-src", "fsl,imx51-src"
  "fsl,imx6sx-src", "fsl,imx51-src"
  "fsl,imx6ul-src", "fsl,imx51-src"

That could be described using oneOf and and an items list of const
values per SoC like in the qcom bindings.

regards
Philipp
