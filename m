Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50177C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F41C20C09
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590772502;
	bh=3UEdCLS2U2X6sRTkzwKK/m7e1dIvATzh1907ZI7A8es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SUoA6ASzt1/H/Gq8pNQv5Du6bA40Afb/Jexxcm1DEJV9zIYorAPZE4GcXV0gjaIxF
	 FzKdTjThxCkE8QQ1VhqwqpMLhG5gTo/MkigvR1KhNhVRy3cZIVlMUavEvwCRGkOUW0
	 XppSeRfkt/qyQOU5vYKzJeX2qs6QHo0r3v+kU8D8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgE2RPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 13:15:01 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:38019 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgE2RPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 13:15:01 -0400
Received: by mail-il1-f195.google.com with SMTP id q18so3234317ilm.5;
        Fri, 29 May 2020 10:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kNm3vdi6ihnVei8rU4MqO8m2guJKDe0NrdeWkMfAtqc=;
        b=oimmwbYkZQg+uqZaL1MueTM2SrZRttqgC4UfXoJqbKdzN1DdQCaTx7KoUiJ0s7CcZj
         xVAdOkhquU63fY1fJ2MT4kr22nYebfArLHzgpzSYLEeL+WKwnY/dkEWQFf/acIAZE++1
         IG/Fx4rr6+CRhRa74kphP+kzbB3qEWMC9d0i5tmHajJrWCLwnsF1aKUBt1zqFkEu9vCp
         W4FIDIgD621z6RwQhBcHkg9xsNkIqA38obN0/0oknA394oULKZyApKks5IMDaHjO3xj3
         Wi0ScqVswj6XBVYJg6y8CM5RWXBC9+qokoftOhTXBOE3qrn6AqBY+w0SAC3KG+f1Iu6e
         BpCQ==
X-Gm-Message-State: AOAM533nJTXOruFV+rCqLvf2W3qo9dD/u39wyQRqQqXBfMvJBMh/d5Qh
        yBO6T/m+Or98cTqNUDis1A==
X-Google-Smtp-Source: ABdhPJzJCOA11eEXWWu9FCBhBqjrR7k5EiZ78OyhLYkzNV1vNtLk1Nwml/TcoIcJ+mHYelzmkTYUgA==
X-Received: by 2002:a92:5ac2:: with SMTP id b63mr3528622ilg.134.1590772500200;
        Fri, 29 May 2020 10:15:00 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id a17sm4993973ild.31.2020.05.29.10.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 10:14:59 -0700 (PDT)
Received: (nullmailer pid 2590915 invoked by uid 1000);
        Fri, 29 May 2020 17:14:58 -0000
Date:   Fri, 29 May 2020 11:14:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     kishon@ti.com, vkoul@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        adrian.hunter@intel.com
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: intel: Add Keem Bay eMMC PHY
 bindings
Message-ID: <20200529171458.GA2588871@bogus>
References: <20200526050452.8837-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200526050452.8837-2-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526050452.8837-2-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 01:04:51PM +0800, Wan Ahmad Zainie wrote:
> Binding description for Intel Keem Bay eMMC PHY.
> 
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> ---
>  .../bindings/phy/intel,keembay-emmc-phy.yaml  | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
> new file mode 100644
> index 000000000000..d3e0f169eb0a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2020 Intel Corporation
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/intel,keembay-emmc-phy.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Intel Keem Bay eMMC PHY bindings
> +
> +maintainers:
> +  - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> +
> +properties:
> +  compatible:
> +    const: intel,keembay-emmc-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: emmcclk
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    phy@20290000 {
> +          compatible = "intel,keembay-emmc-phy";
> +          reg = <0x0 0x20290000 0x0 0x54>;

Examples expect a single cell for address and size.

> +          clocks = <&emmc>;
> +          clock-names = "emmcclk";
> +          #phy-cells = <0>;
> +    };
> -- 
> 2.17.1
> 
