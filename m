Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E80C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0CD420656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSBp4ZhD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgHUSk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgHUSkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:40:25 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A44DC061573;
        Fri, 21 Aug 2020 11:40:25 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u128so1493576pfb.6;
        Fri, 21 Aug 2020 11:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TBcmZiQryJDZNdBrscDVfpwOhyOEvd5bP/Egy4EkLLM=;
        b=OSBp4ZhDrGX2Pwk+71O5VkfU7QibLAPqXDSFB9QAaXpFWkmHtU33PpmMKGI4cKVTMG
         0SSWBRjRSQx9fbLUnxg0LYyqsSjB1CvAYaZx5v41+thu09Mn4YFpAgXs7fJdkJPBmql2
         jABmP+BUrFR3Pi2Ji8/q+suAgsqB1B0G2z/NRmg6g1Qp3uWvSKwNnCfbYxtiiGEVP906
         kbiiId7Sro0qOyXcGRHQ16nYqlSxkOFcr+9as2a2tFPcaX69QIgxsX7mad+t8/4WS/wJ
         mbD7/sSeo1pqqnwulR4Ga1wXLLy+W2QOf9KfEL43mOZ8P+trdTOLUbgHHedvlPfRZvsc
         tECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TBcmZiQryJDZNdBrscDVfpwOhyOEvd5bP/Egy4EkLLM=;
        b=NRnjUR3rhlD+1EeaY9Cld5ZLVFe9UGf0INMy4evBNipZjIaYeBiBCoJBaRmkvXgMkM
         1/HLPydLYD7OsoOLRYhvRSsiqkZU77mbNcDKC6G+Gbfb+TDd9bYU2FOT8I6Jm0qB3Mp4
         snPvIAwWXOXvzkgyp2N+JBZw78VN7n4LbvA50m/t5zjSwJQVF/QESC5DwHttBS/IfuSr
         +Edh2K1vOp1qdk+wBdvx7xzoK0WVIQ/XaQRr2vXYXeL8yj/HciDr26vZLlYe7cSwix9j
         1go3HK5KVwetnu2qV604SoYyRBFUdCqFDmWe2pCc05Reb1bXcHN7mo8rLM9vKKyFeH8+
         sZzA==
X-Gm-Message-State: AOAM532Kc3byE6yDl3nlpWmmzEeM2Ib4oE20wLi0PwJPwbxRKO+CwK9g
        tg0eJ0K8llC3sRpLJvghQHA=
X-Google-Smtp-Source: ABdhPJx/rdzvAh5XF8imCocS6G9J+IfZz7zd1S1CaDBGiNher4ZwZBCOKAA6MOP4TzXEomB2nLipzQ==
X-Received: by 2002:aa7:8f04:: with SMTP id x4mr3647685pfr.199.1598035224701;
        Fri, 21 Aug 2020 11:40:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g23sm3152548pfo.95.2020.08.21.11.40.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Aug 2020 11:40:24 -0700 (PDT)
Date:   Fri, 21 Aug 2020 11:40:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] devicetree: hwmon: shtc1: add sensirion,shtc1.yaml
Message-ID: <20200821184023.GA245767@roeck-us.net>
References: <20200815012227.32538-1-chris.ruehl@gtsys.com.hk>
 <20200815012227.32538-3-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815012227.32538-3-chris.ruehl@gtsys.com.hk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 09:22:27AM +0800, Chris Ruehl wrote:
> Add documentation for the newly added DTS support in the shtc1 driver.
> To align with the drivers logic to have high precision by default
> a boolean sensirion,low-precision is used to switch to low precision.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  .../bindings/hwmon/sensirion,shtc1.yaml       | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> new file mode 100644
> index 000000000000..c523a1beb2b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/sensirion,shtc1.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sensirion SHTC1 Humidity and Temperature Sensor IC
> +
> +maintainers:
> +  - Christopher Ruehl chris.ruehl@gtsys.com.hk
> +
> +description: |
> +  The SHTC1, SHTW1 and SHTC3 are digital humidity and temperature sensor
> +  designed especially for battery-driven high-volume consumer electronics
> +  applications.
> +  For further information refere to Documentation/hwmon/shtc1.rst
> +
> +  This binding document describes the binding for the hardware monitor
> +  portion of the driver.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sensirion,shtc1
> +      - sensirion,shtw1
> +      - sensirion,shtc3
> +
> +  reg:
> +    const: 0x70
> +
> +  sensirion,blocking-io:
> +    $ref: /schemas/types.yaml#definitions/flag
> +    description:
> +      If set, the driver hold the i2c bus until measurement is finished.
> +
> +  sensirion,low-precision:
> +    $ref: /schemas/types.yaml#definitions/flag
> +    description:
> +      If set, the sensor aquire data with low precision (not recommended).
> +      The driver aquire data with high precision by default.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      clock-frequency = <400000>;
> +
> +      shtc3@70 {
> +        compatible = "sensirion,shtc3";
> +        reg = <0x70>;
> +        sensirion,blocking-io;
> +      };
> +    };
> +...
