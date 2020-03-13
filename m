Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8D1C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B23206E9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/J4nlTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgCMIcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 04:32:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34360 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMIcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 04:32:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id x3so7284367wmj.1;
        Fri, 13 Mar 2020 01:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YOjRw+C/n7E7oX+y3x4aSohu3eoOKr98HtVKwmdSAa4=;
        b=h/J4nlTWt0nrIB0e5vOXjzg4dei8f3MbKT7FrmAgrJ17CJ2JgoLp7E5jP9iyeB7/TK
         8j+vk99Yi4sSnia6lKaFs2yZd7kN3BJUzA3ibmGJizd9MybjhPCpM1DQxml1f+UckGaa
         bLVCTNz00BwGw1kbYepy0UllCfMMZxdXSqoWILxrPgCFTYB4LuM/8xPnmEU9pR8Rm8Nm
         RItxLPXcWUE97QScsbsj3G7VvB+fJVCZj/xbAZaoOiSxpernmqx2D23bDdohKMLQYK0t
         axQ90bnZNUy8KVEpLLLkhNBg9MyO/8DBz/ME1wT3dUdIfHtVC/l7PhL8ifz67tHK/G/T
         75sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YOjRw+C/n7E7oX+y3x4aSohu3eoOKr98HtVKwmdSAa4=;
        b=WBIn4tYpTOfLQwMrcaihVmnwdRtrUp05Us1feW/Ubeyqcpt1Yxz9kYQk4InbCdwaRq
         h7Oa0oU4VDG6j789HQKkzxRwHjeE+EJj/XgW9PP7bianBFmrxwqzwEgTM3Yj+PAGyMkj
         vKElH2B0OzfvOFhOSBCS9jiJULTder68gchHFzGNOgkmYU35vbwgnqu0InkbqzWdcega
         enY2ZnT6/esemi2MRMMq4Z7EzAYzdfUxqNiM2/97mlx1UcIJ05P4HHpHTkfyquT1gIVA
         +fHuKe3vZO96xQ55UYxlkOQgXZdbLasiWyLq8v9EcpT0Pq9g63+SYpc8QgZ0TI6R+EIm
         Sb1g==
X-Gm-Message-State: ANhLgQ1Jy3rh5CaRIKDe4UiZ9Zd5XDcCb6VON5gyuVfyJR6SUECzpfYR
        Wh7l3ofYGeXTXdLrpkcEViD+BvEg
X-Google-Smtp-Source: ADFU+vs1FL/6bDgN+NsmfFq6d3hMjZ5VBsz8S+087YMkOLZhXOVbxR4B1049/l8ONxxTnnk72txSGA==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr9351116wmi.140.1584088349511;
        Fri, 13 Mar 2020 01:32:29 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id h10sm4144167wrb.24.2020.03.13.01.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 01:32:29 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: rockchip: Add Hugsun X99 IR receiver and
 power led
To:     Vivek Unune <npcomplete13@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, heiko@sntech.de, ezequiel@collabora.com,
        akash@openedev.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200313000112.19419-1-npcomplete13@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <7f294dd5-3188-e2d6-dd49-4b2afb04455a@gmail.com>
Date:   Fri, 13 Mar 2020 09:32:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313000112.19419-1-npcomplete13@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

The 'power-led' need some changes.

From leds-gpio.yaml:

patternProperties:
  # The first form is preferred, but fall back to just 'led' anywhere in the
  # node name to at least catch some child nodes.
  "(^led-[0-9a-f]$|led)":
    type: object

Test with:
make -k ARCH=arm64 dtbs_check

arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dt.yaml: leds:
power-led:linux,default-trigger:0: 'none' is not one of ['backlight',
'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']

On 3/13/20 1:01 AM, Vivek Unune wrote:
>  - Add Hugsun X99 IR receiver and power led
>  - Remove pwm0 node as it interferes with pwer LED gpio

pwer => power

>    Also, it's not used in factory firmware
>    

> Tested with Libreelec kernel v5.6

Test with linux-next.

git clone -- depth 1
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

> 
> Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
> ---
>  .../boot/dts/rockchip/rk3399-hugsun-x99.dts   | 37 +++++++++++++++++--
>  1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> index d69a613fb65a..df425e164a2e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> @@ -29,6 +29,26 @@
>  		regulator-max-microvolt = <5000000>;
>  	};
>  
> +	ir-receiver {
> +		compatible = "gpio-ir-receiver";
> +		gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ir_rx>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&power_led_gpio>;
> +
> +		power-led {
> +			label = "blue:power";
> +			gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
> +			linux,default-trigger = "none";
> +		};
> +	};
> +
>  	vcc_sys: vcc-sys {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc_sys";
> @@ -483,6 +503,18 @@
>  		};
>  	};
>  
> +	ir {
> +		ir_rx: ir-rx {
> +			rockchip,pins = <0 RK_PA6 1 &pcfg_pull_none>;
> +		};
> +	};
> +
> +	leds {
> +		power_led_gpio: power-led-gpio {
> +			rockchip,pins = <4 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
>  	pmic {
>  		pmic_int_l: pmic-int-l {
>  			rockchip,pins =
> @@ -539,10 +572,6 @@
>  	};
>  };
>  
> -&pwm0 {
> -	status = "okay";
> -};
> -
>  &pwm2 {
>  	status = "okay";
>  	pinctrl-0 = <&pwm2_pin_pull_down>;
> 

