Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E433C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65AAC2068F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgGMFXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 01:23:13 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:42088 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgGMFXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 01:23:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 12C4F20139AB;
        Mon, 13 Jul 2020 13:23:11 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6d45HdKN3EjX; Mon, 13 Jul 2020 13:23:10 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id E3E9020139A6;
        Mon, 13 Jul 2020 13:23:10 +0800 (HKT)
Received: from [10.128.2.32] (unknown [124.217.188.129])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id 7E936C019F4;
        Mon, 13 Jul 2020 13:23:10 +0800 (HKT)
Subject: Re: [PATCH v6 1/2] hwmon: shtc1: add support for device tree bindings
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200712044411.23323-1-chris.ruehl@gtsys.com.hk>
 <20200712044411.23323-2-chris.ruehl@gtsys.com.hk>
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <456804e8-eae6-d013-180f-42b8d5b9ea40@gtsys.com.hk>
Date:   Mon, 13 Jul 2020 13:23:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200712044411.23323-2-chris.ruehl@gtsys.com.hk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/7/2020 12:44 pm, Chris Ruehl wrote:
> Add support for DTS bindings for the sensirion shtc1,shtw1 and shtc3.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Received new PCBA from the factory today, with the chip installed.
Probe working, the measurement of temperature and humidity is correct.

root@pcba0:~# cat 
/sys/devices/platform/ff110000.i2c/i2c-1/1-0070/hwmon/hwmon1/temp1_input
42334
root@pcba0:~# cat 
/sys/devices/platform/ff110000.i2c/i2c-1/1-0070/hwmon/hwmon1/humidity1_input
38128


Tested-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>

> ---
>   drivers/hwmon/shtc1.c | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/shtc1.c b/drivers/hwmon/shtc1.c
> index a0078ccede03..7993a5ff8768 100644
> --- a/drivers/hwmon/shtc1.c
> +++ b/drivers/hwmon/shtc1.c
> @@ -14,6 +14,7 @@
>   #include <linux/err.h>
>   #include <linux/delay.h>
>   #include <linux/platform_data/shtc1.h>
> +#include <linux/of.h>
>   
>   /* commands (high precision mode) */
>   static const unsigned char shtc1_cmd_measure_blocking_hpm[]    = { 0x7C, 0xA2 };
> @@ -196,6 +197,7 @@ static int shtc1_probe(struct i2c_client *client,
>   	enum shtcx_chips chip = id->driver_data;
>   	struct i2c_adapter *adap = client->adapter;
>   	struct device *dev = &client->dev;
> +	struct device_node *np = dev->of_node;
>   
>   	if (!i2c_check_functionality(adap, I2C_FUNC_I2C)) {
>   		dev_err(dev, "plain i2c transactions not supported\n");
> @@ -233,8 +235,14 @@ static int shtc1_probe(struct i2c_client *client,
>   	data->client = client;
>   	data->chip = chip;
>   
> -	if (client->dev.platform_data)
> -		data->setup = *(struct shtc1_platform_data *)dev->platform_data;
> +	if (np) {
> +		data->setup.blocking_io = of_property_read_bool(np, "sensirion,blocking-io");
> +		data->setup.high_precision = !of_property_read_bool(np, "sensicon,low-precision");
> +	} else {
> +		if (client->dev.platform_data)
> +			data->setup = *(struct shtc1_platform_data *)dev->platform_data;
> +	}
> +
>   	shtc1_select_command(data);
>   	mutex_init(&data->update_lock);
>   
> @@ -257,8 +265,19 @@ static const struct i2c_device_id shtc1_id[] = {
>   };
>   MODULE_DEVICE_TABLE(i2c, shtc1_id);
>   
> +static const struct of_device_id shtc1_of_match[] = {
> +	{ .compatible = "sensirion,shtc1" },
> +	{ .compatible = "sensirion,shtw1" },
> +	{ .compatible = "sensirion,shtc3" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, shtc1_of_match);
> +
>   static struct i2c_driver shtc1_i2c_driver = {
> -	.driver.name  = "shtc1",
> +	.driver = {
> +		.name = "shtc1",
> +		.of_match_table = shtc1_of_match,
> +	},
>   	.probe        = shtc1_probe,
>   	.id_table     = shtc1_id,
>   };
> 

-- 
GTSYS Limited RFID Technology
9/F, Unit E, R07, Kwai Shing Industrial Building Phase 2,
42-46 Tai Lin Pai Road, Kwai Chung, N.T., Hong Kong
Tel (852) 9079 9521

Disclaimer: https://www.gtsys.com.hk/email/classified.html
