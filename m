Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64E9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C947B205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594652903;
	bh=tSCwMG3kKKN5MJkIhI/pVKqBUCQiU5I8TxD3u4pXauw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d24jPSMKdQoc6Qd6Bqa83heH0MC9qgsdc2k+1fiFZzpjuT7kPEtolpajXdTBAC1Jk
	 tnju4ogbvE0/p9IkXIE+fNjqVL36fw9Mbj43uDlveDWHF+Rpc0p/8c5+90LMcWdFcN
	 Lm4ScRWauezDKlVJO/Dt83nMCenxepZ96KGj0FxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgGMPIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:08:22 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:45597 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgGMPIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:08:21 -0400
Received: by mail-il1-f194.google.com with SMTP id o3so11415593ilo.12;
        Mon, 13 Jul 2020 08:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v4cXggTd/OPPGdKO38hIkkIvGUA2vA7so39nPLvitDw=;
        b=K6jL4bdAhMP+NGxs3Iqf/kCjq71C4OhDmDJ0QC7Zi00pAqIQ8Xdoxtcubx3fBpAtLO
         e073YRr/VK0/BoIKaiBVDbT8RQTfezw8lfjmiNLcRF6T59VqbvdqN5UXydn+DoMHFj64
         IMrIUKRm3nKLfCMTJYRFGM8vhyNRHpxd1L2fhPMNwU6Trghu4odaPK0YAE5tP3sH/Q60
         eVDzsRZdmqJPbTyTcFH5eTuyUeq1o975AmQLsD9R3f6+ROj7WzrhHksZqIkMBPqv7Tj1
         fDnpruJdWNiQGOo0XH3g100OcGzaGFV7jsm4dT1E9unZ3EBYCj4HiYiljiD8HhR6onKS
         cd4A==
X-Gm-Message-State: AOAM530yv0LPxpTSP4ow/H8lJZfGyLMCH+qv1ro2XOGE/rsDJEYYPWhQ
        D3jmKWvV2d1/FBDszeLNqQ==
X-Google-Smtp-Source: ABdhPJwPQ8bhYRoCPDiPVwwo9RBAq8+lRRZzacUL0wjjOUAg8glIn4/s22/EEIfQTI4XfYdqhSP8KQ==
X-Received: by 2002:a92:bb84:: with SMTP id x4mr99368ilk.177.1594652900880;
        Mon, 13 Jul 2020 08:08:20 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id e21sm7889088ioe.11.2020.07.13.08.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 08:08:20 -0700 (PDT)
Received: (nullmailer pid 186365 invoked by uid 1000);
        Mon, 13 Jul 2020 15:08:18 -0000
Date:   Mon, 13 Jul 2020 09:08:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, andriy.shevchenko@intel.com,
        balbi@kernel.org, cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        yin1.li@intel.com
Subject: Re: [PATCH v5 1/2] dt-bindings: phy: Add USB PHY support for Intel
 LGM SoC
Message-ID: <20200713150818.GB184301@bogus>
References: <20200713085453.7353-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200713085453.7353-2-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713085453.7353-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 04:54:52PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add the dt-schema to support USB PHY on Intel LGM SoC
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/phy/intel,lgm-usb-phy.yaml | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml
> new file mode 100644
> index 000000000000..0fc76cd23774
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/intel,lgm-usb-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel LGM USB PHY Device Tree Bindings
> +
> +maintainers:
> +  - Vadivel Murugan Ramuthevar <vadivel.muruganx.ramuthevar@linux.intel.com>
> +
> +properties:
> +  compatible:
> +    const: intel,lgm-usb-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    items:
> +      - description: USB PHY and Host controller reset
> +      - description: APB BUS reset
> +      - description: General Hardware reset
> +
> +  reset-names:
> +    items:
> +      - const: phy
> +      - const: apb
> +      - const: phy31
> +
> +required:
> +  - compatible
> +  - clocks
> +  - reg
> +  - resets
> +  - reset-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    usb_phy: usb_phy@e7e00000 {

usb-phy@...

> +        compatible = "intel,lgm-usb-phy";
> +        reg = <0xe7e00000 0x10000>;
> +        clocks = <&cgu0 153>;
> +        resets = <&rcu 0x70 0x24>,
> +                 <&rcu 0x70 0x26>,
> +                 <&rcu 0x70 0x28>;
> +        reset-names = "phy", "apb", "phy31";
> +    };
> -- 
> 2.11.0
> 
