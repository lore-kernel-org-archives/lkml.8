Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCC7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAA3F206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591996268;
	bh=g/uvLDAZ+ol49MHFs1XaNpXDp1DbLpjPRHzPzh71JEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hP2CXUDxapVD1idXXZ2rJ1sz/YuIaeORDO9fnKKF8rmfIEfJJYpESHNd0Iy/1aUUn
	 lC8+BSbowtxY5zu4O4WLbfNjIZVle5ZZ3wiLU9a4WLvsEJBUYXLpn8tKL+HdZX4p1T
	 SIOcIwGR3oXYJe0n9P/Emf9AkKprc6yOEpG+8B+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgFLVLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 17:11:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42480 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLVLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 17:11:05 -0400
Received: by mail-io1-f67.google.com with SMTP id x189so2655331iof.9;
        Fri, 12 Jun 2020 14:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LdO+yABvrQyODTNWEnFCNLq5SRWaCDFSeyJReNxOrN4=;
        b=rvwlgD4CDjjxhRFq3GnZQuaaOWynCseOjX9XTo9tzIBXSOhAmSz3UyzW90JrGaUNgA
         8l6XQTaJLbbAYinHsbyVqZwXnU1iGD0TVTxL7PK12EHY1B/hdJZ6yyPaIzah1ZSW4ixd
         wlZYMGu6nEhyDV6yxZklc+YHnRbVnTM/X6u/Kxugb6Xoooo1r2JNOig5X+R3kBZyBH7B
         gZr0MhgY7hh94dpkDNznckXaT0DYuxXBv+0/Dw5XB5KfkvswmqVgCwhGfk+rUODFshfa
         XD8EHjWo+gWCozzZfs7lWJxuaZGSzYit5jCcmoXeWvS54m/6p/HKFBXdZWb/vCRAWRff
         w6rg==
X-Gm-Message-State: AOAM533McH6+m52BWG4lE2qXDMSeMO0VYlKFHHFQ6nWrsJ3EKNt3DiRo
        037kzUbtuadW0f5sSilzGw==
X-Google-Smtp-Source: ABdhPJyTLPwHiCPMWBDlg3TIAXPWsywr4DNWk8QAGkvpv7/LiQJCR/XEW/hsc3A/ByLjKLXUmh/i0w==
X-Received: by 2002:a05:6638:406:: with SMTP id q6mr10161463jap.125.1591996263990;
        Fri, 12 Jun 2020 14:11:03 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id d66sm3628624iof.27.2020.06.12.14.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 14:11:02 -0700 (PDT)
Received: (nullmailer pid 3820221 invoked by uid 1000);
        Fri, 12 Jun 2020 21:11:01 -0000
Date:   Fri, 12 Jun 2020 15:11:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Heiko Stuebner <heiko@sntech.de>,
        Philippe CORNU <philippe.cornu@st.com>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-imx@nxp.com,
        kernel@collabora.com, linux-stm32@st-md-mailman.stormreply.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Fabio Estevam <festevam@gmail.com>,
        Adrian Pop <pop.adrian61@gmail.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Sjoerd Simons <sjoerd.simons@collabora.com>,
        Martyn Welch <martyn.welch@collabora.com>
Subject: Re: [PATCH v9 05/11] dt-bindings: display: add i.MX6 MIPI DSI host
 controller doc
Message-ID: <20200612211101.GA3808755@bogus>
References: <20200609174959.955926-1-adrian.ratiu@collabora.com>
 <20200609174959.955926-6-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609174959.955926-6-adrian.ratiu@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 08:49:53PM +0300, Adrian Ratiu wrote:
> This provides an example DT binding for the MIPI DSI host controller

It's not an example. It defines the exact binding for this peripheral.

> present on the i.MX6 SoC based on Synopsis DesignWare v1.01 IP.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: devicetree@vger.kernel.org
> Tested-by: Adrian Pop <pop.adrian61@gmail.com>
> Tested-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.com>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
> Changes since v8:
>   - Fixed small compatible string typo caught by checkpatch
>   - Added custom select for 'fsl,imx6-mipi-dsi' (Rob)
>   - Replaced additionalProperties -> unevaluatedProperties (Rob)
>   - Dropped all nodes not adding any new constraints apart from
>   the recently upstreamed snps,dw-mipi-dsi.yaml (Rob)
> 
> Changes since v7:
>   - Clarified port@0,1 descriptions, marked them as required and
>   added missing port@0 in example (Laurent)
> 
> Changes since v6:
>   - Added ref to the newly created snps,dw-mipi-dsi.yaml (Laurent)
>   - Moved *-cells properties outside patternProperties (Laurent)
>   - Removed the panel port documentation (Laurent)
>   - Wrapped lines at 80 chars, typo fixes, sort includes (Laurent)
> 
> Changes since v5:
>   - Fixed missing reg warning (Fabio)
>   - Updated dt-schema and fixed warnings (Rob)
> 
> Changes since v4:
>   - Fixed yaml binding to pass `make dt_binding_check dtbs_check`
>   and addressed received binding feedback (Rob)
> 
> Changes since v3:
>   - Added commit message (Neil)
>   - Converted to yaml format (Neil)
>   - Minor dt node + driver fixes (Rob)
>   - Added small panel example to the host controller binding
> 
> Changes since v2:
>   - Fixed commit tags (Emil)
> ---
>  .../display/imx/fsl,mipi-dsi-imx6.yaml        | 112 ++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml b/Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml
> new file mode 100644
> index 0000000000000..86093729fd5f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/imx/fsl,mipi-dsi-imx6.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX6 DW MIPI DSI Host Controller
> +
> +maintainers:
> +  - Adrian Ratiu <adrian.ratiu@collabora.com>
> +
> +description: |
> +  The i.MX6 DSI host controller is a Synopsys DesignWare MIPI DSI v1.01
> +  IP block with a companion PHY IP.
> +
> +  These DT bindings follow the Synopsys DW MIPI DSI bindings defined in
> +  Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt with
> +  the following device-specific properties.
> +
> +allOf:
> +  - $ref: ../bridge/snps,dw-mipi-dsi.yaml#
> +
> +# Need a custom select here or 'snps,dw-mipi-dsi' will match lots of nodes
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - fsl,imx6-mipi-dsi
> +  required:
> +    - compatible
> +
> +properties:

> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0

These 2 are covered by dsi-controller.yaml, so you can drop them.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
