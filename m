Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F764C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 05:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29BC02072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 05:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8h5Ughr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgFKFw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 01:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgFKFwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 01:52:25 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7E8C08C5C1;
        Wed, 10 Jun 2020 22:52:24 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id f7so5182043ejq.6;
        Wed, 10 Jun 2020 22:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PRWwHPfTqqS0ILVaBf+JQrfe5m2txu4W6HO5QlFL/zw=;
        b=k8h5UghrpX8qqfqQfTXDXbRUQ3lwmJ03yuZEbGljcGormhpmoe9NFsLfVUu0w5t6mD
         AkfGcB1P9L7ETCUf72TAX5SQlVChhYCvbl+oaoCCAuGc6aKT3vnbpwNmgek7JM34xhTL
         +WC2/Jr8Rg2GwlbOESl//4/dpp5DVZOdLghIBel5uU6iQsNtD+gIMH33KzzoMclj+U7N
         o6u6syj5XkVeRhAVDq+xTinoHaKoPDp8nICfhgXV8l89hziD73XiYQADUTaZ+MFjpw00
         dq3xy1hpGQcGFEI3ujYIh35gG1Z94zPS0fafe4cr1ihXSZbmG1g9MVFr0OXjbgM2gJW9
         jZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PRWwHPfTqqS0ILVaBf+JQrfe5m2txu4W6HO5QlFL/zw=;
        b=LDxNFEe1OOmlcSKbr8Ay6OKG9bOSryCu6NeeVZTjuTv9EQ8myBQi0TOFjv5xnEs+ES
         EEojoy/sUAUlZfP7oVqnj8dYtiTKrWr0PkG34jvGh+cpLWpT4Y7gqZQceygIUXt9MDt/
         h6um5ZKhuztsC0MTxTvcdXTGj42hLa/02ItsRLCebnTxKTbPqlyEOan38hLBFWcoLFJN
         hoxxYSwdSKouYqLd0c+PyAzaAl+7Vmr0zI35OWcv808tc7mrc6fl5sk4QDA3L6etNUdQ
         ntR4HBQwCSBzMYaFDRKZ60ogY+e5EwxNSSTuqIKe5Jn3hHUmBH/FrCr+tDoUQMHl7TDL
         s+Yg==
X-Gm-Message-State: AOAM532wEnCEmW/UpKagl5C1PxUHsOtYNgyVn+NqVeDYIMpmZ/KtGVXJ
        qrK9ptrxAQ6aIqe9tsNoaFs=
X-Google-Smtp-Source: ABdhPJwOc06qpbKD2caI7O+S/BmvO/YYwrTuc3E0nlZCiwVqofBpsif1N3NCfj5o2uOym87oy/iKZg==
X-Received: by 2002:a17:906:f913:: with SMTP id lc19mr6719703ejb.286.1591854743743;
        Wed, 10 Jun 2020 22:52:23 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id k23sm1270159ejg.89.2020.06.10.22.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 22:52:23 -0700 (PDT)
Subject: Re: [PATCH] ARM: dts: rockchip: Add marvell BT irq config
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        heiko@sntech.de, linux-rockchip@lists.infradead.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org, mka@chromium.org,
        dianders@chromium.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20200610190622.1.I66864be898aa835ccb66b6cd5220d0b082338a81@changeid>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <4d989400-0a2c-e6c8-8c83-d6d15464a10d@gmail.com>
Date:   Thu, 11 Jun 2020 07:52:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610190622.1.I66864be898aa835ccb66b6cd5220d0b082338a81@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/20 4:06 AM, Abhishek Pandit-Subedi wrote:
> Veyron Jaq and Mighty both use the Marvel 8897 WiFi+BT chip. Add wakeup
> and pinctrl block to devicetree so the btmrvl driver can correctly
> configure the wakeup interrupt.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Reviewed-by: Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> The Veyron Mighty Chromebook (rk3288 based board) is missing the wake
> configuration for Bluetooth. Without this change, the wake irq was not
> configurable and wake on Bluetooth was broken.
> 
> I verified this change with additional changes in the Bluetooth driver
> (the series is at https://patchwork.kernel.org/cover/11599101/). The
> driver changes are not necessary for this dts change and shouldn't block
> it.
> 
> 
>  arch/arm/boot/dts/rk3288-veyron-jaq.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288-veyron-jaq.dts b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
> index 171ba6185b6d39..976c0c17a71199 100644
> --- a/arch/arm/boot/dts/rk3288-veyron-jaq.dts
> +++ b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
> @@ -51,6 +51,21 @@ &sdmmc {
>  			&sdmmc_bus4>;
>  };
>  

> +&sdio0 {

For nodes:
Sort things without reg alphabetical first,
then sort the rest by reg address.

&sdio0 goes above &sdmmc.

> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	btmrvl: btmrvl@2 {
> +		compatible = "marvell,sd8897-bt";
> +		reg = <2>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <RK_PD7 IRQ_TYPE_LEVEL_LOW>;
> +		marvell,wakeup-pin = /bits/ 16 <13>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_host_wake_l>;
> +	};
> +};
> +
>  &vcc_5v {
>  	enable-active-high;
>  	gpio = <&gpio7 RK_PC5 GPIO_ACTIVE_HIGH>;
> 

