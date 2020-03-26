Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30004C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3A8206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585249903;
	bh=A0kR+4KEbyMMx81BTTzMjv1bC45dn+Cea1MQ66CGmSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fFSD0/3HUy1wAR9xq2erPyTOpZ2HSqz80/itAUvqs7jTa6/FvqldjjQ47zley58j2
	 nEOqChLY2BI7/vedelHseG1LuP5cIawbjSSMlnMOSRbdIhzmGV5mqaLezC1IbH9oMl
	 I7SoaBmS9aKa0Y3FRXh3nGIY41D3JiU8daftxAvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgCZTLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:11:36 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45686 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgCZTKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:10:15 -0400
Received: by mail-io1-f67.google.com with SMTP id a24so6659068iol.12;
        Thu, 26 Mar 2020 12:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mqe+qvLDL0F5QFPzzY/Qw513N/CcmkZu3+KJVjBKe00=;
        b=TKQMGNlcGUmczbnWf3iALBgfQHR9Qt0mozA1qaiWHLIh7Ub7FQldKLdzZP00bbDjPT
         3kEfm5goifhuwEIZz00TxBYZbJ3z5Qk1ajza5sA1kkJq8xr3DK7RvTETGvot+5QOez+9
         OPxmxkNExIoH0Jds4jB8nYG+ywvVtOivi6gTLIO54rBkANPkzqolfz10D6DllXlN5vxo
         J4ECGEz5OdMvZ/ddDJOQ4FTgThJ+UgZOymMnmrz1KfiTHA1X3DG3TdfUMB0IGu8ZMF96
         YLy2azx42h4SPH3xWbuBgPS4UA72hVa8irglo0qcwKSqxDiDcRYVt5gD/TG9dvLE6OSd
         3NCw==
X-Gm-Message-State: ANhLgQ2sWOWL4bY6aktlNnjil1craifeUjGRNIx8rUjGTKAg28kmyVAy
        sVXYkNCNZX9tcIQbCMfmMA==
X-Google-Smtp-Source: ADFU+vvEhHo6vdvVrVDVz6G66I3+pxBn28EjTel9PRtmA3bkLU64mCh8uH8O0U//+UVR8Wkx0lqxpA==
X-Received: by 2002:a02:94cb:: with SMTP id x69mr8851315jah.19.1585249813647;
        Thu, 26 Mar 2020 12:10:13 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c88sm1084825ill.15.2020.03.26.12.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 12:10:13 -0700 (PDT)
Received: (nullmailer pid 26827 invoked by uid 1000);
        Thu, 26 Mar 2020 19:10:12 -0000
Date:   Thu, 26 Mar 2020 13:10:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     allen <allen.chen@ite.com.tw>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 2/3] dt-bindings: Add binding for IT6505.
Message-ID: <20200326191012.GB15606@bogus>
References: <1584941015-20541-1-git-send-email-allen.chen@ite.com.tw>
 <1584941015-20541-3-git-send-email-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584941015-20541-3-git-send-email-allen.chen@ite.com.tw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 01:21:53PM +0800, allen wrote:
> Add a DT binding documentation for IT6505.
> 
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
> cros-ec does not have an associated driver that uses the standard Linux USB-C driver class.
> extcon is used to model the Type-C connector.(crbug.com/982932)

That's nice, but doesn't matter for upstream. And sounds like a driver 
problem, not a binding issue.

> ---
>  .../bindings/display/bridge/ite,it6505.yaml        | 91 ++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> new file mode 100644
> index 00000000..13feeef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/ite,it6505.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ITE it6505 Device Tree Bindings
> +
> +maintainers:
> +  - Allen Chen <allen.chen@ite.com.tw>
> +
> +description: |
> +  The IT6505 is a high-performance DisplayPort 1.1a transmitter,
> +  fully compliant with DisplayPort 1.1a, HDCP 1.3 specifications.
> +  The IT6505 supports color depth of up to 36 bits (12 bits/color)
> +  and ensures robust transmission of high-quality uncompressed video
> +  content, along with uncompressed and compressed digital audio content.
> +
> +  Aside from the various video output formats supported, the IT6505
> +  also encodes and transmits up to 8 channels of I2S digital audio,
> +  with sampling rate up to 192kHz and sample size up to 24 bits.
> +  In addition, an S/PDIF input port takes in compressed audio of up to
> +  192kHz frame rate.
> +
> +  Each IT6505 chip comes preprogrammed with an unique HDCP key,
> +  in compliance with the HDCP 1.3 standard so as to provide secure
> +  transmission of high-definition content. Users of the IT6505 need not
> +  purchase any HDCP keys or ROMs.
> +
> +properties:
> +  compatible:
> +    const: ite,it6505
> +
> +  ovdd-supply:
> +    maxItems: 1
> +    description: I/O voltage
> +
> +  pwr18-supply:
> +    maxItems: 1
> +    description: core voltage
> +
> +  interrupts:
> +    maxItems: 1
> +    description: interrupt specifier of INT pin
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: gpio specifier of RESET pin
> +
> +  extcon:

Think I said this already, but don't use extcon and define an output 
port to a DP or USB connector.

> +    maxItems: 1
> +    description: extcon specifier for the Power Delivery
> +
> +  port:
> +    type: object
> +    description: A port node pointing to DPI host port node
> +
> +required:
> +  - compatible
> +  - ovdd-supply
> +  - pwr18-supply
> +  - interrupts
> +  - reset-gpios
> +  - extcon
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c3 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dp-bridge@5c {
> +            compatible = "ite,it6505";
> +            interrupts = <152 IRQ_TYPE_EDGE_FALLING 152 0>;
> +            reg = <0x5c>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&it6505_pins>;
> +            ovdd-supply = <&mt6358_vsim1_reg>;
> +            pwr18-supply = <&it6505_pp18_reg>;
> +            reset-gpios = <&pio 179 1>;
> +            extcon = <&usbc_extcon>;
> +
> +            port {
> +                it6505_in: endpoint {
> +                    remote-endpoint = <&dpi_out>;
> +                };
> +            };
> +        };
> +    };
> -- 
> 1.9.1
> 
