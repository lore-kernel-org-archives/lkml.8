Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737CEC33CA3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 16:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0E62084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 16:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AW3O8px0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbgAKQdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 11:33:23 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42878 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729957AbgAKQdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 11:33:23 -0500
Received: by mail-pg1-f195.google.com with SMTP id s64so2514417pgb.9;
        Sat, 11 Jan 2020 08:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y64gfz4lhDMIMyq02nK6cJeBFJg+vUSKhZLISNawoVY=;
        b=AW3O8px0Sa/kGv8GexYh1+MKcwnO+kA/LizzHwyEewnjEhBD/Tm8fokuCdRuETOVaM
         11YmiU4B+Waz8asrjiraSpdopHtUSF0CiniVJZT4ZImzUrb1KgjXvEBjAAZqkc6EvAd5
         7KbcBD4wGoivJeG6t9iBbvx+itPb48P5zH5WC3ItxmSN0gkTaRBns8bBDAB32uPnk5Bq
         uhVhi0999UQn1d3jadcOj+4s9PYJt3rTYpOGFjT4wsJCLMq5IfDtYByJQ2Oek0+cT+8S
         z66Ty2jv6jtwHTYCHGrBKlt4Rjp/QwvsTnh/AE6RIGGsBGpiIdB4sA1kFFE4BtoJO6q2
         OqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=y64gfz4lhDMIMyq02nK6cJeBFJg+vUSKhZLISNawoVY=;
        b=Owjng/8t8DFZI0dWJ5cjnYkp3ZecUft0sBXYq53y1dIt3U/k4h7tizE+QEL06ZCBm6
         MBVYyBzN23b7aIaV64HWkopK9kAt5+UJxbGXAxwJ4PHOpAdvRMkAsExTAIiqpduBK1H4
         uxiTf722jDFfRTV0pEqt2kLS+v86Q0bRYOeiatdTuWRmryFtokC4GkUgqOB2IuNH8Rao
         UlqP+r+fwtEQ1KX6xJ+YEI6GcdyUuNug9c+gInfJLhRctw852OzYQlrRpsZty9mBvYkv
         179Ot3tvaV5CiWcJ3XPue5CQY+4ScRwxcb9VB6/fK48YSdqd8qdhLzdx93+/bTg0H5Kl
         I+Jg==
X-Gm-Message-State: APjAAAVr4e+HINBdaTW79m/l+eiJHFdPBXVjpVEK8W5BZQ15cn5gdnnX
        fVJ4KAOQDL7BC3Am4DReXJ0=
X-Google-Smtp-Source: APXvYqzrmRwXhqzrveRMHB5wXNzXm0isjXDV271j07KSm7nQp5kCj8yuOiApQLcVJyU8LmQV4rCQ/w==
X-Received: by 2002:a63:d14:: with SMTP id c20mr11579296pgl.77.1578760401866;
        Sat, 11 Jan 2020 08:33:21 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z4sm6881221pjn.29.2020.01.11.08.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Jan 2020 08:33:21 -0800 (PST)
Date:   Sat, 11 Jan 2020 08:33:20 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     linux-hwmon@vger.kernel.org, Michael.Hennerich@analog.com,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, biabeniamin@outlook.com
Subject: Re: [PATCH v3 2/3] dt-binding: hwmon: Add documentation for ADM1177
Message-ID: <20200111163320.GA5905@roeck-us.net>
References: <20200107105929.18938-1-beniamin.bia@analog.com>
 <20200107105929.18938-2-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107105929.18938-2-beniamin.bia@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 12:59:28PM +0200, Beniamin Bia wrote:
> Documentation for ADM1177 was added.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> Changes in v3:
> -nothing changed
> 
>  .../bindings/hwmon/adi,adm1177.yaml           | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
> new file mode 100644
> index 000000000000..65ef95328bc6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/adi,adm1177.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADM1177 Hot Swap Controller and Digital Power Monitor
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +  - Beniamin Bia <beniamin.bia@analog.com>
> +
> +description: |
> +  Analog Devices ADM1177 Hot Swap Controller and Digital Power Monitor
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1177.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adm1177
> +
> +  reg:
> +    maxItems: 1
> +
> +  avcc-supply:
> +    description:
> +      Phandle to the Avcc power supply
> +
> +  shunt-resistor-micro-ohms:
> +    description:
> +      The value of curent sense resistor in microohms. If not provided,
> +      the current reading and overcurrent alert is disabled.
> +
> +  adi,shutdown-threshold-microamp:
> +    description:
> +      Specifies the current level at which an over current alert occurs.
> +      If not provided, the overcurrent alert is configured to max ADC range
> +      based on shunt-resistor-micro-ohms.
> +
> +  adi,vrange-high-enable:
> +    description:
> +      Specifies which internal voltage divider to be used. A 1 selects
> +      a 7:2 voltage divider while a 0 selects a 14:1 voltage divider.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pwmon@5a {
> +                compatible = "adi,adm1177";
> +                reg = <0x5a>;
> +		shunt-resistor-micro-ohms = <50000>; /* 50 mOhm */
> +                adi,shutdown-threshold-microamp = <1059000>; /* 1.059 A */
> +                adi,vrange-high-enable;
> +        };
> +    };
> +...
