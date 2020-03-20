Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3F9C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E8C20777
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584726497;
	bh=kH6r0irKxa0rb6nxt3outSD00HOBaM/SfWO6IW1kjO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bOceTaCBLm9Yy10J3vtKNbssgMkXxYemZ03qakSRooBow9KN4t8oNjRJLmQJHDvid
	 uCyosJ6fnPz35WKX+RDUzI77Qx9OnXQFjultMrooHhCUd0HQKbtrgFLPvyOBpwTJ2a
	 OdgBS9v9Hih498jbdR+oowOF7Xdewn72f4lzmdsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgCTRsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:48:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38966 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCTRsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:48:16 -0400
Received: by mail-io1-f65.google.com with SMTP id c19so6836811ioo.6;
        Fri, 20 Mar 2020 10:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sdZ8Fz0NTe2Z8mbny4b+ZzHCT+owc9QawbF3H7/fFjQ=;
        b=Bej2tm2sn5GSpjPSq2sLEm/Jvnu8sMUmYPFgAcBmhnqFIlYYvEcka8MGL6ykUX2AAY
         Rvy6q4OQXd7rQWhUFnDMLWI+Z0HcI6mdHryD5kggV31xTIC1lI0EffF5Qacur/GHrxLz
         eAfU3NE6W9oaZD/tH4FIyV9P3PZ/inOPKSeGJ1T/6ayet0f290yA4h7xl94nS/FOYnOv
         LJYUujblWRDUO5AUiqgg0O9tzf3tlb7qYlqjZpjY7XrHQczjChHii7vcysp1hEyFQIk1
         XWGBGRFJDIcesxiR2JCop5Ai8ByRU2NIIooI3vJjp/Ts8YorZhwe7kuULYzBzKO+1Rjb
         jy6A==
X-Gm-Message-State: ANhLgQ3WAKR6pgFMFnL1vgrDwSGtogbr9OQIil36idXHIS0ifWN/Aj3r
        ju3Odb8Kt6+xsVYr18LtHw==
X-Google-Smtp-Source: ADFU+vvwo0sFRpgMy8S/+VmmSzmDzKFlPryLvd9OSadfOfVEWtEg1diSdrBlcDY6qZflMYnDgSLyOw==
X-Received: by 2002:a6b:7a07:: with SMTP id h7mr8385084iom.47.1584726495070;
        Fri, 20 Mar 2020 10:48:15 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t86sm2201336ili.82.2020.03.20.10.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 10:48:14 -0700 (PDT)
Received: (nullmailer pid 10514 invoked by uid 1000);
        Fri, 20 Mar 2020 17:48:12 -0000
Date:   Fri, 20 Mar 2020 11:48:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, mark.rutland@arm.com, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/7] ASoC: dt-bindings: fsl_easrc: Add document for
 EASRC
Message-ID: <20200320174812.GA27070@bogus>
References: <cover.1583725533.git.shengjiu.wang@nxp.com>
 <71b6ad3d0ea79076fded2373490ec1eb8c418d21.1583725533.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71b6ad3d0ea79076fded2373490ec1eb8c418d21.1583725533.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 11:58:33AM +0800, Shengjiu Wang wrote:
> EASRC (Enhanced Asynchronous Sample Rate Converter) is a new
> IP module found on i.MX8MN.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,easrc.yaml  | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> new file mode 100644
> index 000000000000..ff22f8056a63
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/fsl,easrc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP Asynchronous Sample Rate Converter (ASRC) Controller
> +
> +maintainers:
> +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "^easrc@.*"
> +
> +  compatible:
> +    const: fsl,imx8mn-easrc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Peripheral clock
> +
> +  clock-names:
> +    items:
> +      - const: mem
> +
> +  dmas:
> +    maxItems: 8
> +
> +  dma-names:
> +    items:
> +      - const: ctx0_rx
> +      - const: ctx0_tx
> +      - const: ctx1_rx
> +      - const: ctx1_tx
> +      - const: ctx2_rx
> +      - const: ctx2_tx
> +      - const: ctx3_rx
> +      - const: ctx3_tx
> +
> +  fsl,easrc-ram-script-name:

'firmware-name' is the established property name for this.

> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/string
> +      - const: imx/easrc/easrc-imx8mn.bin

Though if there's only 1 possible value, why does this need to be in DT?

> +    description: The coefficient table for the filters

If the firmware is only 1 thing, then perhaps this should just be a DT 
property rather than a separate file. It depends on who owns/creates 
this file. If fixed for the platform, then DT is a good fit. If updated 
separately from DT and boot firmware, then keeping it separate makes 
sense.

> +
> +  fsl,asrc-rate:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 8000
> +      - maximum: 192000
> +    description: Defines a mutual sample rate used by DPCM Back Ends
> +
> +  fsl,asrc-format:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [2, 6, 10, 32, 36]
> +        default: 2
> +    description:
> +      Defines a mutual sample format used by DPCM Back Ends
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - dmas
> +  - dma-names
> +  - fsl,easrc-ram-script-name
> +  - fsl,asrc-rate
> +  - fsl,asrc-format
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mn-clock.h>
> +
> +    easrc: easrc@300C0000 {
> +           compatible = "fsl,imx8mn-easrc";
> +           reg = <0x0 0x300C0000 0x0 0x10000>;
> +           interrupts = <0x0 122 0x4>;
> +           clocks = <&clk IMX8MN_CLK_ASRC_ROOT>;
> +           clock-names = "mem";
> +           dmas = <&sdma2 16 23 0> , <&sdma2 17 23 0>,
> +                  <&sdma2 18 23 0> , <&sdma2 19 23 0>,
> +                  <&sdma2 20 23 0> , <&sdma2 21 23 0>,
> +                  <&sdma2 22 23 0> , <&sdma2 23 23 0>;
> +           dma-names = "ctx0_rx", "ctx0_tx",
> +                       "ctx1_rx", "ctx1_tx",
> +                       "ctx2_rx", "ctx2_tx",
> +                       "ctx3_rx", "ctx3_tx";
> +           fsl,easrc-ram-script-name = "imx/easrc/easrc-imx8mn.bin";
> +           fsl,asrc-rate  = <8000>;
> +           fsl,asrc-format = <2>;
> +    };
> -- 
> 2.21.0
> 
