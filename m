Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07499C2D0F1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA54B20774
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585609127;
	bh=CYB6zWgrdUFAb8s1pn+wLWaCoZxIaBSbJyLO3eyUG+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sSMFv1xmqmQbYJVLHdRxTJHDwSJNmRXtZpdoDFeI6NN0I4HH+JfKhm3owcfrwo56D
	 0+t2LOdG6lPru75anRIA7QhRz5vefNHabO20BXTLkZiw9rx5Wkafoqc70NmIVo75fx
	 cRi4GZOAKW1VD5vt7li0PdhMDeuYmT89kjr93iTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgC3W6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:58:46 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41065 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgC3W6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 18:58:46 -0400
Received: by mail-io1-f67.google.com with SMTP id b12so3490190ion.8;
        Mon, 30 Mar 2020 15:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=92i4loZNXHhYEU8hXrppE8fgGprdtopi0kvgw/iL638=;
        b=o4weAw/Mpt4Lo1xrYX7fNlkLWEo91FQop+wE33eUVDLSOfbArPIB2MUpKTUWVw2rMy
         90oHURhwXND6fwAleAoJTNFmpM4lJNkB6YH/+tG3YzoiEcRfRm82yIgAGfsg+QGvKGcV
         NaaJ47OmpzIDvapFTR373bgu0mN653efArwk5Veab983ayqD7HOO4tNhiP6pYTEBcVKY
         S77yhgOutkCyEGDT7mktWXUDLc5tYTWnWudO+FvOCsxASckRuN1kjkS/ukeVif/5Ayc1
         WzOlXE5bKTvPV3wGx/Wyh2xhaMW0VkWcSP8aWSkqubFK2x2f6ET6UNKiWJnLUKpXOWz7
         w/Mw==
X-Gm-Message-State: ANhLgQ3dOJaCK9dTu2aJcOiRNedwkSMl2wzzWJ1rfUOQ2DMKgZMVvYvs
        s+M556vHkEsK9iT4Js7IbQ==
X-Google-Smtp-Source: ADFU+vsh9Zr/TkKt+mVFjHBeV5shLVBhbEiElGMFmZMuWENWDbpznSuwoFmMEmCkNWxrb61k5Wh9qw==
X-Received: by 2002:a02:a1c2:: with SMTP id o2mr12802030jah.98.1585609125595;
        Mon, 30 Mar 2020 15:58:45 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z2sm5283211ilp.21.2020.03.30.15.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 15:58:45 -0700 (PDT)
Received: (nullmailer pid 18009 invoked by uid 1000);
        Mon, 30 Mar 2020 22:58:42 -0000
Date:   Mon, 30 Mar 2020 16:58:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Andrzej Hajda <a.hajda@samsung.com>, icenowy@aosc.io,
        anarsoul@gmail.com, Neil Armstrong <narmstrong@baylibre.com>,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        megous@megous.com, Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: Add binding for the Analogix ANX7688
 chip
Message-ID: <20200330225842.GA20868@bogus>
References: <20200318070730.4012371-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318070730.4012371-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 08:07:27AM +0100, Enric Balletbo i Serra wrote:
> The ANX7688 chip is a Type-C Port Controller, HDMI to DP converter and
> USB-C mux between USB 3.0 lanes and the DP output.
> 
> For our use case a big part of the chip, like power supplies, control
> gpios and the usb-c part is managed by an Embedded Controller, hence,
> this is its simplest form of the binding. We'd prefer introduce these
> properties for someone with a different use case so they can test
> on their hardware.

I'm not sure this is a move in the right direction from the prior 
version. Just because you have multiple functions that doesn't mean 
the DT has multiple child nodes. What's a 'function' exactly may vary 
by OS (or in time). Are the USB-C functions separate h/w? Are there 
separate resources for each sub-function that need to be defined in DT?

We do need to be able to construct a graph with this device, HDMI 
output, USB host, and USB connector. That may dictate what does or 
doesn't work here.

> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v4: None
> Changes in v3:
> - Add binding for ANX7688 multi-function device.
> 
> Changes in v2: None
> 
>  .../bindings/mfd/analogix,anx7688.yaml        | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/analogix,anx7688.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/analogix,anx7688.yaml b/Documentation/devicetree/bindings/mfd/analogix,anx7688.yaml
> new file mode 100644
> index 000000000000..bb95a4e87188
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/analogix,anx7688.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/analogix,anx7688.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analogix ANX7688 HDMI to USB Type-C Bridge (Port Controller with MUX)
> +
> +maintainers:
> +  - Nicolas Boichat <drinkcat@chromium.org>
> +  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
> +
> +description: |
> +  ANX7688 converts HDMI 2.0 to DisplayPort 1.3 Ultra-HDi (4096x2160p60)
> +  including an intelligent crosspoint switch to support USB Type-C (USB-C).
> +  The integrated crosspoint switch supports USB 3.1 data transfer along with
> +  the DisplayPort Alternate Mode signaling over USB Type-C. Additionally,
> +  an on-chip microcontroller (OCM) is available to manage the signal switching,
> +  Channel Configuration (CC) detection, USB Power Delivery (USB-PD), Vendor
> +  Defined Message (VDM) protocol support and other functions as defined in the
> +  USB TypeC and USB Power Delivery specifications.
> +
> +  As a result, a multi-function device is exposed as parent of the video
> +  bridge, TCPC and MUX blocks.
> +
> +properties:
> +  compatible:
> +    const: analogix,anx7688
> +
> +  reg:
> +    maxItems: 1
> +    description: I2C address of the device
> +
> +required:
> +  - compatible
> +  - reg

If this does stay like this, then you need to define the child node(s) 
here and reference their bindings.

> +
> +examples:
> +  - |
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        anx7688: anx7688@2c {
> +            compatible = "analogix,anx7688";
> +            reg = <0x2c>;
> +        };
> +    };
> -- 
> 2.25.1
> 
