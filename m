Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1735C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC0A4206E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595526958;
	bh=ZwmCZOhfoRz/Wk59lgUpr4g7k95ln6Iwgzxqq3gc1VM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZnhYXKr/mmVAhmPvn6tWvA52VQ0m0McCcK77P6+Gh/gkLDX9TdDNuKPrPNTWHLT5E
	 YWHyjab3nGGw1TgQETPIPWDNBJDbt5EaOalnqaS48Bnp6SjjR6eLGcL6YmVHR9vqUh
	 Tq00RAxDbsJQP8z1AocbQ+kgcYEjIES9azRH/bk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbgGWRz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:55:57 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38857 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgGWRz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:55:57 -0400
Received: by mail-io1-f67.google.com with SMTP id l1so7150102ioh.5;
        Thu, 23 Jul 2020 10:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LatV4wJPmhuuRpuPDp60yB6PtdwChfxffIyNVC6yNyY=;
        b=kHO8hDqOsjyAgMIdQVkgNujSSOsvkGXZxVYF/ro+7yhLtoRV71sJyD8JWogBpfE7KA
         lfyMWOUU+wnHIbJKDrSXk9FXhc4dD30Vi1TPI45KsdLeKaRNMZ2koWDkBhDwe9Ijk/jY
         0JupCVQdAKAkjJHJlxv3bYxlbnn56av124ko3e5KHSj/KcHAxa6Jqzjt442XiVrPi9G8
         vgWyUVo5PSV6ek7bJnJfD5CgaHHY/4Vw/oczVRcGMkdxvWnYizid4/YvYEnUgUAuSvHM
         ARK0VwQYFUEK0YvtW29jIKLKsKNOu6ugiGdtjyLSjBwGi6PzkMdX4eFNbzwCIyMpbF07
         K9lw==
X-Gm-Message-State: AOAM532PiKdgXj/9jljyHKTV19FDNS6KCEdisDCNZPNvCk8klh5jVKY7
        QlNZHSJ9olYhXCbaLY2yBP1PvW3hLw==
X-Google-Smtp-Source: ABdhPJzoegcIx2PlRuNOI+Swz4uL/vkn4PDWRH4qdvpj9862Fiag84/oo5is7BB48jcKw7CWngO05w==
X-Received: by 2002:a02:7419:: with SMTP id o25mr6144155jac.4.1595526955876;
        Thu, 23 Jul 2020 10:55:55 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id x5sm1808340iol.36.2020.07.23.10.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:55:55 -0700 (PDT)
Received: (nullmailer pid 607657 invoked by uid 1000);
        Thu, 23 Jul 2020 17:55:52 -0000
Date:   Thu, 23 Jul 2020 11:55:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sumit Semwal <sumit.semwal@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: Add bindings for
 Tianma nt36672a panel
Message-ID: <20200723175552.GA602630@bogus>
References: <20200722055816.20768-1-sumit.semwal@linaro.org>
 <20200722055816.20768-2-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722055816.20768-2-sumit.semwal@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 11:28:15AM +0530, Sumit Semwal wrote:
> The nt36672a panel from Tianma is a FHD+ panel with a resolution of 1080x2246
> and 6.18 inches size. It is found in some of the Poco F1 phones.
> 
> Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
> Change-Id: I401dfbfe23ff2d806c956002f45e349cb9688c16

You know better...

> ---
> v2: remove ports node, making port@0 directly under panel@0 node.
> ---
>  .../display/panel/tianma,nt36672a.yaml        | 104 ++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml
> new file mode 100644
> index 000000000000..cb1799fbbd32
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/tianma,nt36672a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Tianma model NT36672A DSI Panel display driver
> +
> +maintainers:
> +  - Sumit Semwal <sumit.semwal@linaro.org>
> +
> +description: |
> +  The nt36672a panel from Tianma is a FHD+ LCD display panel with a resolution
> +  of 1080x2246. It is a video mode DSI panel.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: tianma,nt36672a
> +
> +  reg:
> +    description: DSI virtual channel of the peripheral
> +
> +  reset-gpios:
> +    description: phandle of gpio for reset line - This should be 8mA, gpio
> +      can be configured using mux, pinctrl, pinctrl-names (active high)
> +
> +  vddio-supply:
> +    description: phandle of the regulator that provides the supply voltage
> +      Power IC supply
> +
> +  vddpos-supply:
> +    description: phandle of the positive boost supply regulator
> +
> +  vddneg-supply:
> +    description: phandle of the negative boost supply regulator
> +
> +  pinctrl-names:
> +    description: Pinctrl for panel active and suspend
> +
> +  pinctrl-0:
> +    description: Active pinctrls
> +
> +  pinctrl-1:
> +    description: Suspend pinctrls
> +
> +  port@0:

Just 'port' as there can only be 1 in this case.

You can do just: 'port: true' as panel-common.yaml already has a 
definition.

> +    type: object
> +    description: DSI input port driven by master DSI
> +    properties:
> +      reg:
> +        const: 0
> +
> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +  - reg
> +  - vddi0-supply
> +  - vddpos-supply
> +  - vddneg-supply
> +  - reset-gpios
> +  - pinctrl-names
> +  - pinctrl-0
> +  - pinctrl-1
> +  - port@0
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |+
> +    #include <dt-bindings/gpio/gpio.h>
> +    dsi0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      panel@0 {
> +        compatible = "tianma,nt36672a";
> +        reg = <0>;
> +        vddi0-supply = <&vreg_l14a_1p88>;
> +        vddpos-supply = <&lab>;
> +        vddneg-supply = <&ibb>;
> +
> +        reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
> +
> +        pinctrl-names = "panel_active", "panel_suspend";
> +        pinctrl-0 = <&sde_dsi_active>;
> +        pinctrl-1 = <&sde_dsi_suspend>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        port@0 {
> +          reg = <0>;
> +          tianma_nt36672a_in_0: endpoint {
> +            remote-endpoint = <&dsi0_out>;
> +          };
> +        };
> +      };
> +    };
> +
> +...
> -- 
> 2.27.0
> 

