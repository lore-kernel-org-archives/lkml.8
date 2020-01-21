Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9BAC33CAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221C724655
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579647916;
	bh=iK3ar/jXOSKqd8sn6R0akgYAWeJyJFs/yYOps7b/ZGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y86lJ7qHmPe4x7RL7+sLW6ORxPQVYlLmgQzIniXeXYSsyfM5xoJEXH/DfjHP4t2yV
	 HIFJl9s2IJd/FHd5+Z1frwhWEJx7nZyIvG4jrNJ3PvERpqvCSdPj2kBT6mKzaNCNZE
	 gL1jFNlBJyWEHWZRsGtLb2Yyzr1+sSTTyhuuE51w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgAUXFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 18:05:15 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40762 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgAUXFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 18:05:15 -0500
Received: by mail-ot1-f68.google.com with SMTP id w21so4573038otj.7;
        Tue, 21 Jan 2020 15:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4AAfvC+x8Us+/ThobKytt/iSfaCb3JaxfjdaO0QR9zI=;
        b=hK7s6gog4RXxrspdcjdrUgam0BUB+gwdxONNBIbKoc0dLOIgTMNtdYKDdleLUgxPR2
         9bvv/eadUcHTnaCy6QVMR6XXQ663Nuiiuw0Gg8WeKywGSUr30Ru8xdTqOxY43G18fCWs
         hWi0D/v57A3/y3I120yvjro4rUumx4uKeBJ03umwyAlNY7XrN9DeRr28INqq9hxYYhHw
         WYKufksVHRcykLOXZ56bDgj8+2LHy3uJeCNLryYBOut16uoe4Nv/21ibIWA+LJiCAI9K
         06mftH4WzQuD7gYgvXQOmb72G+fn1AU54kWGE1Oq+r5t0n4AodeetJi2jLraxAiXd8Qt
         PchQ==
X-Gm-Message-State: APjAAAVg2kVig42/i++eQL5I+QXxhSn4hM5U0uIoxakvHjQSFzHpAcRv
        pllieL6LMYINnWEJ213t3g==
X-Google-Smtp-Source: APXvYqxCKSaofsbZttYljSTTzfofpFX0UqhVZAaeUyhtpycBdwaBl/jQmvAxIY6Abpzo89AROKA6JQ==
X-Received: by 2002:a9d:68d3:: with SMTP id i19mr5071722oto.71.1579647914263;
        Tue, 21 Jan 2020 15:05:14 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g5sm14011049otp.10.2020.01.21.15.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 15:05:13 -0800 (PST)
Received: (nullmailer pid 6740 invoked by uid 1000);
        Tue, 21 Jan 2020 23:05:12 -0000
Date:   Tue, 21 Jan 2020 17:05:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/7] dt-bindings: Add AXG shared MIPI/PCIE PHY bindings
Message-ID: <20200121230512.GA4486@bogus>
References: <20200115122908.16954-1-repk@triplefau.lt>
 <20200115122908.16954-3-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115122908.16954-3-repk@triplefau.lt>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 01:29:03PM +0100, Remi Pommarel wrote:
> Add documentation for the shared MIPI/PCIE PHYs found in AXG SoCs.
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  .../phy/amlogic,meson-axg-mipi-pcie.yaml      | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie.yaml
> new file mode 100644
> index 000000000000..3184146318cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie.yaml
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 BayLibre, SAS
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/amlogic,meson-axg-mipi-pcie.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic AXG shared MIPI/PCIE PHY
> +
> +maintainers:
> +  - Remi Pommarel <repk@triplefau.lt>
> +
> +properties:
> +  compatible:
> +    const: amlogic,axg-mipi-pcie-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#phy-cells"

Add:

additionalProperties: false


With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +examples:
> +  - |
> +    mpphy: phy@0 {
> +          compatible = "amlogic,axg-mipi-pcie-phy";
> +          reg = <0x0 0x0 0x0 0xc>;
> +          #phy-cells = <1>;
> +    };
> -- 
> 2.24.1
> 
