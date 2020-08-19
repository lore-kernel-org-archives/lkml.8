Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16496C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA749214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PX5Mjhu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgHSUsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 16:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHSUsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 16:48:41 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93597C061757;
        Wed, 19 Aug 2020 13:48:41 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id df16so19241048edb.9;
        Wed, 19 Aug 2020 13:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mdnZglwI4EjvNb/esSyk9gVq6ig88nPzaI7IUsXkz/Y=;
        b=PX5Mjhu03HyeYYhfatP1x50gNnSApx04aOGnQcg36XJxZhpwXgNNt5k2SqYRFRdfLZ
         tbTrp0sqEw9dPDVMhD/kRlsu3n9pF73WzpwobOfh926j7oQWkwst7L2+Yq2mTwGmTQYq
         +D5yZTEVp3FWmB9Zxc1+CvUNaXx2SMVGCHburPSYGEbzAf0QLfqWVugoQEQZqnFZ4XC+
         slcXjXXeSkwIb4agMPWRJDAo4e4MaOf2bdheY9PgJ295nhMn2P6+Ef4dsVCM8lp/dlle
         JinNx31bdaahLStC8hx+TMzHUO7Zqptp1yD0kjToMxWXsP2YOWlWFzZpMjFGQQHcx9Mc
         6SGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mdnZglwI4EjvNb/esSyk9gVq6ig88nPzaI7IUsXkz/Y=;
        b=TIyflaoltsUgRH1+0jngWFxtzA5a5rBbMFz77FftIsfF5/y+GI72uJnxfRUWbnxz0A
         7cN2o4goINpRHyn39nl+kmKbvGLowjrNfuVRGl7GgUNKkbTYtIw4QdCKq/bwK0yRH0+7
         dPhgzI/4iXybrrfuYUNahagicJtpqJGr6GVYmv7LkLIH2MpQJ2eT1fEbyVC1aav1fzyg
         jyjYVckss64HXPM7g7WAPI1O6SyMFCgPyKsnbQqXYHha4zdxcqr4Byso0Z3alW4SW6c6
         cD+tLkeTFc8hw+tco4XRzwslQg8W7KUGVnJ01qzYpv1jdzr190Bd2jz8tMLNgzFpbYFO
         imJQ==
X-Gm-Message-State: AOAM531XdgzwkYIpiYrTiIvdGZxO5aoFBlPH/PmkskpTIoHKa7cMhvRm
        aO0jdt1ZeVpOKK38O+YspIkQc8BmeoE=
X-Google-Smtp-Source: ABdhPJx1mnImvIxu6eqtbKhO+TId8N68r59WzshKC5S78XgfC+g8tY+6DqAe34oWDS6x54ifvveFkA==
X-Received: by 2002:a05:6402:1430:: with SMTP id c16mr25995987edx.144.1597870119863;
        Wed, 19 Aug 2020 13:48:39 -0700 (PDT)
Received: from debian64.daheim (pd9e294f0.dip0.t-ipconnect.de. [217.226.148.240])
        by smtp.gmail.com with ESMTPSA id b9sm20368932ejz.57.2020.08.19.13.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 13:48:38 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
        by debian64.daheim with esmtp (Exim 4.94)
        (envelope-from <chunkeey@gmail.com>)
        id 1k8V0d-001EXU-R2; Wed, 19 Aug 2020 22:48:35 +0200
Subject: Re: [PATCH] ARM: dts: BCM5301X: Fix pin controller node
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "maintainer:BROADCOM BCM5301X ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200819042308.19043-1-f.fainelli@gmail.com>
From:   Christian Lamparter <chunkeey@gmail.com>
Message-ID: <7501cb2f-ea5a-8339-40a0-6706fea32a06@gmail.com>
Date:   Wed, 19 Aug 2020 22:48:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819042308.19043-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-19 06:23, Florian Fainelli wrote:
> The pin controller resources start at 0xc0 from the CRU base which is at
> 0x100 from th DMU base, for a final address of 0x1800_c1c0, whereas we
> are currently off by 0x100. The resource size of the CRU is also
> incorrect and should end at 0x248 bytes from 0x100 which is the start
> address. Finally, the compatibility strings defined for the
> pin-controller node should reflect the SoC being used.
> 
> Fixes: 9994241ac97c ("ARM: dts: BCM5301X: Describe Northstar pins mux controller")
> Reported-by: Christian Lamparter <chunkeey@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Christian, can you test this as a preliminary patch for your Cisco
> Meraki MR32 series? Thanks!

Hm, it looks like this is more complicated than this. We should have 
looked at pinctrl-ns.c's ns_pinctrl_probe() [0] before calling it.

|	ns_pinctrl->regmap = syscon_node_to_regmap(of_get_parent(np));
|	if (IS_ERR(ns_pinctrl->regmap)) {
|		int err = PTR_ERR(ns_pinctrl->regmap);
|
|		dev_err(dev, "Failed to map pinctrl regs: %d\n", err);
|
|		return err;
|	}
|
|	if (of_property_read_u32(np, "offset", &ns_pinctrl->offset)) {
|		dev_err(dev, "Failed to get register offset\n");
|		return -ENOENT;
|	}

So, the ns_pinctrl_probe() takes the address of the parent node (cru)
and then looks for a "offset" property to add to this (which is missing
in the bcm5301x.dtsi [1]).

Thing is, for this to work, the parent-node should be a "simple-mfd" (so 
a regmap is created for the reg), right? This would also mean that the 
"reg" property in the pin-controller node is just cosmetic.

I guess the reason why this sort-of-works for me is because I'm using 
this MR32 with OpenWrt (Rafał Miłecki is probably using it too ;) ).

(Note: We should not forget to update the binding-documentation as well!)

BTW: I'll reply my findings for the i2c issue with the MR32 in the other 
mail.

> 
>   arch/arm/boot/dts/bcm4708.dtsi  | 4 ++++
>   arch/arm/boot/dts/bcm4709.dtsi  | 4 ++++
>   arch/arm/boot/dts/bcm5301x.dtsi | 8 ++++----
>   3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/bcm4708.dtsi b/arch/arm/boot/dts/bcm4708.dtsi
> index 1a19e97a987d..5064fe51e402 100644
> --- a/arch/arm/boot/dts/bcm4708.dtsi
> +++ b/arch/arm/boot/dts/bcm4708.dtsi
> @@ -43,6 +43,10 @@ cpu@1 {
>   
>   };
>   
> +&pinctrl {
> +	compatible = "brcm,bcm4708-pinmux";
> +};
> +
>   &uart0 {
>   	status = "okay";
>   };
> diff --git a/arch/arm/boot/dts/bcm4709.dtsi b/arch/arm/boot/dts/bcm4709.dtsi
> index e1bb8661955f..7417c275ea9d 100644
> --- a/arch/arm/boot/dts/bcm4709.dtsi
> +++ b/arch/arm/boot/dts/bcm4709.dtsi
> @@ -5,6 +5,10 @@
>   
>   #include "bcm4708.dtsi"
>   
> +&pinctrl {
> +	compatible = "brcm,bcm4709-pinmux";
> +};
> +
>   &uart0 {
>   	clock-frequency = <125000000>;
>   	status = "okay";
> diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
> index 2d9b4dd05830..bf49943f504a 100644
> --- a/arch/arm/boot/dts/bcm5301x.dtsi
> +++ b/arch/arm/boot/dts/bcm5301x.dtsi
> @@ -402,14 +402,14 @@ dmu@1800c000 {
>   
>   		cru@100 {
>   			compatible = "simple-bus";
> -			reg = <0x100 0x1a4>;
> +			reg = <0x100 0x248>;
>   			ranges;
>   			#address-cells = <1>;
>   			#size-cells = <1>;
>   
> -			pin-controller@1c0 {
> -				compatible = "brcm,bcm4708-pinmux";
> -				reg = <0x1c0 0x24>;
> +			pinctrl: pin-controller@c0 {
> +				compatible = "brcm,bcm53012-pinmux";
> +				reg = <0xc0 0x24>;
>   				reg-names = "cru_gpio_control";
>   
>   				spi-pins {
> 

[0] 
<https://elixir.bootlin.com/linux/v5.9-rc1/source/drivers/pinctrl/bcm/pinctrl-ns.c#L302>

[1] 
<https://elixir.bootlin.com/linux/v5.9-rc1/source/arch/arm/boot/dts/bcm5301x.dtsi#L410>
