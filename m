Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58600C35655
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2948A20722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tOVwwD8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgBUNFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:05:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42386 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgBUNFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:05:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id k11so1975320wrd.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 05:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Jmee0gPaCTfsOpWSoQjCJFto4t8cMGzSFxQTb3xz48k=;
        b=tOVwwD8qmpuy5R/iusBnSTi8xzbbMZqdDcRX1UOwcX8kYv5EzHXV5Ir5H2I6/HY6Hv
         GHf+wxF/Eu/sDmuamXnYsjUsxTYXICaKH1O67ZVlBrWMNCXCIY8FwA5CAIT5tRVzIm5R
         SzzKxvH5U9ZGw02P+TWARGK1gYUEDSeg0Nil+OEPJxqUoNA9ceBM1Xs+S2wAuJCu2a2t
         BcG8GYWfdv51wj9aVj+vQ6z1GkOcoaDsm2wii0rDsEMImic2AUBX6vBFegMWdWgq+3Dv
         Xqma0ebK4QQ3qXwG/wD/JNMq7nmiAXc4fiLJTXOZPl/Fg4IPEXNX+500312IIPGI2tC1
         Ht6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Jmee0gPaCTfsOpWSoQjCJFto4t8cMGzSFxQTb3xz48k=;
        b=BRT6BZn+Vav5h934OWKWjDgECTAHGKTjZA1k6Vw4Zeb8AdzeA+k5BwkT3+40JJ7bXg
         TXJSrIXs8Pje2Avnp1DJISMbQVciLvzBNrR17eka3khbMStxaEaS/wkjxmJMD1FHHu6U
         piLoU6DPowICb+IalymA2e+MC4Pq80pMKdXTIDquCz3I/uYQAqHAaCYuvCTITSyrJ0JZ
         3CP539d8KDWm9yxhSAR7R9Qvk5z5MNZNntOmwfNFiIkThQse8Ri4e+IFp1LBod0r0QeA
         xkhodqVfY5cX4XTCO6VGndECcdF3dqvmwHRgibZgnSmAKYvPp0kr2RhkStHXSra5ucfy
         BpxQ==
X-Gm-Message-State: APjAAAXKaWF7JqUBqx/HOQrLaKwZpDafHUVOiBFP80pFaOoSYlRxHYCf
        PVFsAhNJIc900N7x7vEtqMyKOw==
X-Google-Smtp-Source: APXvYqxdbqMgUjOMna0Vnnx+4FKMnwXT3QMS6vD/TsFNrXqcxXU3SY8DOXJ72CRLWnbQ393hdP3QPw==
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr47209498wrw.373.1582290343755;
        Fri, 21 Feb 2020 05:05:43 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:2dfb:b5ce:9043:4adb])
        by smtp.gmail.com with ESMTPSA id y1sm3422496wrq.16.2020.02.21.05.05.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 05:05:43 -0800 (PST)
Date:   Fri, 21 Feb 2020 14:05:40 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, aisheng.dong@nxp.com,
        linux@roeck-us.net, srinivas.kandagatla@linaro.org,
        krzk@kernel.org, fugang.duan@nxp.com, peng.fan@nxp.com,
        daniel.baluta@nxp.com, bjorn.andersson@linaro.org, olof@lixom.net,
        dinguyen@kernel.org, leonard.crestez@nxp.com,
        marcin.juszkiewicz@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V15 RESEND 5/5] arm64: dts: imx: add i.MX8QXP thermal
 support
Message-ID: <20200221130540.GD10516@linaro.org>
References: <1582161028-2844-1-git-send-email-Anson.Huang@nxp.com>
 <1582161028-2844-5-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1582161028-2844-5-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 09:10:28AM +0800, Anson Huang wrote:
> Add i.MX8QXP CPU thermal zone support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No change.
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 36 ++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index fb5f752..0a14fe4 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/pinctrl/pads-imx8qxp.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  / {
>  	interrupt-parent = <&gic>;
> @@ -189,6 +190,11 @@
>  			compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
>  			timeout-sec = <60>;
>  		};
> +
> +		tsens: thermal-sensor {
> +			compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
> +			#thermal-sensor-cells = <1>;
> +		};
>  	};
>  
>  	timer {
> @@ -586,4 +592,34 @@
>  			#clock-cells = <1>;
>  		};
>  	};
> +
> +	thermal_zones: thermal-zones {
> +		cpu-thermal0 {
> +			polling-delay-passive = <250>;
> +			polling-delay = <2000>;
> +			thermal-sensors = <&tsens IMX_SC_R_SYSTEM>;
> +			trips {
> +				cpu_alert0: trip0 {
> +					temperature = <107000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};

Same comment as previous patch.

> +				cpu_crit0: trip1 {
> +					temperature = <127000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_alert0>;
> +					cooling-device =
> +						<&A35_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&A35_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&A35_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&A35_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +	};
>  };
> -- 
> 2.7.4
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
