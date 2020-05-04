Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203A2C47247
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B0020658
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqvH+Rnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgEDJwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 05:52:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54251 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728421AbgEDJwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 05:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588585971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MBb6wDVPhgzIGexiHrJFGmv6UayYZW4W2kAvtUWACtM=;
        b=PqvH+Rnzg8v8cVxf5smD5E1z2Po/KVpd82LeNAEy9adbpduyRypcmSN/2TCC/EwPc/H+8Q
        ONmpdkyXSb+EaFRo5Ee5meNbph3c+95vgYvTp7X2xCG4MOSAv5g6ieQPawrvRyAKhxjxH9
        OOVhCFGZ4SjoWIkoP/ROdE1r42GFGWs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-PwY9YlVxPSuXPg26Ft8YVQ-1; Mon, 04 May 2020 05:52:49 -0400
X-MC-Unique: PwY9YlVxPSuXPg26Ft8YVQ-1
Received: by mail-wr1-f71.google.com with SMTP id z8so3327777wrp.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 02:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MBb6wDVPhgzIGexiHrJFGmv6UayYZW4W2kAvtUWACtM=;
        b=WrKyMt8YZaf5Twv+C/K4br7H5y8xbyIP/Zz8Pf8y7DQ6VMbBeKSrJtF98oMaKIHcQV
         XIqJbGQWdtxlZJun723QjAe97WLppVZxpZNf80HkyjpTr/wc3y18M7vwL+WqNgSQ2XKL
         b/1XXzMDgDOiGDHq7Zs6MQmx0QtfipUW1pYHLUK+HSsP6on8kZN43i2AtbBoFB5nA0Y3
         nk7GoprBmYYaX79wzjZ+NBZP01AojKiEbc4y3Q7i9UdrUQgvKEuOvNFWIK4P0DWxdqBg
         /tLb6gBn3r5yCKXxR43LnjBlFVjyy64RPqzDMFtG0hN6FrEu/z4lGcKMDGyHsmbvg3GE
         W3lw==
X-Gm-Message-State: AGi0PuaQDEpmnH32R4a8ST2BVx8VEmNTjhVi+BlHH3PpaQ0weaEulvrv
        IavlfeTNkVnX9XOyQbNALzzBg8ye13FGCcrmTI3Y37LH9DoGxH7FpF6qS2zRehZlb911WaZRSbt
        cfhjdUy0X3/RHwjhJRTHu7uHO
X-Received: by 2002:a1c:64c5:: with SMTP id y188mr13420916wmb.130.1588585967898;
        Mon, 04 May 2020 02:52:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypLFiTL7rOTi2RC/bwg4dqNbtsVsVTe6AoK9p8QOHZI567WWIZjAGHPz3V7F4OWUGM2QUS2ydw==
X-Received: by 2002:a1c:64c5:: with SMTP id y188mr13420902wmb.130.1588585967665;
        Mon, 04 May 2020 02:52:47 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id d9sm1977062wrg.60.2020.05.04.02.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 02:52:47 -0700 (PDT)
Subject: Re: [PATCH v3 06/11] iio: light: cm32181: Handle CM3218 ACPI devices
 with 2 I2C resources
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <20200428172923.567806-1-hdegoede@redhat.com>
 <20200428172923.567806-6-hdegoede@redhat.com>
 <20200503120439.113d2cd2@archlinux>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <447a98f7-ef54-98a9-6ac2-c6132a4b5b7d@redhat.com>
Date:   Mon, 4 May 2020 11:52:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200503120439.113d2cd2@archlinux>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/3/20 1:04 PM, Jonathan Cameron wrote:
> On Tue, 28 Apr 2020 19:29:18 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Some ACPI systems list 2 I2C resources for the CM3218 sensor. On these
>> systems the first I2cSerialBus ACPI-resource points to the SMBus Alert
>> Response Address (ARA, 0x0c) and the second I2cSerialBus ACPI-resource
>> points to the actual CM3218 sensor address:
>>
>>   Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>>   {
>>       Name (SBUF, ResourceTemplate ()
>>       {
> 
> I have a vague recollection that we had case of this where they could
> come in either order.  Could that happen here?

Not to the best of my knowledge. I've only seen this
construct on a couple of Asus models and they are all consistent.

> My mind may be playing tricks on me of course and that may never
> happen...
> 
> Did I ever mention how much the lack of spec for some of these corner
> cases annoys me?

Yes I think you have mentioned before. Unfortunately there
is nothing we can do about this, but I hear you.

Regards,

Hans


> 
> J
> 
>>           I2cSerialBusV2 (0x000C, ControllerInitiated, 0x00061A80,
>>               AddressingMode7Bit, "\\_SB.I2C3",
>>               0x00, ResourceConsumer, , Exclusive,
>>               )
>>           I2cSerialBusV2 (0x0048, ControllerInitiated, 0x00061A80,
>>               AddressingMode7Bit, "\\_SB.I2C3",
>>               0x00, ResourceConsumer, , Exclusive,
>>               )
>>           Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
>>           {
>>               0x00000033,
>>           }
>>       })
>>       Return (SBUF) /* \_SB_.I2C3.ALSD._CRS.SBUF */
>>   }
>>
>> Detect this and take the following step to deal with it:
>>
>> 1. When a SMBus Alert capable sensor has an Alert asserted, it will
>>     not respond on its actual I2C address. Read a byte from the ARA
>>     to clear any pending Alerts.
>>
>> 2. Create a "dummy" client for the actual I2C address and
>>     use that client to communicate with the sensor.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v3:
>> - Create and use a dummy client instead of relying on i2c-multi-instantiate
>>    to create 2 separate clients for the 2 I2C resources
>>
>> Changes in v2
>> - s/i2c_client-s/I2C clients/ in added comment
>> ---
>>   drivers/iio/light/cm32181.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
>> index 8fe49610fc26..c23a5c3a86a3 100644
>> --- a/drivers/iio/light/cm32181.c
>> +++ b/drivers/iio/light/cm32181.c
>> @@ -51,6 +51,8 @@
>>   #define CM32181_CALIBSCALE_RESOLUTION	1000
>>   #define MLUX_PER_LUX			1000
>>   
>> +#define SMBUS_ALERT_RESPONSE_ADDRESS	0x0c
>> +
>>   static const u8 cm32181_reg[CM32181_CONF_REG_NUM] = {
>>   	CM32181_REG_ADDR_CMD,
>>   };
>> @@ -335,6 +337,26 @@ static int cm32181_probe(struct i2c_client *client)
>>   	if (!indio_dev)
>>   		return -ENOMEM;
>>   
>> +	/*
>> +	 * Some ACPI systems list 2 I2C resources for the CM3218 sensor, the
>> +	 * SMBus Alert Response Address (ARA, 0x0c) and the actual I2C address.
>> +	 * Detect this and take the following step to deal with it:
>> +	 * 1. When a SMBus Alert capable sensor has an Alert asserted, it will
>> +	 *    not respond on its actual I2C address. Read a byte from the ARA
>> +	 *    to clear any pending Alerts.
>> +	 * 2. Create a "dummy" client for the actual I2C address and
>> +	 *    use that client to communicate with the sensor.
>> +	 */
>> +	if (ACPI_HANDLE(dev) && client->addr == SMBUS_ALERT_RESPONSE_ADDRESS) {
>> +		struct i2c_board_info board_info = { .type = "dummy" };
>> +
>> +		i2c_smbus_read_byte(client);
>> +
>> +		client = i2c_acpi_new_device(dev, 1, &board_info);
>> +		if (IS_ERR(client))
>> +			return PTR_ERR(client);
>> +	}
>> +
>>   	cm32181 = iio_priv(indio_dev);
>>   	cm32181->client = client;
>>   
> 

