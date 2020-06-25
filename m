Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2F4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3A3B20707
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390781AbgFYIkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 04:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbgFYIkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 04:40:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44C2C061573;
        Thu, 25 Jun 2020 01:40:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id E8EE32A0267
Subject: Re: [PATCH 7/7] arm64: dts: mt8183: Add krane-sku176 board
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, erwanaliasr1@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Ben Ho <Ben.Ho@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20200619102757.1358675-1-enric.balletbo@collabora.com>
 <20200619102757.1358675-8-enric.balletbo@collabora.com>
 <fe814ab3-c237-da9c-d391-cbd0cdbe29bf@gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <3700a9b7-195b-f8d6-de03-fc5a77beffee@collabora.com>
Date:   Thu, 25 Jun 2020 10:40:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <fe814ab3-c237-da9c-d391-cbd0cdbe29bf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Thank you for your review.

On 22/6/20 12:33, Matthias Brugger wrote:
> 
> 
> On 19/06/2020 12:27, Enric Balletbo i Serra wrote:
>> Also known as the Lenovo IdeaPad Duet Chromebook.
>>
>> There are different krane boards with shared resources, hence a
>> mt8183-kukui-krane.dtsi was created for easily introduce future new
>> boards. The same happens with the baseboard codenamed kukui where
>> different variants, apart from kukui variant can take advantage of the
>> shared resources.
>>
>> Signed-off-by: Ben Ho <Ben.Ho@mediatek.com>
>> [originally created by Ben Ho but adapted and ported to mainline]
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>>  arch/arm64/boot/dts/mediatek/Makefile         |   1 +
>>  .../mediatek/mt8183-kukui-krane-sku176.dts    |  18 +
>>  .../boot/dts/mediatek/mt8183-kukui-krane.dtsi | 343 ++++++++
>>  .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 788 ++++++++++++++++++
>>  arch/arm64/boot/dts/mediatek/mt8183.dtsi      |   1 +
>>  5 files changed, 1151 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts
>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
>>
> [...]
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
>> new file mode 100644
>> index 0000000000000..f0a070535b340
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> [...]
>> +
>> +	max98357a: codec0 {
>> +		compatible = "maxim,max98357a";
>> +		sdmode-gpios = <&pio 175 0>;
>> +	};
>> +
>> +	btsco: codec1 {
> 
> bt_sco_codec:
> is more clear, I think.
> 

Ok. I'll change that in next version.

>> +		compatible = "linux,bt-sco";
>> +	};
>> +
>> +	wifi_pwrseq: wifi-pwrseq {
>> +		compatible = "mmc-pwrseq-simple";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&wifi_pins_pwrseq>;
>> +
>> +		/* Toggle WIFI_ENABLE to reset the chip. */
>> +		reset-gpios = <&pio 119 1>;
>> +	};
>> +
> [...]> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> index a1576f1b5a447..689bce13e0165 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> @@ -719,6 +719,7 @@ u3phy: usb-phy@11f40000 {
>>  			compatible = "mediatek,mt8183-tphy",
>>  				     "mediatek,generic-tphy-v2";
>>  			#address-cells = <1>;
>> +			#phy-cells = <1>;
> 
> Wrong patch?
> 

Oh yes, this should go with the USB one. Thank you to catch this, I'll fix in
next version.

>>  			#size-cells = <1>;
>>  			ranges = <0 0 0x11f40000 0x1000>;
>>  			status = "okay";
>>
> 
> Regards,
> Matthias
> 
