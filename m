Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DEBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF26720702
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AmAE7w5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732809AbgF3L6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732517AbgF3L6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:58:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522ECC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 04:58:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so16832811wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 04:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zMgLLB+598P0Iwp/1mLhAQ3r7/OgN8nusdD6icBCvtw=;
        b=AmAE7w5oqwI11OWu3owKDkvOa88BlDd7rXcHIDQLSzjmUhdlgXLL+TAbRwVVwm2sat
         UwLJsaIJM/xu0P8S2TFiUPm2/miFEZimCTrskbUYw2XkotPhZWRORxSr6sUZFWloor7d
         RcscNVNW6iy8YhURPRUDSeuQ4/5L4ktp9hXy5Xn6sWlm98N+aXnT4gQ/WVBrFExOJqJ+
         PpfjnBriCzFlwvNo9jNn83Im2bscKyMvLG6CUmxQ7jCJc9uzc6cbmBF+cHmA3NyjxPdJ
         Zp5PDFFVQui08yCOFg1KsE05WmAZrjtm4XYcXCsQSuRaWZpbShBIFdFXMhoWk6tv4kfh
         e1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zMgLLB+598P0Iwp/1mLhAQ3r7/OgN8nusdD6icBCvtw=;
        b=iMfchuzmX1FeQGxKEXQu9p8z1Yg/Z9Pvz/3NIJyO5tNXYolF8yZ/v3KEp8KiqrwbuP
         wBBr2izZer60RQudq0gVfXCR9ZmgNcIvvAWZ+R8s6YxwEKzya9Wt37iaAYn3Ft5eRPzR
         Y6Z7E5D07lezibgP0kvqxCZiAPnwqKaCT8Cphqim/pfz1vTZKqeZJKbgWqlDAxGLsC+n
         yRgcTQYNFBifMgtWDk79E7saHvKO/ENv+RkquW2bMUMxqpslZDjJ1YpMltadbCY6nKoA
         d0/cwuOZv6EVhUQ35nCFwfHcDvQq5Y1JX7BcPLzZP4kXWDXQQ0IVPaHUs+fSBe1wwAa9
         g6TQ==
X-Gm-Message-State: AOAM533iB+lQjQ/IubOGxe8pYtD4D2o9rTNfbt4r040Ux5W9fm8jQCp3
        NPOMuXiBjnudJvAqheKuznQFBICrFyA=
X-Google-Smtp-Source: ABdhPJw6SThH2f9ZDJgnSwBOwc7JBbw648pryQfkzpPsmAHggWB61FjIutKLuVhBtuwMn6zv1kz0TQ==
X-Received: by 2002:adf:f546:: with SMTP id j6mr21303570wrp.167.1593518326725;
        Tue, 30 Jun 2020 04:58:46 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07? ([2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07])
        by smtp.googlemail.com with ESMTPSA id f12sm3507711wrj.48.2020.06.30.04.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 04:58:46 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] thermal: core: Add notifications call in the
 framework
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
 <20200625144509.17918-5-daniel.lezcano@linaro.org>
 <CAP245DVDMNisH1BavQuKwmxOefgG=Pw_RFBhyiecQ44g1gLZig@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1ad5743c-9405-9860-f835-6053f86b6590@linaro.org>
Date:   Tue, 30 Jun 2020 13:58:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAP245DVDMNisH1BavQuKwmxOefgG=Pw_RFBhyiecQ44g1gLZig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2020 13:49, Amit Kucheria wrote:
> On Thu, Jun 25, 2020 at 8:15 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> The generic netlink protocol is implemented but the different
>> notification functions are not yet connected to the core code.
>>
>> These changes add the notification calls in the different
>> corresponding places.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/thermal/thermal_core.c    | 21 +++++++++++++++++++++
>>  drivers/thermal/thermal_helpers.c | 11 +++++++++--
>>  drivers/thermal/thermal_sysfs.c   | 15 ++++++++++++++-
>>  3 files changed, 44 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 58c95aeafb7f..1388c03d1190 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -215,6 +215,8 @@ int thermal_zone_device_set_policy(struct thermal_zone_device *tz,
>>         mutex_unlock(&tz->lock);
>>         mutex_unlock(&thermal_governor_lock);
>>
>> +       thermal_notify_tz_gov_change(tz->id, policy);
>> +
>>         return ret;
>>  }
>>
>> @@ -406,12 +408,25 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>>  static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
>>  {
>>         enum thermal_trip_type type;
>> +       int trip_temp, hyst = 0;
>>
>>         /* Ignore disabled trip points */
>>         if (test_bit(trip, &tz->trips_disabled))
>>                 return;
>>
>> +       tz->ops->get_trip_temp(tz, trip, &trip_temp);
>>         tz->ops->get_trip_type(tz, trip, &type);
>> +       if (tz->ops->get_trip_hyst)
>> +               tz->ops->get_trip_hyst(tz, trip, &hyst);
>> +
>> +       if (tz->last_temperature != THERMAL_TEMP_INVALID) {
>> +               if (tz->last_temperature < trip_temp &&
>> +                   tz->temperature >= trip_temp)
>> +                       thermal_notify_tz_trip_up(tz->id, trip);
>> +               if (tz->last_temperature >= trip_temp &&
>> +                   tz->temperature < (trip_temp - hyst))
>> +                       thermal_notify_tz_trip_down(tz->id, trip);
>> +       }
>>
>>         if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
>>                 handle_critical_trips(tz, trip, type);
>> @@ -443,6 +458,8 @@ static void update_temperature(struct thermal_zone_device *tz)
>>         mutex_unlock(&tz->lock);
>>
>>         trace_thermal_temperature(tz);
>> +
>> +       thermal_genl_sampling_temp(tz->id, temp);
> 
> Does this need any rate limiting? How many times is update_temperature
> called on a platform with a dozen sensors?

Assuming they are all in polling mode, it is dozen messages average per
second.

If *all* sensors are doing passive cooling with 100ms, then it is around
120 messages per second in the very worst case (fast polling, all above
the trip point).

We do not need any rate limiting ATM. If we reach this limit in the
future we can improve the notification.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
