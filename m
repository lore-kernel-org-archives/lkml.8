Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2887C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB9E92074D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KxE6Q7c5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390793AbgF3Scb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729676AbgF3Scb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 14:32:31 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FD7C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 11:32:30 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w3so8116892wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 11:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GKwGZ9AjocBj0erd60dAbuHDOCvoB7srk5YN7nKTbUo=;
        b=KxE6Q7c5nSA9AuHnt62YpROogNbJ+JQuoKHRNqM/OReX9+L/BL8YZpG2p8FCtB6D7/
         dvQEZcFdXKHg83JhUuGi7TSamOQwiKB2/qyjldYvX8TZsgSLDHZALivK/EDYKHFKOFfy
         3Sn1jsvzc/61r88yOM9Zzajod7b/A068pomWP58ap33qzPI6vn57kS6YD0EgsKqP8NHP
         ue7qOPlH8nRkDAWaFa7s3yixOv6xaEK5iisbtQO4aby0AAa/CIqYopZ0YtCgSAH6MpQo
         YCGvIfijv6xZR+EoAwNX4bmD1pe0g9sPsQogKw7uaoVEbBObVYh9V4BKC/1gNb02J2EW
         VyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GKwGZ9AjocBj0erd60dAbuHDOCvoB7srk5YN7nKTbUo=;
        b=fU1z9eT/kDjIzKwijV/vakkNfd8k7f9Zfkw75H/602o/p+zznUvzwKpd/BNqJt4R5d
         OmunsqRnx7B1MxbzcLUfMtuho1OcG7tUuQ+nRYa7GEJ0ayDCCMvFA18LDndQbKW5aF8z
         DmO4HnYnL5RDCnr1nzDNAZv3N1zD118ops3vl/iDubecHbLhwcQOCXzUc+DN5sVcwznA
         4teHZGleyxR3A8BypMEQZmKzJV9FKyEz9nAfAOv9qZ5OSAQFAKDq9bcdlIunb2rsD7Gk
         pk2GJMpdX9Jg4ZbEHiVrwRJVDSfZAlfj+8w94+6zSiJGn44KwEH3TtaIWmz26XqWMDiM
         J9Ig==
X-Gm-Message-State: AOAM5327gUhffTPIgcRBxJjSb3nCeVzYYD+/ZrDyrQcZtLqNGYqd6lEc
        g6XJZqn663zSpQRIwnrG17hIrS3w/mg=
X-Google-Smtp-Source: ABdhPJxTWsKwHvfZD35jwxyAkhQ5PmqOVZdgoyUB0ioLKHnQwKLGfkVXjSfPa5alGcvxX9lzfnR7QA==
X-Received: by 2002:a1c:e355:: with SMTP id a82mr23498216wmh.165.1593541948667;
        Tue, 30 Jun 2020 11:32:28 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07? ([2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07])
        by smtp.googlemail.com with ESMTPSA id f16sm4314959wmf.17.2020.06.30.11.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 11:32:27 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] thermal: core: genetlink support for
 events/cmd/sampling
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
 <20200625144509.17918-4-daniel.lezcano@linaro.org>
 <73150ef4ca536368f087672b917dd9773417020e.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <23458be6-1e5f-7397-4935-c5268b9f52a6@linaro.org>
Date:   Tue, 30 Jun 2020 20:32:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <73150ef4ca536368f087672b917dd9773417020e.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Zhang,

thanks for taking the time to review


On 30/06/2020 18:12, Zhang Rui wrote:

[ ... ]

>> +int thermal_notify_tz_enable(int tz_id);
>> +int thermal_notify_tz_disable(int tz_id);
> 
> these two will be used after merging the mode enhancement patches from
> Andrzej Pietrasiewicz, right?

Yes, that is correct.

>> +int thermal_notify_tz_trip_down(int tz_id, int id);
>> +int thermal_notify_tz_trip_up(int tz_id, int id);
> 
>> +int thermal_notify_tz_trip_delete(int tz_id, int id);
>> +int thermal_notify_tz_trip_add(int tz_id, int id, int type,
>> +			       int temp, int hyst);
> 
> is there any case we need to use these two?
There is the initial proposal to add/del trip points via sysfs which is
not merged because of no comments and the presentation from Srinivas
giving the 'add' and 'del' notification description, so I assumed the
feature would be added soon.

These functions are here ready to be connected to the core code. If
anyone is planning to implement add/del trip point, he won't have to
implement these two notifications as they will be ready to be called.

>> +int thermal_notify_tz_trip_change(int tz_id, int id, int type,
>> +				  int temp, int hyst);
>> +int thermal_notify_cdev_update(int cdev_id, int state);
> 
> This is used when the cdev cur_state is changed.
> what about cases that cdev->max_state changes? I think we need an extra
> event for it, right?

Sure, I can add:

int thermal_notify_cdev_change(...)

>> +int thermal_notify_cdev_add(int cdev_id, const char *name,
>> +			    int min_state, int max_state);
>> +int thermal_notify_cdev_delete(int cdev_id);
> 
> These two should be used in patch 5/5.

Sure.

>> +int thermal_notify_tz_gov_change(int tz_id, const char *name);
>> +int thermal_genl_sampling_temp(int id, int temp);
>> +
> 
>  struct thermal_attr {
>>  	struct device_attribute attr;
>>  	char name[THERMAL_NAME_LENGTH];
>> diff --git a/drivers/thermal/thermal_netlink.c
>> b/drivers/thermal/thermal_netlink.c
>> new file mode 100644
>> index 000000000000..a8d6a815a21d
>> --- /dev/null
>> +++ b/drivers/thermal/thermal_netlink.c
>> @@ -0,0 +1,645 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2020 Linaro Limited
>> + *
>> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
>> + *
>> + * Generic netlink for thermal management framework
>> + */
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <net/genetlink.h>
>> +#include <uapi/linux/thermal.h>
>> +
>> +#include "thermal_core.h"
>> +
>> +static const struct genl_multicast_group thermal_genl_mcgrps[] = {
>> +	{ .name = THERMAL_GENL_SAMPLING_GROUP_NAME, },
>> +	{ .name = THERMAL_GENL_EVENT_GROUP_NAME,  },
>> +};
>> +
>> +static const struct nla_policy
>> thermal_genl_policy[THERMAL_GENL_ATTR_MAX + 1] = {
>> +	/* Thermal zone */
>> +	[THERMAL_GENL_ATTR_TZ]			= { .type =
>> NLA_NESTED },
>> +	[THERMAL_GENL_ATTR_TZ_ID]		= { .type = NLA_U32 },
>> +	[THERMAL_GENL_ATTR_TZ_TEMP]		= { .type = NLA_U32
>> },
>> +	[THERMAL_GENL_ATTR_TZ_TRIP]		= { .type =
>> NLA_NESTED },
>> +	[THERMAL_GENL_ATTR_TZ_TRIP_ID]		= { .type = NLA_U32
>> },
>> +	[THERMAL_GENL_ATTR_TZ_TRIP_TEMP]	= { .type = NLA_U32 },
>> +	[THERMAL_GENL_ATTR_TZ_TRIP_TYPE]	= { .type = NLA_U32 },
>> +	[THERMAL_GENL_ATTR_TZ_TRIP_HYST]	= { .type = NLA_U32 },
>> +	[THERMAL_GENL_ATTR_TZ_MODE]		= { .type = NLA_U32
>> },
>> +	[THERMAL_GENL_ATTR_TZ_CDEV_WEIGHT]	= { .type = NLA_U32
>> },
>> +	[THERMAL_GENL_ATTR_TZ_NAME]		= { .type =
>> NLA_STRING,
>> +						    .len =
>> THERMAL_NAME_LENGTH },
>> +	/* Governor(s) */
>> +	[THERMAL_GENL_ATTR_TZ_GOV]		= { .type =
>> NLA_NESTED },
>> +	[THERMAL_GENL_ATTR_TZ_GOV_NAME]		= { .type =
>> NLA_STRING,
>> +						    .len =
>> THERMAL_NAME_LENGTH },
>> +	/* Cooling devices */
>> +	[THERMAL_GENL_ATTR_CDEV]		= { .type = NLA_NESTED },
>> +	[THERMAL_GENL_ATTR_CDEV_ID]		= { .type = NLA_U32
>> },
>> +	[THERMAL_GENL_ATTR_CDEV_CUR_STATE]	= { .type = NLA_U32
>> },
>> +	[THERMAL_GENL_ATTR_CDEV_MAX_STATE]	= { .type = NLA_U32
>> },
>> +	[THERMAL_GENL_ATTR_CDEV_MIN_STATE]	= { .type = NLA_U32
>> },
> 
> is there any case that min_state does not equal 0?

You are right, there is no min state for a cooling device, only for the
instances in the thermal zones. I will fix that.

>> +	[THERMAL_GENL_ATTR_CDEV_NAME]		= { .type =
>> NLA_STRING,
>> +						    .len =
>> THERMAL_NAME_LENGTH },
>> +};
>> +
> 
> [...]
>> +
>> +static cb_t cmd_cb[] = {
>> +	[THERMAL_GENL_CMD_TZ_GET]	= thermal_genl_cmd_tz_get,
> 
>> +	[THERMAL_GENL_CMD_TZ_GET_TRIP]	=
>> thermal_genl_cmd_tz_get_trip,
>> +	[THERMAL_GENL_CMD_TZ_GET_TEMP]	=
>> thermal_genl_cmd_tz_get_temp,
>> +	[THERMAL_GENL_CMD_TZ_GET_GOV]	=
>> thermal_genl_cmd_tz_get_gov,
> 
> A dumb question, can we share the same command for the above three?
> Say,
> THERMAL_GENL_CMD_GET_ALL_TZ or THERMAL_GENL_CMD_GET_TZS returns the id
> && name of all the thermal zones.
> THERMAL_GENL_CMD_GET_TZ returns general information of a specified
> thermal zone, include trip points, governor and temperature. My
> understanding is that all these information will be queried once, in
> the very beginning, and then userpsace relies on the netlink events to
> give updated information, right?
> 
> This could simplify the kernel code and also userspace a bit.

Actually the userspace still need a 'get temp' or 'get trip' commands.

get temp : Get the temperature at any time, like reading the sysfs
temperature

get trip : Get the trip point information when a trip event happens, no
need to get a full discovery of the thermal zones before.

If I send a bulk message containing all the thermal zones, their trips
point, the governors and the cooling devices, that will force the
userspace to deal with multiple level of nested arrays. With netlinks
that makes the code really more complicated and prone to errors.

With this approach, if the userspace is interested only on "gpu", it can
get the thermal zone id when getting all the thermal zones <id, name>
and then ask for the information it is interested in.

Well I thought that is be more flexible.





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
