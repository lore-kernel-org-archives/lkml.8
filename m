Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400E9C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECBAC2071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u4W2mQSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgIAUg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgIAUgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 16:36:22 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C602C061244;
        Tue,  1 Sep 2020 13:36:22 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 5so1324641pgl.4;
        Tue, 01 Sep 2020 13:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9H6U0Wlfdrl+gtFbR8ODzSvr8e02W/pnIpeXIdIDsec=;
        b=u4W2mQSvg8CNEvzVuuL/w0CJppCH5x34Y6nmI/q0aJGrItf5Tmd3Jg2+NXjMANIWjd
         aWlRvm4gBfS1orwyzy6GeTeI57t6LpQD9SbWRAH7aYG6KpGcI5IpUMNq2kIIHnmOElfy
         YE80k6LrCL2CIvEeOx0ZF/g0bF2bzZGXfnIXyx27bKjBtFLzEQee8T4r+z5VxxOlUz5m
         H75TUudU2LVtb8DmBaNHBAAGg3u41C0Z5FfVun/fNbZFp268RVOtb1X08fy9YZbyuGXz
         u94GnTJlQI+/yrlh6hJx6x0SUNQsnvinoY7M5Jj0tz5ZJnvo0vujW1iN4dIkO0yIzGjY
         qOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9H6U0Wlfdrl+gtFbR8ODzSvr8e02W/pnIpeXIdIDsec=;
        b=G6V/ags8RHGVjkY+bApGpoULM0xihbhyHZfn4HJYc2uZq2LXsbrkS4AUqlKSMOf57Z
         izkxNj0pztLc4yanSCCvbAsl5A7dbRBFj7c0EONlEZ5EK32VsBC7/9IzOc9PfuX5AZ71
         TuVTcEIyVcOU2DvFd9nkwYNdHwPavqHkramuWvcJ3YyWA9UFolqJ7qLsMJhGPMGdCgmW
         PbOIadBvT98kRMtOqNOni0XSvaVd6Qz1BqR8LbLwRf3Y2iZGK1K33SMgSOHjsLorcMEU
         Kjmf4X/P9Jwa0I3gJJmBu16rC4UIT4o1Y4cGY/JFpsB5MXtJ64tT6wYUost5KSr7ffR7
         zQug==
X-Gm-Message-State: AOAM530yq4wYrpjNGUfW1RyFb6Phycf/8R0tV9fyr+TbamfEFV2BC6In
        2ZsyhB/4IIrA1wBd0+dpVXJqI2xqpVI=
X-Google-Smtp-Source: ABdhPJzXvVOpuXhwV+/maNrWUNO3zMJyMcJIT6ypRi69wxE4fFy6aYGqw2vO7Y5A5F8kJXsdivMMHQ==
X-Received: by 2002:a62:8f45:: with SMTP id n66mr3579670pfd.288.1598992581782;
        Tue, 01 Sep 2020 13:36:21 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n128sm1647747pga.5.2020.09.01.13.36.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Sep 2020 13:36:21 -0700 (PDT)
Date:   Tue, 1 Sep 2020 13:36:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ugur Usug <ugur.usug@maximintegrated.com>
Cc:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] hwmon (pmbus/max20730): add device monitoring via
 debugfs
Message-ID: <20200901203620.GA145484@roeck-us.net>
References: <MWHPR11MB1965838B874218DD5800EE24FD520@MWHPR11MB1965.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1965838B874218DD5800EE24FD520@MWHPR11MB1965.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 07:21:45AM +0000, Ugur Usug wrote:
> Add debugfs interface support for accessing device specific registers (MFR_VOUT_MIN, MFR_DEVSET1 and MFR_DEVSET2) and others including OPERATION, ON_OFF_CONFIG, SMB_ALERT_MASK, VOUT_MODE, VOUT_COMMAND and VOUT_MAX.
> 
Line above needs to be split into multiple lines. The e-mail address
in the header does not match the e-mail address in the Signed-off-by:
tag. Again, please run checkpatch and fix what it reports.

Also, there is no change log, and my other comments were ignored
(use of strnlen, returning -EINVAL from debugfs functions). Please
at least explain why you chose to ignore my feedback.

Thanks,
Guenter

> Signed-off-by: Ugur Usug <ugur.usug@maximintegrated.com>
> ---
>  drivers/hwmon/pmbus/max20730.c | 365 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 364 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.c
> index a151a2b..2115772 100644
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
> @@ -26,16 +27,369 @@ enum chips {
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
> +				     size_t count, loff_t *ppos)
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
> +		} else {
> +			return -EINVAL;
> +		}
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
> +					       PMBUS_SMB_ALERT_MASK);
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
> +				 struct max20730_data *data)
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
> +				 struct max20730_data *data)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_DEBUG_FS */
>  
>  /*
>   * Convert discreet value to direct data format. Strictly speaking, all passed
> @@ -370,7 +724,16 @@ static int max20730_probe(struct i2c_client *client,
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
