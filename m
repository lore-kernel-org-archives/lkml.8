Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA56C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86ABE206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JW2aLIs6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732965AbgDAUF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:05:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42607 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732645AbgDAUF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 16:05:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id h15so1564025wrx.9;
        Wed, 01 Apr 2020 13:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a+S142soWxvPAwTiDQVsijQTQxAvRRcAFkGcI4sxqnk=;
        b=JW2aLIs6va4+0cC2zjC0VP+jQjJjrybEKjKoXHFOiz3w9umvjU+QMPGzk3Api0c0pz
         QK/tdwPratsyvutPSeeQZxJ/Ajl7bwX0See6h4T0Cyk2RzRDWry9HqHoJkpCf85I8nR8
         ZVkMyy0XQRs1PeCYZ4U2nqQ8xmdaiJhl/7SXTKgKkruMCO4HBkqkNAAjGbRHjOOsHgUy
         EEq2q4b+tvBdSahvomld+BG5VX1o+KIZc169oFGnDEMumcYt6S06aaivwLgxvWaCNYi3
         Amw/DFVggYIy/QF+ZuXyQBy1NpIkD3fC0FzKXx1KJIdDgHLHQTJxn9jfomJTKHzhU0kr
         sAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=a+S142soWxvPAwTiDQVsijQTQxAvRRcAFkGcI4sxqnk=;
        b=lJtDAbtD3K1714/LHe2/pIbbdUSoHfuNOhGWaFM2Zkcqk+iAuT9WyPlPXXgMrgp7w/
         faXBoaceGK0aCd+0uvo7zUSXbxWVEkTMhP2/dDP4E61I6SJZRN993XH/qudrmS2Twlii
         kUyw4MLj2xUQZvLPFw73vvwcnrAIqPdI4THMBW/VMWx/AQ4lhZbHgjswtM6xKVhYSzFd
         K0zGjarfqehNEtWTVVYfKHjqSr1JrQbjDQOnVPd9ca8JvF9wjMLEg0RZP2cVRy8waycu
         PvGRkrr/xlWbpwkSwn+L9ncZN+zkQ4OFOrDn8X7VOqBkEQartUtsqLwkjzrOEDp9zNHN
         d5jg==
X-Gm-Message-State: ANhLgQ27rE/YY5jLsKAZbiGf+VHryooslFGdLeaMq9VWnFgtw7k2DX1H
        7nACZtcyT60VGy5Oec+glK655d2J
X-Google-Smtp-Source: ADFU+vtlD0R0agSTAwWxIvSWi1GnzL/csfWdua+qV/QAzNcG4NYAaLzAAuZM1/AlzuodSr61PGI7FA==
X-Received: by 2002:adf:bb06:: with SMTP id r6mr28143761wrg.324.1585771555790;
        Wed, 01 Apr 2020 13:05:55 -0700 (PDT)
Received: from [192.168.1.23] (afdg236.neoplus.adsl.tpnet.pl. [95.49.84.236])
        by smtp.gmail.com with ESMTPSA id z1sm4434377wrp.90.2020.04.01.13.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 13:05:55 -0700 (PDT)
Subject: Re: [PATCH 1/6] arm64: dts: rockchip: rk3399-roc-pc: Fix MMC
 numbering for LED triggers
To:     Robin Murphy <robin.murphy@arm.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        pavel@ucw.cz, devicetree@vger.kernel.org
References: <20200327030414.5903-2-wens@kernel.org>
 <684a08e6-7dfe-4cb1-2ae5-c1fb4128976b@gmail.com>
 <CAGb2v65ayZwN14S-Pzu2ip1K=fgzTbNB=ZzUcpou-jtv8m6vBA@mail.gmail.com>
 <ccf35a92-7005-9c6d-a8a2-c17b714a60bc@arm.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Autocrypt: addr=jacek.anaszewski@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <13d459df-114d-3657-0b97-712c3143fe3c@gmail.com>
Date:   Wed, 1 Apr 2020 22:05:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <ccf35a92-7005-9c6d-a8a2-c17b714a60bc@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/20 1:07 PM, Robin Murphy wrote:
> [ +cc LED binding maintainers]
> 
> On 2020-03-29 5:36 pm, Chen-Yu Tsai wrote:
>> On Fri, Mar 27, 2020 at 5:58 PM Johan Jonker <jbx6244@gmail.com> wrote:
>>>
>>> Hi Chen-Yu Tsai,
>>>
>>> The led node names need some changes.
>>> 'linux,default-trigger' value does not fit.
>>>
>>>  From leds-gpio.yaml:
>>>
>>> patternProperties:
>>>    # The first form is preferred, but fall back to just 'led'
>>> anywhere in the
>>>    # node name to at least catch some child nodes.
>>>    "(^led-[0-9a-f]$|led)":
>>>      type: object
>>>
>>> Rename led nodenames to 'led-0' form
>>>
>>> Also include all mail lists found with:
>>> ./scripts/get_maintainer.pl --nogit-fallback --nogit
>>>
>>> devicetree@vger.kernel.org
>>
>> Oops...
>>
>>> If you like change the rest of dts with leds as well...
>>>
>>>    DTC     arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dt.yaml
>>>    CHECK   arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dt.yaml
>>> arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dt.yaml: leds:
>>> yellow-led:linux,default-trigger:0: 'mmc0' is not one of ['backlight',
>>> 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer',
>>> 'pattern']
>>> arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dt.yaml: leds:
>>> diy-led:linux,default-trigger:0: 'mmc1' is not one of ['backlight',
>>> 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer',
>>> 'pattern']
>>>    DTC     arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dt.yaml
>>>    CHECK   arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dt.yaml
>>> arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dt.yaml: leds:
>>> diy-led:linux,default-trigger:0: 'mmc2' is not one of ['backlight',
>>> 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer',
>>> 'pattern']
>>> arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dt.yaml: leds:
>>> yellow-led:linux,default-trigger:0: 'mmc1' is not one of ['backlight',
>>> 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer',
>>> 'pattern']
>>
>> Maybe we should just get rid of linux,default-trigger then?
> 
> In this particular case, I'd say it's probably time to reevaluate the
> rather out-of-date binding. The apparent intent of the
> "linux,default-trigger" property seems to be to describe any trigger
> supported by Linux, so either the binding wants to be kept in sync with
> all the triggers Linux actually supports, or perhaps it should just be
> redefined as a free-form string. FWIW I'd be slightly inclined towards
> the latter, since the schema validator can't know whether the given
> trigger actually corresponds to the correct thing for whatever the LED

I agree. It is possible for LED class drivers to register their private
triggers, so generic bindings cannot use predefined set for validation.

I think that Rob just blindly converted common.txt to yaml and I acked
that but didn't envisage the implications for validation.
All in all, even that list in common.txt didn't include all existing
generic LED triggers.

Best regards,
Jacek Anaszewski

> is physically labelled on the board/case, nor whether the version(s) of
> Linux that people intend to use actually support that trigger (since it
> doesn't have to be the version contemporary with the schema definition),
> so strict validation of this particular property seems to be of limited
> value.
> 
> Robin.
> 
>>
>> Heiko?
>>
>> ChenYu
>>
>>> make -k ARCH=arm64 dtbs_check
>>> DT_SCHEMA_FILES=Documentation/devicetree/bindings/leds/leds-gpio.yaml
>>>
>>>> From: Chen-Yu Tsai <wens@csie.org>
>>>>
>>>> With SDIO now enabled, the numbering of the existing MMC host
>>>> controllers
>>>> gets incremented by 1, as the SDIO host is the first one.
>>>>
>>>> Increment the numbering of the MMC LED triggers to match.
>>>>
>>>> Fixes: cf3c5397835f ("arm64: dts: rockchip: Enable sdio0 and uart0
>>>> on rk3399-roc-pc-mezzanine")
>>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>>> ---
>>>>   arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts | 8 ++++++++
>>>>   arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi          | 4 ++--
>>>>   2 files changed, 10 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git
>>>> a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
>>>> b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
>>>> index 2acb3d500fb9..f0686fc276be 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
>>>> @@ -38,6 +38,10 @@ vcc3v3_pcie: vcc3v3-pcie {
>>>>        };
>>>>   };
>>>>
>>>> +&diy_led {
>>>> +     linux,default-trigger = "mmc2";
>>>> +};
>>>> +
>>>>   &pcie_phy {
>>>>        status = "okay";
>>>>   };
>>>> @@ -91,3 +95,7 @@ &uart0 {
>>>>        pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
>>>>        status = "okay";
>>>>   };
>>>> +
>>>> +&yellow_led {
>>>> +     linux,default-trigger = "mmc1";
>>>> +};
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>>>> b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>>>> index 9f225e9c3d54..bc060ac7972d 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>>>> @@ -70,14 +70,14 @@ work-led {
>>>>                        linux,default-trigger = "heartbeat";
>>>>                };
>>>>
>>>> -             diy-led {
>>>> +             diy_led: diy-led {
>>>>                        label = "red:diy";
>>>>                        gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
>>>>                        default-state = "off";
>>>>                        linux,default-trigger = "mmc1";
>>>>                };
>>>>
>>>> -             yellow-led {
>>>> +             yellow_led: yellow-led {
>>>>                        label = "yellow:yellow-led";
>>>>                        gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
>>>>                        default-state = "off";
>>>> -- 
>>>> 2.25.1
>>>
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>

