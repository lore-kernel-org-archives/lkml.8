Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435B7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EF70206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MialHHzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404166AbgFXPgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403931AbgFXPgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:36:13 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37487C061573;
        Wed, 24 Jun 2020 08:36:13 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p3so1596973pgh.3;
        Wed, 24 Jun 2020 08:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WYEKnN7nA21JB0ycHxEYN/ixhfUYs5OvQyxuIhLAqoE=;
        b=MialHHzWVp7+d5SqKnUpexmEhGCWYyZEjcJGmG5AobzPasrL8II1/Z7Y1hM0dpFulE
         5UPAVsZ16pTbzZIKlMoFq8dhzR3nrrIu0AgzQ4bWHKIudwEeZp8a3KSQLf8Iqa3guime
         EoL2uPEPh7to3axmNFZYPGP8W3P+s+ucfFcBl7uFDVtAsAERHp71FPp3heV96tNitvfB
         PFqvE9+MrtuFLiM3Lmm3W5gg/Ddiwv+xlFZjY/gVWDT9GzSXU10RiZeA8fZC00ZEbtub
         NS4RUG74Ggpi6xJMCIVl9j3FAP4ujHJMHfMsSQTtNAETkzgjFAMjHG998Qc4VnEkoBmT
         RDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WYEKnN7nA21JB0ycHxEYN/ixhfUYs5OvQyxuIhLAqoE=;
        b=CwF1Ykdkv24oKJuZTVS/1v+XEa7cZG3MwLq7on0WIVoUVjqOFIeNXigoKIrwrQt0Hu
         mz8fAWnjTl/52T3TabQu7p5voVx8oezGGJ4vkSDQ+CmRun0BtQO5QS3iQtNGxojrguTm
         NE4693ZosDL2MxET1Ld5d4rcBo3u+zQtpEQWwYVMwpcqWqI4G5tsW9LfOhmVVun1EiZA
         wTjF4jo8WcAp4scvh7ecvfxRtmj+QaYqyy+e5vOftMHjjxZb8t15pCIQsr+RD5bNsqpF
         khSZ/rCEmZkfHc4czRn19Lf+yaNo4lJd4/F/ebIex7IXdPs/sC2AGoaaJze1eRYQJv7u
         czHg==
X-Gm-Message-State: AOAM533dXybzodlMUQMSRn9i5CH4ge9tqzA82CoUNggi4P0jCeHOuWuQ
        hAKeBfmsGcplPrCqfzUMfTmeG7WU
X-Google-Smtp-Source: ABdhPJw0G5kEcp95uBqy613cvljceq0vXADBZs+63uSpcGFxu4ymILipuW1huJyOfPcFdXmJBiRT1A==
X-Received: by 2002:aa7:8ad9:: with SMTP id b25mr30362171pfd.248.1593012972725;
        Wed, 24 Jun 2020 08:36:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n19sm16774926pgb.0.2020.06.24.08.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 08:36:12 -0700 (PDT)
Subject: Re: [PATCH v5 4/7] hwmon: pmbus: adm1266: Add ioctl commands
To:     alexandru.tachici@analog.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org
References: <20200624151736.95785-1-alexandru.tachici@analog.com>
 <20200624151736.95785-5-alexandru.tachici@analog.com>
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
Message-ID: <bb1ea000-29d0-0eb0-818f-513aa33c400d@roeck-us.net>
Date:   Wed, 24 Jun 2020 08:36:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624151736.95785-5-alexandru.tachici@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/20 8:17 AM, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Add two ioctl commands for reading the current state
> of the adm1266 sequencer and sending commands.
> 

Please note that I am not going to a accept any ioctls for hwmon drivers,
much less unprivileged commands like this.

Guenter

> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  Documentation/hwmon/adm1266.rst               | 15 +++
>  .../userspace-api/ioctl/ioctl-number.rst      |  1 +
>  drivers/hwmon/pmbus/adm1266.c                 | 97 +++++++++++++++++++
>  include/uapi/linux/adm1266.h                  | 16 +++
>  4 files changed, 129 insertions(+)
>  create mode 100644 include/uapi/linux/adm1266.h
> 
> diff --git a/Documentation/hwmon/adm1266.rst b/Documentation/hwmon/adm1266.rst
> index 65662115750c..5dc05808db60 100644
> --- a/Documentation/hwmon/adm1266.rst
> +++ b/Documentation/hwmon/adm1266.rst
> @@ -33,3 +33,18 @@ inX_min			Minimum Voltage.
>  inX_max			Maximum voltage.
>  inX_min_alarm		Voltage low alarm.
>  inX_max_alarm		Voltage high alarm.
> +
> +
> +User API
> +========
> +
> +ioctls
> +------
> +
> +ADM1266_SET_GO_COMMAND:
> +
> +  Issue a GO_COMMAND to the device.
> +
> +ADM1266_GET_STATUS:
> +
> +  Returns state of the sequencer.
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 59472cd6a11d..df92ca274622 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -348,6 +348,7 @@ Code  Seq#    Include File                                           Comments
>  0xCC  00-0F  drivers/misc/ibmvmc.h                                   pseries VMC driver
>  0xCD  01     linux/reiserfs_fs.h
>  0xCF  02     fs/cifs/ioctl.c
> +0xD1  00-0F  linux/adm1266.h
>  0xDB  00-0F  drivers/char/mwave/mwavepub.h
>  0xDD  00-3F                                                          ZFCP device driver see drivers/s390/scsi/
>                                                                       <mailto:aherrman@de.ibm.com>
> diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
> index 76bf2c78e737..0960ead8d96a 100644
> --- a/drivers/hwmon/pmbus/adm1266.c
> +++ b/drivers/hwmon/pmbus/adm1266.c
> @@ -15,11 +15,16 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/proc_fs.h>
>  #include <linux/slab.h>
> +#include <linux/uaccess.h>
>  
> +#include <linux/adm1266.h>
>  #include "pmbus.h"
>  
>  #define ADM1266_PDIO_CONFIG	0xD4
> +#define ADM1266_GO_COMMAND	0xD8
> +#define ADM1266_READ_STATE	0xD9
>  #define ADM1266_GPIO_CONFIG	0xE1
>  #define ADM1266_PDIO_STATUS	0xE9
>  #define ADM1266_GPIO_STATUS	0xEA
> @@ -46,6 +51,7 @@ struct adm1266_data {
>  	struct gpio_chip gc;
>  	const char *gpio_names[ADM1266_GPIO_NR + ADM1266_PDIO_NR];
>  	struct i2c_client *client;
> +	struct mutex ioctl_mutex; /* lock ioctl access */
>  };
>  
>  /* Different from Block Read as it sends data and waits for the slave to
> @@ -311,6 +317,93 @@ static int adm1266_config_gpio(struct adm1266_data *data)
>  }
>  #endif
>  
> +static int adm1266_set_go_command_op(struct adm1266_data *data, u8 val)
> +{
> +	val = FIELD_GET(GENMASK(4, 0), val);
> +
> +	return i2c_smbus_write_word_data(data->client, ADM1266_GO_COMMAND, val);
> +}
> +
> +static int adm1266_ioctl_unlocked(struct file *fp, unsigned int cmd,
> +				  unsigned long arg)
> +{
> +	int __user *argp = (int __user *)arg;
> +	struct adm1266_data *data;
> +	int val;
> +	int ret;
> +
> +	data = fp->private_data;
> +
> +	if (!argp)
> +		return -EINVAL;
> +
> +	switch (cmd) {
> +	case ADM1266_SET_GO_COMMAND:
> +		if (copy_from_user(&val, argp, sizeof(int)))
> +			return -EFAULT;
> +
> +		return adm1266_set_go_command_op(data, val);
> +	case ADM1266_GET_STATUS:
> +		ret = i2c_smbus_read_word_data(data->client,
> +					       ADM1266_READ_STATE);
> +
> +		if (ret < 0)
> +			return ret;
> +
> +		if (copy_to_user(argp, &ret, sizeof(int)))
> +			return -EFAULT;
> +
> +		break;
> +	default:
> +		return -ENOTTY;
> +	}
> +
> +	return 0;
> +}
> +
> +static long adm1266_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
> +{
> +	struct adm1266_data *data;
> +	long ret;
> +
> +	data = fp->private_data;
> +
> +	mutex_lock(&data->ioctl_mutex);
> +	ret = adm1266_ioctl_unlocked(fp, cmd, arg);
> +	mutex_unlock(&data->ioctl_mutex);
> +
> +	return ret;
> +}
> +
> +static int adm1266_open(struct inode *inode, struct file *filp)
> +{
> +	filp->private_data = PDE_DATA(inode);
> +
> +	return 0;
> +}
> +
> +static const struct proc_ops adm1266_proc_ops = {
> +	.proc_open	= adm1266_open,
> +	.proc_ioctl	= adm1266_ioctl,
> +};
> +
> +static int adm1266_init_procfs(struct adm1266_data *data)
> +{
> +	struct proc_dir_entry *proc_dir;
> +	u8 proc_fs_name[32];
> +
> +	mutex_init(&data->ioctl_mutex);
> +
> +	snprintf(proc_fs_name, 32, "adm1266-%x", data->client->addr);
> +	proc_dir = proc_create_data(proc_fs_name, 0, NULL, &adm1266_proc_ops,
> +				    data);
> +
> +	if (!proc_dir)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static int adm1266_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -333,6 +426,10 @@ static int adm1266_probe(struct i2c_client *client,
>  
>  	crc8_populate_msb(pmbus_crc_table, 0x7);
>  
> +	ret = adm1266_init_procfs(data);
> +	if (ret < 0)
> +		return ret;
> +
>  	info = &data->info;
>  	info->pages = 17;
>  	info->format[PSC_VOLTAGE_OUT] = linear;
> diff --git a/include/uapi/linux/adm1266.h b/include/uapi/linux/adm1266.h
> new file mode 100644
> index 000000000000..535d270ee8c5
> --- /dev/null
> +++ b/include/uapi/linux/adm1266.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * ADM1266 - Cascadable Super Sequencer with Margin
> + * Control and Fault Recording
> + *
> + * Copyright 2020 Analog Devices Inc.
> + */
> +
> +#ifndef _LINUX_ADM1266_H
> +#define _LINUX_ADM1266_H
> +
> +/* ADM1266 ioctl commands */
> +#define ADM1266_SET_GO_COMMAND		_IOW(0xD1, 0x00, int)
> +#define ADM1266_GET_STATUS		_IOR(0xD1, 0x01, int)
> +
> +#endif
> 

