Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F60C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D11C206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586879221;
	bh=yDomIilinKjKK4g9W8MaLiIgzrCHzp7UDmwVuhtnFmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FBX/VvYRa3mqqUAPDWDDb8nMcGF3ySRGnH03ngezjbSc3lez6yutO/oHK9jLV3TX7
	 M6OvpZvGFc2Z2cSi7T+NryimfL0WrXLroO6W2TSxCWXbNxi/uIbWTzjiLUsbcS4qfM
	 Ywfi7ZqdaDPf25g9+jki1ct1Qg3/aXrvYbF1MJRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440879AbgDNPq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:46:58 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37582 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731196AbgDNPqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:46:48 -0400
Received: by mail-oi1-f194.google.com with SMTP id r25so920662oij.4;
        Tue, 14 Apr 2020 08:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5/QdFs0H17QBuX1uwsHW6SudnkNXUrD80svVL4aPMwA=;
        b=k9aOKYssPBKNmvD+yPo6pOODZ2wkUQv0NDmCSelZq/4ayruvqlttiBLAn7g0D9v31t
         I4Caj4P3sNNDUAFfIkcLcPD5M/yIBS+ekBiEdUsW7YzgBBWzezUVx9qwBt2ro0DTLx8o
         JZnuzMhSDuOnURnsUwqRMfXK/GNmlMT2PqOEw8Wn7Oz86fhh8nASTGMPqWTc1H5eODhh
         RIr3/YvTsV3jcwPIaoTbtco9y8KVHHJJNjFyIdDAF0LDjqIYxuWsE2yqfCGLvUOAkITM
         o+QoAc/tOwxMaQyv5V02rKpmn26Q03VA4YYlOMI/ky1DXcl48HR66FT1nxA0agSntJxN
         Cqug==
X-Gm-Message-State: AGi0PuYY6yM8dhSMz8PDk+kxBwfMF7Xry8Er+ncaU/zQnISgrT+Im3J0
        nP3zBM5uuCl5GuHneqodlA==
X-Google-Smtp-Source: APiQypJ3eP83Z2ZO3/8+TVOT/jGS5+ZbScl3AXJZ0ygf+ficXnDSMlWcvhkIksYNLU3yBioFZCcKvA==
X-Received: by 2002:aca:2209:: with SMTP id b9mr16431716oic.103.1586879206591;
        Tue, 14 Apr 2020 08:46:46 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z24sm1428489otq.75.2020.04.14.08.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 08:46:45 -0700 (PDT)
Received: (nullmailer pid 28325 invoked by uid 1000);
        Tue, 14 Apr 2020 15:46:43 -0000
Date:   Tue, 14 Apr 2020 10:46:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, mark.rutland@arm.com, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/7] ASoC: dt-bindings: fsl_easrc: Add document for
 EASRC
Message-ID: <20200414154643.GA29098@bogus>
References: <cover.1585726761.git.shengjiu.wang@nxp.com>
 <68208297b49e85adfddf843bc205d154790a49de.1585726761.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68208297b49e85adfddf843bc205d154790a49de.1585726761.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 04:45:39PM +0800, Shengjiu Wang wrote:
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
> index 000000000000..14ea60084420
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
> +  firmware-name:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/string
> +      - const: imx/easrc/easrc-imx8mn.bin
> +    description: The coefficient table for the filters
> +
> +  fsl,asrc-rate:

fsl,asrc-rate-hz

> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32

And then you can drop this.

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
> +  - firmware-name
> +  - fsl,asrc-rate
> +  - fsl,asrc-format
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mn-clock.h>
> +
> +    easrc: easrc@300C0000 {

Lowercase hex

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
> +           firmware-name = "imx/easrc/easrc-imx8mn.bin";
> +           fsl,asrc-rate  = <8000>;
> +           fsl,asrc-format = <2>;
> +    };
> -- 
> 2.21.0
> 
