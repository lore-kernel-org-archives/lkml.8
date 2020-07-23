Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA73DC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA20020714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595518413;
	bh=Xc9dZfoEvXH/ux9MG5rXAE4LQbS2e8u78gSE7KvgLeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nqlJ1BcNmlxix/Z9v+pdzs1NY3Ih5zHXJHn9HWG136ZY0FS2ahMgruHGE1b3V700J
	 5ksiDHT/DcYLHOv6kqKfElSOLR/eqOiU/6q5DqO7+occxKR99rt9YMkUyPapD+EMsq
	 MlrBzMa4gnzrQaf5YSpcSfTYm8Tk96hFuOe6Voig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgGWPdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:33:32 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:46159 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgGWPdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:33:31 -0400
Received: by mail-il1-f196.google.com with SMTP id p15so4629557ilh.13;
        Thu, 23 Jul 2020 08:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LM6+liSSw+7zYWXhgHdp4eA8X4EaVz+GpXnsgH9vTZo=;
        b=bxlDAdqMteW4gGBMJ4aZ66nCrDKreTizhZsggh2ResBX2PP/+eQ/0tZBdVwGCF57TN
         rcqvtI8G1gZQW7NRItBRt+qV8IuQi6wh3hhZMaJ8++VYfe2MCj/TXpcwQK7UdPN92Nzz
         X9RMjIPHmSjUgpAM/yI01TYay2Q+4GiAuomgNmuqUBrdSKsk92AyCRmCBQcB/RRjxwLS
         PxY+A9dPyXFrJ800PQSrmUhvbZuI17Nz+bcwA9Pgh5mHG2WDMIus+TQM5he0+E+Zj57Z
         bGi4xg+0u3lqQai6e8u4Jcqo+m3wH33baUq47j50l3w5b+zEnq2Z8k8Qk+RiYZH5ik2a
         6Aug==
X-Gm-Message-State: AOAM531FBBWQ1uaUmwhrXcciioT785YgOKEC3vxRPMYySFsh1rLbMMwf
        X5SjS2zn8uynqnwfW1SB8b2zwlHB1w==
X-Google-Smtp-Source: ABdhPJzOFystWAMI9/98m5QBC9Z743ueo9tJi9nCRp7nGLYtCeMGte3aiYMh2AA43yi48RLZXie/fg==
X-Received: by 2002:a05:6e02:1253:: with SMTP id j19mr5586422ilq.145.1595518410158;
        Thu, 23 Jul 2020 08:33:30 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id j17sm1593887ilq.7.2020.07.23.08.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 08:33:29 -0700 (PDT)
Received: (nullmailer pid 412465 invoked by uid 1000);
        Thu, 23 Jul 2020 15:33:26 -0000
Date:   Thu, 23 Jul 2020 09:33:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch,
        Laurent.pinchart@ideasonboard.com, a.hajda@samsung.com,
        narmstrong@baylibre.com, jonas@kwiboo.se, jernej.skrabec@siol.net,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mparab@cadence.com,
        yamonkar@cadence.com, tomi.valkeinen@ti.com, jsarha@ti.com,
        nsekhar@ti.com, praneeth@ti.com
Subject: Re: [PATCH v7 1/3] dt-bindings: drm/bridge: Document Cadence MHDP
 bridge bindings
Message-ID: <20200723153326.GA407329@bogus>
References: <1595403640-12816-1-git-send-email-sjakhade@cadence.com>
 <1595403640-12816-2-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595403640-12816-2-git-send-email-sjakhade@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 09:40:38AM +0200, Swapnil Jakhade wrote:
> From: Yuti Amonkar <yamonkar@cadence.com>
> 
> Document the bindings used for the Cadence MHDP DPI/DP bridge in
> yaml format.
> 
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  .../bindings/display/bridge/cdns,mhdp.yaml    | 127 ++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
> new file mode 100644
> index 000000000000..cdf5760d4ec5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
> @@ -0,0 +1,127 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/display/bridge/cdns,mhdp.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Cadence MHDP bridge
> +
> +maintainers:
> +  - Swapnil Jakhade <sjakhade@cadence.com>
> +  - Yuti Amonkar <yamonkar@cadence.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cdns,mhdp8546
> +      - ti,j721e-mhdp8546
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description:
> +          Register block of mhdptx apb registers up to PHY mapped area (AUX_CONFIG_P).
> +          The AUX and PMA registers are not part of this range, they are instead
> +          included in the associated PHY.
> +      - description:
> +          Register block for DSS_EDP0_INTG_CFG_VP registers in case of TI J7 SoCs.
> +
> +  reg-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - const: mhdptx
> +      - const: j721e-intg
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      DP bridge clock, used by the IP to know how to translate a number of
> +      clock cycles into a time (which is used to comply with DP standard timings
> +      and delays).
> +
> +  phys:

maxItems: 1

> +    description:
> +      phandle to the DisplayPort PHY.
> +
> +  ports:
> +    type: object
> +    description:
> +      Ports as described in Documentation/devicetree/bindings/graph.txt.
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +      port@0:
> +        type: object
> +        description:
> +          Input port representing the DP bridge input.
> +
> +      port@1:
> +        type: object
> +        description:
> +          Output port representing the DP bridge output.
> +
> +    required:
> +      - port@0
> +      - port@1
> +      - '#address-cells'
> +      - '#size-cells'
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,j721e-mhdp8546
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +        reg-names:
> +          minItems: 2

else:
  properties:
    reg:
      maxItems: 1
    reg-names:
      maxItems: 1

> +
> +required:
> +  - compatible
> +  - clocks
> +  - reg
> +  - reg-names
> +  - phys
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mhdp: dp-bridge@f0fb000000 {
> +        compatible = "cdns,mhdp8546";
> +        reg = <0xf0 0xfb000000 0x0 0x1000000>;
> +        reg-names = "mhdptx";
> +        clocks = <&mhdp_clock>;
> +        phys = <&dp_phy>;
> +
> +        ports {
> +              #address-cells = <1>;
> +              #size-cells = <0>;
> +
> +              port@0 {
> +                     reg = <0>;
> +                     dp_bridge_input: endpoint {
> +                        remote-endpoint = <&xxx_dpi_output>;
> +                     };
> +              };
> +
> +              port@1 {
> +                     reg = <1>;
> +                     dp_bridge_output: endpoint {
> +                        remote-endpoint = <&xxx_dp_connector_input>;
> +                     };
> +              };
> +        };
> +    };
> +...
> -- 
> 2.26.1
> 
