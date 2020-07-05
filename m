Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FF1C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 14:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A947820739
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 14:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohEGptPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgGEOZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 10:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgGEOZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 10:25:17 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823C6C061794;
        Sun,  5 Jul 2020 07:25:17 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t15so1498962pjq.5;
        Sun, 05 Jul 2020 07:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JR7kwKiFMyvd55rimdXeKVadd9DIbk1gr0VeN52B5gw=;
        b=ohEGptPdtz/dMRDpu6mfz4PUpjxyKl/UyLwOarCQGBS2We2st84rSN5jix4C8FiqNb
         DbUQfd7IIlMUqjCBBRTBcNGWI2fKpo6SJ/hHCg9PVFjk+ssrvBroFm/o5ez4f/TqT9+5
         Yr1cbS3zPq9K4lZSECQj0yGv0QKpYDCXunVW5acQW9f45Z+lxEbLvIUgByvUOopDjhM2
         g5mWHLxGZiwkkwqaP0COYohoO84gE/qaPUm6hAz3r45dhfrOrPLtNvGM8G+ANOlGAyxG
         PtNz+1xYQ3mgoS/0AmnBfA9mlUm+Jx5gMKy6Iz94dbeStfexLIQEZqKSd+ORQDJvbfv3
         bwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=JR7kwKiFMyvd55rimdXeKVadd9DIbk1gr0VeN52B5gw=;
        b=pso7gj91+2vnf9jgSAh9Z1Tf9ubqSUNnMDwArwFSuUyS6aKQ98iu/J+E/ANSRWJiWr
         iRmzGrrNMvOTBN34qY8C3EHN/V3pFbJh4mRCMliHRA+mLXOWZGgsODOA+8aCy1dCDE5j
         mNUhABMtqLG/wgAvyU0tZbLxXICrSqlxqvGQaOScKe9nabdWhBRREATbzAGusNlb/J8z
         yO9jzcoTYRpGykmgDwLvCOabd/st7fbfpoyzJejEigqctZucHxW4o8Pb80gEOqSFbpoS
         vpQIZiDh8+yZZtMR/QKm0xVqb7lswcDlJM3FZ9kQf55OqI4jk2bO8dqhNXTTsnsd3VEj
         L54g==
X-Gm-Message-State: AOAM530mxl7GcIbDOgJ5nITTVPus+Lm3PT6qX22F4Cth3Xqvlti364CB
        kXuydx6wE9VXb1y3FwcwnvElDfc4M30=
X-Google-Smtp-Source: ABdhPJxL3mA3++jITE0N7Bpxwb9SJfrFkV4GdFSJeF0HqaQp3Hwnh+bEJOSPJkmt3OyxcgZQ57RXNQ==
X-Received: by 2002:a17:90a:f2c3:: with SMTP id gt3mr31168368pjb.92.1593959116964;
        Sun, 05 Jul 2020 07:25:16 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c188sm16712159pfc.143.2020.07.05.07.25.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Jul 2020 07:25:16 -0700 (PDT)
Date:   Sun, 5 Jul 2020 07:25:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hwmon: shtc1: add support for device tree bindings
Message-ID: <20200705142515.GA1975@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 05, 2020 at 11:47:25AM +0800, Chris Ruehl wrote:
> Add support for DTS bindings for the sensirion shtc1,shtw1 and shtc3.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  drivers/hwmon/shtc1.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/shtc1.c b/drivers/hwmon/shtc1.c
> index a0078ccede03..61e9275eb666 100644
> --- a/drivers/hwmon/shtc1.c
> +++ b/drivers/hwmon/shtc1.c
> @@ -14,6 +14,7 @@
>  #include <linux/err.h>
>  #include <linux/delay.h>
>  #include <linux/platform_data/shtc1.h>
> +#include <linux/of.h>
>  
>  /* commands (high precision mode) */
>  static const unsigned char shtc1_cmd_measure_blocking_hpm[]    = { 0x7C, 0xA2 };
> @@ -196,6 +197,7 @@ static int shtc1_probe(struct i2c_client *client,
>  	enum shtcx_chips chip = id->driver_data;
>  	struct i2c_adapter *adap = client->adapter;
>  	struct device *dev = &client->dev;
> +	struct device_node *np = dev->of_node;
>  
>  	if (!i2c_check_functionality(adap, I2C_FUNC_I2C)) {
>  		dev_err(dev, "plain i2c transactions not supported\n");
> @@ -233,8 +235,13 @@ static int shtc1_probe(struct i2c_client *client,
>  	data->client = client;
>  	data->chip = chip;
>  
> -	if (client->dev.platform_data)
> +	if (np) {
> +		data->setup.blocking_io = of_property_read_bool(np, "sensirion,blocking_io");
> +		data->setup.high_precision = of_property_read_bool(np, "sensicon,low_precision");
> +	}
> +	else if (client->dev.platform_data)
>  		data->setup = *(struct shtc1_platform_data *)dev->platform_data;

CHECK: braces {} should be used on all arms of this statement
#46: FILE: drivers/hwmon/shtc1.c:238:
+	if (np) {
[...]
+	else if (client->dev.platform_data)
[...]

ERROR: else should follow close brace '}'
#50: FILE: drivers/hwmon/shtc1.c:242:
+	}
+	else if (client->dev.platform_data)
