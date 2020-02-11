Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593C0C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 05:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AD720714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 05:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRcL34Yp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgBKFet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 00:34:49 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39600 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbgBKFet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 00:34:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so3792965plp.6;
        Mon, 10 Feb 2020 21:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ivadewsFdljPKGgU8zY4G8R57cGYgDgWlBvWXEKzAk8=;
        b=WRcL34YpFhKvEhmAs+B/RESDqWjwcWMz8lCgo/B0eJ/px8jJfcOsAAnBn0ZyjiYztY
         NjvtYiZdGAAAoW4COS6IYItdOpi1kgWK9K5V11YOW0xOKfVHCnBeitTX9uC0/cqSMiOW
         +aT/ESgRn8mM56yQ9EacljRZiuWhswR15mHBVkCIEZlUPFPKL6u4uhfD2+Ta8Myeyh3V
         iIV+/vP3D4ZHh5yzbuucmm417Ff+LSQU2zSFCadPtticprLThkll7vLB3qYZRo+yzwds
         FStjEA1DwnO/jO9vQyU+y5FQZ9lcoS5yO8Ty3+DJf7ei7kSyc1Z2/YHEPijKvWWEYvn7
         8LOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ivadewsFdljPKGgU8zY4G8R57cGYgDgWlBvWXEKzAk8=;
        b=Ngr662Q2dsc0Nsi83Y/y2xUx5ofOHXtDGqutzf9txPvCyAnPAr0omdKLuy8IaQ64yy
         e89abCN6PpWtoVrZdJrai/rZTsRM7NTNgbKaZWnGEf+fnZvtXHPno3ZkI/kEnDH4uhQR
         Z9zxPUcOB/EBz4J4g88YvURMpNCgcxQLTqnIlTj+Naeq5jxp2iGNjzvISTdyQzgZiyML
         tqqrtRM7dfVeTH3eeCsShZhxlAfeUbkcmrCDADndYsEM9U3c8hGIwvcyVyyH3HXt3xKz
         d3dp4vH+ukwrimXNrFA5e8stf0Wnpm3c+Vm0VEpgP3EPAvWNkwjoQS/38tqLXIBdI+GD
         dlHw==
X-Gm-Message-State: APjAAAWTg5VIV73p9JNm9pv77JHbIXYfDx9fVk7mvQUZODkBGcpbJEML
        fkNmL+iO6EpecCEJhlBydcnXY/xy
X-Google-Smtp-Source: APXvYqxdhKVDwDg+5C9klb9SpcQTYKd5ePu6gQaZRlHUE6kbf8rZWVTHYeua1QweeaJuPUqFcmyRlA==
X-Received: by 2002:a17:902:7c85:: with SMTP id y5mr1514512pll.227.1581399288180;
        Mon, 10 Feb 2020 21:34:48 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d4sm1188283pjg.19.2020.02.10.21.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 21:34:47 -0800 (PST)
Subject: Re: [PATCH] hwmon: (lm73) Add support for of_match_table
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "guillaume.ligneul@gmail.com" <guillaume.ligneul@gmail.com>,
        Henry Shen <Henry.Shen@alliedtelesis.co.nz>,
        "jdelvare@suse.com" <jdelvare@suse.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
References: <20200205010657.29483-1-henry.shen@alliedtelesis.co.nz>
 <20200205010657.29483-2-henry.shen@alliedtelesis.co.nz>
 <44032203aa33817430cd120ddd540ec0baaa5f2d.camel@alliedtelesis.co.nz>
 <e8c2b347-5af2-e48c-0f9d-2a6860171171@roeck-us.net>
 <dfae85e86f5a75b462f4cc23a158f608ef368685.camel@alliedtelesis.co.nz>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c8ed3023-3b99-fac7-8857-33c253c5f9b4@roeck-us.net>
Date:   Mon, 10 Feb 2020 21:34:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <dfae85e86f5a75b462f4cc23a158f608ef368685.camel@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/20 6:32 PM, Chris Packham wrote:
> On Mon, 2020-02-10 at 18:30 -0800, Guenter Roeck wrote:
>> On 2/10/20 6:21 PM, Chris Packham wrote:
>>> On Wed, 2020-02-05 at 14:06 +1300, Henry Shen wrote:
>>>> Add the of_match_table.
>>>
>>> Needs your Signed-off-by line.
>>>
>>
>> ti,lm73 would also have to be documented as trivial device.
>>
> 
> Yes there's another patch for that. I'll work with Henry to send a v2
> series instead of individual patches.
> 
DT patches need to be separate patches, or you'll get a complaint from Rob.

On a side note, I don't see the actual patch on hwmon's patchwork,
and I don't recall being copied on it.

Guenter

>> Guenter
>>
>>>> ---
>>>>    drivers/hwmon/lm73.c | 10 ++++++++++
>>>>    1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
>>>> index 1eeb9d7de2a0..733c48bf6c98 100644
>>>> --- a/drivers/hwmon/lm73.c
>>>> +++ b/drivers/hwmon/lm73.c
>>>> @@ -262,10 +262,20 @@ static int lm73_detect(struct i2c_client *new_client,
>>>>    	return 0;
>>>>    }
>>>>    
>>>> +static const struct of_device_id lm73_of_match[] = {
>>>> +	{
>>>> +		.compatible = "ti,lm73",
>>>> +	},
>>>> +	{ },
>>>> +};
>>>> +
>>>> +MODULE_DEVICE_TABLE(of, lm73_of_match);
>>>> +
>>>>    static struct i2c_driver lm73_driver = {
>>>>    	.class		= I2C_CLASS_HWMON,
>>>>    	.driver = {
>>>>    		.name	= "lm73",
>>>> +		.of_match_table = lm73_of_match,
>>>>    	},
>>>>    	.probe		= lm73_probe,
>>>>    	.id_table	= lm73_ids,
>>
>>

