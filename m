Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6271EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 03:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C3CA20734
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 03:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589512200;
	bh=mGIjQ5UgRZBwSrwRanDpjsWAq7KpK2H1hq9cmp4eX9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DFZLmboW8e9eNysS/omdRb8+S2dZU20mOdTKw3nPru5g8Y2kKhZCZVBFwZodNOKt6
	 1nLiVVBk31VqXGeIAHT8xQ+BRUpVNlhhnjDDkkrSi6qlw7qDnL6PCNxoBHd3JvTVVg
	 3wMVx0F5mzIpiwX0D6wsX/yLlnxRAHTAzVtVSkrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgEODJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 23:09:59 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37562 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgEODJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 23:09:59 -0400
Received: by mail-oi1-f196.google.com with SMTP id r25so1009589oij.4;
        Thu, 14 May 2020 20:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cqCt031WyGhINaoPOgD7e/Ng/z3AcL7LFst4h8g4aQc=;
        b=g9N9PA7n/xgm8dC2CLCXDj5O+006UZ1612/4lSVEoVDHZ8sufdh4snUKSpksekXbfr
         MYaguVZTOP6RfFDREeU5IR3RXD5xBDaz4nCFC2z6DgFxAw8sOGnq1xR8m3dWw6QwiSGN
         sugFDeqcAzLQg7uzP+AalXNfUgBhg8v501sk6e/nsXzq7mQreTCrnfj5m8LlkNBE/z+S
         SFCVQps+D/i0ylXTZ+DNWSgGj96LIq7SckykYcVB3VRbh+6HB+BwMrjYjx4hagsdSjzH
         910LDoIY6vztWYKljAjtN6Izgzg0WaG4tGH3eTwOFgqj2ztinxc+8VWuymefkntWjLAk
         PD0Q==
X-Gm-Message-State: AOAM532C1M8ga9DzGO4ZfVP+d1Rgmpu53UTDsUWJGOkCm/TdrUq0LLOZ
        9wt2xDTyEBcU9vxw5HBtgIaKhv8=
X-Google-Smtp-Source: ABdhPJxjfaFgbx+BckYEXFaVqvbzIdtHGFBM9fJhxsQAoJcIf8K3VIyKPMTm7k7hpJ6LJf1+1aoqsg==
X-Received: by 2002:a05:6808:698:: with SMTP id k24mr733523oig.102.1589512197867;
        Thu, 14 May 2020 20:09:57 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y22sm293187oih.57.2020.05.14.20.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 20:09:56 -0700 (PDT)
Received: (nullmailer pid 24896 invoked by uid 1000);
        Fri, 15 May 2020 03:09:56 -0000
Date:   Thu, 14 May 2020 22:09:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, nikolaus.voss@loewensteinmedical.de,
        andriy.shevchenko@linux.intel.com, garsilva@embeddedor.com,
        keescook@chromium.org
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Add TI tps6598x device tree
 binding documentation
Message-ID: <20200515030956.GA14495@bogus>
References: <20200507214733.1982696-1-bryan.odonoghue@linaro.org>
 <20200507214733.1982696-2-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507214733.1982696-2-bryan.odonoghue@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 10:47:32PM +0100, Bryan O'Donoghue wrote:
> Add device tree binding documentation for the Texas Instruments tps6598x
> Type-C chip driver.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../devicetree/bindings/usb/ti,tps6598x.yaml  | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> new file mode 100644
> index 000000000000..8eaf4b6c4735
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/usb/ti,tps6598x.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Texas Instruments 6598x Type-C Port Switch and Power Delivery controller DT bindings
> +
> +maintainers:
> +  - Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> +
> +description: |
> +  Texas Instruments 6598x Type-C Port Switch and Power Delivery controller
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tps6598x
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    items:
> +      - const: irq
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        tps6598x: tps6598x@38 {
> +            compatible = "ti,tps6598x";
> +            reg = <0x38>;
> +
> +            interrupt-parent = <&msmgpio>;
> +            interrupts = <107 IRQ_TYPE_LEVEL_LOW>;
> +            interrupt-names = "irq";
> +
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&typec_pins>;
> +
> +            typec_con: connector {
> +                compatible = "usb-c-connector";
> +                label = "USB-C";
> +                port {

The connector binding has specific numbering of the ports defined for 
HS, SS, alt mode.

So you should have 'ports' here.

> +                    typec_ep: endpoint {
> +                        remote-endpoint = <&otg_ep>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> +...
> -- 
> 2.25.1
> 
