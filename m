Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFB4C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 543EA2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYqMY/9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbgIJC3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbgIJC06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:26:58 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C91BC0613ED;
        Wed,  9 Sep 2020 19:26:57 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id u126so4447081oif.13;
        Wed, 09 Sep 2020 19:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=czynTSoQR8aIdTOVXc0g2LHocKM0BXA9TRAb/a5XiJw=;
        b=qYqMY/9ih2OwAN/LzfIuv4PW7CNc568H0JC2PHiBFHG5lX7DXx4SJfjA6MU6E9QaIq
         Qu/AGKeWOZv84jmdcFQ/Dld/ttlppIJxSBwGQjrHvWetcObSAc1MOq2luvVG6MJMEmLc
         MumFKf32HAZJWcOAah8dLf8MsxVg1osg3L3gCgAVnTuSISWw6MVGmL7orXg9/3l89Uj9
         uezVSjyoGO02Jlp/p3JlDQE46NTqUcrF0RKihk12N3zXOJFIH5C0xZVvhzg9GGmu5LBG
         XUtWfa0a9Pp7GY3UDC38w5UYFf32sOSIq5RXArFQLMsCkOrTHkm0LARbVVmxWASOhkaf
         ubAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=czynTSoQR8aIdTOVXc0g2LHocKM0BXA9TRAb/a5XiJw=;
        b=Z6DbgZs/gqrJ6wV484d+1DT9JP0iYgLIWKO0KLhMHrtXBcH0cKrj0oxC6/j5lArvNw
         +3N7/U3VpNQmqizPILrE/c32KhfQJ/f7ksx38E/yjKGpiICuD1w5UBrPzjduwaMAP3TO
         vwDeAit0EeEmuuUMDaNSgItG8fNIteq61v1GofBrpPObgEChBxNfPoUQQYmKfGM/yEwY
         wNQtoZdUs3+Z3eLYrmV8LAkgqJS+VP+q8j57Oa0JmjZLbnz9SJKD9Mud8K9WF4wEbE8v
         z8KLWgjJCG6SHisivFlVq9g6w07F2XP2DDui18WRqjR412gOvzIKjqU3+H2o15dVKJ+R
         iVVw==
X-Gm-Message-State: AOAM533I1xzS+EAArsazS3Xs4vpkYtsONsqny+x3V7qHY9O34IQqRCFO
        vQPFI9/Vj1aaM5pQyFjEtg4Olhz14BQ=
X-Google-Smtp-Source: ABdhPJwwZ/0h3XhnkbLjp3gEQDmCnakuLLp2/IqOj1JVVTy9Iu1QTaNVb3iX7gJnTUjZXPyp84D2nw==
X-Received: by 2002:a54:4e95:: with SMTP id c21mr2319903oiy.118.1599704816446;
        Wed, 09 Sep 2020 19:26:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 187sm726618oie.42.2020.09.09.19.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 19:26:55 -0700 (PDT)
Subject: Re: [PATCH v2] hwmon: (pmbus) Expose PEC debugfs attribute
To:     Andrew Jeffery <andrew@aj.id.au>, linux-hwmon@vger.kernel.org
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org
References: <20200910021106.2958382-1-andrew@aj.id.au>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <06000105-9438-6803-1ef9-0bfec7c09360@roeck-us.net>
Date:   Wed, 9 Sep 2020 19:26:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910021106.2958382-1-andrew@aj.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/20 7:11 PM, Andrew Jeffery wrote:
> Enable runtime debug control of whether the PEC byte is exchanged with
> the PMBus device.
> 
> Some manufacturers have asked for the PEC to be disabled as part of
> debugging driver communication issues with devices.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 39 ++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 44535add3a4a..9e7d5f7f0cd0 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2346,6 +2346,42 @@ static int pmbus_debugfs_get_status(void *data, u64 *val)
>  DEFINE_DEBUGFS_ATTRIBUTE(pmbus_debugfs_ops_status, pmbus_debugfs_get_status,
>  			 NULL, "0x%04llx\n");
>  
> +static int pmbus_debugfs_get_pec(void *data, u64 *val)
> +{
> +	struct i2c_client *client = data;
> +
> +	*val = !!(client->flags & I2C_CLIENT_PEC);
> +
> +	return 0;
> +}
> +
> +static int pmbus_debugfs_set_pec(void *data, u64 val)
> +{
> +	int rc;
> +	struct i2c_client *client = data;
> +
> +	if (!val) {
> +		client->flags &= ~I2C_CLIENT_PEC;
> +		return 0;
> +	}
> +
> +	if (val != 1)
> +		return -EINVAL;
> +
> +	rc = i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (!(rc & PB_CAPABILITY_ERROR_CHECK))
> +		return -EOPNOTSUPP;
> +
> +	client->flags |= I2C_CLIENT_PEC;
> +
> +	return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(pmbus_debugfs_ops_pec, pmbus_debugfs_get_pec,
> +			 pmbus_debugfs_set_pec, "%1llu\n");
> +
>  static int pmbus_init_debugfs(struct i2c_client *client,
>  			      struct pmbus_data *data)
>  {
> @@ -2374,6 +2410,9 @@ static int pmbus_init_debugfs(struct i2c_client *client,
>  	if (!entries)
>  		return -ENOMEM;
>  
> +	debugfs_create_file("pec", 0664, data->debugfs, client,
> +			    &pmbus_debugfs_ops_pec);
> +
>  	for (i = 0; i < data->info->pages; ++i) {
>  		/* Check accessibility of status register if it's not page 0 */
>  		if (!i || pmbus_check_status_register(client, i)) {
> 

