Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466E8C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0F6206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vEZ2wNAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgDFJ5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:57:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44232 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgDFJ5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:57:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id c15so741869wro.11;
        Mon, 06 Apr 2020 02:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FvEi+v8qZ6wRx1mCm/iC1sBfa5p8W6TIxjoeXPWIu2Q=;
        b=vEZ2wNARNNG/UR7JHYBp4KiNBSoFde3bLdpN9GMUsmvYX57lbUKfJHpc/r2cTubTpP
         jRBX+4Lre5qkFI2ENdU1t3IgZ1t3rfVgokDYliC7NtymTR/ksf0iwzLnQkbvUH/sw3Om
         AE3OA0r2/6qWDEAu7YdxTogwiNHyHDfV2Oae8xhs9TVu7u0YmLRhKQuwB21+lCFKJWlq
         fAdVEVoWJNyPiHivCpbvgL9XXTBOf+MzNyRdLdKRkyCpr6Ee0nbq34I2ltbqhxDC1ZZF
         A4SXyvv9hpePr1jYYbfc9sDH9iJ8IJcpmbV+ZzE7CgJoRpgrUpDW888LTtk+8AHqLYF5
         jTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FvEi+v8qZ6wRx1mCm/iC1sBfa5p8W6TIxjoeXPWIu2Q=;
        b=lbnh79j1eqMiJ5kw5KJsZOrOX2T3NbDQ5HLVe/1+lbuXFVcLyXyYVszEjc3QLIh+xF
         W/X0PycGqB5UHshtl25RKodnJz0YdflnwAz3FNK7tBTDpVIvAKmNGnIgZnc+RgtNF/1N
         sJy8BpRgfprukasVR7Q2w2NJUor57XmKGXyZoVslJ5lhXnN8X+MQlkg7aXHiHPouIMHv
         S1l5DZ5EHUf3CROMuoPiek0ojAUvpYM30i4knLTYD3U7KiEU+0QQDsHuzpXs5FQfKHLe
         kIlf3TMib9ud5LRnFXJNRGqIRXcxjkJUtGTqlU4PeD1BdAKLN3yFlt0duqtp7K0YuJfL
         IYOw==
X-Gm-Message-State: AGi0PuZzOt6aeyRCoVcguvndVZYhAv3C4g0/ZCaQoneyp2a/MjW8gwIZ
        UFubiA+vfLtV7Zczpfc/fDU=
X-Google-Smtp-Source: APiQypKOYgFbX4rIA4V65ymFGi6FWm5SoeTA/SifEwSIIg4ZrWipB3EBywllK0pF5ZWsglTTIlRd2Q==
X-Received: by 2002:adf:a459:: with SMTP id e25mr15750030wra.402.1586167025240;
        Mon, 06 Apr 2020 02:57:05 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f187sm25107141wme.9.2020.04.06.02.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 02:57:04 -0700 (PDT)
To:     justin.swartz@risingedge.co.za
Cc:     devicetree@vger.kernel.org, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, mark.rutland@arm.com,
        robh+dt@kernel.org
References: <20200405110022.3849-1-justin.swartz@risingedge.co.za>
Subject: Re: [PATCH] ARM: dts: enable WLAN for Mecer Xtreme Mini S6
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <e602c1b8-3606-a8d3-c64c-ec9e58315974@gmail.com>
Date:   Mon, 6 Apr 2020 11:57:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200405110022.3849-1-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

Have a look at the documents:

Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
Documentation/devicetree/bindings/mmc/mmc-controller.yaml

Fix &emmc as well.

> From: Justin Swartz <justin.swartz@risingedge.co.za>
> To: Heiko Stuebner <heiko@sntech.de>,
> 	Rob Herring <robh+dt@kernel.org>,
> 	Mark Rutland <mark.rutland@arm.com>
> Cc: Justin Swartz <justin.swartz@risingedge.co.za>,
> 	linux-arm-kernel@lists.infradead.org,
> 	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
> 	linux-kernel@vger.kernel.org
> Subject: [PATCH] ARM: dts: enable WLAN for Mecer Xtreme Mini S6
> Date: Sun,  5 Apr 2020 11:00:21 +0000
> Message-ID: <20200405110022.3849-1-justin.swartz@risingedge.co.za> (raw)
> 
> The Mecer Xtreme Mini S6 features a wireless module, based on a
> Realtek 8723BS, which provides WLAN and Bluetooth connectivity via
> SDIO and UART interfaces respectively.
> 
> Define a simple MMC power sequence that declares the GPIO pins
> connected to the module's WLAN Disable and Bluetooth Disable pins
> as active low reset signals, because both signals must be deasserted
> for WLAN radio operation.
> 
> Configure the host's SDIO interface for High Speed mode with 1.8v
> I/O signalling and IRQ detection over a 4-bit wide bus.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---
>  arch/arm/boot/dts/rk3229-xms6.dts | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3229-xms6.dts b/arch/arm/boot/dts/rk3229-xms6.dts
> index 679fc2b00..cdfcef41b 100644
> --- a/arch/arm/boot/dts/rk3229-xms6.dts
> +++ b/arch/arm/boot/dts/rk3229-xms6.dts
> @@ -39,6 +39,12 @@
>  		};
>  	};
>  
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		reset-gpios = <&gpio2 26 GPIO_ACTIVE_LOW>,
> +		              <&gpio2 29 GPIO_ACTIVE_LOW>;
> +	};
> +
>  	vcc_host: vcc-host-regulator {
>  		compatible = "regulator-fixed";
>  		enable-active-high;
> @@ -202,6 +208,18 @@
>  	status = "okay";
>  };
>  
> +&sdio {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cap-sdio-irq;

> +	disable-wp;

Not used in combination with sdio and emmc.

> +	mmc-pwrseq = <&sdio_pwrseq>;
> +	non-removable;

> +	num-slots = <1>;

Deprecated.

> +	vqmmc-supply = <&vccio_1v8>;
> +	status = "okay";
> +};
> +
>  &sdmmc {
>  	cap-mmc-highspeed;
>  	disable-wp;
> -- 
> 2.11.0

