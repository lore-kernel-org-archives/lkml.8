Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E48C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 316CB215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="azMdh4tc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbgIIQLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbgIIQHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:07:55 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC96C061367
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 07:10:00 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s12so3104808wrw.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 07:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AqdCvXthY64M0/BgH+IgO4cFQky1yop2f9gBjmeTzIo=;
        b=azMdh4tcatk3h2bNwuMv8KW2hiBxo01r6sZN+Y96c4MLNjFQfR0t+Wl3xOHJVaYwnp
         fG7zz7yRlCMKv+SvjUWBHEoiP99bK5xI2/ACJzcsue6LVeXzuHXzZ9yVWh8JIGS+L70Q
         dpBwgWa3h9E27uF5zzzhK9uo9F59usK2vq3oLEWU3TAHeu0c8nYQHXHFE1AhirII4j72
         J1VaGxv5vKWkZTKzRFNAS0NcaisGUEno0XdInD1Ed3FBJ37KG/JaCxS9RkU+mbBV14iu
         hLPId/z8KKiZAqmhZ2U+g91+oS/W9WD5kL+aXMG1NqcB6aNSYGEWO6isiK9LPkvM+SqS
         ZUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AqdCvXthY64M0/BgH+IgO4cFQky1yop2f9gBjmeTzIo=;
        b=WdGVQQeCup1tDjTPiDo6VdG32KKI1Hm7fN7Jwa4JScnUrZhV7zLRUGQEZjSXjhI/xw
         15BHirpk1SwiYaPWyFfVI+XaHBk1N8SobwdJUWVUouoPb8EbL/N6uClvaaGCwmhbOBRW
         hwvEs5M0l9NLPg1suR9kyZsmd5xbsLqFFwYF8jmQ59NSz0UOOsL9WA3U2vpdJ2tELx5b
         iPXZUOVt3k2woSO0LbtqnCCxhQQFiKfQxqDnFYgPnvZSydNnBudOaZs0ubYWoPLC2EHr
         4hmyOMMNxSnYeuFEHHhFfmK83WlnUfNBlFHj/kI0R/7ZELbak1golX4fxXXxRWimoj0n
         Qh7A==
X-Gm-Message-State: AOAM5305445Tc4RbDvVv6q7v7Z4OZcvoHkyh/hHxFgUw3bFTeEebzjv5
        t3Yau0mEuXEHF2WlRkulJ3r++yrRnMVGew==
X-Google-Smtp-Source: ABdhPJxJQB3ifjMaYxPOuJSRUQxdrttYTOXb6TsYOI5JQTv4Nv/vhFgnCG76XhgUp0LkxT1Hn+WFNw==
X-Received: by 2002:adf:e7ce:: with SMTP id e14mr3965390wrn.43.1599660598943;
        Wed, 09 Sep 2020 07:09:58 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id n14sm2894195wmi.33.2020.09.09.07.09.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 07:09:58 -0700 (PDT)
Subject: Re: [PATCH] soundwire: bus: add enumerated slave to device list
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     sanyog.r.kale@intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20200909082711.11670-1-srinivas.kandagatla@linaro.org>
 <80081c70-9137-c9f0-9813-8166275ef7af@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ab107351-dbde-7f6d-c588-11572aed5d2d@linaro.org>
Date:   Wed, 9 Sep 2020 15:09:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <80081c70-9137-c9f0-9813-8166275ef7af@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/09/2020 14:37, Pierre-Louis Bossart wrote:
> 
> 
> On 9/9/20 3:27 AM, Srinivas Kandagatla wrote:
>> Currently slave devices are only added either from device tree or acpi
>> entries. However lets say, there is wrong or no entry of a slave device
>> in DT that is enumerated, then there is no way for user to know all
>> the enumerated devices on the bus.
> 
> Sorry Srinivas, I don't understand your point.
> 
> The sysfs entries will include all devices that are described in 
> platform firmware (be it DT or ACPI).

yes that is true, but it will not include all the enumerated devices on 
the bus!

In my case on a new board I was trying to figure out what devices are on 
the bus even before even adding any device tree entries!

In second case I had a typo in the device tree entry and sysfs displayed 
devices with that typo rather than actual enumerated device id.

> 
> If you add to sysfs entries unknown devices which happen to be present 
> on the bus, then what? How would you identify them from the devices that 
> are described in firmware?

Both of them should be displayed in sysfs, core should be able to 
differentiate this based on the presence of fw_node or of_node and not bind!

> 
> Also the sysfs entries describe properties, but if you haven't bound a 
> driver then how would this work?

This is would be informative, atleast in cases like me!

All I want to know is the list of enumerated devices on the bus, If 
doing this way is not the right thing, then am happy to try any suggestion!

For now I have managed to figure out enumerated device ids on the bus 
with this patch, I was hoping that other people would also hit such 
issue, so I sent this patch!


thanks,
srini
> 
> I really feel this deserves more explanations on the problem statement 
> and what you are hoping to achieve in this case.
> 
> Thanks!
> 
>>
>> To fix this add slave device by default if there is no matching dt or
>> acpi entry, so that we can see this in sysfs entry.
>>
>> In my case I had a wrong address entry in DT, However I had no way to
>> know what devices are actually enumerated on the bus!
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/soundwire/bus.c      | 1 +
>>   drivers/soundwire/bus.h      | 2 ++
>>   drivers/soundwire/bus_type.c | 6 ++++++
>>   drivers/soundwire/slave.c    | 4 ++--
>>   4 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
>> index e6e0fb9a81b4..55d9c22c4ec5 100644
>> --- a/drivers/soundwire/bus.c
>> +++ b/drivers/soundwire/bus.c
>> @@ -699,6 +699,7 @@ static int sdw_program_device_num(struct sdw_bus 
>> *bus)
>>           if (!found) {
>>               /* TODO: Park this device in Group 13 */
>> +            sdw_slave_add(bus, &id, NULL);
>>               dev_err(bus->dev, "Slave Entry not found\n");
>>           }
>> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
>> index 82484f741168..1517d6789dff 100644
>> --- a/drivers/soundwire/bus.h
>> +++ b/drivers/soundwire/bus.h
>> @@ -19,6 +19,8 @@ static inline int sdw_acpi_find_slaves(struct 
>> sdw_bus *bus)
>>   int sdw_of_find_slaves(struct sdw_bus *bus);
>>   void sdw_extract_slave_id(struct sdw_bus *bus,
>>                 u64 addr, struct sdw_slave_id *id);
>> +int sdw_slave_add(struct sdw_bus *bus, struct sdw_slave_id *id,
>> +          struct fwnode_handle *fwnode);
>>   int sdw_master_device_add(struct sdw_bus *bus, struct device *parent,
>>                 struct fwnode_handle *fwnode);
>>   int sdw_master_device_del(struct sdw_bus *bus);
>> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
>> index 6fba55898cf0..ac036223046f 100644
>> --- a/drivers/soundwire/bus_type.c
>> +++ b/drivers/soundwire/bus_type.c
>> @@ -84,6 +84,12 @@ static int sdw_drv_probe(struct device *dev)
>>       const struct sdw_device_id *id;
>>       int ret;
>> +    /*
>> +     * fw description is mandatory to bind
>> +     */
>> +    if (!dev->fwnode || !dev->of_node)
>> +        return -ENODEV;
>> +
>>       id = sdw_get_device_id(slave, drv);
>>       if (!id)
>>           return -ENODEV;
>> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
>> index 0839445ee07b..24a16ebf9ae2 100644
>> --- a/drivers/soundwire/slave.c
>> +++ b/drivers/soundwire/slave.c
>> @@ -20,8 +20,8 @@ struct device_type sdw_slave_type = {
>>       .uevent =    sdw_slave_uevent,
>>   };
>> -static int sdw_slave_add(struct sdw_bus *bus,
>> -             struct sdw_slave_id *id, struct fwnode_handle *fwnode)
>> +int sdw_slave_add(struct sdw_bus *bus,
>> +          struct sdw_slave_id *id, struct fwnode_handle *fwnode)
>>   {
>>       struct sdw_slave *slave;
>>       int ret;
>>
