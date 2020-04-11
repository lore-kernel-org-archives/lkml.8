Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEBFC2BB86
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 21:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A763B20708
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 21:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MU+xhgai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgDKVHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 17:07:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37447 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgDKVHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 17:07:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so6102434wrm.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 14:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8HBuDzCvkyfKZZ1tWeVB8Szek2VwmJjlVHK8Ycm75ag=;
        b=MU+xhgaisR+NyZ8E+v0OCZVZz+jLsa8lyOgrjMSAty9kHH02bT62wao77pNaT55AXZ
         7f15fXwyxEVmypTS0UlU6yjXt5t0OHMlIcUwRtGMxUi1UP9pJFMHmmmn2VyCgXkJA3SZ
         utcKlYdBHgGPJk/sL/iKfuQYjaVjStKezSOJsNQ2qT0L1ubtcfdrLKwhaMN4lF+uym5q
         y9Bwl9RNiEq5m7pspk1uC1ckMCvTGkXQ87l/Vtba88xv4expzbJ3/QySePeykwvBmx/p
         rEiH9PlyxASGn4h+TucMYnQnz1jX3ZcvPBqazMNHwr9IppJmL8XtlQNLOBiDj1KANBS2
         Y4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8HBuDzCvkyfKZZ1tWeVB8Szek2VwmJjlVHK8Ycm75ag=;
        b=b5g9AbL32uZrRjzQRuH6BPchS01E+sz2VKJNrAL9avwzfK7/SR9QQTSZ40Sv53ZEm+
         YcQwWLN/fPxmYgEadgjjp4hlfxAs0+Y5TvstSqDoVZ+K9QRW7dsNBR4WRtQPmI0kwo4c
         Ty4W/CV6Ozx2xjcAzhobtzBPOISM7fHsOq4j//dTqbz7C5zV+iA39CIWXdHlGltkcvQ5
         6UrAyPqjlZ7okZSyTT0ZP3I7kdiRggo3n1N38SY7+ie6KSOHmZMReBOMl4x6TnmInZpo
         F/i55D8iz2QPiIiu137Isdm6pOz5ifQJhWOCxbPyJ88m3WIFbCzYNswLMcN4LHheA2sb
         jFmw==
X-Gm-Message-State: AGi0Pub/RYySKuMcTKL3AoHs2SSLSuwTfmZ909Qw+foYXt+55s5oq8KL
        mTFReNYpggcnBcVquudHCjmKFw==
X-Google-Smtp-Source: APiQypKGcArGCT9bJ4WMewqhv1+haDm9Gmwn/cfH5TvdNqSULDHYIF1YXEBYFuzgsQAukS//WmEsXg==
X-Received: by 2002:a5d:6543:: with SMTP id z3mr11300361wrv.396.1586639242449;
        Sat, 11 Apr 2020 14:07:22 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:6d65:1643:5f3d:f45d? ([2a01:e34:ed2f:f020:6d65:1643:5f3d:f45d])
        by smtp.googlemail.com with ESMTPSA id k9sm8433048wrn.89.2020.04.11.14.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2020 14:07:21 -0700 (PDT)
Subject: Re: [PATCH 1/6] thermal: hwmon: Replace the call the
 thermal_cdev_update()
To:     Guenter Roeck <linux@roeck-us.net>, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com, linux-kernel@vger.kernel.org,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        "open list:PWM FAN DRIVER" <linux-hwmon@vger.kernel.org>,
        Lukasz Majewski <lukma@denx.de>
References: <20200410221236.6484-1-daniel.lezcano@linaro.org>
 <20200410221236.6484-2-daniel.lezcano@linaro.org>
 <4ded7975-499d-024a-283f-de4f82d295f3@roeck-us.net>
 <907914e7-7f5a-e66d-bf38-be110aa1f6f0@linaro.org>
 <bf81a4db-9687-b9b2-4976-64bdd364b101@roeck-us.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9b4584e6-6229-9e7b-dcda-9128a2cbcdf2@linaro.org>
Date:   Sat, 11 Apr 2020 23:07:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <bf81a4db-9687-b9b2-4976-64bdd364b101@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2020 19:26, Guenter Roeck wrote:
> On 4/11/20 9:45 AM, Daniel Lezcano wrote:
>> On 11/04/2020 03:32, Guenter Roeck wrote:
>>> On 4/10/20 3:12 PM, Daniel Lezcano wrote:
>>>> The function thermal_cdev_upadte is called from the throttling
>>>
>>> misspelled
>>>
>>>> functions in the governors not from the cooling device itself.
>>>>
>>>> The cooling device is set to its maximum state and then updated. Even
>>>> if I don't get the purpose of probing the pwm-fan to its maximum
>>>> cooling state, we can replace the thermal_cdev_update() call to the
>>>> internal set_cur_state() function directly.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> ---
>>>>  drivers/hwmon/pwm-fan.c | 3 +--
>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
>>>> index 30b7b3ea8836..a654ecdf21ab 100644
>>>> --- a/drivers/hwmon/pwm-fan.c
>>>> +++ b/drivers/hwmon/pwm-fan.c
>>>> @@ -372,7 +372,6 @@ static int pwm_fan_probe(struct platform_device *pdev)
>>>>  	if (ret)
>>>>  		return ret;
>>>>  
>>>> -	ctx->pwm_fan_state = ctx->pwm_fan_max_state;
>>>>  	if (IS_ENABLED(CONFIG_THERMAL)) {
>>>>  		cdev = devm_thermal_of_cooling_device_register(dev,
>>>>  			dev->of_node, "pwm-fan", ctx, &pwm_fan_cooling_ops);
>>>> @@ -384,7 +383,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
>>>>  			return ret;
>>>>  		}
>>>>  		ctx->cdev = cdev;
>>>> -		thermal_cdev_update(cdev);
>>>> +		pwm_fan_set_cur_state(cdev, ctx->pwm_fan_max_state);
>>>
>>> So far the function would only change the state if the new
>>> state is not equal to the old state. This was the case because
>>> pwm_fan_state was set to pwm_fan_max_state, and the call to
>>> thermal_cdev_update() and thus pwm_fan_set_cur_state() would
>>> do nothing except update statistics. The old code _assumed_
>>> that the current state is pwm_fan_max_state. The new code
>>> enforces it. That is a substantial semantic change, and it
>>> is not really reflected in the commit message. Is that really
>>> what you want ? If so, the commit message needs to state that
>>> and explain the rationale.
>>
>> Well, to be honest I'm not getting the rational of calling
>> thermal_cdev_update(cdev) right after
>> devm_thermal_of_cooling_device_register() neither setting pwm_fan_state
>> to pwm_fan_max_state.
>>
> Good question. The author might know/recall. Maybe the idea was that
> thermal would update the state to a lower state shortly thereafter.
> 
>> Do we have the guarantee there is at this point a thermal instance
>> making the target state working when thermal_cdev_update is called?
>>
>> Are we sure a thermal_cdev_update(cdev) is actually right here?
>>
> I don't know. I am not exactly familiar with thermal subsystem
> particulars. I do recall seeing similar code in other drivers, though.

This call is done only in the governors actually.

> Either case, your patch does change functionality, and we should not
> do that without understanding its impact.

Right, so I've been hacking my board, added a pwm-fan and binded the
thermal zone to it.

As expected, the call to thermal_cdev_update() is not needed.

ctx->pwm_fan_state = ctx->pwm_fan_max_state;

intializes to a max value (in my case it is 3). Right after it calls
thermal_cdev_update() which fails to find any instance active because we
are at init time and then calls set_cur_state with the target state set
to zero and passing through a stats usage for nothing.

The ctx->pwm_fan_state is only used by the cooling device ops, so I
don't see any reason why it is set to pwm_fan_max_state before the
compilation condition.

May be there is something subtle here.

Lukasz ? Is there any reason why thermal_cdev_update() was called here ?

IMO, this function is a governor thing and it must be removed from the
cooling device.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
