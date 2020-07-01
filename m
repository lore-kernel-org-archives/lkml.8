Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEAEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4274C20775
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ehk8QxCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgGAIWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbgGAIWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:22:52 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1BBC061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:22:52 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a6so22863523wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fqNKcNDWBO1tiQLOFziaLK2OkzYUszDxX893hoiiz9o=;
        b=Ehk8QxCeHB/mnCJXzEK1P5FNNLtj8uiSRIKn1ej3tkK+nKRnj1tyBrFkoUAtC+JYFB
         bmlL2IMxo4b3fNk/aNzlBBdxoQtj7WjjtrjqZ16qH960MHcw/yxusCVLnJQHzcGG7XrR
         hkw7xIgs1SRuBwGg6xDfUxd5AXpIdaL7Jim7NLYE4XQ94EtsVbDehcv5j3ZSDNJlWNCK
         0pdT0/zn9oZoFvocVAA3j2c/kLXdL+SLUf63mmeoqvMU2A0AtCUmpp9S66teTW1jnDGB
         RudZwLiDChBHm7QXBZAlka2rkApynpTa3qbc5YQPpDpoM1XeIkdPCoztmLykKnaqOi0b
         gwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fqNKcNDWBO1tiQLOFziaLK2OkzYUszDxX893hoiiz9o=;
        b=km10cj1Zy2TMXoizTEegpGjQ976OS47zvq5tQDciZ0lcR7P6LaJTB27IVGXDu3+Kwy
         +xZd3WtCis3STFBWwSXBODa/5Yb2MPbJIvAtcMgejM5sVUtAQqwN4qiHfnXp5S6ImFdm
         WVJnGskxXGgtf9QvY6rwUjeh5ZiChq0tgJrOqyGJdm4883E3sGzN2E38oesqsGAMRXXf
         8JC99PZ4rpMizL66saga85f3kxn4cJxJuABa2iotJLAHt9EA2IcuO5K9nuSs50uQUEyt
         7v8Li7YTWRnoIbQUFdW4V8yJ2tKtu4rduN8RuRUkuSAYIj1c8JeH5GDq2Dvax/OSauGz
         6vBw==
X-Gm-Message-State: AOAM532lGyGFMUdEDqe+p4xwuv9WJ1EpMXedFI1CpvktTfl4Xq7LZS/L
        HUdNbbV3rJavTz6ZFruA112RGGnnlR4=
X-Google-Smtp-Source: ABdhPJyEwEOBEK9Wfs4bAhcC2E5e73b5MTuRD/jKeJpE3uGcviUsWhu3GgN6BcFL1tFqYpOIXyN7Lg==
X-Received: by 2002:a5d:688c:: with SMTP id h12mr25108563wru.212.1593591770614;
        Wed, 01 Jul 2020 01:22:50 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07? ([2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07])
        by smtp.googlemail.com with ESMTPSA id c65sm6179920wme.8.2020.07.01.01.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 01:22:50 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] thermal: core: genetlink support for
 events/cmd/sampling
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
 <20200625144509.17918-4-daniel.lezcano@linaro.org>
 <73150ef4ca536368f087672b917dd9773417020e.camel@intel.com>
 <23458be6-1e5f-7397-4935-c5268b9f52a6@linaro.org>
 <171936e84c416d7647756d9b453ef2d4475ebdc8.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ac55475f-7c38-399f-b710-a671074f577d@linaro.org>
Date:   Wed, 1 Jul 2020 10:22:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <171936e84c416d7647756d9b453ef2d4475ebdc8.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2020 09:41, Zhang Rui wrote:
> Hi, Daniel,
> 
> On Tue, 2020-06-30 at 20:32 +0200, Daniel Lezcano wrote:
>> Hi Zhang,
>>
>> thanks for taking the time to review
>>
>>
>> On 30/06/2020 18:12, Zhang Rui wrote:
>>
>> [ ... ]
>>
>>>> +int thermal_notify_tz_enable(int tz_id);
>>>> +int thermal_notify_tz_disable(int tz_id);
>>>
>>> these two will be used after merging the mode enhancement patches
>>> from
>>> Andrzej Pietrasiewicz, right?
>>
>> Yes, that is correct.
>>
>>>> +int thermal_notify_tz_trip_down(int tz_id, int id);
>>>> +int thermal_notify_tz_trip_up(int tz_id, int id);
>>>> +int thermal_notify_tz_trip_delete(int tz_id, int id);
>>>> +int thermal_notify_tz_trip_add(int tz_id, int id, int type,
>>>> +			       int temp, int hyst);
>>>
>>> is there any case we need to use these two?
>>
>> There is the initial proposal to add/del trip points via sysfs which
>> is
>> not merged because of no comments and the presentation from Srinivas
>> giving the 'add' and 'del' notification description, so I assumed the
>> feature would be added soon.
>>
>> These functions are here ready to be connected to the core code. If
>> anyone is planning to implement add/del trip point, he won't have to
>> implement these two notifications as they will be ready to be called.
>>
> Then I'd prefer we only introduce the events that are used or will be
> used soon, like the tz disable/enable, to avoid some potential dead
> code.
> We can easily add more events when they are needed.

Sure, if Srinivas does not need them, I can drop these notifications.

However, I would suggest to keep at the uapi header file with the
definition of the events and the attributes in order to reduce the
impact of the userspace change when adding these two notifications in
the future.

> Srinivas, do you have plan to use the trip add/delete events?
> 
>>>> +int thermal_notify_tz_trip_change(int tz_id, int id, int type,
>>>> +				  int temp, int hyst);
>>>> +int thermal_notify_cdev_update(int cdev_id, int state);
>>>
>>> This is used when the cdev cur_state is changed.
>>> what about cases that cdev->max_state changes? I think we need an
>>> extra
>>> event for it, right?
>>
>> Sure, I can add:
>>
>> int thermal_notify_cdev_change(...)
> 
> thermal_notify_cdev_change() and thermal_notify_cdev_update() looks
> confusing to me.
> Can we use thermal_notify_cdev_update_cur() and
> thermal_notify_cdev_update_max()?
> Or can we use one event, with updated cur_state and max_state?

I think it is a good idea to use the same event and depending on the
change we can add the cur_state or the max_state attribute. Up to the
userspace to figure out which one is present.

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
