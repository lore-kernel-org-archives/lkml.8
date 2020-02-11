Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAB9C3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 02:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E4920714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 02:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2s7t7ow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgBKCau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 21:30:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35563 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbgBKCat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 21:30:49 -0500
Received: by mail-pf1-f193.google.com with SMTP id y73so4683353pfg.2;
        Mon, 10 Feb 2020 18:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V87euS/8pXX/80AgjH6l2braYmcve4PsxhwWOHh5DvM=;
        b=t2s7t7owbyhqezro7cU0ncBPk4cNz8QOyTZxJwEGwHClj31ljbe2g4SkUvQz33chwb
         GD27X9YFKRjng3DNCNgxmMDkp+kAOunbUVffwEAbQz5OhX2FNG+SieiIYTr1W1MSSFio
         H861Zam0eRP836HW/1AQ3H/dZxrrgYX6Csx+GKkScpCoSGyXaxOHk6xlaU885TOMVxsG
         Uur4zqRtvHM+Xj72poheYhiZcYEIVqH0q9amr3rZEy4rHeuL3yttodD9xetB4YTdgDUL
         X38ZGzaLo0xV+TFBr7YFsHQVdh3Ue7JFxlV4Nly3u/3dpJoWaim8GnDNcO/xrA/6EpqL
         Rcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V87euS/8pXX/80AgjH6l2braYmcve4PsxhwWOHh5DvM=;
        b=B4oFO3iATThOjcTlvFgeZHBejQCFYyMuazgtaSKgyBJCqB4bhv13fJekQh2TnihPuq
         lUzbIvby7vsoMvPTV/q0F1tdzGBHJ5LtX+3WmDOkEwB/KPyssJ4bSdN2XWDptAZ0HZR3
         1Ikt+hYkyqtuoRis+WTVO/RIO/IWlJub+QbqeN3mjtwTDmUeGANm6MzPHnFWrjZ3q+G6
         2PKhUWBnZahMPAUpQf8qxQ6ztyjjEK6HIdCN1Voy8pOCUSEdmCD2ve9micv64LLsmySa
         HDSdiJqFSYXEhDkt8xL6vKWeijp5T3uOCviGgOOtxvxkp9WWwgxMWbOviUfneAtCr6WS
         cT9A==
X-Gm-Message-State: APjAAAX7FiUUuCCVX9YJMHkgWdsuwyCMKecTc62ODj/6I9QPFyd0bTeC
        cMs37Vk0OK3b5MPG0dJDevHt04JF
X-Google-Smtp-Source: APXvYqweQdnXjd3OoyEaNikHnRZhw9SYjCRE8xxYCdA9LvGT1zsPLYvROuGjdcZ9j/ENVr1FG+JmOQ==
X-Received: by 2002:a63:2a02:: with SMTP id q2mr4490503pgq.198.1581388248495;
        Mon, 10 Feb 2020 18:30:48 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u23sm1741429pfm.29.2020.02.10.18.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 18:30:47 -0800 (PST)
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
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e8c2b347-5af2-e48c-0f9d-2a6860171171@roeck-us.net>
Date:   Mon, 10 Feb 2020 18:30:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <44032203aa33817430cd120ddd540ec0baaa5f2d.camel@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/20 6:21 PM, Chris Packham wrote:
> On Wed, 2020-02-05 at 14:06 +1300, Henry Shen wrote:
>> Add the of_match_table.
> 
> Needs your Signed-off-by line.
> 

ti,lm73 would also have to be documented as trivial device.

Guenter

>> ---
>>   drivers/hwmon/lm73.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
>> index 1eeb9d7de2a0..733c48bf6c98 100644
>> --- a/drivers/hwmon/lm73.c
>> +++ b/drivers/hwmon/lm73.c
>> @@ -262,10 +262,20 @@ static int lm73_detect(struct i2c_client *new_client,
>>   	return 0;
>>   }
>>   
>> +static const struct of_device_id lm73_of_match[] = {
>> +	{
>> +		.compatible = "ti,lm73",
>> +	},
>> +	{ },
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, lm73_of_match);
>> +
>>   static struct i2c_driver lm73_driver = {
>>   	.class		= I2C_CLASS_HWMON,
>>   	.driver = {
>>   		.name	= "lm73",
>> +		.of_match_table = lm73_of_match,
>>   	},
>>   	.probe		= lm73_probe,
>>   	.id_table	= lm73_ids,

