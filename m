Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631D0C54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 399A0207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HwcsLLuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbgELI02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 04:26:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20766 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726187AbgELI00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 04:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589271984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n8nO5fHZLrM6PQkaLb7BJDAZwymlyJdLzlZKx/2lNbQ=;
        b=HwcsLLuF2JvT72HKHqfJxckrTf0n04c1kuduNCJtdJqt9tnNnNg9TQLkOe2jIuKkvhCFeH
        X9IyIPgEEtt2dZ7y/wh76n1v4zO+JUwmJiHxdJZD1y54YSpQFl2WqmhNXLSA4fILxdUp5G
        qAXEPY9RsEUd2SXRJcd80+6VH2eYZAA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-7rC_M227OXmVC4CtepIspw-1; Tue, 12 May 2020 04:26:23 -0400
X-MC-Unique: 7rC_M227OXmVC4CtepIspw-1
Received: by mail-wm1-f70.google.com with SMTP id q5so9605756wmc.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 01:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n8nO5fHZLrM6PQkaLb7BJDAZwymlyJdLzlZKx/2lNbQ=;
        b=SvWm+ra8aaS6NTJPRkxROQKNtXrrtU/err6bhubtZDZRx6MvXeGbJ/oJ9hnu5BhHiD
         fwT7OyZr8Stx7zVDdmi2uEwFPoQvoLTOQ9MH9HspDwyNSZY/gl+UIvY9bKr/JPLRXZzl
         HtjdtJIduSh7MlKUb7j8X25s8I6y40MXFffoxwC5DHWJSkRVyLAwKn6VyVJPjE2PrANz
         rnlOUdfV7VFn1lM5/SYxuaNpWWYqE55xEFaHOUXCSz67AbacFqZQt2GUxwq4toOeJ3AP
         z4kM090IFHjpZ2TYAvsdEC1qx7LpbYJSYuJrWXD7Bz0HDmqktYVvyG5uSiUr7sX6lICE
         HL+w==
X-Gm-Message-State: AGi0PuYRBCPKlY2XI9CWYB0Uv2HddW2a96ZC1Fg4rxZEG+5526btejsu
        vQkZRBun5nYhZdotbqD6mtRtELDwgoKv9f1JMuZ5dkluxZyILrtTT9lOvEz44l2klKyeUs1cyAc
        Le8DCvmOV7EmnUQUDVYfw7cAR
X-Received: by 2002:adf:e951:: with SMTP id m17mr17948599wrn.352.1589271981664;
        Tue, 12 May 2020 01:26:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypJaP1MQDVNSlNDB+rfcXseLw/jvYwxAe7dLaeN9+oNEFlGNo3DJhrTWQZYK/JV1Zy235MDWlw==
X-Received: by 2002:adf:e951:: with SMTP id m17mr17948573wrn.352.1589271981411;
        Tue, 12 May 2020 01:26:21 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id m7sm7453572wmc.40.2020.05.12.01.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 01:26:20 -0700 (PDT)
Subject: Re: [PATCH v4 10/11] iio: light: cm32181: Add support for parsing
 CPM0 and CPM1 ACPI tables
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20200504125551.434647-1-hdegoede@redhat.com>
 <20200504125551.434647-10-hdegoede@redhat.com>
 <20200511202023.45f2d130@archlinux>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7dc53183-d3e8-3437-5ac2-a5b74dea643e@redhat.com>
Date:   Tue, 12 May 2020 10:26:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200511202023.45f2d130@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/11/20 9:20 PM, Jonathan Cameron wrote:
> On Mon,  4 May 2020 14:55:50 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> On ACPI based systems the CPLM3218 ACPI device node describing the
>> CM3218[1] sensor typically will have some extra tables with register
>> init values for initializing the sensor and calibration info.
>>
>> This is based on a newer version of cm32181.c, with a copyright of:
>>
>>   * Copyright (C) 2014 Capella Microsystems Inc.
>>   * Author: Kevin Tsai <ktsai@capellamicro.com>
>>   *
>>   * This program is free software; you can redistribute it and/or modify it
>>   * under the terms of the GNU General Public License version 2, as published
>>   * by the Free Software Foundation.
>>
>> Which is floating around on the net in various places, but the changes
>> from this newer version never made it upstream.
>>
>> This was tested on the following models: Acer Switch 10 SW5-012 (CM32181)
>> Asus T100TA (CM3218), Asus T100CHI (CM3218) and HP X2 10-n000nd (CM32181).
>>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Tiny thing 0-day picked up that I've just fixed and pushed out.
> 
>> ---
>> Changes in v2:
>> - Factor out the parsing into a separate helper function
>> ---
>>   drivers/iio/light/cm32181.c | 101 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 101 insertions(+)
>>
>> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
>> index a0812e3cba9b..5eeefa3ee4f1 100644
>> --- a/drivers/iio/light/cm32181.c
>> +++ b/drivers/iio/light/cm32181.c
>> @@ -4,6 +4,7 @@
>>    * Author: Kevin Tsai <ktsai@capellamicro.com>
>>    */
>>   
>> +#include <linux/acpi.h>
>>   #include <linux/delay.h>
>>   #include <linux/err.h>
>>   #include <linux/i2c.h>
>> @@ -53,6 +54,15 @@
>>   
>>   #define SMBUS_ALERT_RESPONSE_ADDRESS	0x0c
>>   
>> +/* CPM0 Index 0: device-id (3218 or 32181), 1: Unknown, 2: init_regs_bitmap */
>> +#define CPM0_REGS_BITMAP		2
>> +#define CPM0_HEADER_SIZE		3
>> +
>> +/* CPM1 Index 0: lux_per_bit, 1: calibscale, 2: resolution (100000) */
>> +#define CPM1_LUX_PER_BIT		0
>> +#define CPM1_CALIBSCALE			1
>> +#define CPM1_SIZE			3
>> +
>>   struct cm32181_chip_info {
>>   	const char *name;
>>   	const int *als_it_bits;
>> @@ -61,6 +71,7 @@ struct cm32181_chip_info {
>>   };
>>   
>>   struct cm32181_chip {
>> +	struct device *dev;
>>   	struct i2c_client *client;
>>   	const struct cm32181_chip_info *info;
>>   	struct mutex lock;
>> @@ -95,6 +106,92 @@ const struct cm32181_chip_info cm32181_chip_info = {
>>   	.num_als_it = ARRAY_SIZE(cm32181_als_it_bits),
>>   };
>>   
>> +static int cm32181_read_als_it(struct cm32181_chip *cm32181, int *val2);
>> +
>> +#ifdef CONFIG_ACPI
>> +/**
>> + * cm32181_acpi_get_cpm() - Get CPM object from ACPI
>> + * @client	pointer of struct i2c_client.
>> + * @obj_name	pointer of ACPI object name.
>> + * @count	maximum size of return array.
>> + * @vals	pointer of array for return elements.
>> + *
>> + * Convert ACPI CPM table to array.
>> + *
>> + * Return: -ENODEV for fail.  Otherwise is number of elements.
>> + */
>> +static int cm32181_acpi_get_cpm(struct device *dev, char *obj_name,
>> +				u64 *values, int count)
>> +{
>> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>> +	union acpi_object *cpm, *elem;
>> +	acpi_handle handle;
>> +	acpi_status status;
>> +	int i;
>> +
>> +	handle = ACPI_HANDLE(dev);
>> +	if (!handle)
>> +		return -ENODEV;
>> +
>> +	status = acpi_evaluate_object(handle, obj_name, NULL, &buffer);
>> +	if (ACPI_FAILURE(status)) {
>> +		dev_err(dev, "object %s not found\n", obj_name);
>> +		return -ENODEV;
>> +	}
>> +
>> +	cpm = buffer.pointer;
>> +	if (cpm->package.count > count)
>> +		dev_warn(dev, "%s table contains %d values, only using first %d values\n",
>> +			 obj_name, cpm->package.count, count);
> 
> cpm->package.count is unsigned.

Ok, thank you for letting me know.

Regards,

Hans




