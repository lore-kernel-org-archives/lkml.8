Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4145CC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 22:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1190D207BC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 22:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4UyF2Iw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgHZWJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 18:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgHZWJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 18:09:31 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C41C061574;
        Wed, 26 Aug 2020 15:09:31 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 2so1550356pjx.5;
        Wed, 26 Aug 2020 15:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/zuHoYqvdzPhmaWNvI3sEmLkVFdBNbK3scuyqMVOpvs=;
        b=e4UyF2Iwy54LWaGY3dDD6N2qJL7S5HZNwoEvcRQFYYYqIuOjDeoeTsRD6gzHZRfAAy
         ng18TrRNzIxZIAlkyzyMCjOBBe5hLpflRfAdLcIMC2VzR+9J9HpgDAR6sW1ivJahV3iF
         mJ+Ej2KTeVQS5CHB/20GYuivXcYkRjcKrz9T0XbLO7d0aQtn5aZlldnGfXYmlVoxZS8f
         t9dzBa27fezBJ/mHj9PS1Ha7TZgIyCqh/z22L5L0lf5PtAgK/5TrUdF0XJbtMMopfz9O
         F1hnNXTPKqNWBmezvgmGVvLh3ANKzpxW7YEGjWuPLlCnBcRgh8i8GY/euMtMU/DzufjS
         YWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/zuHoYqvdzPhmaWNvI3sEmLkVFdBNbK3scuyqMVOpvs=;
        b=SWV/XNBfobgbSw4xIDEzx2jpm0QLbk0BbjkcB0WxvdljzHGR1hx1qQxk+ZRuQ5+QAA
         r2KVuvogu29tLu0jm5UTVFky4j4caHg1YzJUPRAxW3y4h9VhjvDWi8xUKefuWZQQ10tx
         ZEgNVUkuIjCWtoGyD0xoMzWem93UpQVCLBbArdJFGRszrhO7HLrbAufuk9TcBK8rC6lK
         QvNjLOtGBk4kHskzbSW9oNgBuAxnnvJE4cGWvXpM10/O3E0ozcquhBUho5ZGWwLIhQ0S
         LOt9hCk2gC7pDMv7/yeHwsU9CxbNcBCLg3bmTCupf5SghW2KHErfXZrIrooI+GWU8hQL
         eH3w==
X-Gm-Message-State: AOAM530/ZJowuTBlflAPm1xo28c+0s4+oeQbEcGtxfWl+LRzrmXdTzTG
        J3wjlTR28HBwkZzOOTaTaOs=
X-Google-Smtp-Source: ABdhPJxIxpT/8RNGGHRdy88sds4Hkj5tXzCq3ntKcimrUxxFsGOHItTS8fvdR6GbLWQYcEc8culZKw==
X-Received: by 2002:a17:90a:bc96:: with SMTP id x22mr8281548pjr.164.1598479770502;
        Wed, 26 Aug 2020 15:09:30 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i123sm184473pfg.85.2020.08.26.15.09.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Aug 2020 15:09:29 -0700 (PDT)
Date:   Wed, 26 Aug 2020 15:09:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ugur Usug <Ugur.Usug@maximintegrated.com>
Cc:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] hwmon (pmbus/max20730): add device monitoring via
 debugfs
Message-ID: <20200826220928.GA179110@roeck-us.net>
References: <MWHPR11MB19659276002CE27A5E36DAD2FD540@MWHPR11MB1965.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB19659276002CE27A5E36DAD2FD540@MWHPR11MB1965.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 09:06:04PM +0000, Ugur Usug wrote:
> Add debugfs interface support for accessing device specific registers (MFR_VOUT_MIN, MFR_DEVSET1 and MFR_DEVSET2) and others including OPERATION, ON_OFF_CONFIG, SMB_ALERT_MASK, VOUT_MODE, VOUT_COMMAND and VOUT_MAX.
> 
> Signed-off-by: Ugur Usug <ugur.usug@maximintegrated.com>

Please run checkpatch --strict and fix what it reports;
mostly continuation alignment issues.

> ---
>  drivers/hwmon/pmbus/max20730.c | 364 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 363 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.c
> index a151a2b..aa5e2be 100644
> --- a/drivers/hwmon/pmbus/max20730.c
> +++ b/drivers/hwmon/pmbus/max20730.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/bits.h>
> +#include <linux/debugfs.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> @@ -26,16 +27,368 @@ enum chips {
>  	max20743
>  };
>  
> +enum {
> +	MAX20730_DEBUGFS_VOUT_MIN = 0,
> +	MAX20730_DEBUGFS_FREQUENCY,
> +	MAX20730_DEBUGFS_PG_DELAY,
> +	MAX20730_DEBUGFS_INTERNAL_GAIN,
> +	MAX20730_DEBUGFS_BOOT_VOLTAGE,
> +	MAX20730_DEBUGFS_OUT_V_RAMP_RATE,
> +	MAX20730_DEBUGFS_OC_PROTECT_MODE,
> +	MAX20730_DEBUGFS_SS_TIMING,
> +	MAX20730_DEBUGFS_IMAX,
> +	MAX20730_DEBUGFS_OPERATION,
> +	MAX20730_DEBUGFS_ON_OFF_CONFIG,
> +	MAX20730_DEBUGFS_SMBALERT_MASK,
> +	MAX20730_DEBUGFS_VOUT_MODE,
> +	MAX20730_DEBUGFS_VOUT_COMMAND,
> +	MAX20730_DEBUGFS_VOUT_MAX,
> +	MAX20730_DEBUGFS_NUM_ENTRIES
> +};
> +
>  struct max20730_data {
>  	enum chips id;
>  	struct pmbus_driver_info info;
>  	struct mutex lock;	/* Used to protect against parallel writes */
>  	u16 mfr_devset1;
> +	u16 mfr_devset2;
> +	u16 mfr_voutmin;
>  };
>  
>  #define to_max20730_data(x)  container_of(x, struct max20730_data, info)
>  
> +#define PMBUS_SMB_ALERT_MASK	0x1B
> +
> +#define MAX20730_MFR_VOUT_MIN	0xd1
>  #define MAX20730_MFR_DEVSET1	0xd2
> +#define MAX20730_MFR_DEVSET2	0xd3
> +
> +#define MAX20730_MFR_VOUT_MIN_MASK		GENMASK(9, 0)
> +#define MAX20730_MFR_VOUT_MIN_BIT_POS		0
> +
> +#define MAX20730_MFR_DEVSET1_RGAIN_MASK		(BIT(13) | BIT(14))
> +#define MAX20730_MFR_DEVSET1_OTP_MASK		(BIT(11) | BIT(12))
> +#define MAX20730_MFR_DEVSET1_VBOOT_MASK		(BIT(8) | BIT(9))
> +#define MAX20730_MFR_DEVSET1_OCP_MASK		(BIT(5) | BIT(6))
> +#define MAX20730_MFR_DEVSET1_FSW_MASK		GENMASK(4, 2)
> +#define MAX20730_MFR_DEVSET1_TSTAT_MASK		(BIT(0) | BIT(1))
> +
> +#define MAX20730_MFR_DEVSET1_RGAIN_BIT_POS	13
> +#define MAX20730_MFR_DEVSET1_OTP_BIT_POS	11
> +#define MAX20730_MFR_DEVSET1_VBOOT_BIT_POS	8
> +#define MAX20730_MFR_DEVSET1_OCP_BIT_POS	5
> +#define MAX20730_MFR_DEVSET1_FSW_BIT_POS	2
> +#define MAX20730_MFR_DEVSET1_TSTAT_BIT_POS	0
> +
> +#define MAX20730_MFR_DEVSET2_IMAX_MASK		GENMASK(10, 8)
> +#define MAX20730_MFR_DEVSET2_VRATE		(BIT(6) | BIT(7))
> +#define MAX20730_MFR_DEVSET2_OCPM_MASK		BIT(5)
> +#define MAX20730_MFR_DEVSET2_SS_MASK		(BIT(0) | BIT(1))
> +
> +#define MAX20730_MFR_DEVSET2_IMAX_BIT_POS	8
> +#define MAX20730_MFR_DEVSET2_VRATE_BIT_POS	6
> +#define MAX20730_MFR_DEVSET2_OCPM_BIT_POS	5
> +#define MAX20730_MFR_DEVSET2_SS_BIT_POS		0
> +
> +#define DEBUG_FS_DATA_MAX			8
> +
> +struct max20730_debugfs_data {
> +	struct i2c_client *client;
> +	int debugfs_entries[MAX20730_DEBUGFS_NUM_ENTRIES];
> +};
> +
> +#define to_psu(x, y) container_of((x), \
> +			struct max20730_debugfs_data, debugfs_entries[(y)])
> +
> +#ifdef CONFIG_DEBUG_FS
> +static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
> +				      size_t count, loff_t *ppos)
> +{
> +	int ret, len;
> +	int *idxp = file->private_data;
> +	int idx = *idxp;
> +	struct max20730_debugfs_data *psu = to_psu(idxp, idx);
> +	const struct pmbus_driver_info *info;
> +	const struct max20730_data *data;
> +	char tbuf[DEBUG_FS_DATA_MAX + 2] = { 0 };
> +	u16 val;
> +
> +	info = pmbus_get_driver_info(psu->client);
> +	data = to_max20730_data(info);
> +
> +	switch (idx) {
> +	case MAX20730_DEBUGFS_VOUT_MIN:
> +		len = snprintf(tbuf, 5, "%d", data->mfr_voutmin);

Do you really want to report raw numbers here ?

> +		break;
> +	case MAX20730_DEBUGFS_FREQUENCY:
> +		val = (data->mfr_devset1 & MAX20730_MFR_DEVSET1_FSW_MASK)
> +			>> MAX20730_MFR_DEVSET1_FSW_BIT_POS;
> +		if (val == 0)
> +			ret = 400;
> +		else if (val == 1)
> +			ret = 500;
> +		else if (val == 2 || val == 3)
> +			ret = 600;
> +		else if (val == 4)
> +			ret = 700;
> +		else if (val == 5)
> +			ret = 800;
> +		else
> +			ret = 900;
> +		len = snprintf(tbuf, 4, "%d", ret);
> +		break;
> +	case MAX20730_DEBUGFS_PG_DELAY:
> +		val = (data->mfr_devset1 & MAX20730_MFR_DEVSET1_TSTAT_MASK)
> +			>> MAX20730_MFR_DEVSET1_TSTAT_BIT_POS;
> +
> +		if (val == 0)
> +			strcpy(tbuf, "2000");
> +		else if (val == 1)
> +			strcpy(tbuf, "125");
> +		else if (val == 2)
> +			strcpy(tbuf, "62.5");
> +		else
> +			strcpy(tbuf, "32");
> +		len = strnlen(tbuf, DEBUG_FS_DATA_MAX);

FWIW, strnlen() is kind of odd here, especially since strlcpy() or similar
was not used above. Same everywhere else, really.

> +		break;
> +
> +	case MAX20730_DEBUGFS_INTERNAL_GAIN:
> +		val = (data->mfr_devset1 & MAX20730_MFR_DEVSET1_RGAIN_MASK)
> +			>> MAX20730_MFR_DEVSET1_RGAIN_BIT_POS;
> +
> +		if (data->id == max20734) {
> +			/* AN6209 */
> +			if (val == 0)
> +				strcpy(tbuf, "0.8");
> +			else if (val == 1)
> +				strcpy(tbuf, "3.2");
> +			else if (val == 2)
> +				strcpy(tbuf, "1.6");
> +			else
> +				strcpy(tbuf, "6.4");
> +		} else if (data->id == max20730 || data->id == max20710) {
> +			/* AN6042 or AN6140 */
> +			if (val == 0)
> +				strcpy(tbuf, "0.9");
> +			else if (val == 1)
> +				strcpy(tbuf, "3.6");
> +			else if (val == 2)
> +				strcpy(tbuf, "1.8");
> +			else
> +				strcpy(tbuf, "7.2");
> +		} else if (data->id == max20743) {
> +			/* AN6042 */
> +			if (val == 0)
> +				strcpy(tbuf, "0.45");
> +			else if (val == 1)
> +				strcpy(tbuf, "1.8");
> +			else if (val == 2)
> +				strcpy(tbuf, "0.9");
> +			else
> +				strcpy(tbuf, "3.6");
> +		} else
> +			return -EINVAL;

Missing { } in the last else branch. Also, I would suggest to return a string
such as "Invalid", not an error. -EINVAL is at the very least confusing here;
the user did not do anything wrong. The same applies to other -EINVAL return
values.

> +
> +		len = strnlen(tbuf, DEBUG_FS_DATA_MAX);
> +		break;
> +	case MAX20730_DEBUGFS_BOOT_VOLTAGE:
> +		val = (data->mfr_devset1 & MAX20730_MFR_DEVSET1_VBOOT_MASK)
> +			>> MAX20730_MFR_DEVSET1_VBOOT_BIT_POS;
> +
> +		if (val == 0)
> +			strcpy(tbuf, "0.6484");
> +		else if (val == 1)
> +			strcpy(tbuf, "0.8984");
> +		else if (val == 2)
> +			strcpy(tbuf, "1.0");
> +		else
> +			return -EINVAL;
> +
> +		len = strnlen(tbuf, DEBUG_FS_DATA_MAX);
> +		break;
> +	case MAX20730_DEBUGFS_OUT_V_RAMP_RATE:
> +		val = (data->mfr_devset2 & MAX20730_MFR_DEVSET2_VRATE)
> +			>> MAX20730_MFR_DEVSET2_VRATE_BIT_POS;
> +
> +		if (val == 0)
> +			ret = 4;
> +		else if (val == 1)
> +			ret = 2;
> +		else if (val == 2)
> +			ret = 1;
> +		else
> +			return -EINVAL;
> +
> +		len = snprintf(tbuf, 2, "%d", ret);
> +		break;
> +	case MAX20730_DEBUGFS_OC_PROTECT_MODE:
> +		ret = (data->mfr_devset2 & MAX20730_MFR_DEVSET2_OCPM_MASK)
> +			>> MAX20730_MFR_DEVSET2_OCPM_BIT_POS;
> +		len = snprintf(tbuf, 2, "%d", ret);
> +		break;
> +	case MAX20730_DEBUGFS_SS_TIMING:
> +		val = (data->mfr_devset2 & MAX20730_MFR_DEVSET2_SS_MASK)
> +			>> MAX20730_MFR_DEVSET2_SS_BIT_POS;
> +
> +		if (val == 0)
> +			strcpy(tbuf, "0.75");
> +		else if (val == 1)
> +			strcpy(tbuf, "1.5");
> +		else if (val == 2)
> +			strcpy(tbuf, "3");
> +		else
> +			strcpy(tbuf, "6");
> +
> +		len = strnlen(tbuf, DEBUG_FS_DATA_MAX);
> +		break;
> +	case MAX20730_DEBUGFS_IMAX:
> +		ret = (data->mfr_devset2 & MAX20730_MFR_DEVSET2_IMAX_MASK)
> +			>> MAX20730_MFR_DEVSET2_IMAX_BIT_POS;
> +		len = snprintf(tbuf, 2, "%d", ret);
> +		break;
> +	case MAX20730_DEBUGFS_OPERATION:
> +		ret = i2c_smbus_read_byte_data(psu->client, PMBUS_OPERATION);
> +		if (ret < 0)
> +			return ret;
> +		len = snprintf(tbuf, 2, "%d", ret);
> +		break;
> +	case MAX20730_DEBUGFS_ON_OFF_CONFIG:
> +		ret = i2c_smbus_read_byte_data(psu->client, PMBUS_ON_OFF_CONFIG);
> +		if (ret < 0)
> +			return ret;
> +		len = snprintf(tbuf, 2, "%d", ret);
> +		break;
> +	case MAX20730_DEBUGFS_SMBALERT_MASK:
> +		ret = i2c_smbus_read_word_data(psu->client,
> +							PMBUS_SMB_ALERT_MASK);
> +		if (ret < 0)
> +			return ret;
> +		len = snprintf(tbuf, 3, "%d", ret);
> +		break;
> +	case MAX20730_DEBUGFS_VOUT_MODE:
> +		ret = i2c_smbus_read_byte_data(psu->client, PMBUS_VOUT_MODE);
> +		if (ret < 0)
> +			return ret;
> +		len = snprintf(tbuf, 2, "%d", ret);
> +		break;
> +	case MAX20730_DEBUGFS_VOUT_COMMAND:
> +		ret = i2c_smbus_read_word_data(psu->client, PMBUS_VOUT_COMMAND);
> +		if (ret < 0)
> +			return ret;
> +		len = snprintf(tbuf, 3, "%d", ret);
> +		break;
> +	case MAX20730_DEBUGFS_VOUT_MAX:
> +		ret = i2c_smbus_read_word_data(psu->client, PMBUS_VOUT_MAX);
> +		if (ret < 0)
> +			return ret;
> +		len = snprintf(tbuf, 3, "%d", ret);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	tbuf[len] = '\n';
> +	len += 2;

Why + 2 ? Doesn't that also return the terminating '\0' ?
Or is that on purpose ?

> +
> +	return simple_read_from_buffer(buf, count, ppos, tbuf, len);
> +}
> +
> +static const struct file_operations max20730_fops = {
> +	.llseek = noop_llseek,
> +	.read = max20730_debugfs_read,
> +	.write = NULL,
> +	.open = simple_open,
> +};
> +
> +static int max20730_init_debugfs(struct i2c_client *client,
> +				struct max20730_data *data)
> +{
> +	int ret, i;
> +	struct dentry *debugfs;
> +	struct dentry *max20730_dir;
> +	struct max20730_debugfs_data *psu;
> +
> +	ret = i2c_smbus_read_word_data(client, MAX20730_MFR_DEVSET2);
> +	if (ret < 0)
> +		return ret;
> +	data->mfr_devset2 = ret;
> +
> +	ret = i2c_smbus_read_word_data(client, MAX20730_MFR_VOUT_MIN);
> +	if (ret < 0)
> +		return ret;
> +	data->mfr_voutmin = ret;
> +
> +	psu = devm_kzalloc(&client->dev, sizeof(*psu), GFP_KERNEL);
> +	if (!psu)
> +		return -ENOMEM;
> +	psu->client = client;
> +
> +	debugfs = pmbus_get_debugfs_dir(client);
> +	if (!debugfs)
> +		return -ENOENT;
> +
> +	max20730_dir = debugfs_create_dir(client->name, debugfs);
> +	if (!max20730_dir)
> +		return -ENOENT;
> +
> +	for (i = 0; i < MAX20730_DEBUGFS_NUM_ENTRIES; ++i)
> +		psu->debugfs_entries[i] = i;
> +
> +	debugfs_create_file("vout_min", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_VOUT_MIN],
> +			    &max20730_fops);
> +	debugfs_create_file("frequency", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_FREQUENCY],
> +			    &max20730_fops);
> +	debugfs_create_file("power_good_delay", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_PG_DELAY],
> +			    &max20730_fops);
> +	debugfs_create_file("internal_gain", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_INTERNAL_GAIN],
> +			    &max20730_fops);
> +	debugfs_create_file("boot_voltage", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_BOOT_VOLTAGE],
> +			    &max20730_fops);
> +	debugfs_create_file("out_voltage_ramp_rate", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_OUT_V_RAMP_RATE],
> +			    &max20730_fops);
> +	debugfs_create_file("oc_protection_mode", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_OC_PROTECT_MODE],
> +			    &max20730_fops);
> +	debugfs_create_file("soft_start_timing", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_SS_TIMING],
> +			    &max20730_fops);
> +	debugfs_create_file("imax", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_IMAX],
> +			    &max20730_fops);
> +	debugfs_create_file("operation", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_OPERATION],
> +			    &max20730_fops);
> +	debugfs_create_file("on_off_config", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_ON_OFF_CONFIG],
> +			    &max20730_fops);
> +	debugfs_create_file("smbalert_mask", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_SMBALERT_MASK],
> +			    &max20730_fops);
> +	debugfs_create_file("vout_mode", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_VOUT_MODE],
> +			    &max20730_fops);
> +	debugfs_create_file("vout_command", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_VOUT_COMMAND],
> +			    &max20730_fops);
> +	debugfs_create_file("vout_max", 0444, max20730_dir,
> +			    &psu->debugfs_entries[MAX20730_DEBUGFS_VOUT_MAX],
> +			    &max20730_fops);
> +
> +	return 0;
> +}
> +#else
> +static int max20730_init_debugfs(struct i2c_client *client,
> +				struct max20730_data *data)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_DEBUG_FS */
>  
>  /*
>   * Convert discreet value to direct data format. Strictly speaking, all passed
> @@ -370,7 +723,16 @@ static int max20730_probe(struct i2c_client *client,
>  		return ret;
>  	data->mfr_devset1 = ret;
>  
> -	return pmbus_do_probe(client, id, &data->info);
> +	ret = pmbus_do_probe(client, id, &data->info);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = max20730_init_debugfs(client, data);
> +	if (ret)
> +		dev_warn(dev, "Failed to register debugfs: %d\n",
> +			 ret);
> +
> +	return 0;
>  }
>  
>  static const struct i2c_device_id max20730_id[] = {
