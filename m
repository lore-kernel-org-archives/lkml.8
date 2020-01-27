Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2184AC35248
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E654922527
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580145302;
	bh=MNDC3L72xdbz+DHTkFAqJDB2KEZTvOLexRz8u1AgfNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GTWAiTeAQ+Gn5Q7STQ5tnwpu21XdjNxGVKh/NlxUmvOZpgJoTrZcOcqMzXKQyRY9j
	 uJ7KLC0R6EPKbAJhK2EqhgvT39SkPBivs1uKm9ahhEbwOYIye6dB4GM1TR/ZBuL/N6
	 ptEQ5LK4gh+jvYCMbmD73nsYiP8A1aEmgMLFhANo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgA0RPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:15:01 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35956 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgA0RPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:15:00 -0500
Received: by mail-oi1-f196.google.com with SMTP id c16so7381599oic.3;
        Mon, 27 Jan 2020 09:15:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k4ey/v184CvKWYOReTk6RsIuynmUBFRFgYAqJjPcrR4=;
        b=oYnTFROH3KjFqanxyA3baGhgecDF3aTA3wCli2AB/MUVgHrzZOxgXk3QQuiuE5ZJmK
         FHCewuj3718BTJ1ieQbEz8pNVO4YpMdkm2JSO007FMosQCc2ikeGiQfQajxA+8FTlnvk
         8KEpSyDGGDbUOHeNsIVHqR2TIxH6tblYUKYwz611UgzWmIXiHVfp5dwJPVhZwXRtsfn3
         YX7bJgN9n3v5XwUAzTD7BGQVV4xwsAjgryhjE1c1HVmqX08y6IlGkyZv1VDI6v8UF9Fp
         U8hE3fb3Cfi8uaV3sZp9PWJoR1VMlk3j1cwibwtSeIYCTD9AYSA2gKz1kLaJwl0PwU2i
         U40w==
X-Gm-Message-State: APjAAAWW4Q9XTRnpFzO2yizhc5Bfs9jiCV0PIKz5jdbhHnJWUREXyqeQ
        uf2M3tIAgkpc9S0yhN8aej6s0c4=
X-Google-Smtp-Source: APXvYqziCDKOQq2CX3TlOi7pNha+sxl3OTQ8qLhFGhkhv0aU4a8izXXCeClJ1npkU1amNVWiRslj3Q==
X-Received: by 2002:aca:e146:: with SMTP id y67mr39769oig.93.1580145299818;
        Mon, 27 Jan 2020 09:14:59 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 6sm4930858oil.43.2020.01.27.09.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 09:14:59 -0800 (PST)
Received: (nullmailer pid 8334 invoked by uid 1000);
        Mon, 27 Jan 2020 17:14:57 -0000
Date:   Mon, 27 Jan 2020 11:14:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yuti Amonkar <yamonkar@cadence.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, maxime@cerno.tech, airlied@linux.ie,
        daniel@ffwll.ch, mark.rutland@arm.com, a.hajda@samsung.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, praneeth@ti.com,
        jsarha@ti.com, tomi.valkeinen@ti.com, mparab@cadence.com,
        sjakhade@cadence.com
Subject: Re: [PATCH v3 1/3] dt-bindings: drm/bridge: Document Cadence MHDP
 bridge bindings in yaml format
Message-ID: <20200127171457.GA32507@bogus>
References: <1579690501-10698-1-git-send-email-yamonkar@cadence.com>
 <1579690501-10698-2-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579690501-10698-2-git-send-email-yamonkar@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 11:54:59AM +0100, Yuti Amonkar wrote:
> Document the bindings used for the Cadence MHDP DPI/DP bridge in
> yaml format.
> 
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> ---
>  .../bindings/display/bridge/cdns,mhdp.yaml         | 131 +++++++++++++++++++++
>  1 file changed, 131 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
> new file mode 100644
> index 0000000..696418a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
> @@ -0,0 +1,131 @@

Missing SPDX tag. Dual license please.

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
> +          Register block of mhdptx apb registers upto PHY mapped area(AUX_CONFIG_P).
> +          The AUX and PMA registers are mapped to associated phy driver.
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
> +      DP bridge clock, it's used by the IP to know how to translate a number of
> +      clock cycles into a time (which is used to comply with DP standard timings
> +      and delays).
> +
> +  phys:
> +    description: Phandle to the DisplyPort phy.
> +
> +  phy-names:
> +    const: dpphy
> +
> +  ports:
> +    type: object
> +    description:
> +      Ports as described in Documentation/devicetree/bindings/graph.txt
> +
> +    properties:
> +       '#address-cells':

Wrong indentation.

> +         const: 1
> +
> +       '#size-cells':
> +         const: 0
> +
> +       port@0:
> +         type: object
> +         description:
> +           input port representing the DP bridge input
> +
> +       port@1:
> +         type: object
> +         description:
> +           output port representing the DP bridge output.
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
> +          maxItems: 2
> +        reg-names:
> +          minItems: 2
> +          maxItems: 2

As we've already defined the max, you can drop maxItems on these 2.

With those 2 changes,

Reviewed-by: Rob Herring <robh@kernel.org>
