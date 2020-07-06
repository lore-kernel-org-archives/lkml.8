Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242D4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09C012070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgGFB07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 21:26:59 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:56658 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbgGFB04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 21:26:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 412992016B13;
        Mon,  6 Jul 2020 09:26:51 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MbPrCEWsKdKw; Mon,  6 Jul 2020 09:26:51 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 1CF5220160D4;
        Mon,  6 Jul 2020 09:26:51 +0800 (HKT)
Received: from [10.128.2.32] (unknown [124.217.189.122])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id D5450C01B74;
        Mon,  6 Jul 2020 09:26:50 +0800 (HKT)
Subject: Re: [PATCH v2 1/2] hwmon: shtc1: add support for device tree bindings
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200705142515.GA1975@roeck-us.net>
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <0e3cc05b-2ae4-186b-d3b4-fa3ac201b128@gtsys.com.hk>
Date:   Mon, 6 Jul 2020 09:26:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200705142515.GA1975@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 5/7/2020 10:25 pm, Guenter Roeck wrote:
> On Sun, Jul 05, 2020 at 11:47:25AM +0800, Chris Ruehl wrote:
>> Add support for DTS bindings for the sensirion shtc1,shtw1 and shtc3.
>>
>> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
>> ---
>>   drivers/hwmon/shtc1.c | 22 ++++++++++++++++++++--
>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwmon/shtc1.c b/drivers/hwmon/shtc1.c
>> index a0078ccede03..61e9275eb666 100644
>> --- a/drivers/hwmon/shtc1.c
>> +++ b/drivers/hwmon/shtc1.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/err.h>
>>   #include <linux/delay.h>
>>   #include <linux/platform_data/shtc1.h>
>> +#include <linux/of.h>
>>   
>>   /* commands (high precision mode) */
>>   static const unsigned char shtc1_cmd_measure_blocking_hpm[]    = { 0x7C, 0xA2 };
>> @@ -196,6 +197,7 @@ static int shtc1_probe(struct i2c_client *client,
>>   	enum shtcx_chips chip = id->driver_data;
>>   	struct i2c_adapter *adap = client->adapter;
>>   	struct device *dev = &client->dev;
>> +	struct device_node *np = dev->of_node;
>>   
>>   	if (!i2c_check_functionality(adap, I2C_FUNC_I2C)) {
>>   		dev_err(dev, "plain i2c transactions not supported\n");
>> @@ -233,8 +235,13 @@ static int shtc1_probe(struct i2c_client *client,
>>   	data->client = client;
>>   	data->chip = chip;
>>   
>> -	if (client->dev.platform_data)
>> +	if (np) {
>> +		data->setup.blocking_io = of_property_read_bool(np, "sensirion,blocking_io");
>> +		data->setup.high_precision = of_property_read_bool(np, "sensicon,low_precision");
>> +	}
>> +	else if (client->dev.platform_data)
>>   		data->setup = *(struct shtc1_platform_data *)dev->platform_data;
> 
> CHECK: braces {} should be used on all arms of this statement
> #46: FILE: drivers/hwmon/shtc1.c:238:
> +	if (np) {
> [...]
> +	else if (client->dev.platform_data)
> [...]
> 
> ERROR: else should follow close brace '}'
> #50: FILE: drivers/hwmon/shtc1.c:242:
> +	}
> +	else if (client->dev.platform_data)
> 

it bites back not using the check-patch script! I _should_ know better! :-(

v3 then.

But i will wait a moment to see if someone else lift a finger.

Chris
