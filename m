Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BCAC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A521A2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589462682;
	bh=C7NAO11aE0r2LgHOJkaFdjJFZKOV8MUBP8uh8MfpQyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VYo3O1eU8zJ8jW8+LKZBgRry7UhFXULkbhZxTSm2eTqaHUvZ1fBcWcgn8K3MkC9tF
	 ZPM6rZS6CmpQIXGaSOe7S/B+tqfNIybC6a1n0IV+t21HuByd6xhZUcKk4nyOgrSfB2
	 kan+Civbau0XlMSiLdO3cEIaqwWnbwSs3eUzjxsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgENNYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 09:24:42 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36143 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgENNYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:24:41 -0400
Received: by mail-oi1-f195.google.com with SMTP id x7so23585945oic.3;
        Thu, 14 May 2020 06:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mV1gDXAu3PHj2qz8NxRMN80UJwMB7imwalApGyVK3E0=;
        b=rDlcZMRT8ZFy0X7uHFdkSZKCNdaDLNy4xKlFadQg8bTr9KP1Y/pRZppJJFHf3UZHB+
         EefEkFnSRzjkCjP0zJheirTviEGXaOhqNho41j3Dh1xKGW+sYY26D+2hpjt8Z49ghSuy
         Q79AeKDseVuWDnyy0y8xuqvAiPwFSmqnB4jyRpuM8aIB6180vF9BCxESJv2sXxE2x4l4
         3SlviqGS7yYxKEqoCkX0EJd7JuwIzq8MZQwjBg6xTSce06n3UXN38DLXahBKUpO5hLMn
         zf7iybh3381wdNvPflCKLUtc8e8SMEBqhPFhvxIfGzh1buRNxt3AqaZJHArhW7B5pmgv
         pvPg==
X-Gm-Message-State: AOAM533bHrwdkXsOuS+EzAlgXw4YuYIYe5DG+Q0Su5qaPDEShdOtWHQF
        qnhzETBG41zaxdvPve+Jmw==
X-Google-Smtp-Source: ABdhPJzvIYVfE92YPp93du6vUI1pwaY/vFWHWgAMhu5qICOSPCQPcgESncNedDAP0dRa0QJKVz0y2A==
X-Received: by 2002:aca:cdc6:: with SMTP id d189mr809229oig.19.1589462680705;
        Thu, 14 May 2020 06:24:40 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l196sm1634201oih.25.2020.05.14.06.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 06:24:39 -0700 (PDT)
Received: (nullmailer pid 14823 invoked by uid 1000);
        Thu, 14 May 2020 13:24:39 -0000
Date:   Thu, 14 May 2020 08:24:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     TY Chang <tychang@realtek.com>
Cc:     linux-realtek-soc@lists.infradead.org, afaerber@suse.de,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] dt-bindings: pinctrl: realtek: Add Realtek DHC SoC
 rtd1195 and rtd1295.
Message-ID: <20200514132439.GB23147@bogus>
References: <20200514092125.6875-1-tychang@realtek.com>
 <20200514092125.6875-5-tychang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514092125.6875-5-tychang@realtek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 05:21:22PM +0800, TY Chang wrote:
> Add compatible string for RTD1195 and RTD1295.
> 
> Signed-off-by: TY Chang <tychang@realtek.com>
> ---
>  .../bindings/pinctrl/realtek,rtd-pinctrl.yaml | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/realtek,rtd-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/realtek,rtd-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/realtek,rtd-pinctrl.yaml
> new file mode 100644
> index 000000000000..5af5fc8fe633
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/realtek,rtd-pinctrl.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/realtek,rtd-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Realtek DHC pin control
> +
> +maintainers:
> +  - Andreas Farber <afaerber@suse.de>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - realtek,rtd1195-iso-pinctrl
> +      - realtek,rtd1195-crt-pinctrl
> +      - realtek,rtd1295-iso-pinctrl
> +      - realtek,rtd1295-sb2-pinctrl
> +      - realtek,rtd1295-disp-pinctrl
> +      - realtek,rtd1295-cr-pinctrl
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    iso_pinctrl: pinctrl@300 {
> +        compatible = "realtek,rtd1195-iso-pinctrl";
> +        reg = <0x300 0x14>;

Aren't there child nodes with pin settings? They need to be documented.

> +    }
> +  - |
> +    crt_pinctrl: pinctrl@300 {
> +        compatible = "realtek,rtd1195-crt-pinctrl";
> +        reg = <0x300 0x78>;
> +    }
> +  - |
> +    iso_pinctrl: pinctrl@300 {
> +        compatible = "realtek,rtd1295-iso-pinctrl";
> +        reg = <0x300 0x24>;
> +    }
> +  - |
> +    sb2_pinctrl: pinctrl@900 {
> +        compatible = "realtek,rtd1295-sb2-pinctrl";
> +        reg = <0x900 0x100>;
> +    }
> +  - |
> +    disp_pinctrl: pinctrl@4d000 {
> +        compatible = "realtek,rtd1295-disp-pinctrl";
> +        reg = <0x4d000 0x100>;
> +    };
> +  - |
> +    cr_pinctrl: pinctrl@12600 {
> +        compatible = "realtek,rtd1295-cr-pinctrl";
> +        reg = <0x12600 0x100>;
> +    };
> +
> -- 
> 2.26.2
> 
