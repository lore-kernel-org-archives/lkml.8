Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0C4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B57C7207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXjBld8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404515AbgE1Pg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404424AbgE1Pgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:36:55 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4182C08C5C6;
        Thu, 28 May 2020 08:36:55 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 185so5405058pgb.10;
        Thu, 28 May 2020 08:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iUcJohyaN09S3OSOlzUXknVRLMZFzPBBl2ghSn2VPQY=;
        b=nXjBld8OH5AgCTWvC3auvtGbx2a7IIxy7YGcRyYN3poAtm/iMbqAvzOxQvq/SANbvf
         PejCw6y8kh0Og2EDQPqvIzyY3vXeWd3Ia6YYlwKIT2Rhi8eN2t+CCZvONNVBW6fJe7eo
         l706cIiG8w+WTzrC5RcPO8XJoBS2itIKSJpe6CFj5FTX5V+cVlll5rD+TaZhnjzlIm4L
         2Dn3uMBQG2GLkXK+nn4ZYeYzpKJW1UVkPeoQygIi6YUYwdi+/Dy/rrCEnqRe4I5l+Lyy
         tJyXGgiDQcqzGeEjK0r0L01DH4IQeJ16jEMYCeHrCCFBudlUX7VOUeDNYmS15zDTDFGk
         48qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iUcJohyaN09S3OSOlzUXknVRLMZFzPBBl2ghSn2VPQY=;
        b=JeUQO4ghKaKEwgFa/oq3MfGbI1NKsd5LAa1skxPK0sb4J9ACtxDUgD3f9JJ4h7hXTR
         UIGmsyKKF5hfVvYEsrCduQvAIluEhxnpx5u9WZT07js1B+83M30tclZHOI0oVXoOSJ/k
         X7MdQUpDblKMMcrak0jFsi7DaaQ8Mtpm8nWYK+P7acGN0kbd3O+SnWq6awImkndLEbdI
         U/o7/AO620o3Whx/kT4mXcenbusRp/kL0SjiUveJOOmII5i13gLDzkDDivEPgwU8KpUA
         qe/YiB7O/rMsTi+63usTYAwTOcU2xqUDV/hoT6Kl6jNcAtygsz+A5UAOBrwzOw8IQVW/
         CW4g==
X-Gm-Message-State: AOAM5302oaqnBocXNOeyWEPvYMfpacnnamZAIvAIU63NQfeHy+ehIHYd
        E731jbAskub3um+Av1+7V0c=
X-Google-Smtp-Source: ABdhPJysI9YG620MytGVBr4Hg7VTzDBtyJrWZ0H47U/pfuEM0bxKS8Ae4MJ2t3h2TOoD9Ya3Vu9ViA==
X-Received: by 2002:a63:f854:: with SMTP id v20mr3638569pgj.0.1590680215006;
        Thu, 28 May 2020 08:36:55 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k18sm4916052pfg.217.2020.05.28.08.36.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 May 2020 08:36:54 -0700 (PDT)
Date:   Thu, 28 May 2020 08:36:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ugur Usug <Ugur.Usug@maximintegrated.com>
Cc:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon (pmbus/max20730): add max20710 and debugfs access
 support
Message-ID: <20200528153652.GA7755@roeck-us.net>
References: <MWHPR11MB1661A23F609D54EAAC93FDE7FDB00@MWHPR11MB1661.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1661A23F609D54EAAC93FDE7FDB00@MWHPR11MB1661.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 09:42:19AM +0000, Ugur Usug wrote:
> This change has 2 parts:
> 1. Add support for max20710 into the existing max20730 driver.
> 
> 2. Add debugfs interface support for accessing device specific registers 
> (MFR_VOUT_MIN, MFR_DEVSET1 and MFR_DEVSET2) and others 
> including OPERATION, ON_OFF_CONFIG, SMB_ALERT_MASK, 
> VOUT_MODE, VOUT_COMMAND and VOUT_MAX.

This should be two separate patches. Please split and resubmit.

Thanks,
Guenter

> 
> Signed-off-by: Ugur Usug <ugur.usug@maximintegrated.com>
> ---
>  Documentation/hwmon/max20730.rst |  10 +-
>  drivers/hwmon/pmbus/Kconfig      |   4 +-
>  drivers/hwmon/pmbus/max20730.c   | 412 ++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 414 insertions(+), 12 deletions(-)
>  mode change 100644 => 100755 drivers/hwmon/pmbus/max20730.c
> 
> diff --git a/Documentation/hwmon/max20730.rst b/Documentation/hwmon/max20730.rst
> index cea7ae5..cb0c95b 100644
> --- a/Documentation/hwmon/max20730.rst
> +++ b/Documentation/hwmon/max20730.rst
> @@ -5,6 +5,14 @@ Kernel driver max20730
>  
>  Supported chips:
>  
> +  * Maxim MAX20710
> +
> +    Prefix: 'max20710'
> +
> +    Addresses scanned: -
> +
> +    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX20710.pdf
> +
>    * Maxim MAX20730
>  
>      Prefix: 'max20730'
> @@ -35,7 +43,7 @@ Author: Guenter Roeck <linux@roeck-us.net>
>  Description
>  -----------
>  
> -This driver implements support for Maxim MAX20730, MAX20734, and MAX20743
> +This driver implements support for Maxim MAX20710, MAX20730, MAX20734, and MAX20743
>  Integrated, Step-Down Switching Regulators with PMBus support.
>  
>  The driver is a client driver to the core PMBus driver.
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index de12a56..cac96e0 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -147,10 +147,10 @@ config SENSORS_MAX16064
>  	  be called max16064.
>  
>  config SENSORS_MAX20730
> -	tristate "Maxim MAX20730, MAX20734, MAX20743"
> +	tristate "Maxim MAX20710, MAX20730, MAX20734, MAX20743"
>  	help
>  	  If you say yes here you get hardware monitoring support for Maxim
> -	  MAX20730, MAX20734, and MAX20743.
> +	  MAX20710, MAX20730, MAX20734, and MAX20743.
>  
>  	  This driver can also be built as a module. If so, the module will
>  	  be called max20730.
> diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.c
> old mode 100644
> new mode 100755
> index c0bb054..fc38be0
> --- a/drivers/hwmon/pmbus/max20730.c
> +++ b/drivers/hwmon/pmbus/max20730.c
> @@ -1,12 +1,14 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * Driver for MAX20730, MAX20734, and MAX20743 Integrated, Step-Down
> - * Switching Regulators
> + * Driver for MAX20710, MAX20730, MAX20734, and MAX20743 Integrated, 
> + * Step-Down Switching Regulators
>   *
>   * Copyright 2019 Google LLC.
> + * Copyright 2020 Maxim Integrated
>   */
>  
>  #include <linux/bits.h>
> +#include <linux/debugfs.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> @@ -19,21 +21,283 @@
>  #include "pmbus.h"
>  
>  enum chips {
> +	max20710,
>  	max20730,
>  	max20734,
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
> +#define MAX20730_MFR_VOUT_MIN_MASK			GENMASK(9, 0)
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
> +#define MAX20730_MFR_DEVSET2_VRATE			(BIT(6) | BIT(7))
> +#define MAX20730_MFR_DEVSET2_OCPM_MASK		BIT(5)
> +#define MAX20730_MFR_DEVSET2_SS_MASK		(BIT(0) | BIT(1))
> +
> +#define MAX20730_MFR_DEVSET2_IMAX_BIT_POS	8
> +#define MAX20730_MFR_DEVSET2_VRATE_BIT_POS	6
> +#define MAX20730_MFR_DEVSET2_OCPM_BIT_POS	5
> +#define MAX20730_MFR_DEVSET2_SS_BIT_POS		0
> +
> +#define DEBUG_FS_DATA_MAX					8
> +
> +struct max20730_debugfs_data {
> +	struct i2c_client *client;
> +	int debugfs_entries[MAX20730_DEBUGFS_NUM_ENTRIES];
> +};
> +
> +#define to_psu(x, y) container_of((x), \
> +			struct max20730_debugfs_data, debugfs_entries[(y)])
> +
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
> +		} else
> +			return -EINVAL;
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
> +		if(ret < 0)
> +			return ret;
> +		len = snprintf(tbuf, 2, "%d", ret);
> +		break;
> +	case MAX20730_DEBUGFS_ON_OFF_CONFIG:
> +		ret = i2c_smbus_read_byte_data(psu->client, PMBUS_ON_OFF_CONFIG);
> +		if(ret < 0)
> +			return ret;
> +		len = snprintf(tbuf, 2, "%d", ret);
> +		break;
> +	case MAX20730_DEBUGFS_SMBALERT_MASK:
> +		ret = i2c_smbus_read_word_data(psu->client, 
> +							PMBUS_SMB_ALERT_MASK);
> +		if(ret < 0)
> +			return ret;
> +		len = snprintf(tbuf, 3, "%d", ret);
> +		break;
> +	case MAX20730_DEBUGFS_VOUT_MODE:
> +		ret = i2c_smbus_read_byte_data(psu->client, PMBUS_VOUT_MODE);
> +		if(ret < 0)
> +			return ret;
> +		len = snprintf(tbuf, 2, "%d", ret);
> +		break;
> +	case MAX20730_DEBUGFS_VOUT_COMMAND:
> +		ret = i2c_smbus_read_word_data(psu->client, PMBUS_VOUT_COMMAND);
> +		if(ret < 0)
> +			return ret;
> +		len = snprintf(tbuf, 3, "%d", ret);
> +		break;
> +	case MAX20730_DEBUGFS_VOUT_MAX:
> +		ret = i2c_smbus_read_word_data(psu->client, PMBUS_VOUT_MAX);
> +		if(ret < 0)
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
>  
>  /*
>   * Convert discreet value to direct data format. Strictly speaking, all passed
> @@ -80,6 +344,7 @@ static long direct_to_val(u16 w, enum pmbus_sensor_classes class,
>  }
>  
>  static u32 max_current[][5] = {
> +	[max20710] = { 6200, 8000, 9700, 11600 },
>  	[max20730] = { 13000, 16600, 20100, 23600 },
>  	[max20734] = { 21000, 27000, 32000, 38000 },
>  	[max20743] = { 18900, 24100, 29200, 34100 },
> @@ -164,6 +429,45 @@ static int max20730_write_word_data(struct i2c_client *client, int page,
>  }
>  
>  static const struct pmbus_driver_info max20730_info[] = {
> +	[max20710] = {
> +		.pages = 1,
> +		.read_word_data = max20730_read_word_data,
> +		.write_word_data = max20730_write_word_data,
> +
> +		/* Source : Maxim AN6140 and AN6042 */
> +		.format[PSC_TEMPERATURE] = direct,
> +		.m[PSC_TEMPERATURE] = 21,
> +		.b[PSC_TEMPERATURE] = 5887,
> +		.R[PSC_TEMPERATURE] = -1,
> +
> +		.format[PSC_VOLTAGE_IN] = direct,
> +		.m[PSC_VOLTAGE_IN] = 3609,
> +		.b[PSC_VOLTAGE_IN] = 0,
> +		.R[PSC_VOLTAGE_IN] = -2,
> +
> +		/*
> +		 * Values in the datasheet are adjusted for temperature and
> +		 * for the relationship between Vin and Vout.
> +		 * Unfortunately, the data sheet suggests that Vout measurement
> +		 * may be scaled with a resistor array. This is indeed the case
> +		 * at least on the evaulation boards. As a result, any in-driver
> +		 * adjustments would either be wrong or require elaborate means
> +		 * to configure the scaling. Instead of doing that, just report
> +		 * raw values and let userspace handle adjustments.
> +		 */
> +		.format[PSC_CURRENT_OUT] = direct,
> +		.m[PSC_CURRENT_OUT] = 153,
> +		.b[PSC_CURRENT_OUT] = 4976,
> +		.R[PSC_CURRENT_OUT] = -1,
> +
> +		.format[PSC_VOLTAGE_OUT] = linear,
> +
> +		.func[0] = PMBUS_HAVE_VIN |
> +			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> +			PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
> +			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
> +			PMBUS_HAVE_STATUS_INPUT,
> +	},
>  	[max20730] = {
>  		.pages = 1,
>  		.read_word_data = max20730_read_word_data,
> @@ -200,7 +504,8 @@ static const struct pmbus_driver_info max20730_info[] = {
>  		.func[0] = PMBUS_HAVE_VIN |
>  			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
>  			PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
> -			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
> +			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
> +			PMBUS_HAVE_STATUS_INPUT,
>  	},
>  	[max20734] = {
>  		.pages = 1,
> @@ -228,7 +533,8 @@ static const struct pmbus_driver_info max20730_info[] = {
>  		.func[0] = PMBUS_HAVE_VIN |
>  			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
>  			PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
> -			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
> +			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
> +			PMBUS_HAVE_STATUS_INPUT,
>  	},
>  	[max20743] = {
>  		.pages = 1,
> @@ -256,7 +562,8 @@ static const struct pmbus_driver_info max20730_info[] = {
>  		.func[0] = PMBUS_HAVE_VIN |
>  			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
>  			PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
> -			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
> +			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
> +			PMBUS_HAVE_STATUS_INPUT,
>  	},
>  };
>  
> @@ -267,14 +574,17 @@ static int max20730_probe(struct i2c_client *client,
>  	u8 buf[I2C_SMBUS_BLOCK_MAX + 1];
>  	struct max20730_data *data;
>  	enum chips chip_id;
> -	int ret;
> +	int i, ret;
> +	struct dentry *debugfs;
> +	struct dentry *max20730_dir;
> +	struct max20730_debugfs_data *psu;
>  
>  	if (!i2c_check_functionality(client->adapter,
>  				     I2C_FUNC_SMBUS_READ_BYTE_DATA |
>  				     I2C_FUNC_SMBUS_READ_WORD_DATA |
>  				     I2C_FUNC_SMBUS_BLOCK_DATA))
>  		return -ENODEV;
> -
> +	
>  	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "Failed to read Manufacturer ID\n");
> @@ -335,10 +645,93 @@ static int max20730_probe(struct i2c_client *client,
>  		return ret;
>  	data->mfr_devset1 = ret;
>  
> -	return pmbus_do_probe(client, id, &data->info);
> +	ret = pmbus_do_probe(client, id, &data->info);
> +	if (ret < 0)
> +		return ret;
> +
> +#if IS_ENABLED(CONFIG_DEBUG_FS)
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
> +	/*
> +	 * Don't fail the probe if there isn't enough memory for debugfs.
> +	 */
> +	psu = devm_kzalloc(&client->dev, sizeof(*psu), GFP_KERNEL);
> +	if (!psu)
> +		return 0;
> +	psu->client = client;
> +
> +	/* Don't fail the probe if we can't create debugfs */
> +	debugfs = pmbus_get_debugfs_dir(client);
> +	if (!debugfs)
> +		return 0;
> +
> +	max20730_dir = debugfs_create_dir(client->name, debugfs);
> +	if (!max20730_dir)
> +		return 0;
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
> +#endif
> +	
> +	return 0;
>  }
>  
>  static const struct i2c_device_id max20730_id[] = {
> +	{ "max20710", max20710 },
>  	{ "max20730", max20730 },
>  	{ "max20734", max20734 },
>  	{ "max20743", max20743 },
> @@ -348,6 +741,7 @@ static const struct i2c_device_id max20730_id[] = {
>  MODULE_DEVICE_TABLE(i2c, max20730_id);
>  
>  static const struct of_device_id max20730_of_match[] = {
> +	{ .compatible = "maxim,max20710", .data = (void *)max20710 },
>  	{ .compatible = "maxim,max20730", .data = (void *)max20730 },
>  	{ .compatible = "maxim,max20734", .data = (void *)max20734 },
>  	{ .compatible = "maxim,max20743", .data = (void *)max20743 },
> @@ -369,5 +763,5 @@ static struct i2c_driver max20730_driver = {
>  module_i2c_driver(max20730_driver);
>  
>  MODULE_AUTHOR("Guenter Roeck <linux@roeck-us.net>");
> -MODULE_DESCRIPTION("PMBus driver for Maxim MAX20730 / MAX20734 / MAX20743");
> +MODULE_DESCRIPTION("PMBus driver for Maxim MAX20710 / MAX20730 / MAX20734 / MAX20743");
>  MODULE_LICENSE("GPL");
> -- 
> 2.7.4
> 
