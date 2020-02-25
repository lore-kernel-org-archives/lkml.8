Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AFCC35E0C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B9820CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582654618;
	bh=WMnTiSLcGKnpluzNKx++szmvD4S9JUV7fzgGr7J8B7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GaXJE1EFOKvnYEnYve8R/ig8MGtfRfaNlLPKZfd1HYSg7K/lz721vkblo6dvtew3W
	 ZK0xoMvUXbohLb5YNAldkTcMKGaasfLAC29RnRTbUye4BOUM2sowO79vnPSo0KURQF
	 7MIuNPkUCJX/WMVlq2s+QksC5bR+QvQvCCqe3muY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731411AbgBYSQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:16:57 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40136 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730995AbgBYSQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:16:57 -0500
Received: by mail-oi1-f194.google.com with SMTP id a142so236098oii.7;
        Tue, 25 Feb 2020 10:16:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7UyTeMzaTbOixtQKcOlo1zEfQ//tLMtgH0J7yCWDsaI=;
        b=YFKBgbjPT381uwJhjngnsA2yYIsTFXd5kijxBupBIeEUKnJf7TI1M/FhpVABMeJ1pR
         WDO2kSXuneSEL3AXaQSobykz6gBIyoKyMRf3lPW+Rz35o4IHREOJc17d3BRUHTdHQUoY
         OJvCyDZ4u23m6hSWq5gKU0PB6JC1RMaCFDGLc1+HKs4CSQ70txwszbbtRPwfhOA3oE6U
         bNaocxuWr7f2uC4ZzRhzQnfbTuXIbaywgNrxZVHf+6ZnOPeSUG+8Rr4U8i4BqW8rfelS
         Zsvmnht31kYiPQ7hVas7umbBWT4bbpHsedvnLVDBtYxyRCCU8NwEOACm6F4YtYRd5EM4
         O8LA==
X-Gm-Message-State: APjAAAWz+x0Hwdi2J+UUk26AjQC4+kUnDInjbZ7+c5uSgsxLfnxUgNUH
        ECFI4kN0swixllTaMu9LwzuBxIU=
X-Google-Smtp-Source: APXvYqyG5jtbTR8e+2eatGO7AOO/3BLqG2/NHQ3384FNvtFffmk1sB1TsteHHtEFBpdhQlFHBTXPqA==
X-Received: by 2002:aca:190b:: with SMTP id l11mr175520oii.65.1582654616272;
        Tue, 25 Feb 2020 10:16:56 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c10sm5886903otl.77.2020.02.25.10.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 10:16:55 -0800 (PST)
Received: (nullmailer pid 3615 invoked by uid 1000);
        Tue, 25 Feb 2020 18:16:54 -0000
Date:   Tue, 25 Feb 2020 12:16:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>, devicetree@vger.kernel.org,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/89] dt-bindings: clock: Add a binding for the RPi
 Firmware clocks
Message-ID: <20200225181654.GA694@bogus>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
 <9166f3acdc2a64e3f3ca1cd2e283005ee2df37c9.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9166f3acdc2a64e3f3ca1cd2e283005ee2df37c9.1582533919.git-series.maxime@cerno.tech>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 10:06:08AM +0100, Maxime Ripard wrote:
> The firmare running on the RPi VideoCore can be used to discover and
> change the various clocks running in the BCM2711. Since devices will
> need to use them through the DT, let's add a pretty simple binding.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  Documentation/devicetree/bindings/clock/raspberrypi,firmware-clocks.yaml | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/raspberrypi,firmware-clocks.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/raspberrypi,firmware-clocks.yaml b/Documentation/devicetree/bindings/clock/raspberrypi,firmware-clocks.yaml
> new file mode 100644
> index 000000000000..d37bc311321d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/raspberrypi,firmware-clocks.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/raspberrypi,firmware-clocks.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RaspberryPi Firmware Clocks Device Tree Bindings
> +
> +maintainers:
> +  - Maxime Ripard <mripard@kernel.org>
> +
> +properties:
> +  "#clock-cells":
> +    const: 1
> +
> +  compatible:
> +    const: raspberrypi,firmware-clocks
> +
> +  raspberrypi,firmware:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: >
> +      Phandle to the mailbox node to communicate with the firmware.

Can't this be a child node of the phandle instead? Or just add 
'#clock-cells' to the firmware node.

> +
> +required:
> +  - "#clock-cells"
> +  - compatible
> +  - raspberrypi,firmware
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    firmware_clocks: firmware-clocks {
> +        compatible = "raspberrypi,firmware-clocks";
> +        raspberrypi,firmware = <&firmware>;
> +        #clock-cells = <1>;
> +    };
> +
> +...
> -- 
> git-series 0.9.1
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
