Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D189C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06FCC207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAqxCq5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgE2SnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 14:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2SnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:43:11 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1EBC03E969;
        Fri, 29 May 2020 11:43:11 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z26so241807pfk.12;
        Fri, 29 May 2020 11:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a6+0Hr2CeoWTcFsUTPut7XnQ/Hfbu6IFfTK7nr7msiY=;
        b=bAqxCq5DHbOxMB3yI3KkzE4MlZv3SYtJEH+olYrmRcCfy93mFXuqo3mrdRCwlozjbT
         DieqJRjMJe8Fj75GGYSymMYD02MDeMj5uRofbfqQd6B6VgWGN3NvKzBjy0GMOOg3Sy3V
         I09r2HCgPvjHEZEsLG6Wb2qQSl09Zmw24v3/fuB3y7S25KdBNMCF0TygU2L9BrHA8FU1
         NciGVhE39wxCx0i3s+fkhUy82sFIu9L6j7wWhMN2b9abimbZhb2OLHadMR+g3gCAsTSu
         eMNDKvBeYh85MRo92AtsIpzwQZKzbJM5dfxamGymvYrOJjueaxzAOaR89TYR2fVNEQeW
         tWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=a6+0Hr2CeoWTcFsUTPut7XnQ/Hfbu6IFfTK7nr7msiY=;
        b=ottWh9DjqpDfXgkRsjUAzgJuuidizmh8Pclw7ZiYYk4rp7BR8kkfUoZ9ehLutm1C3W
         hSTP87Ktw9w7Z9N1K8Ea8U/JWmaYgQe8mHhVj526AIodiX9sD344l6414avrNeQaStAJ
         aC3BbdLdeup5Eprx9GL4b+nWBI4oPDGRKB5lajHs6zBWXWiQPwBRK3YZ2ZtxXXgxXk5g
         WtVgYjN5l9MY90sNnzRWJktkbizzT5yzIhaWHArUdprYa6SXlPVj7+2XaksOnpESBQfU
         y+b6DeN502CxhnzQxL5sAfm95w3WlcOVey88CtxEZOfji0/BZPHTFYLILXTPzrkbcIe7
         KZ0g==
X-Gm-Message-State: AOAM532/h9+T9eNOivfrjN5gtbQzI5Wcz60ZeDHvoIfOC3qwenoMU3t5
        YI3J8vQ7fPT5SMADnmekq1E=
X-Google-Smtp-Source: ABdhPJy1CvZKXqPGAALJkolc8ZNVs8kHExelqB0iRAw7/AKr8a7MVU6U/xpb7bc5QFbXlREQJajHtQ==
X-Received: by 2002:aa7:8a48:: with SMTP id n8mr9919881pfa.257.1590777791255;
        Fri, 29 May 2020 11:43:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m14sm7391487pgt.6.2020.05.29.11.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 11:43:10 -0700 (PDT)
Subject: Re: [PATCH v3 4/6] hwmon: pmbus: adm1266: add debugfs attr for states
To:     alexandru.tachici@analog.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org
References: <20200529130506.73511-1-alexandru.tachici@analog.com>
 <20200529130506.73511-5-alexandru.tachici@analog.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <877a42cb-2b22-ccb6-5c2a-15c6067401cc@roeck-us.net>
Date:   Fri, 29 May 2020 11:43:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200529130506.73511-5-alexandru.tachici@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/20 6:05 AM, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Add debugfs files for go_command and read_state.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  drivers/hwmon/pmbus/adm1266.c | 47 +++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
> index 190170300ef1..85d6795b79d3 100644
> --- a/drivers/hwmon/pmbus/adm1266.c
> +++ b/drivers/hwmon/pmbus/adm1266.c
> @@ -19,6 +19,8 @@
>  #include "pmbus.h"
>  
>  #define ADM1266_PDIO_CONFIG	0xD4
> +#define ADM1266_GO_COMMAND	0xD8
> +#define ADM1266_READ_STATE	0xD9
>  #define ADM1266_GPIO_CONFIG	0xE1
>  #define ADM1266_PDIO_STATUS	0xE9
>  #define ADM1266_GPIO_STATUS	0xEA
> @@ -41,6 +43,7 @@ struct adm1266_data {
>  	struct gpio_chip gc;
>  	const char *gpio_names[ADM1266_GPIO_NR + ADM1266_PDIO_NR];
>  	struct i2c_client *client;
> +	struct dentry *debugfs_dir;
>  };
>  
>  #if IS_ENABLED(CONFIG_GPIOLIB)
> @@ -234,6 +237,48 @@ static inline int adm1266_config_gpio(struct adm1266_data *data)
>  }
>  #endif
>  
> +static int adm1266_get_state_op(void *pdata, u64 *state)
> +{
> +	struct adm1266_data *data = pdata;
> +	int ret;
> +
> +	ret = i2c_smbus_read_word_data(data->client, ADM1266_READ_STATE);
> +	if (ret < 0)
> +		return ret;
> +
> +	*state = ret;
> +
> +	return 0;
> +}
> +
> +static int adm1266_set_go_command_op(void *pdata, u64 val)
> +{
> +	struct adm1266_data *data = pdata;
> +	u8 reg;
> +
> +	reg = FIELD_GET(GENMASK(4, 0), val);
> +
> +	return i2c_smbus_write_word_data(data->client, ADM1266_GO_COMMAND, reg);
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(go_command_fops, NULL, adm1266_set_go_command_op,
> +			 "%llu\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(read_state_fops, adm1266_get_state_op, NULL, "%llu\n");
> +
> +static void adm1266_debug_init(struct adm1266_data *data)
> +{
> +	struct dentry *root;
> +	char dir_name[30];
> +
> +	sprintf(dir_name, "adm1266-%x_debugfs", data->client->addr);
> +	root = debugfs_create_dir(dir_name, NULL);
> +	data->debugfs_dir = root;
> +	debugfs_create_file_unsafe("go_command", 0200, root, data,
> +				   &go_command_fops);

I am not entirely sure what this does, but from the description in the datasheet
it is way too critical to support as debugfs command. Anyone believing this
is needed should use ioctl commands instead.


> +	debugfs_create_file_unsafe("read_state", 0400, root, data,
> +				   &read_state_fops);
> +}
> +

We have standard pmbus debug functions. Please use it.

>  static int adm1266_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -254,6 +299,8 @@ static int adm1266_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> +	adm1266_debug_init(data);
> +
>  	info = &data->info;
>  	info->pages = 17;
>  	info->format[PSC_VOLTAGE_OUT] = linear;
> 

