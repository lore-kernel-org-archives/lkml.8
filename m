Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFBBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E3B22CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QePSCcK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgGTH5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgGTH5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:57:01 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA51EC0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 00:57:00 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f18so16856231wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 00:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XKQtYvYGtM0N/Ct4CJlyU+ij1I7Ll/jDSuKe/r+tpV8=;
        b=QePSCcK44UIZmJ+7DxfyU1stV2IDfXAudhLIu4v/IMxSh8Vo2pcJb27KTvxXFjLFM+
         LP8YkYzbjZCsk/yVjQmLbGiUNJlrC+f5jBGzNKpOcuuVqIO/0ByNOIBahGxYYJACP2S3
         YnVWBTQCVl4dIsL5SGS9oj+oida3cWbwMSWqgU9xEeWzzNRKWLxhQo8k1vngaN8p8Ai+
         1qy3Rsc9bLjsIo4w14Ok0AXZZOc1A/mf+OFmTDYpjhvPP24VV0cMrhFHYssj1HWuQDY+
         x2Q+4NL4p4WOe4sLAIhsnWrJwh397PCWL/9S69t6WBIJIQb6N9ZBW7XYcBznB/t8mVHQ
         Cwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XKQtYvYGtM0N/Ct4CJlyU+ij1I7Ll/jDSuKe/r+tpV8=;
        b=Ab3H9PBFUZAS2UO7z9TpdJoSRX30uFiNWGD/1UI9VhjzT14K9Ffn20K825MjxvoP6J
         j4PL/tyyq1Ia9mErBJk20N+1qoZi2i0q+ivASGiAn/C+4dS/90NyoGFps72l8xMliOvK
         Ubf936hzwfJQ0FGs5xNSwmDbJrXbFvtGotYAzg5/b3H6x35eG8WQ+6mPeRy13FqWn9ok
         K0ODXQn60HcBbFZ+IJ39QOnuiH374YRkdqqdQ7n/MkMolslqjLSsNzxoX3Zh2sWleGWH
         jVEWjAsg3Jgx0/zBm1lllxdDdoIrjJIc4GZTHcT2mvSO5qcxQxWmWDjHg9EN1kV/Cx31
         P7GQ==
X-Gm-Message-State: AOAM533ayXhU7XOid7IddPIY3/HwHXyDoiBw61lPn3V8P5MMsUP+p6Q/
        32QBCek5k3m4cdf/yCq7JAzXxndgBkg=
X-Google-Smtp-Source: ABdhPJzE09wAmkmLbE0ZLSzAWTmKyq12TseLHzepWKU2Mh0MBwqpfoiX9ZxPvEJ9HRW9CPX/lIlSjA==
X-Received: by 2002:a5d:61c8:: with SMTP id q8mr11044972wrv.160.1595231819481;
        Mon, 20 Jul 2020 00:56:59 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:3590:b402:869a:11fc? ([2a01:e34:ed2f:f020:3590:b402:869a:11fc])
        by smtp.googlemail.com with ESMTPSA id h11sm7223446wrb.68.2020.07.20.00.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 00:56:58 -0700 (PDT)
Subject: Re: [PATCH v8 1/2] dt-bindings: timer: Add Ingenic X1000 OST
 bindings.
To:     =?UTF-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        tglx@linutronix.de, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, paul@crapouillou.net
References: <20200719114247.56100-1-zhouyanjie@wanyeetech.com>
 <20200719114247.56100-2-zhouyanjie@wanyeetech.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <53448115-2aa0-0aa0-03d8-a5993e8c84e9@linaro.org>
Date:   Mon, 20 Jul 2020 09:56:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200719114247.56100-2-zhouyanjie@wanyeetech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2020 13:42, 周琰杰 (Zhou Yanjie) wrote:
> Add the OST bindings for the X10000 SoC from Ingenic.


Description: [v8,1/2] dt-bindings: timer: Add Ingenic X1000 OST bindings.
Applying: dt-bindings: timer: Add Ingenic X1000 OST bindings.
.git/rebase-apply/patch:91: space before tab in indent.
    		compatible = "ingenic,x1000-ost";
.git/rebase-apply/patch:92: space before tab in indent.
    		reg = <0x12000000 0x3c>;
.git/rebase-apply/patch:94: space before tab in indent.
    		#clock-cells = <1>;
.git/rebase-apply/patch:96: space before tab in indent.
    		clocks = <&cgu X1000_CLK_OST>;
.git/rebase-apply/patch:97: space before tab in indent.
    		clock-names = "ost";
warning: squelched 3 whitespace errors
warning: 8 lines add whitespace errors.


> Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> 
> Notes:
>     v1->v2:
>     No change.
>     
>     v2->v3:
>     Fix wrong parameters in "clocks".
>     
>     v3->v4:
>     1.Rename "ingenic,ost.yaml" to "ingenic,sysost.yaml".
>     2.Rename "ingenic,ost.h" to "ingenic,sysost.h".
>     3.Modify the description in "ingenic,sysost.yaml".
>     
>     v4->v5:
>     No change.
>     
>     v5->v6:
>     1.Drop "oneOf" and the blank line.
>     2.Add "additionalProperties: false".
>     
>     v6->v7:
>     No change.
>     
>     v7->v8:
>     No change.
> 
>  .../devicetree/bindings/timer/ingenic,sysost.yaml  | 63 ++++++++++++++++++++++
>  include/dt-bindings/clock/ingenic,sysost.h         | 12 +++++
>  2 files changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
>  create mode 100644 include/dt-bindings/clock/ingenic,sysost.h
> 
> diff --git a/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
> new file mode 100644
> index 000000000000..1dae2e538725
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/ingenic,sysost.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bindings for SYSOST in Ingenic XBurst family SoCs
> +
> +maintainers:
> +  - 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> +
> +description:
> +  The SYSOST in an Ingenic SoC provides one 64bit timer for clocksource
> +  and one or more 32bit timers for clockevent.
> +
> +properties:
> +  "#size-cells":
> +    const: 1
> +
> +  compatible:
> +    enum:
> +      - ingenic,x1000-ost
> +      - ingenic,x2000-ost
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: ost
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - "#clock-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/x1000-cgu.h>
> +
> +    ost: timer@12000000 {
> +    		compatible = "ingenic,x1000-ost";
> +    		reg = <0x12000000 0x3c>;
> +
> +    		#clock-cells = <1>;
> +
> +    		clocks = <&cgu X1000_CLK_OST>;
> +    		clock-names = "ost";
> +
> +    		interrupt-parent = <&cpuintc>;
> +    		interrupts = <3>;
> +    	};
> +...
> diff --git a/include/dt-bindings/clock/ingenic,sysost.h b/include/dt-bindings/clock/ingenic,sysost.h
> new file mode 100644
> index 000000000000..9ac88e90babf
> --- /dev/null
> +++ b/include/dt-bindings/clock/ingenic,sysost.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This header provides clock numbers for the ingenic,tcu DT binding.
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_INGENIC_OST_H__
> +#define __DT_BINDINGS_CLOCK_INGENIC_OST_H__
> +
> +#define OST_CLK_PERCPU_TIMER	0
> +#define OST_CLK_GLOBAL_TIMER	1
> +
> +#endif /* __DT_BINDINGS_CLOCK_INGENIC_OST_H__ */
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
