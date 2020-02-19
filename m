Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47C7C34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8788F24670
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582126224;
	bh=lo61ec0S5b6zGdj13lHlvMM1CymdMd4QZDOHORUp6D0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k6nB2ZHCx/e96LQr+PLGVcyshr2y3FezAWPeirRp68g7EQe14K04wmQplyqwX+17e
	 h8ljZj6orzgsUFs5NQ87/k7G/5kbsk1cjsSpK3hNnSwXxhecSoggzwXKAVsV+zKk4l
	 1kAwQIH3ndvFxZZgu++vDOo1Z/4e1SH+Kuv247EA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgBSPaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:30:23 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35443 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgBSPaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:30:22 -0500
Received: by mail-oi1-f193.google.com with SMTP id b18so24191803oie.2;
        Wed, 19 Feb 2020 07:30:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JzcGItIJYGsl2cZdeJy9RWrhUYytz4QlrMkMbEGYVto=;
        b=HJZkBmk+x89uDojI7ZE6uEKtJEcYgBNMQtGG5818UyMIrthiRB/aqqL3/XKm0TYtMR
         Jb58hVSdNmepb2StvadbXvsP/F3MRqZf+I5hXdWyclVZX/DvvkhG+aPkCGBk3pA1M3Jo
         aGpEgoYE9D5TBAWyj3f85nsemGCIQM3NllPRC7JV1mNGiwbBqYwvM58XD6I/voQWsGcS
         tEuV3x3bTvEgIIAYAp7FgVCl5O+cmW4QsQsdmQs4xW5rgidIlVXkf5GwZ1KDB1gxUKMw
         Unp4jcwKE2awaTJexYW9xiSRlFdvaYv9KCycvJ6GSP6w9aDxS2LMyl+CoWdV9s+NPwD3
         +poA==
X-Gm-Message-State: APjAAAW0C2Z4Xnp+KI0TrNVF3VZFFR5hgSgRH41upQlPbsK0yz2eye+Q
        gnRt1rtj7KW4Yux0gKs5oQ==
X-Google-Smtp-Source: APXvYqzgdNvRS6k2NroirQrsz+VuIisaXtV513aooiJzs49WDEhynFy2ewrvEpl6PVO4/ZyO6EK6kw==
X-Received: by 2002:a05:6808:45:: with SMTP id v5mr4765338oic.90.1582126221379;
        Wed, 19 Feb 2020 07:30:21 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l207sm74554oih.25.2020.02.19.07.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 07:30:20 -0800 (PST)
Received: (nullmailer pid 24733 invoked by uid 1000);
        Wed, 19 Feb 2020 15:30:19 -0000
Date:   Wed, 19 Feb 2020 09:30:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Andrzej Hajda <a.hajda@samsung.com>, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 1/2] Documentation: bindings: Add ANX7688 HDMI to DP
 bridge binding
Message-ID: <20200219153019.GA19271@bogus>
References: <20200213145416.890080-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213145416.890080-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 03:54:15PM +0100, Enric Balletbo i Serra wrote:
> From: Nicolas Boichat <drinkcat@chromium.org>

'dt-bindings: ....' for the subject please.

> 
> Add documentation for DT properties supported by anx7688 HDMI-DP
> converter.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v2:
> - Improve a bit the descriptions using the info from the datasheet.
> - Convert binding to yaml.
> - Use dual licensing.
> 
>  .../bindings/display/bridge/anx7688.yaml      | 79 +++++++++++++++++++

Use the full compatible string: analogix,anx7688.yaml

>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/anx7688.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/anx7688.yaml b/Documentation/devicetree/bindings/display/bridge/anx7688.yaml
> new file mode 100644
> index 000000000000..c1b4b5191d44
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/anx7688.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/anx7688.yaml#

Don't forget to update this too.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analogix ANX7688 HDMI to USB Type-C Bridge (Port Controller with MUX)
> +
> +maintainers:
> +  - Nicolas Boichat <drinkcat@chromium.org>
> +  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
> +
> +description: |
> +  The ANX7688 is a single-chip mobile transmitter to support 4K 60 frames per
> +  second (4096x2160p60) or FHD 120 frames per second (1920x1080p120) video
> +  resolution from a smartphone or tablet with full function USB-C.
> +
> +  This binding only describes the HDMI to DP display bridge.
> +
> +properties:
> +  compatible:
> +    const: analogix,anx7688
> +
> +  reg:
> +    maxItems: 1
> +    description: I2C address of the device

That's every reg, you can drop 'description'.

> +
> +  ports:
> +    type: object
> +
> +    properties:
> +      port@0:
> +        type: object
> +        description: |
> +          Video port for HDMI input
> +
> +      port@1:
> +        type: object
> +        description: |
> +          Video port for DP output
> +
> +    required:
> +      - port@0

IMO, port@1 should be required too. If not a fixed panel, then it should 
have a connector node.

> +
> +required:
> +  - compatible
> +  - reg
> +  - ports
> +
> +examples:
> +  - |
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        anx7688: dp-bridge@2c {
> +            compatible = "analogix,anx7688";
> +            reg = <0x2c>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    anx7866_in: endpoint {
> +                        remote-endpoint = <&hdmi0_out>;
> +                    };
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +                    anx7866_out: endpoint {
> +                        remote-endpoint = <&panel_in>;
> +                   };
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.25.0
> 
