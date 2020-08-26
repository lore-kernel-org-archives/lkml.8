Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86986C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EE4E20707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgHZMmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:42:01 -0400
Received: from foss.arm.com ([217.140.110.172]:45692 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729308AbgHZMmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:42:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD9F3101E;
        Wed, 26 Aug 2020 05:41:59 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9917C3F71F;
        Wed, 26 Aug 2020 05:41:56 -0700 (PDT)
Subject: Re: [PATCH] dtbs: hikey970: add wifi support
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>, linuxarm@huawei.com,
        Wei Xu <xuwei5@hisilicon.com>, linux-kernel@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>, mauro.chehab@huawei.com,
        linux-arm-kernel@lists.infradead.org
References: <b22e5799fe16a6902f95a8bd3f0f41f5a260c1ad.1598421453.git.mchehab+huawei@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f055afe8-1888-48a4-4a4f-0ea031d1942c@arm.com>
Date:   Wed, 26 Aug 2020 13:41:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <b22e5799fe16a6902f95a8bd3f0f41f5a260c1ad.1598421453.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-26 06:57, Mauro Carvalho Chehab wrote:
> The dwmmc2 is used on Hikey 970 for WiFi support. The
> hi3670.dtsi adds it, but with status="disabled".
> 
> For WiFi to work,it needs to be enabled. While here, add
> the missing properties:
> 
> 	#address-cells = <0x1>;
> 	#size-cells = <0x0>;
> 
> and add
> 	ti,non-removable
> 
> To DT properties, as the WiFi support is on a non-removable slot.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>   arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> index f218acceec0b..a2b0d2a1d09d 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> @@ -402,6 +402,7 @@ &sd_clk_cfg_func
>   
>   &dwmmc2 { /* WIFI */
>   	bus-width = <0x4>;
> +	ti,non-removable;

Why? This property is only defined for OMAP HSMMC controllers, which 
this isn't, and you've already got the proper generic property right 
there below. Plus in terms of Linux it will have zero effect, since it's 
only parsed by the omap_hsmmc driver anyway.

>   	non-removable;
>   	broken-cd;
>   	cap-power-off-card;
> @@ -409,8 +410,12 @@ &dwmmc2 { /* WIFI */
>   	pinctrl-0 = <&sdio_pmx_func
>   		     &sdio_clk_cfg_func
>   		     &sdio_cfg_func>;
> +	status = "ok";

Have you noticed the context 6 lines below?

> +
>   	/* WL_EN */
>   	vmmc-supply = <&wlan_en>;
> +	#address-cells = <0x1>;
> +	#size-cells = <0x0>;

These are already present in hi3670.dtsi. AFAICS Wifi support was merged 
18 months ago :/

Robin.

>   	status = "ok";
>   
>   	wlcore: wlcore@2 {
>
