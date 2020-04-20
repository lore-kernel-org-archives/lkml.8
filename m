Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B938C55182
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4EF820722
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587419043;
	bh=BoAvpCZUao/+tOLx2sDOOs3FQbUO0aLqRApbbgzOnys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JqUmHlGygjOWrLhcIh11kQRfRcyMbEpPpQ629uBzOh0G8pub0AAZiO95YbsD4nub0
	 HwWvHVlJfzQQyUFxpthxd/JMWVqhTFr0/R07dLlp0OFBHX/cMpjvQ8SZfurdx77Esg
	 rjqQR1LJuiBpwP5EzMiUT09M7SuxdA+tjuOt+glc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgDTVoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:44:02 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35330 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgDTVoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:44:01 -0400
Received: by mail-ot1-f68.google.com with SMTP id e20so9554683otl.2;
        Mon, 20 Apr 2020 14:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LZKwSahPOrclJ2VbpUDt4G9WvWMr16xeYo8HAFLzKHs=;
        b=jHh0jcIHsiGIkeQzCxvvlV+OWimM6d7hIlWq/XUDqz/App23r7FmnXzl+Y5z0H6MPQ
         BK+mtbxXLQ0iNgcD238/sXDVXSsZVihz5jq6kOw0zIpqPy20EJRZ+I8rv//2INdwLCXH
         RTFuICQORTx9gQgCw2xQtjcSEmYfb9me23e8dDatnIk0Vj2ZLBV7beIpHPW2d27kxEx2
         PI8FDymDGYCuzZ2M0k4+9nkeJZ9e9mNILk64YlcR0QjPUNNpDHhGc4vPiwaUp0/cSwRs
         SEgvSLLAkWOD1Uj2pvn2/dhibopYW4cGg2MOGUeEgtVNH2H9z/fZ7Bo5gXXxKr8ogpBX
         SLzQ==
X-Gm-Message-State: AGi0PuaSz5/hJzJwILsHIqaqAznbd5rluUaDDNR/3BmOv5FFqIGV4X68
        QKi2pIVwDgPxQNxryjMXtw==
X-Google-Smtp-Source: APiQypK5PQwdf2U+EhRi0OR/D/U3xkutLBi8s1XHwblbK6QRNb3bnhVOo1qkGTQJvhYoYxIjojr/NA==
X-Received: by 2002:a9d:7343:: with SMTP id l3mr9432115otk.276.1587419040593;
        Mon, 20 Apr 2020 14:44:00 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 76sm227400otg.68.2020.04.20.14.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:44:00 -0700 (PDT)
Received: (nullmailer pid 15237 invoked by uid 1000);
        Mon, 20 Apr 2020 21:43:59 -0000
Date:   Mon, 20 Apr 2020 16:43:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     srinivas.kandagatla@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 2/3] dt-bindings: nvmem: Convert i.MX IIM to json-schema
Message-ID: <20200420214358.GA13370@bogus>
References: <1586921602-1877-1-git-send-email-Anson.Huang@nxp.com>
 <1586921602-1877-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586921602-1877-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 11:33:21AM +0800, Anson Huang wrote:
> Convert the i.MX IIM binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/nvmem/imx-iim.txt          | 22 --------
>  .../devicetree/bindings/nvmem/imx-iim.yaml         | 59 ++++++++++++++++++++++
>  2 files changed, 59 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/nvmem/imx-iim.txt
>  create mode 100644 Documentation/devicetree/bindings/nvmem/imx-iim.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/imx-iim.txt b/Documentation/devicetree/bindings/nvmem/imx-iim.txt
> deleted file mode 100644
> index 1978c5b..0000000
> --- a/Documentation/devicetree/bindings/nvmem/imx-iim.txt
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -Freescale i.MX IC Identification Module (IIM) device tree bindings
> -
> -This binding represents the IC Identification Module (IIM) found on
> -i.MX25, i.MX27, i.MX31, i.MX35, i.MX51 and i.MX53 SoCs.
> -
> -Required properties:
> -- compatible: should be one of
> -	"fsl,imx25-iim", "fsl,imx27-iim",
> -	"fsl,imx31-iim", "fsl,imx35-iim",
> -	"fsl,imx51-iim", "fsl,imx53-iim",
> -- reg: Should contain the register base and length.
> -- interrupts: Should contain the interrupt for the IIM
> -- clocks: Should contain a phandle pointing to the gated peripheral clock.
> -
> -Example:
> -
> -	iim: iim@63f98000 {
> -		compatible = "fsl,imx53-iim", "fsl,imx27-iim";
> -		reg = <0x63f98000 0x4000>;
> -		interrupts = <69>;
> -                clocks = <&clks IMX5_CLK_IIM_GATE>;
> -	};
> diff --git a/Documentation/devicetree/bindings/nvmem/imx-iim.yaml b/Documentation/devicetree/bindings/nvmem/imx-iim.yaml
> new file mode 100644
> index 0000000..0d85d37
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/imx-iim.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/imx-iim.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX IC Identification Module (IIM) device tree bindings
> +
> +maintainers:
> +  - Anson Huang <Anson.Huang@nxp.com>
> +
> +description: |
> +  This binding represents the IC Identification Module (IIM) found on
> +  i.MX25, i.MX27, i.MX31, i.MX35, i.MX51 and i.MX53 SoCs.
> +
> +allOf:
> +  - $ref: "nvmem.yaml#"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx25-iim
> +      - fsl,imx27-iim
> +      - fsl,imx31-iim
> +      - fsl,imx35-iim
> +      - fsl,imx51-iim
> +      - fsl,imx53-iim
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description: |
> +      IIM's clock source.

Drop this. Same in patch 3.

> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx5-clock.h>
> +
> +    iim: efuse@63f98000 {
> +        compatible = "fsl,imx53-iim";
> +        reg = <0x63f98000 0x4000>;
> +        interrupts = <69>;
> +        clocks = <&clks IMX5_CLK_IIM_GATE>;
> +    };
> +
> +...
> -- 
> 2.7.4
> 
