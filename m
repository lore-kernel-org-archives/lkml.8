Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446D5C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20EFE2065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ts3s5J/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgGOXPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 19:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgGOXPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 19:15:02 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A842EC08C5DB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 16:15:02 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id e11so3696684qkm.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 16:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xd3yKqfzGmIuyChmnHGbxGkkq4tAYE3GR+3CE+pvQXg=;
        b=Ts3s5J/0Jn86cWG4tF6CjMnwblbzfZlvMliTt+poHpAG7orVq3o3nSe6n6Q1EYPvYa
         5QSUhh8VkISuEaFNLQ0Nq89faKdYqhaCqvSyPDIKMhJFeMis5CXzx3OzzvMWT5OYXkEG
         Wx4NhgyxGnvXNO151lP+C0lffDejUl1x+1SXEXqWE+cQjQDKFy5ffljzNj6ryf1HznNK
         jlebn5peyRii0ZNLjeLReRyhUhDGqBX/hlxs9n0twT5nWn2AKG4yhGKX670b5nh5Y73S
         NPGhHXQpPmIAxzDFnHK8GzrJvS/dsx1QYdmOgOTEP2xaaIud7o7YYvdDZ9gC431R3Hu8
         vEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xd3yKqfzGmIuyChmnHGbxGkkq4tAYE3GR+3CE+pvQXg=;
        b=cQ+P1B9Friv9aA1LTvPMryJUciuZyzxlLXn5o2kFPJL2U+bHHP0HdozepMxC3nyuAC
         seH1c1eifzb1tL2OQj9WJXoiUwUy2ovTPamv0zYop4NLsLj/kIva7Xj9Eb0TLbQyp+Ku
         6KNwKQ9k0ZYdM93VAX/yJYseAUa0ZXDYJ4z79CReXiDEMDbeT7NLeOVln5G00psVSt6e
         JzEj5/faeenIjOuE+d8DsLvrNx2f9o6KIMC5N0Fo0EsUqyoAKYpF0E/Vu/JQg90tq4OL
         OycSIEHu2Gcn/upuquQmnd58TEvzGjfvHy0mrwzPc1FuZKKJFweVeyDuxfaDeJBvhBsk
         x0UQ==
X-Gm-Message-State: AOAM531enFrBrW4m8zEZxHImxnqbRmNxjBIwk7vFoGx/PbwxP0FgiN95
        UwLmEBH7U6NudsyFGO9QA0T4CIAO+6s=
X-Google-Smtp-Source: ABdhPJzszqQUB8jmldBHMhwuFEBC+z8WHjXAb/q6EGDZuz6YCf/xKyIqVeXUt0vagEfU/5DMKL7TpQ==
X-Received: by 2002:a05:620a:2002:: with SMTP id c2mr1314654qka.35.1594854901466;
        Wed, 15 Jul 2020 16:15:01 -0700 (PDT)
Received: from [192.168.1.92] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id o187sm4343607qke.76.2020.07.15.16.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 16:15:00 -0700 (PDT)
Subject: Re: [RFC PATCH 3/4] thermal:core:Add genetlink notifications for
 monitoring falling temperature
To:     Zhang Rui <rui.zhang@intel.com>, daniel.lezcano@linaro.org,
        robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200710135154.181454-1-thara.gopinath@linaro.org>
 <20200710135154.181454-4-thara.gopinath@linaro.org>
 <746420e6b213985518d8b314018e32dc3438e9af.camel@intel.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <021bec8e-2cf7-99fb-d224-e16796b95567@linaro.org>
Date:   Wed, 15 Jul 2020 19:15:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <746420e6b213985518d8b314018e32dc3438e9af.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/20 4:46 AM, Zhang Rui wrote:
> On Fri, 2020-07-10 at 09:51 -0400, Thara Gopinath wrote:
>> Add notification calls for trip type THERMAL_TRIP_COLD when
>> temperature
>> crosses the trip point in either direction.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>   drivers/thermal/thermal_core.c | 21 +++++++++++++++------
>>   1 file changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c
>> b/drivers/thermal/thermal_core.c
>> index 750a89f0c20a..e2302ca1cd3b 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -429,12 +429,21 @@ static void handle_thermal_trip(struct
>> thermal_zone_device *tz, int trip)
>>   		tz->ops->get_trip_hyst(tz, trip, &hyst);
>>   
>>   	if (tz->last_temperature != THERMAL_TEMP_INVALID) {
>> -		if (tz->last_temperature < trip_temp &&
>> -		    tz->temperature >= trip_temp)
>> -			thermal_notify_tz_trip_up(tz->id, trip);
>> -		if (tz->last_temperature >= trip_temp &&
>> -		    tz->temperature < (trip_temp - hyst))
>> -			thermal_notify_tz_trip_down(tz->id, trip);
>> +		if (type == THERMAL_TRIP_COLD) {
>> +			if (tz->last_temperature > trip_temp &&
>> +			    tz->temperature <= trip_temp)
>> +				thermal_notify_tz_trip_down(tz->id,
>> trip);
> 
> trip_type should also be part of the event because trip_down/trip_up
> for hot trip and cold trip have different meanings.
> Or can we use some more generic names like trip_on/trip_off? trip_on
> means the trip point is violated or actions need to be taken for the
> specific trip points, for both hot and cold trips. I know
> trip_on/trip_off doesn't represent what I mean clearly, but surely you
> can find a better name.

Makes sense.. I will fix this in the next version. I don't have a good 
name at the moment but will think of something!


-- 
Warm Regards
Thara
