Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D399C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EBD21D56
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583200005;
	bh=ctG19+s42J2Y9cC8qlXSPN7mcuF71KKyeyCRAQoX9kA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yIPxWHy7VlIe4g1ypG6pT1AKSyTjQpanTbrbZ42YTDnTr6tAc943WAM41tiFnALeV
	 xdGjoxp34FZ5C7eOnSFr5KNqxHfdaZ7roWGN1hZbxI02ajsciMlI5JCHEaOskxrWvF
	 LF4Jp2mo43JKCGbJme4yRlIT6OyDd7/QUUGrfgpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgCCBqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 20:46:44 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44175 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCCBqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 20:46:43 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so1336584oia.11;
        Mon, 02 Mar 2020 17:46:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0fZprhK1W/+54HzE9JKB5hhmjgGt264/Y236IBMlW68=;
        b=lR/4o+07bzBzlRkdlfv0gattUouxgkExDjVvOmrFA31b+x7/mz1mIwT75EsQjFMRPG
         jp+B9VfvE0pitJaueic08AgwQ22RiLEhY2Jy2Gbfr6oSR7PVcesVv90OfCMcoVAEZBwT
         J1Mi0R6UZ3IqnTLlATz6RbRs/ojdo/nwUOLLjZCwNfVCxvv1FqZA8eMc34+VVowF06R3
         7LxZQ/lCd9j8Vr5zIeJfKrBP0Miwlr0MLTW/+eUT84BhMLZ6F1hZM+Px+qLHd+m/1k9c
         9OZyVBGyG9w2t8ApUjIouni2mIYpdx15R7T1XKzAE4IILRTQ/o9SpIJwALmAx0TKioZK
         UVeA==
X-Gm-Message-State: ANhLgQ1d7KbHJeb4DSDsBM+sObWqwhYovrwGXAHnVMqXWdj9R2/Sgc5K
        3Ssjkou1aEg/Z2orsuTIdg==
X-Google-Smtp-Source: ADFU+vtMKankA5j2TyBMep5zxakZ/gSxHjO96dpd6H9OgS/zdaStVrFVHEAotLCrZcCrix4ZjMErJQ==
X-Received: by 2002:aca:bfc2:: with SMTP id p185mr936911oif.57.1583200002745;
        Mon, 02 Mar 2020 17:46:42 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m19sm7258226otn.47.2020.03.02.17.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 17:46:42 -0800 (PST)
Received: (nullmailer pid 467 invoked by uid 1000);
        Tue, 03 Mar 2020 01:46:40 -0000
Date:   Mon, 2 Mar 2020 19:46:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, mark.rutland@arm.com, devicetree@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/8] ASoC: dt-bindings: fsl_easrc: Add document for
 EASRC
Message-ID: <20200303014640.GA26270@bogus>
References: <cover.1583039752.git.shengjiu.wang@nxp.com>
 <2aa0b446c3e2af59e3472d8f7706298691ec4a5c.1583039752.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aa0b446c3e2af59e3472d8f7706298691ec4a5c.1583039752.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 01:24:18PM +0800, Shengjiu Wang wrote:
> EASRC (Enhanced Asynchronous Sample Rate Converter) is a new
> IP module found on i.MX8MN.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,easrc.yaml  | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> new file mode 100644
> index 000000000000..500af8f0c8f0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings:

(GPL-2.0-only OR BSD-2-Clause)

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
> +    oneOf:
> +      - items:

You can drop oneOf and items here.

> +        - enum:
> +          - fsl,imx8mn-easrc

Blank line between properties please.

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
> +    oneOf:

Drop oneOf as there is only one.

> +      - items:
> +          - const: ctx0_rx
> +          - const: ctx0_tx
> +          - const: ctx1_rx
> +          - const: ctx1_tx
> +          - const: ctx2_rx
> +          - const: ctx2_tx
> +          - const: ctx3_rx
> +          - const: ctx3_tx
> +
> +  fsl,easrc-ram-script-name:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: The coefficient table for the filters

Need to define the exact string(s).

> +
> +  fsl,asrc-rate:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Defines a mutual sample rate used by DPCM Back Ends

Constraints?

> +
> +  fsl,asrc-format:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Defines a mutual sample format used by DPCM Back Ends

Constraints?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - dmas
> +  - dma-name

dma-names

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
> +           status = "disabled";

Don't show status in examples.

> +    };
> -- 
> 2.21.0
> 
