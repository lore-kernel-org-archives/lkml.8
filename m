Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38535C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13E042074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIMCC0FS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgE2Rzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 13:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgE2Rzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 13:55:36 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0C5C03E969;
        Fri, 29 May 2020 10:55:36 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 5so1688376pjd.0;
        Fri, 29 May 2020 10:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yi6uUu+RTFIHommJHMKQAX9hIvOuH3TxTlQFNPzGHl4=;
        b=tIMCC0FSd0hQc/d/AxQ/aNeeVnKIU5F1sgxJGKkXastM+rQ4eCU5UhZ+y8OtbZgBb+
         Axrc1FurCOoI/RSAVY/IpZRm7bktykasEPkI0JygKSe5tlQYtmBZqGQUN3Yw6VXLxVwY
         t7K8meuKlV9+5hHLEpZFU9ir7Yty+63yvPMMAiA/3a180LCaUmsDMgfUoqOfeT2OBwra
         7j9qU14BbDgtWMewiuAQQXDOiYNLUZ2bHv6sLfirIhx07JE4gTHcbLECL3q9BS89Q2V2
         9+OVTZV7cE7V3y9dTzJf3Nmz3l2pUHkfv6Bk8B71xquRF+ZTe7JcqWYdCl8v3nYXi5Ql
         pd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yi6uUu+RTFIHommJHMKQAX9hIvOuH3TxTlQFNPzGHl4=;
        b=UvLxiZ+QdGNwU40OHnPoth5sMp5xUzqCCcvWZjshFR6JyxjbYoFfuLG51VcxEMpRRw
         WmcpORmzrKRfmy/1xnxkag+osSWDkzqA5wM23LbMAvj77Hd8wtK5K+dawp1U1V5NMHxk
         D22eeWcwzXX6EQICLCJthwCJ+cf0NrPm9Ufg9ELVN2gEEmk0cw6wvr6vFn0YWBg/bFUB
         DF5TCJilMr0Tr3idIfeDcdvu9RZFlYb6SLnaXx4uFuD8budhhd7j3zNsQpNScUSJ19qV
         lxFPOlCw6Bypm903uk5JlWUFRiAIJCD4a0b8n9m1u2ZBwmcwUiS+qThFoAb992LYNH03
         gkqg==
X-Gm-Message-State: AOAM533o85bF02ZpOr6sNFAGj9G+x/4G93a5DRXctG0UqMgf81tVpPvI
        WCxUBA2He1htOLBX0pAlNmg=
X-Google-Smtp-Source: ABdhPJxc0nD9zfDKZdPjrIQc/uLZy1KekTziwXsyXmjKzYcpt0FhbmNUGSDHufUlHJR4E2aAHNLuQA==
X-Received: by 2002:a17:902:b187:: with SMTP id s7mr10128624plr.60.1590774935906;
        Fri, 29 May 2020 10:55:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e15sm7874449pfh.23.2020.05.29.10.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 10:55:35 -0700 (PDT)
Subject: Re: [PATCH v3 2/6] hwmon: (pmbus/core) Add Block WR
To:     alexandru.tachici@analog.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org
References: <20200529130506.73511-1-alexandru.tachici@analog.com>
 <20200529130506.73511-3-alexandru.tachici@analog.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <fbe5afc6-56d7-1802-6fa4-8aac4ea58bfa@roeck-us.net>
Date:   Fri, 29 May 2020 10:55:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200529130506.73511-3-alexandru.tachici@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/20 6:05 AM, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> PmBus devices support Block Write-Block Read Process
> Call described in SMBus specification v 2.0 with the
> exception that Block writes and reads are permitted to
> have up 255 data bytes instead of max 32 bytes (SMBus).
> 
> This patch adds Block WR process call support for PMBus.
> 

I don't think I want to have this code in the PMBus core.
We can move it there if needed at some point in the future,
but for the time being I'd rather have it in the driver
needing it.

> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  drivers/hwmon/pmbus/Kconfig      |  2 +-
>  drivers/hwmon/pmbus/pmbus.h      |  4 ++
>  drivers/hwmon/pmbus/pmbus_core.c | 88 ++++++++++++++++++++++++++++++++
>  3 files changed, 93 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 6949483aa732..f11712fdcea8 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -5,7 +5,7 @@
>  
>  menuconfig PMBUS
>  	tristate "PMBus support"
> -	depends on I2C
> +	depends on I2C && CRC8

This should be select CRC8, not depends.

>  	help
>  	  Say yes here if you want to enable PMBus support.
>  
> diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
> index 18e06fc6c53f..ae4e15c5dff2 100644
> --- a/drivers/hwmon/pmbus/pmbus.h
> +++ b/drivers/hwmon/pmbus/pmbus.h
> @@ -392,6 +392,8 @@ enum pmbus_sensor_classes {
>  #define PMBUS_PHASE_VIRTUAL	BIT(30)	/* Phases on this page are virtual */
>  #define PMBUS_PAGE_VIRTUAL	BIT(31)	/* Page is virtual */
>  
> +#define PMBUS_BLOCK_MAX		255
> +
>  enum pmbus_data_format { linear = 0, direct, vid };
>  enum vrm_version { vr11 = 0, vr12, vr13, imvp9, amd625mv };
>  
> @@ -467,6 +469,8 @@ int pmbus_read_word_data(struct i2c_client *client, int page, int phase,
>  			 u8 reg);
>  int pmbus_write_word_data(struct i2c_client *client, int page, u8 reg,
>  			  u16 word);
> +int pmbus_block_wr(struct i2c_client *client, u8 cmd, u8 w_len, u8 *data_w,
> +		   u8 *data_r);
>  int pmbus_read_byte_data(struct i2c_client *client, int page, u8 reg);
>  int pmbus_write_byte(struct i2c_client *client, int page, u8 value);
>  int pmbus_write_byte_data(struct i2c_client *client, int page, u8 reg,
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 8d321bf7d15b..ef63468da3b5 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -6,6 +6,7 @@
>   * Copyright (c) 2012 Guenter Roeck
>   */
>  
> +#include <linux/crc8.h>
>  #include <linux/debugfs.h>
>  #include <linux/kernel.h>
>  #include <linux/math64.h>
> @@ -44,6 +45,8 @@
>  
>  #define PMBUS_NAME_SIZE		24
>  
> +DECLARE_CRC8_TABLE(pmbus_crc_table);
> +
>  struct pmbus_sensor {
>  	struct pmbus_sensor *next;
>  	char name[PMBUS_NAME_SIZE];	/* sysfs sensor name */
> @@ -184,6 +187,89 @@ int pmbus_set_page(struct i2c_client *client, int page, int phase)
>  }
>  EXPORT_SYMBOL_GPL(pmbus_set_page);
>  
> +/* Block Write/Read command.

I won't accept network-style multi-line comments.

> + * @client: Handle to slave device
> + * @cmd: Byte interpreted by slave
> + * @w_len: Size of write data block; PMBus allows at most 255 bytes
> + * @data_w: byte array which will be written.
> + * @data_r: Byte array into which data will be read; big enough to hold
> + *	the data returned by the slave. PMBus allows at most 255 bytes.
> + *
> + * Different from Block Read as it sends data and waits for the slave to
> + * return a value dependent on that data. The protocol is simply a Write Block
> + * followed by a Read Block without the Read-Block command field and the
> + * Write-Block STOP bit.
> + *
> + * Returns number of bytes read or negative errno.
> + */
> +int pmbus_block_wr(struct i2c_client *client, u8 cmd, u8 w_len,

_wr is misleading, since it suggests an abbreviated _write.
Better use something like _transfer or _xfer.

> +		   u8 *data_w, u8 *data_r)
> +{
> +	u8 write_buf[PMBUS_BLOCK_MAX + 1];
> +	struct i2c_msg msgs[2] = {
> +		{
> +			.addr = client->addr,
> +			.flags = 0,
> +			.buf = write_buf,
> +			.len = w_len + 2,
> +		},
> +		{
> +			.addr = client->addr,
> +			.flags = I2C_M_RD,
> +			.len = PMBUS_BLOCK_MAX,
> +		}
> +	};
> +	u8 addr = 0;
> +	u8 crc = 0;
> +	int ret;
> +
> +	msgs[0].buf[0] = cmd;
> +	msgs[0].buf[1] = w_len;
> +	memcpy(&msgs[0].buf[2], data_w, w_len);
> +

w_len can be up to 255, meaning up to 255 + 2 bytes can be written
into write_buf. Yet, write_buf is only 256 bytes long.

> +	msgs[0].buf = i2c_get_dma_safe_msg_buf(&msgs[0], 1);
> +	if (!msgs[0].buf)
> +		return -ENOMEM;
> +
> +	msgs[1].buf = i2c_get_dma_safe_msg_buf(&msgs[1], 1);
> +	if (!msgs[1].buf) {
> +		i2c_put_dma_safe_msg_buf(msgs[0].buf, &msgs[0], false);
> +		return -ENOMEM;
> +	}
> +
> +	ret = i2c_transfer(client->adapter, msgs, 2);
> +	if (ret != 2) {
> +		dev_err(&client->dev, "I2C transfer error.");

ret may be 1, which would suggest to the caller that one byte
of data was returned. Also, I am not in favor of logging noise.

> +		goto cleanup;
> +	}
> +
> +	if (client->flags & I2C_CLIENT_PEC) {
> +		addr = i2c_8bit_addr_from_msg(&msgs[0]);
> +		crc = crc8(pmbus_crc_table, &addr, 1, crc);
> +		crc = crc8(pmbus_crc_table, msgs[0].buf,  msgs[0].len, crc);
> +
> +		addr = i2c_8bit_addr_from_msg(&msgs[1]);
> +		crc = crc8(pmbus_crc_table, &addr, 1, crc);
> +		crc = crc8(pmbus_crc_table, msgs[1].buf,  msgs[1].buf[0] + 1,
> +			   crc);
> +
> +		if (crc != msgs[1].buf[msgs[1].buf[0] + 1]) {
> +			ret = -EBADMSG;
> +			goto cleanup;
> +		}
> +	}
> +
> +	memcpy(data_r, &msgs[1].buf[1], msgs[1].buf[0]);

The length of the read buffer is 255 bytes, yet the code suggests
that up to 256 bytes can actually be received.

> +	ret = msgs[1].buf[0];
> +
> +cleanup:
> +	i2c_put_dma_safe_msg_buf(msgs[0].buf, &msgs[0], true);
> +	i2c_put_dma_safe_msg_buf(msgs[1].buf, &msgs[1], true);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pmbus_block_wr);
> +
>  int pmbus_write_byte(struct i2c_client *client, int page, u8 value)
>  {
>  	int rv;
> @@ -2522,6 +2608,8 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
>  	if (!data->groups)
>  		return -ENOMEM;
>  
> +	crc8_populate_msb(pmbus_crc_table, 0x7);
> +
>  	i2c_set_clientdata(client, data);
>  	mutex_init(&data->update_lock);
>  	data->dev = dev;
> 

