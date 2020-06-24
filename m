Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD08EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 880AC2065F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKieyH+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404549AbgFXVkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404448AbgFXVkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 17:40:46 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5870C061573;
        Wed, 24 Jun 2020 14:40:46 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d4so2105122pgk.4;
        Wed, 24 Jun 2020 14:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vDjthLvue7rJpdKNLz6dv+eoodKgAvRWMoeoBdp50r4=;
        b=XKieyH+3DUr6TD6DXhR426CXKD8dITHmz/WqwhIG7m2d5kAnECAiESAO06XIHhymfj
         o4FLuv2XiHPdorSxc1eglE+2uaaQVC+1O5Tkq2pwLoFDLYItggv4ZU0Rpdhknk1/xJfU
         IyL9r2Sf+P/RXHkXf/uMpChARWJn5xkMkDPKiihXEJVfDSnxo2yR2mdJbqQh8Jwh0aun
         QmQ1/qtxm+dHqLFrfyO4VOhQkhKZZYffTVGJ7xoI/SoxJiCRzHdc0VI1ZSz9UKt9t1GI
         sp+cUYeJ6f/gb/C/CtYS4IfMDKAUNfrY+AdCbHdqSXZ+0MF72g6txQefhwnpUGjxFG3C
         hHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vDjthLvue7rJpdKNLz6dv+eoodKgAvRWMoeoBdp50r4=;
        b=C8YK/lNsDxhvWI29gb1/xguFwTHnd0cIJ5U2fO2VAfi50ntj42wOplTulgcZBzKmyQ
         Z2Rl0Pk0x7fum70THk58lZUyCfBq+Ld2L/ZWMagKSbDQPvV8eJqHM3Aees2u5hHmB6qT
         uxkWT3ygXrRG9RhP0vKR6h3q7beQnKDPnK+EEH7HpSorq3ElJCFAJhzJilvPnOBcr2Ol
         fVIXkkiv37JJXiGejlX5wLe9Mk3hkIFhWnRjlvSqG/cyxhr/poUs6JW7bbgSIn4GysDz
         9f1DBO1YCs4++cCTpRgaHicb9mp0sTln3UcvtE3sBg2TrVxo+qC4eNRHZYONcnj1lLFc
         lkVQ==
X-Gm-Message-State: AOAM532zw9YIImB/eJKCCk/fmXnZG2F94CRKScj/YZFRKadzr29w7bOv
        dwCBgr96vOWAULYS6MOlOW1iEQ5I
X-Google-Smtp-Source: ABdhPJziw/AXtiiDjPF6NrHpk59IQgbUS2zQd+5trAFIdDZ2CDHz7fnHSCNGAjoAKEuV4uJ4FoFS8w==
X-Received: by 2002:aa7:9782:: with SMTP id o2mr31608126pfp.212.1593034846208;
        Wed, 24 Jun 2020 14:40:46 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f207sm5760195pfa.107.2020.06.24.14.40.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jun 2020 14:40:45 -0700 (PDT)
Date:   Wed, 24 Jun 2020 14:40:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     alexandru.tachici@analog.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v4 4/7] hwmon: pmbus: adm1266: Add ioctl commands
Message-ID: <20200624214044.GA74870@roeck-us.net>
References: <20200623173659.41358-1-alexandru.tachici@analog.com>
 <20200623173659.41358-5-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623173659.41358-5-alexandru.tachici@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 08:36:56PM +0300, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Add two ioctl commands for reading the current state
> of the adm1266 sequencer and sending commands.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> Reported-by: kernel test robot <lkp@intel.com>

This doesn't make sense here.

As already mentioned, I won't accept a patch introducing ioctls.
Technically, the "go" command (if it does what I think it does)
is way too critical to handle this way, and the status can be
reported as debugfs file.

If the idea for the GO command ioctl is to start the device (hard to say
because it isn't documented here, and I don't have time right now to look
it up in the datasheet), it might make sense to check if the regulator
API can be used instead.

Guenter

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
> index f759edafd938..db4d912e3d86 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -345,6 +345,7 @@ Code  Seq#    Include File                                           Comments
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
> index 000000000000..0db3c1129293
> --- /dev/null
> +++ b/include/uapi/linux/adm1266.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
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
