Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51934C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2452320675
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hOL4meLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbgFVHzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731289AbgFVHzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 03:55:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C8BC061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:55:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 17so155590wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GZ3cQNtQ465MvBmgLjG0yWAIDvq/cCKM9rt4ipQtrNg=;
        b=hOL4meLAABo6fJnAXJJbgyiZ5819SFtS0xNF5hh7cHM1e9XvP2cgvMa5a1G9Fv5FNd
         9vULLyjB7PqqNUN0NG9VfC5vlkEBYqSa4sl5WnGobpr6w8+Ql7bP+E402tIpRqebDqRe
         QiX1uId7tYb4apLUsjdGJQD96a4VFGF7rqXpoqBXqxnU5ouuphgJ4AEyPcgOna2WyFRL
         vfWzjorTagbXILwcahTuYr/7xlTB3+C5bpzMW4GhGzJ9g3hn/20Hhww62zhUYKTrmVFz
         +j1qzt+UXlfr7ulwX5MO3yAqpDnIka+eZ1AVd1UQtKLCnX3efo9EZsfOjjUjKg3mTQGy
         2Lcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GZ3cQNtQ465MvBmgLjG0yWAIDvq/cCKM9rt4ipQtrNg=;
        b=Aoe/9CqwaMdUP6kf8scZqTPU30SvwqooWu0jl2FltHlFYqBoIatBcJ5ipTMbJQbRZl
         iFXzc35DF8Xl6By+wWYG7VwaMg17Ntmii3NeY3QKOqbhe5xFjUhkT+Lk/oBpc6yncpnu
         I0FIirvOpLFUES63IlrpwuqOQgcfjFdjx461Gcw51TwxHAVq0EKFMGu5KgzksiMjVFiT
         V6FlotSuMs8Ycn+tKhYsEQyZL6k+ku90N8ONm1ZiaXIa3mOJl9UiI12iuCVQJ1p7apaT
         QI1S91zGF/llju9RSE4W2mxElr2/Vru9iDpTIKKbyAA6l4j/Lu7Pyjq3Z7VohMVTiRnU
         z+dQ==
X-Gm-Message-State: AOAM530A9mtIm9JqMQPjnlIPXFSRP8yI7mOKzpvimCY3tMJdDT7HVvTC
        gFqKjUKLX0UqFZTTx6v+AlzOXWn8/JQLIQ==
X-Google-Smtp-Source: ABdhPJzdHGZpnVpUbRL2SMjOwrxrqkxg8X3ISlb9FMuftY+j3ODbu3SnjFlKu3ELIimNMrRZojG83A==
X-Received: by 2002:a05:600c:281:: with SMTP id 1mr9288566wmk.143.1592812536623;
        Mon, 22 Jun 2020 00:55:36 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:9902:c1f0:76c7:9dbc? ([2a01:e35:2ec0:82b0:9902:c1f0:76c7:9dbc])
        by smtp.gmail.com with ESMTPSA id 207sm4810304wme.13.2020.06.22.00.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 00:55:35 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: meson-gx: Switch to the meson-ee-pwrc
 bindings
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200620161211.23685-1-martin.blumenstingl@googlemail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT7CwHsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIXOwU0EVid/pAEQAND7AFhr
 5faf/EhDP9FSgYd/zgmb7JOpFPje3uw7jz9wFb28Cf0Y3CcncdElYoBNbRlesKvjQRL8mozV
 9RN+IUMHdUx1akR/A4BPXNdL7StfzKWOCxZHVS+rIQ/fE3Qz/jRmT6t2ZkpplLxVBpdu95qJ
 YwSZjuwFXdC+A7MHtQXYi3UfCgKiflj4+/ITcKC6EF32KrmIRqamQwiRsDcUUKlAUjkCLcHL
 CQvNsDdm2cxdHxC32AVm3Je8VCsH7/qEPMQ+cEZk47HOR3+Ihfn1LEG5LfwsyWE8/JxsU2a1
 q44LQM2lcK/0AKAL20XDd7ERH/FCBKkNVzi+svYJpyvCZCnWT0TRb72mT+XxLWNwfHTeGALE
 +1As4jIS72IglvbtONxc2OIid3tR5rX3k2V0iud0P7Hnz/JTdfvSpVj55ZurOl2XAXUpGbq5
 XRk5CESFuLQV8oqCxgWAEgFyEapI4GwJsvfl/2Er8kLoucYO1Id4mz6N33+omPhaoXfHyLSy
 dxD+CzNJqN2GdavGtobdvv/2V0wukqj86iKF8toLG2/Fia3DxMaGUxqI7GMOuiGZjXPt/et/
 qeOySghdQ7Sdpu6fWc8CJXV2mOV6DrSzc6ZVB4SmvdoruBHWWOR6YnMz01ShFE49pPucyU1h
 Av4jC62El3pdCrDOnWNFMYbbon3vABEBAAHCwn4EGAECAAkFAlYnf6QCGwICKQkQFpq3saTP
 +K7BXSAEGQECAAYFAlYnf6QACgkQd9zb2sjISdGToxAAkOjSfGxp0ulgHboUAtmxaU3viucV
 e2Hl1BVDtKSKmbIVZmEUvx9D06IijFaEzqtKD34LXD6fjl4HIyDZvwfeaZCbJbO10j3k7FJE
 QrBtpdVqkJxme/nYlGOVzcOiKIepNkwvnHVnuVDVPcXyj2wqtsU7VZDDX41z3X4xTQwY3SO1
 9nRO+f+i4RmtJcITgregMa2PcB0LvrjJlWroI+KAKCzoTHzSTpCXMJ1U/dEqyc87bFBdc+DI
 k8mWkPxsccdbs4t+hH0NoE3Kal9xtAl56RCtO/KgBLAQ5M8oToJVatxAjO1SnRYVN1EaAwrR
 xkHdd97qw6nbg9BMcAoa2NMc0/9MeiaQfbgW6b0reIz/haHhXZ6oYSCl15Knkr4t1o3I2Bqr
 Mw623gdiTzotgtId8VfLB2Vsatj35OqIn5lVbi2ua6I0gkI6S7xJhqeyrfhDNgzTHdQVHB9/
 7jnM0ERXNy1Ket6aDWZWCvM59dTyu37g3VvYzGis8XzrX1oLBU/tTXqo1IFqqIAmvh7lI0Se
 gCrXz7UanxCwUbQBFjzGn6pooEHJYRLuVGLdBuoApl/I4dLqCZij2AGa4CFzrn9W0cwm3HCO
 lR43gFyz0dSkMwNUd195FrvfAz7Bjmmi19DnORKnQmlvGe/9xEEfr5zjey1N9+mt3//geDP6
 clwKBkq0JggA+RTEAELzkgPYKJ3NutoStUAKZGiLOFMpHY6KpItbbHjF2ZKIU1whaRYkHpB2
 uLQXOzZ0d7x60PUdhqG3VmFnzXSztA4vsnDKk7x2xw0pMSTKhMafpxaPQJf494/jGnwBHyi3
 h3QGG1RjfhQ/OMTX/HKtAUB2ct3Q8/jBfF0hS5GzT6dYtj0Ci7+8LUsB2VoayhNXMnaBfh+Q
 pAhaFfRZWTjUFIV4MpDdFDame7PB50s73gF/pfQbjw5Wxtes/0FnqydfId95s+eej+17ldGp
 lMv1ok7K0H/WJSdr7UwDAHEYU++p4RRTJP6DHWXcByVlpNQ4SSAiivmWiwOt490+Ac7ATQRN
 WQbPAQgAvIoM384ZRFocFXPCOBir5m2J+96R2tI2XxMgMfyDXGJwFilBNs+fpttJlt2995A8
 0JwPj8SFdm6FBcxygmxBBCc7i/BVQuY8aC0Z/w9Vzt3Eo561r6pSHr5JGHe8hwBQUcNPd/9l
 2ynP57YTSE9XaGJK8gIuTXWo7pzIkTXfN40Wh5jeCCspj4jNsWiYhljjIbrEj300g8RUT2U0
 FcEoiV7AjJWWQ5pi8lZJX6nmB0lc69Jw03V6mblgeZ/1oTZmOepkagwy2zLDXxihf0GowUif
 GphBDeP8elWBNK+ajl5rmpAMNRoKxpN/xR4NzBg62AjyIvigdywa1RehSTfccQARAQABwsBf
 BBgBAgAJBQJNWQbPAhsMAAoJEBaat7Gkz/iuteIH+wZuRDqK0ysAh+czshtG6JJlLW6eXJJR
 Vi7dIPpgFic2LcbkSlvB8E25Pcfz/+tW+04Urg4PxxFiTFdFCZO+prfd4Mge7/OvUcwoSub7
 ZIPo8726ZF5/xXzajahoIu9/hZ4iywWPAHRvprXaim5E/vKjcTeBMJIqZtS4u/UK3EpAX59R
 XVxVpM8zJPbk535ELUr6I5HQXnihQm8l6rt9TNuf8p2WEDxc8bPAZHLjNyw9a/CdeB97m2Tr
 zR8QplXA5kogS4kLe/7/JmlDMO8Zgm9vKLHSUeesLOrjdZ59EcjldNNBszRZQgEhwaarfz46
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <f6c2f1e7-b35f-e7a6-1891-693274824da6@baylibre.com>
Date:   Mon, 22 Jun 2020 09:55:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200620161211.23685-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2020 18:12, Martin Blumenstingl wrote:
> The "amlogic,meson-gx-pwrc-vpu" binding only supports the VPU power
> domain, while actually there are more power domains behind that set of
> registers. Switch to the new bindings so we can add more power domains
> as needed.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 18 ++++++++++--------
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi |  7 +++++--
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  |  7 +++++--
>  3 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index ba63c36b22e0..0edd137151f8 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -12,6 +12,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/power/meson-gxbb-power.h>
>  #include <dt-bindings/thermal/thermal.h>
>  
>  / {
> @@ -60,7 +61,7 @@ simplefb_cvbs: framebuffer-cvbs {
>  			compatible = "amlogic,simple-framebuffer",
>  				     "simple-framebuffer";
>  			amlogic,pipeline = "vpu-cvbs";
> -			power-domains = <&pwrc_vpu>;
> +			power-domains = <&pwrc PWRC_GXBB_VPU_ID>;
>  			status = "disabled";
>  		};
>  
> @@ -68,7 +69,7 @@ simplefb_hdmi: framebuffer-hdmi {
>  			compatible = "amlogic,simple-framebuffer",
>  				     "simple-framebuffer";
>  			amlogic,pipeline = "vpu-hdmi";
> -			power-domains = <&pwrc_vpu>;
> +			power-domains = <&pwrc PWRC_GXBB_VPU_ID>;
>  			status = "disabled";
>  		};
>  	};
> @@ -438,12 +439,6 @@ sysctrl_AO: sys-ctrl@0 {
>  				compatible = "amlogic,meson-gx-ao-sysctrl", "simple-mfd", "syscon";
>  				reg =  <0x0 0x0 0x0 0x100>;
>  
> -				pwrc_vpu: power-controller-vpu {
> -					compatible = "amlogic,meson-gx-pwrc-vpu";
> -					#power-domain-cells = <0>;
> -					amlogic,hhi-sysctrl = <&sysctrl>;
> -				};
> -
>  				clkc_AO: clock-controller {
>  					compatible = "amlogic,meson-gx-aoclkc";
>  					#clock-cells = <1>;
> @@ -552,6 +547,12 @@ hiubus: bus@c883c000 {
>  			sysctrl: system-controller@0 {
>  				compatible = "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon";
>  				reg = <0 0 0 0x400>;
> +
> +				pwrc: power-controller {
> +					compatible = "amlogic,meson-gxbb-pwrc";
> +					#power-domain-cells = <1>;
> +					amlogic,ao-sysctrl = <&sysctrl_AO>;
> +				};
>  			};
>  
>  			mailbox: mailbox@404 {
> @@ -574,6 +575,7 @@ ethmac: ethernet@c9410000 {
>  			interrupt-names = "macirq";
>  			rx-fifo-depth = <4096>;
>  			tx-fifo-depth = <2048>;
> +			power-domains = <&pwrc PWRC_GXBB_ETHERNET_MEM_ID>;
>  			status = "disabled";
>  		};
>  
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> index 03c25b9facff..ea50dd434887 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> @@ -748,7 +748,7 @@ mux {
>  	};
>  };
>  
> -&pwrc_vpu {
> +&pwrc {
>  	resets = <&reset RESET_VIU>,
>  		 <&reset RESET_VENC>,
>  		 <&reset RESET_VCBUS>,
> @@ -761,6 +761,9 @@ &pwrc_vpu {
>  		 <&reset RESET_VDI6>,
>  		 <&reset RESET_VENCL>,
>  		 <&reset RESET_VID_LOCK>;
> +	reset-names = "viu", "venc", "vcbus", "bt656",
> +		      "dvin", "rdma", "venci", "vencp",
> +		      "vdac", "vdi6", "vencl", "vid_lock";
>  	clocks = <&clkc CLKID_VPU>,
>  	         <&clkc CLKID_VAPB>;
>  	clock-names = "vpu", "vapb";
> @@ -867,7 +870,7 @@ &uart_C {
>  
>  &vpu {
>  	compatible = "amlogic,meson-gxbb-vpu", "amlogic,meson-gx-vpu";
> -	power-domains = <&pwrc_vpu>;
> +	power-domains = <&pwrc PWRC_GXBB_VPU_ID>;
>  };
>  
>  &vdec {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> index 60484bbc7272..beb5fc79d186 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> @@ -783,7 +783,7 @@ external_mdio: mdio@2009087f {
>  	};
>  };
>  
> -&pwrc_vpu {
> +&pwrc {
>  	resets = <&reset RESET_VIU>,
>  		 <&reset RESET_VENC>,
>  		 <&reset RESET_VCBUS>,
> @@ -796,6 +796,9 @@ &pwrc_vpu {
>  		 <&reset RESET_VDI6>,
>  		 <&reset RESET_VENCL>,
>  		 <&reset RESET_VID_LOCK>;
> +	reset-names = "viu", "venc", "vcbus", "bt656",
> +		      "dvin", "rdma", "venci", "vencp",
> +		      "vdac", "vdi6", "vencl", "vid_lock";
>  	clocks = <&clkc CLKID_VPU>,
>  	         <&clkc CLKID_VAPB>;
>  	clock-names = "vpu", "vapb";
> @@ -902,7 +905,7 @@ &uart_C {
>  
>  &vpu {
>  	compatible = "amlogic,meson-gxl-vpu", "amlogic,meson-gx-vpu";
> -	power-domains = <&pwrc_vpu>;
> +	power-domains = <&pwrc PWRC_GXBB_VPU_ID>;
>  };
>  
>  &vdec {
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
