Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804DFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6448020B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuQnTAjr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgFPRRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgFPRRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 13:17:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7470BC061573;
        Tue, 16 Jun 2020 10:17:22 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f185so3895193wmf.3;
        Tue, 16 Jun 2020 10:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=uDJlG7NKbhHOEOP5+/MCZt7k2gTlyC3ZozgLnPD/qnc=;
        b=EuQnTAjrq5O7qeykI+K0h0HEN7NUH/LXy+fISYb9khZRB8jsV3x3Idy0D2cQJ+ZcNr
         1RGVloN8+2ThekbeGH64onDz0dYEOEU0ZQAzEKyXNnLqfxyDqd8KYozE77RBpmr9WH+U
         quyXnz18sAerteHR17dhi99/dVPDvdHcPwZrnSsKD/zBddo3HMhVvak3GarHNWGjgJ5o
         xWVg3lTz4FC329TOHZH8GWdZ5ZVHUj/gZindrS7KXCKkyvAEB7CaCf/WZdjN4997azWI
         x5hZ5aoADKaEElv7t6mJVX/TUjloW/nngg8mGq0H0tQJdXD477WbGm6eAPa/9nk9FRX0
         9J5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uDJlG7NKbhHOEOP5+/MCZt7k2gTlyC3ZozgLnPD/qnc=;
        b=Kf9Sg+f7zD0x5dTh/LopHtP6kkrUameN/F5mx7MNpJ6oAxRVZEAVO1YiRIR3ZJTzmW
         1t9XRD+ShWxZwnlHtc2YUbyVQPon9XPE4gJJf1ko1bDiuLXEhlSSkVPWAxHKnh34PZ39
         Chx3Kyl6EVCjcpcLteNvxcMRZ/Xt+xSRJsUSY3AUXpM0zuoFLQrdS01tB/AsZh7gNdBf
         10DPIQ8vwVIOxT60Z8mSx6LYPMCibvJUHrBPk6Q15NO/UlMTtsRydV145bkIgZaC7N9b
         mcT9ieWiqS1BcVuvsbacwK9rLTvKne3e0NCNHMW7B1ZGXGzUD1y9+nydsepqsAXxufYc
         LJ8Q==
X-Gm-Message-State: AOAM531fL+/Qh+WYmQBE9pi0vwPuNLSZjro6lKpK5azRytmZRPD+hpY8
        AWHCJsF7XtiXpLXFrZM/r3o=
X-Google-Smtp-Source: ABdhPJy8FA6T3ZhcYYWeGoz+2DkBFY/4UXWRhNEr30Ak0PPqV376AI+aFXq7lr9dvCWQbWgSeRmUpQ==
X-Received: by 2002:a1c:9cd3:: with SMTP id f202mr4046648wme.64.1592327841094;
        Tue, 16 Jun 2020 10:17:21 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id y80sm5293964wmc.34.2020.06.16.10.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 10:17:19 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: phy: add bcm63xx-usbh bindings
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        simon@fire.lp0.eu, jonas.gorski@gmail.com, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        krzk@kernel.org, gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200616083408.3426435-1-noltari@gmail.com>
 <20200616083408.3426435-2-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <2cc00ff1-f411-1c2d-d2ce-4cc0bfc2ccb5@gmail.com>
Date:   Tue, 16 Jun 2020 10:17:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616083408.3426435-2-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/2020 1:34 AM, Álvaro Fernández Rojas wrote:
> Document BCM63xx USBH PHY bindings.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  .../bindings/phy/brcm,bcm63xx-usbh-phy.yaml   | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
> new file mode 100644
> index 000000000000..3e7c97799b91
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/brcm,bcm63xx-usbh-phy.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: BCM63xx USBH PHY
> +
> +maintainers:
> +  - Álvaro Fernández Rojas <noltari@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,bcm6318-usbh-phy
> +      - brcm,bcm6328-usbh-phy
> +      - brcm,bcm6358-usbh-phy
> +      - brcm,bcm6362-usbh-phy
> +      - brcm,bcm6368-usbh-phy
> +      - brcm,bcm63268-usbh-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: usbh
> +      - const: usb_ref
> +
> +  resets:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 0

On 6328, the same register space allows the controlling of the USB PHY
in either host or device mode, so I believe you would need to add a
#phy-cells = 1 in order to distinguish the consumer (host versus device)
if we get to the point where drivers/usb/gadget/udc/bcm63xx_udc.c
becomes DT aware.

Other than that, this looks good to me!
-- 
Florian
