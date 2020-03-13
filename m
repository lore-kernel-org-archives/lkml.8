Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180F3C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AE62073E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFPc+qrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgCMOaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:30:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44784 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMOaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:30:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id l18so12306082wru.11;
        Fri, 13 Mar 2020 07:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+iojI06QF7FW93GI5k/iMm9nhOev+eb8ZJmHPMfD0wo=;
        b=gFPc+qrAJVx6MNr5/f9VEM8/KRYsy32zt4obDgMH5/jJtgMoYBJcYAKauVoSQ8Jlv6
         zQCx+ujfz7tdW0XbBMzUf1u9xrHmDawBe1ULNAhiqNP46T9uuwTn3UNMrsfBlLpD5ACc
         W0BNP3d5fLxpkN9tOf+S2WU30QT7DnPdrrRRo9zCOA2z4nIkrkAIqjhRPdSFq8XYZMdm
         bo5jgcB0FtUaTurNiSUGJKeQYMHGJE5W0/JBY0uGfSSG8gLCPktM140bzsyikbc3TQ2T
         YuYyUEocPbbBSii3Rrxnic1kXYEVFoJ099Tk2fRW42Vbv/7wQ09WyF6PlPz4izaP93Ix
         90ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+iojI06QF7FW93GI5k/iMm9nhOev+eb8ZJmHPMfD0wo=;
        b=VCJbXip2OKcQ9rrj10oqAnPry3Jd6PHQnFyVc1FIWxy5VaEIiMWdwHM2YDtJgMm6vk
         SpteBlekowIFbdNQ/sfz0cBJnrRH84TFdHZikvsaus4ZxE6LkMUeuYJWy8V5pjsKYH7l
         l6s+SejGD6+7CsJVI/tMYG0AUbqSZQPvGzRNQM3zVxBrZqrMiQy5Qtz1qNkJivmeIuRN
         1nicaYL+BHoEcGa4fCtJ63RUkk096Xn/SM8eqU87xTRsmbkFugOzwz09tStJDL4wgIGa
         vkFujaYO8BvWgi4kbVlhUVQquOByYjVYdSLcGwaafsiIhDIJcJu8kf13oay1bh+J1g2J
         Utfg==
X-Gm-Message-State: ANhLgQ0jv9SeaE8PG+bqQ6TE03F+DjFX9GuCNN6XX7PFyoXGbQ4dR3Fp
        aWh3CTHbKtgmmt1T6yqkZpIlMhG7
X-Google-Smtp-Source: ADFU+vswj9FEP6E4nDcI/ph/NC061YGRPjXe6ZauPpIi3u3V2Sz0ZF2771H3kPpnX8MPMwIPnmVNAw==
X-Received: by 2002:a5d:42c8:: with SMTP id t8mr18264616wrr.415.1584109801877;
        Fri, 13 Mar 2020 07:30:01 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o26sm16212133wmc.33.2020.03.13.07.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 07:30:01 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: rockchip: Add Hugsun X99 IR receiver and
 power led
To:     Vivek Unune <npcomplete13@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        ezequiel@collabora.com, akash@openedev.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200313000112.19419-1-npcomplete13@gmail.com>
 <7f294dd5-3188-e2d6-dd49-4b2afb04455a@gmail.com>
 <20200313142005.GA25349@ubuntu>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <4deb154d-3095-7d18-fbf9-85b60f57765f@gmail.com>
Date:   Fri, 13 Mar 2020 15:29:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313142005.GA25349@ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

On 3/13/20 3:20 PM, Vivek Unune wrote:
> On Fri, Mar 13, 2020 at 09:32:27AM +0100, Johan Jonker wrote:
>> Hi Vivek,
>>
>> The 'power-led' need some changes.
>>
>> From leds-gpio.yaml:
>>
>> patternProperties:
>>   # The first form is preferred, but fall back to just 'led' anywhere in the
>>   # node name to at least catch some child nodes.
>>   "(^led-[0-9a-f]$|led)":
>>     type: object
>>
>> Test with:
>> make -k ARCH=arm64 dtbs_check
>>
>> arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dt.yaml: leds:
>> power-led:linux,default-trigger:0: 'none' is not one of ['backlight',
>> 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
>>
>> On 3/13/20 1:01 AM, Vivek Unune wrote:
>>>  - Add Hugsun X99 IR receiver and power led
>>>  - Remove pwm0 node as it interferes with pwer LED gpio
>>
>> pwer => power
>>
> 
> Hi Johan,
> 
> I'll fix those in my next version. Here's what I intended to to:
> 

> 1. Rename 'power-led' node to 'led-power'

The first form is preferred.
Put 'led-power' in a regex tester with ^led-[0-9a-f]$
https://regex101.com/
Your regular expression does not match the subject string.

Test 'led-0'
Full match


> 2. Remove 'linux,default-trigger' entirely since this led is always on
> 
> Thanks,
> 
> Vivek 
> 
>>> index d69a613fb65a..df425e164a2e 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
>>> @@ -29,6 +29,26 @@
>>>  		regulator-max-microvolt = <5000000>;
>>>  	};
>>>  
>>> +	leds {
>>> +		compatible = "gpio-leds";
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&power_led_gpio>;
>>> +
>>> +		power-led {
>>> +			label = "blue:power";
>>> +			gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_HIGH>;
>>> +			default-state = "on";
>>> +			linux,default-trigger = "none";
>>> +		};
>>> +	};
>>> +

