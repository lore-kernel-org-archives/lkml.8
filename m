Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A97FC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 03:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1C820829
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 03:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrXYlR7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgHSDWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 23:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgHSDWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 23:22:38 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39393C061389;
        Tue, 18 Aug 2020 20:22:38 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id nv17so241469pjb.3;
        Tue, 18 Aug 2020 20:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tKjdmWZ0YaWSEeRl7XMx088aeUgLrVG6OjhyJWdeeXY=;
        b=QrXYlR7y3Fr1AtJ0qNYi4d+/M68TRSfdySuMag2Ed0ejes+HhN7djh8P2bvvmsRCkv
         bARLzYfsEtyzqE9tTrH433/OiYVo+tbu37rRwbUaRpkKrPd1Zp8TvIZyCDRAYkY3fX3a
         iKMOFWg1fQW/EXDJ2Mskk4yvFHcPwUdkDTJpTIOGYeQzX5LHUrSCwytf2g8BgfNvyIhu
         WHgxPUpEzktyok6Zn8/kxIli6ZTyup8oOYjveZ5b6vi9pR/3+DQklPoEXV0+JfrWZXAb
         7ynumczlVe60dAgCfbhNw0Ay7YGSPSwr6kpXHVZ+abeDZ2Ga/Jqd4LlzNpmjee3gTwfA
         qhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tKjdmWZ0YaWSEeRl7XMx088aeUgLrVG6OjhyJWdeeXY=;
        b=V7w7EBxDgco70mDY9cuJ4ppptu1a7MRCZa8K7Mw0L9ycXVcCeO6K96NIHVs7kh2m5Y
         +iyKrzCL5oO0Nzekhzj7W4/lwStELrN7iavTs6ace6wl21tzlRu8qFo1XFO8wrrLNloh
         mOMRYljqD0GbFusiG9/DEFj0nuLS+fx64z4r01Xpuclc4Lg4Yf0rE1o8wqcwjbXbgT8u
         Pir9+H2TeNQPhPEE5X5o8IcA2XHhgtkSGlEobh+JmORlytbbYtw1wcBW8ZmMPi+h2yPQ
         /abv4bzPXIs3WllgGYOjFgbmam4Ie3niNIIGdoZHJD3ylHc3+GJ8Bp06rzUsMSJWPvQS
         CuiA==
X-Gm-Message-State: AOAM532v2jpXanP74FgLWv3B7sUhPOFMaOjlBmnDQkCf6Xf2teBxoKcg
        8lUDcGH+K+ChanYI0wF19vGeXsKBWsM=
X-Google-Smtp-Source: ABdhPJzMQxvsaXdksUMQa1vlYwoBzXSNz/kkGGWX8gEMiPXqwiR1kims64A+y37vyeryu0b37su+dQ==
X-Received: by 2002:a17:90a:b107:: with SMTP id z7mr2559347pjq.4.1597807357198;
        Tue, 18 Aug 2020 20:22:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u65sm26164396pfb.102.2020.08.18.20.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 20:22:36 -0700 (PDT)
Subject: Re: [PATCH] [PATCH] hwmon/pmbus/Q54SJ108A2: new driver for Delta
 modules Q54SJ108A2
To:     "xiao.mx.ma" <734056705@qq.com>, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_6F447F4063454C89D034DBE956D29BD22E0A@qq.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <678d49b6-461b-cff1-8bdc-4936c9d0da04@roeck-us.net>
Date:   Tue, 18 Aug 2020 20:22:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <tencent_6F447F4063454C89D034DBE956D29BD22E0A@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/20 7:21 PM, xiao.mx.ma wrote:
> The driver is used for Q54SJ108A2 series.
> 
> Signed-off-by: xiao.mx.ma <734056705@qq.com>

there is a gazillion of unnecessary empty lines. Please drop all those.
checkpatch --strict might help.

Other comments inline.

> ---
>  drivers/hwmon/pmbus/Kconfig      |   9 +
>  drivers/hwmon/pmbus/Makefile     |   1 +
>  drivers/hwmon/pmbus/Q54SJ108A2.c | 404 +++++++++++++++++++++++++++++++
>  3 files changed, 414 insertions(+)
>  create mode 100644 drivers/hwmon/pmbus/Q54SJ108A2.c
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index e35db489b76f..b4bd6ac491c8 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -209,6 +209,15 @@ config SENSORS_PXE1610
>  	  This driver can also be built as a module. If so, the module will
>  	  be called pxe1610.
>  
> +config SENSORS_Q54SJ108A2
> +	tristate "Delta Q54SJ108A2"
> +	help
> +	  If you say yes here you get hardware monitoring support for Delta modules
> +	  Q54SJ108A2.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called Q54SJ108A2.
> +
>  config SENSORS_TPS40422
>  	tristate "TI TPS40422"
>  	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index c4b15db996ad..4536c57ef1a4 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -30,3 +30,4 @@ obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
>  obj-$(CONFIG_SENSORS_UCD9200)	+= ucd9200.o
>  obj-$(CONFIG_SENSORS_XDPE122)	+= xdpe12284.o
>  obj-$(CONFIG_SENSORS_ZL6100)	+= zl6100.o
> +obj-$(CONFIG_SENSORS_Q54SJ108A2)	+= Q54SJ108A2.o
> diff --git a/drivers/hwmon/pmbus/Q54SJ108A2.c b/drivers/hwmon/pmbus/Q54SJ108A2.c
> new file mode 100644
> index 000000000000..67fac5506763
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/Q54SJ108A2.c

This is way too cryptic. Please select a human readable file name (delta.c would do).

> @@ -0,0 +1,404 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * Driver for Q54SJ108A2, Q50SN12050, and Q50SN12072 Integrated, Step-Down
> + * Switching Regulators
> + *
> + * Copyright 2020 Delta LLC.
> + */
> +
> +
> +#include <linux/bits.h>
> +
> +#include <linux/err.h>
> +
> +#include <linux/i2c.h>
> +
> +#include <linux/init.h>
> +
> +#include <linux/kernel.h>
> +
> +#include <linux/module.h>
> +
> +#include <linux/mutex.h>
> +
> +#include <linux/of_device.h>
> +
> +#include <linux/pmbus.h>
> +
> +#include <linux/util_macros.h>
> +
> +#include "pmbus.h"
> +
> +enum chips {
> +
> +	Q54SJ108A2,
> +	Q50SN12050,
> +	Q50SN12072
> +};
> +
> +static int delta_read_word_data(struct i2c_client *client, int page, int phase, int reg)
> +{
> +	int ret = 0;
> +	u16 temp;
> +
> +	temp = pmbus_read_word_data(client, page, phase, reg);
> +
> +	switch (reg) {
> +	case PMBUS_STATUS_WORD:
> +		ret = temp;
> +		break;
> +	default:
> +		ret = -ENODATA;
> +		break;
> +	}
> +	return ret;

This doesn't even make sense. It returns -ENODATA for pretty much all sensors,
meaning the core will read the value again. Why read the value twice except for
PMBUS_STATUS_WORD ?

> +
> +}
> +
> +static int delta_write_word_data(struct i2c_client *client, int page, int reg, u16 word)
> +{
> +	u8 value;
> +
> +	switch (reg) {
> +	case PMBUS_OPERATION:

Pointless. This is a byte command anyway.

> +	case PMBUS_WRITE_PROTECT:
> +	case PMBUS_VOUT_OV_FAULT_RESPONSE:
> +	case PMBUS_IOUT_OC_FAULT_RESPONSE:

Those three are also pointless. Never called.

> +		value = (u8)word;
> +		return pmbus_write_byte_data(client, page, reg, value);
> +
> +	default:
> +		return -ENODATA;
> +	}
> +
> +}
> +
> +static int delta_read_byte_data(struct i2c_client *client, int page, int reg)
> +{
> +	int ret = 0;
> +	u16 temp;
> +
> +	temp = pmbus_read_byte_data(client, page, reg);
> +
> +	switch (reg) {
> +	case PMBUS_OPERATION:
> +	case PMBUS_WRITE_PROTECT:
> +	case PMBUS_VOUT_MODE:
> +	case PMBUS_VOUT_OV_FAULT_RESPONSE:
> +	case PMBUS_IOUT_OC_FAULT_RESPONSE:
> +	case PMBUS_STATUS_VOUT:
> +	case PMBUS_STATUS_IOUT:
> +	case PMBUS_STATUS_INPUT:
> +	case PMBUS_STATUS_TEMPERATURE:
> +	case PMBUS_STATUS_CML:
> +	case PMBUS_REVISION:
> +		ret = temp;
> +		break;
> +
> +	default:
> +		ret = -ENODATA;
> +		break;
> +	}
> +	return ret;
> +

What exactly is the point of this ? Return the value read for some commands,
-ENODATA for others, which means the PMBus core will read them again.

> +}
> +
> +static int delta_write_byte(struct i2c_client *client, int page, u8 value)
> +{
> +	switch (value) {
> +	case PMBUS_CLEAR_FAULTS:
> +		ret = pmbus_write_byte(client, page, PMBUS_CLEAR_FAULTS);
> +		break;
> +
> +	default:
> +		ret = -ENODATA;
> +		break;
> +	}

Pointless again. Write PMBUS_CLEAR_FAULTS here, the rest in the PMBus core.

What is this all about ? Sorry, I am completely lost. All those driver
specific functions are useless, the rest of the code has severe formatting
problems. Is this driver even needed, or would it be sufficient to add the
chip IDs to pmbus.c ? I see nothing in the datasheets that would suggest
otherwise.

Guenter

> +	return ret;
> +}
> +
> +static const struct pmbus_driver_info delta_info[] = {
> +
> +[Q54SJ108A2] = {
> +
> +.pages = 1,
> +
> +.read_word_data = delta_read_word_data,
> +
> +.write_word_data = delta_write_word_data,
> +
> +.read_byte_data = delta_read_byte_data,
> +
> +.write_byte = delta_write_byte,
> +
> +
> +/* Source : Delta Q54SJ108A2 */
> +
> +.format[PSC_TEMPERATURE] = linear,
> +
> +.format[PSC_VOLTAGE_IN] = linear,
> +
> +.format[PSC_CURRENT_OUT] = linear,
> +
> +
> +.func[0] = PMBUS_HAVE_VIN |
> +
> +PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> +
> +PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
> +
> +PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
> +
> +PMBUS_HAVE_STATUS_INPUT,
> +
> +},
> +
> +[Q50SN12050] = {
> +
> +.pages = 1,
> +
> +.read_word_data = delta_read_word_data,
> +
> +.write_word_data = delta_write_word_data,
> +
> +.read_byte_data = delta_read_byte_data,
> +
> +.write_byte = delta_write_byte,
> +
> +
> +/* Source : Delta Q50SN12050 */
> +
> +.format[PSC_TEMPERATURE] = linear,
> +
> +
> +.format[PSC_VOLTAGE_IN] = linear,
> +
> +
> +.format[PSC_CURRENT_OUT] = linear,
> +
> +
> +.func[0] = PMBUS_HAVE_VIN |
> +
> +PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> +
> +PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
> +
> +PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
> +
> +PMBUS_HAVE_STATUS_INPUT,
> +},
> +
> +[Q50SN12072] = {
> +
> +.pages = 1,
> +
> +.read_word_data = delta_read_word_data,
> +
> +.write_word_data = delta_write_word_data,
> +
> +.read_byte_data = delta_read_byte_data,
> +
> +.write_byte = delta_write_byte,
> +
> +
> +/* Source : Delta Q50SN12072 */
> +
> +.format[PSC_TEMPERATURE] = linear,
> +
> +
> +.format[PSC_VOLTAGE_IN] = linear,
> +
> +
> +.format[PSC_CURRENT_OUT] = linear,
> +
> +
> +.func[0] = PMBUS_HAVE_VIN |
> +
> +PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> +
> +PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
> +
> +PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
> +
> +PMBUS_HAVE_STATUS_INPUT,
> +},
> +
> +};
> +
> +
> +
> +static int delta_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +
> +	struct device *dev = &client->dev;
> +
> +	u8 buf[I2C_SMBUS_BLOCK_MAX + 1];
> +
> +	struct pmbus_driver_info *info;
> +
> +	enum chips chip_id;
> +
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +
> +		I2C_FUNC_SMBUS_BYTE_DATA |
> +
> +		I2C_FUNC_SMBUS_WORD_DATA |
> +
> +		I2C_FUNC_SMBUS_BLOCK_DATA))
> +
> +		return -ENODEV;
> +
> +	if (client->dev.of_node)
> +
> +		chip_id = (enum chips)of_device_get_match_data(dev);
> +
> +	else
> +
> +		chip_id = id->driver_data;
> +
> +	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
> +
> +	if (ret < 0) {
> +
> +		dev_err(&client->dev, "Failed to read Manufacturer ID\n");
> +
> +		return ret;
> +
> +	}
> +
> +	if (ret != 5 || strncmp(buf, "DELTA", 5)) {
> +
> +		buf[ret] = '\0';
> +
> +		dev_err(dev, "Unsupported Manufacturer ID '%s'\n", buf);
> +
> +		return -ENODEV;
> +
> +	}
> +
> +/*
> + * The chips support reading PMBUS_MFR_MODEL.
> + */
> +
> +	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
> +
> +	if (ret < 0) {
> +
> +		dev_err(dev, "Failed to read Manufacturer Model\n");
> +
> +		return ret;
> +
> +	}
> +
> +	if (ret != 14 || strncmp(buf, "Q54SJ108A2", 10)) {
> +
> +		buf[ret] = '\0';
> +
> +		dev_err(dev, "Unsupported Manufacturer Model '%s'\n", buf);
> +
> +		return -ENODEV;
> +
> +	}
> +
> +	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_REVISION, buf);
> +
> +	if (ret < 0) {
> +
> +		dev_err(dev, "Failed to read Manufacturer Revision\n");
> +
> +		return ret;
> +
> +	}
> +
> +	if (ret != 4 || buf[0] != 'S') {
> +
> +		buf[ret] = '\0';
> +
> +		dev_err(dev, "Unsupported Manufacturer Revision '%s'\n", buf);
> +
> +		return -ENODEV;
> +
> +	}
> +
> +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +
> +	if (!info)
> +
> +		return -ENOMEM;
> +
> +	memcpy(info, &delta_info[chip_id], sizeof(*info));
> +
> +	return pmbus_do_probe(client, id, info);
> +
> +}
> +
> +
> +
> +static const struct i2c_device_id delta_id[] = {
> +
> +{ "Q54SJ108A2", Q54SJ108A2 },
> +
> +{ "Q50SN12050", Q50SN12050 },
> +
> +{ "Q50SN12072", Q50SN12072 },
> +
> +{ },
> +
> +};
> +
> +
> +
> +MODULE_DEVICE_TABLE(i2c, delta_id);
> +
> +
> +
> +static const struct of_device_id delta_of_match[] = {
> +
> +{ .compatible = "delta,Q54SJ108A2", .data = (void *)Q54SJ108A2 },
> +
> +{ .compatible = "delta,Q50SN12050", .data = (void *)Q50SN12050 },
> +
> +{ .compatible = "delta,Q50SN12072", .data = (void *)Q50SN12072 },
> +
> +{ },
> +
> +};
> +
> +
> +
> +MODULE_DEVICE_TABLE(of, delta_of_match);
> +
> +
> +
> +static struct i2c_driver delta_driver = {
> +
> +.driver = {
> +
> +.name = "Q54SJ108A2",
> +
> +.of_match_table = delta_of_match,
> +
> +},
> +
> +.probe = delta_probe,
> +
> +.remove = pmbus_do_remove,
> +
> +.id_table = delta_id,
> +
> +};
> +
> +
> +
> +module_i2c_driver(delta_driver);
> +
> +
> +
> +MODULE_AUTHOR("Delta <xiao.mx.ma@deltaww.com>");
> +
> +MODULE_DESCRIPTION("PMBus driver for Delta Q54SJ108A2 / Q50SN12050 / Q50SN12072");
> +
> +MODULE_LICENSE("GPL");
> 

