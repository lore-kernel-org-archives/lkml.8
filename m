Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910A4C55182
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E4C0207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587417895;
	bh=wV/xC13m4vAE/JFz5qIugHkQT858OWkygzriD3LoE+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J+omMuOeyKZV30sunBwDwUrkzDYzOWnSAZ9KqqU0qjNgi/xTaF/IxhAhvY5cF0wwU
	 FKIijyaQwa2U54rpGNDTumDvte/bTh7F93/sSB762LlBZ6zhKeyg3Dqn/1OVpIW5CE
	 38pg0PCGVV0ZX6UNZmvKgKhiHge/uF3c52aGtG+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgDTVYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:24:54 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39320 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgDTVYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:24:54 -0400
Received: by mail-ot1-f65.google.com with SMTP id m13so9467240otf.6;
        Mon, 20 Apr 2020 14:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/PYRUd145uwywq6C1mfwPkvq46x3zUYySJRsVBrwgD0=;
        b=gABfUn/VhIiCaPBml9RA1JUY45UI3S1Nc3CH4iclMcyfq9vjkiMVisSdp8EAq9QHx6
         O49A7JUxotAj/Sr2v/c4ByIoNxQqqa48L3cCJloXuF4mFUNPVT+6vhSngpwf05T3RZs/
         yDqZTpQHR6StKFXxNK17b3ixSifY9VKPHyp4Jb/1NoBnZtGQu3Usp9t195JBT9CZTdYA
         l0L3MwQ7s6/09ekaUor64qI22UOg2F4uPk+zTNh8EoZe+r3AqF1Anxk070ITPPFw+Grj
         KQbXYOt9OC29mc+jE2SU/Al6eN8Ln5dGjsbHyZx3ruQuZzkVFibrf1yc4GjkppJSd63q
         B6zg==
X-Gm-Message-State: AGi0PuZfDn92Gwl7k4p4OKq9RxpuGwFSU0txpJrvjSCsRUWplIuQu0Zk
        j38nkYA0i7YxhQ6H2v4KkA==
X-Google-Smtp-Source: APiQypKHGZeotSvJnLU+HKhQIe9WZ4T519yDeefcTOMv5aOAD9cDz6Px0Xs8V3iP/9aejEJL9YmFXQ==
X-Received: by 2002:a9d:72c2:: with SMTP id d2mr11805918otk.260.1587417891893;
        Mon, 20 Apr 2020 14:24:51 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q206sm172423oib.2.2020.04.20.14.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:24:51 -0700 (PDT)
Received: (nullmailer pid 6994 invoked by uid 1000);
        Mon, 20 Apr 2020 21:24:50 -0000
Date:   Mon, 20 Apr 2020 16:24:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     dri-devel@lists.freedesktop.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: Document the Synopsys ARC HDMI TX
 bindings
Message-ID: <20200420212450.GA16835@bogus>
References: <20200414232929.22788-1-Eugeniy.Paltsev@synopsys.com>
 <20200414232929.22788-3-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414232929.22788-3-Eugeniy.Paltsev@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 02:29:29AM +0300, Eugeniy Paltsev wrote:
> This patch adds documentation of device tree bindings for the Synopsys
> HDMI 2.0 TX encoder driver for ARC SoCs.

You're going to need to base this on top of Laurent's conversion of 
dw_hdmi.txt to schema.

> 
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
>  .../display/bridge/snps,arc-dw-hdmi.yaml      | 136 ++++++++++++++++++
>  1 file changed, 136 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/snps,arc-dw-hdmi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/snps,arc-dw-hdmi.yaml b/Documentation/devicetree/bindings/display/bridge/snps,arc-dw-hdmi.yaml
> new file mode 100644
> index 000000000000..9b2fdfecd5b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/snps,arc-dw-hdmi.yaml
> @@ -0,0 +1,136 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings please:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/snps,arc-dw-hdmi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DesignWare HDMI 2.0 TX encoder driver

Bindings are for h/w blocks, not drivers.

> +
> +maintainers:
> +  - Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> +
> +description: |
> +  The HDMI transmitter is a Synopsys DesignWare HDMI 2.0 TX controller IP
> +  with a companion of Synopsys DesignWare HDMI 2.0 TX PHY IP.

Sounds like 2 blocks?

> +
> +  These DT bindings follow the Synopsys DWC HDMI TX bindings defined in
> +  Documentation/devicetree/bindings/display/bridge/dw_hdmi.txt
> +  with the following device-specific properties.
> +
> +properties:
> +  compatible:
> +    const: snps,arc-dw-hdmi-hsdk
> +
> +  reg:
> +    maxItems: 1
> +    description: |
> +      Memory mapped base address and length of the DWC HDMI TX registers.

Can drop.

> +
> +  clocks:
> +    items:
> +      - description: The bus clock for AHB / APB
> +      - description: The internal register configuration clock
> +
> +  clock-names:
> +    items:
> +      - const: iahb
> +      - const: isfr
> +
> +  interrupts:
> +    maxItems: 1
> +    description: Reference to the DWC HDMI TX interrupt

Can drop.

> +
> +  reg-io-width:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [1, 4]
> +        description: |
> +          Width of the registers specified by the reg property. The
> +          value is expressed in bytes and must be equal to 1 or 4 if specified.
> +          The register width defaults to 1 if the property is not present.

default: 1

The description is pretty much a plain text version of the constraints, 
so all but the first sentence can be dropped.

> +
> +  ports:
> +    type: object
> +    description: |
> +      A ports node with endpoint definitions as defined in
> +      Documentation/devicetree/bindings/media/video-interfaces.txt

Can drop. That's all 'ports'.

> +
> +    properties:
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +      port@0:
> +        type: object
> +        description: |
> +          Video input endpoints of the controller.
> +          Usually it is associated with ARC PGU.
> +
> +      port@1:
> +        type: object
> +        description: |
> +          Output endpoints of the controller. HDMI connector.
> +
> +    required:
> +      - "#address-cells"
> +      - "#size-cells"
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    hdmi@10000 {
> +        compatible = "snps,arc-dw-hdmi-hsdk";
> +        reg = <0x10000 0x10000>;
> +        reg-io-width = <4>;
> +        interrupts = <14>;
> +        clocks = <&apbclk>, <&hdmi_pix_clk>;
> +        clock-names = "iahb", "isfr";
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +                hdmi_enc_input: endpoint {
> +                    remote-endpoint = <&pgu_output>;
> +                };
> +            };
> +
> +            port@1 {
> +                reg = <1>;
> +                hdmi_enc_out: endpoint {
> +                    remote-endpoint = <&hdmi_con>;
> +                };
> +            };
> +        };
> +    };
> +
> +    hdmi-out {
> +        port {
> +            hdmi_con: endpoint {
> +                remote-endpoint = <&hdmi_enc_out>;
> +            };
> +        };
> +    };
> +
> +    pgu {
> +        port_o: port {
> +            pgu_output: endpoint {
> +                remote-endpoint = <&hdmi_enc_input>;
> +            };
> +        };
> +    };
> -- 
> 2.21.1
> 
