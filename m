Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1F7C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71532072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYG/M7Mv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439564AbgDNLpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439532AbgDNLpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:45:05 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B6AC061A0C;
        Tue, 14 Apr 2020 04:45:04 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y24so13571603wma.4;
        Tue, 14 Apr 2020 04:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H1H+WW/rfol3XCr99+J5WEL3zWbHBKA7AHfmHx0QHrA=;
        b=ZYG/M7Mv2RWSGdB7XWVJLwSLyM1KyjyOyAfs0l5PvfKAF/NfeSrXtK33UlQq+rFubE
         BRvv0vA7QQXSsW3JqL9zAlN9/3dMqPpj8Eq4itpJSB4SbUOuxZFzAthjQ3miYsn+SfLY
         7YhdSlC6Y2DnoBFYV4YkmtjQAN4sq/PplVYxPMUbjEt9DFXbRLbqL3s9qftHjsVwy4oR
         OjgRKMZQY0luC92TIO8UwzayBEblh3B4uyPpMk/4OLLp0mE8z+ciUxb8viesohCqxkv8
         qIM95iwTmYHxCugZrUp05M/ypr/Xs2d9AYlV5QT9Sd3bdtc+wB46oDSZNM3r/Fi6kYGK
         qyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H1H+WW/rfol3XCr99+J5WEL3zWbHBKA7AHfmHx0QHrA=;
        b=ksHS/BTLZJeyg7eDqKKshBV6hG6zDnT5v9R/Fk2boCk1KScsG2+g7pNmiv8PyJoPjg
         ZCEG+ViEQXgXIQGU4cEAN+KdNdjHeSwUAF05H493ot0IMGoH8ox9Qrj6zsbDGl+V+6JQ
         1LQJXZFyZgn4vNFbhWEX4wGAxS4GBX0vegDmPjZgkJWzJW078J6ij19ciuocsBspWts1
         vK9OdTyKpt5vlN1qWxrmgSgVFBGyK2nxo+TkmP9xd9X74k5u7u82PFxGvHAn/e8sJwby
         eD90PLplAAI0jgd7APWumhr5wkSafzAButJCpqkD2ijLq+MUnPGMZToCUblCudNuhHsx
         srlQ==
X-Gm-Message-State: AGi0PubgeWgkzRWHowufX3H2FINgB/gTAhpbGRuBKTWWILN9UGRTXYWP
        ht5h1+WK4AH0Qu0N+SQuasE=
X-Google-Smtp-Source: APiQypI+pzhmOtvHbjeu5Az00+oZWfw3LuLDn5G0O9eSh9lLsvK6ekfBlcuQ+ZBlenp/Szsmw7pxdg==
X-Received: by 2002:a1c:ded4:: with SMTP id v203mr23311735wmg.106.1586864703169;
        Tue, 14 Apr 2020 04:45:03 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 138sm19207778wmb.14.2020.04.14.04.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 04:45:02 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: rockchip: remove bus-width from mmc nodes in
 rk3308.dtsi
To:     Robin Murphy <robin.murphy@arm.com>, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20200413193652.1952-1-jbx6244@gmail.com>
 <20c81edc-247c-8db0-2b3c-a6c2fcad6b4e@arm.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <f19b6b48-2950-abca-7dee-31c24118c3ef@gmail.com>
Date:   Tue, 14 Apr 2020 13:45:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20c81edc-247c-8db0-2b3c-a6c2fcad6b4e@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin, Heiko,

If the Rockchip DT maintainers(= Heiko) agree that the new line for the
'bus-width' properties is that it should be placed in dtsi I'll produce
a version 2. Please advise what should be done with the other Rockchip
SoCs. Change them too?

Johan.

On 4/14/20 12:02 PM, Robin Murphy wrote:
> On 2020-04-13 8:36 pm, Johan Jonker wrote:
>> The 'bus-width' property for mmc nodes is defined both in
>> 'rk3308.dtsi' and 'rk3308-roc-cc.dts'.
>> In line with the other Rockchip SoCs define that in a user dts only,
>> so remove all entries from mmc nodes in 'rk3308.dtsi'.
> 
> Judging by the pinctrl entries, these represent the number of pins
> provided by the SoC itself. Obviously boards need to override that if
> for some reason they don't wire up all the available data lines, but it
> seems backwards to have every board restate the SoC's default value.
> 
> In fact, having brought it up, for this particular case the pinctrl
> setting is inherently related to the bus width, so having one without
> the other in either place doesn't smell right.
> 
> Robin.
> 
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3308.dtsi | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
>> b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
>> index a9b98555d..130771ede 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
>> @@ -587,7 +587,6 @@
>>           compatible = "rockchip,rk3308-dw-mshc",
>> "rockchip,rk3288-dw-mshc";
>>           reg = <0x0 0xff480000 0x0 0x4000>;
>>           interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
>> -        bus-width = <4>;
>>           clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
>>                <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
>>           clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>> @@ -602,7 +601,6 @@
>>           compatible = "rockchip,rk3308-dw-mshc",
>> "rockchip,rk3288-dw-mshc";
>>           reg = <0x0 0xff490000 0x0 0x4000>;
>>           interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
>> -        bus-width = <8>;
>>           clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
>>                <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
>>           clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>> @@ -615,7 +613,6 @@
>>           compatible = "rockchip,rk3308-dw-mshc",
>> "rockchip,rk3288-dw-mshc";
>>           reg = <0x0 0xff4a0000 0x0 0x4000>;
>>           interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
>> -        bus-width = <4>;
>>           clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
>>                <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
>>           clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>>

