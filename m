Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA66C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6F820801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JSYel0nS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgBQPTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:19:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33634 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbgBQPTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:19:05 -0500
Received: by mail-wr1-f65.google.com with SMTP id u6so20251974wrt.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 07:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uWzJUoyM/E+cChM1AtHHgZTTLGuCAVXjAFYI38VEtZ0=;
        b=JSYel0nSekRza1rap31VPpG3XQOWmubSzagYhvCjd8h5giFdy2G9q4UHhjCGH/SyRg
         mdBfhRgQQfyCDjH74EMsjTh1KEyH5nWN87+z9O8WQoJKpdSltsUdmzA4HepWUlHX2/SW
         mJo6VxODQ7dV6hXyNgPpWELSSY4yBW/PLMikRLIVFS/MTO18wn2cRekNdygj9jXZQqAO
         NoyBo5/mSnLf7atXx4c9KQSOmbcpQYbZE4LO8UUyx2xFO/jy73v7FqpBo/uZW5Nr6ZwY
         9Ao1BAUuyhCHzBUoy3lRnO9eRtViXkiZIDVfdJBsWa3CDAJ6uPRo8YNyisqTUPCm7ws4
         T/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uWzJUoyM/E+cChM1AtHHgZTTLGuCAVXjAFYI38VEtZ0=;
        b=RwK1LesPa3TXFrGnotnEv07xFnGyYHxAI3IIT21dw95E8JvBBa/DqHvvz/S3zFVAgw
         eiSWL3bGUmhWMOUYpOLfNxEIcHuH5Ol5PdTRkW8uvqGMggWql2m/KOLGKyrIpju7JZHv
         n7bslngGD/ioEO/olOnINpUc3KXcNjeO3SwieD8HrDl3ke763ul5nYg1bKYvtLJyEeQO
         3H+4gBMGfAB25PEGv6jBhOFwKdEXfqa4n16LZGGbPC3NV0zXUhmSgE6JV8kMX4C+/663
         F24dRVbzNbnGxsiYoImuJAIws+Awrmo1q+8xnB++hw3bk/4krp0hscHJj+3tEeKvy/ml
         Zd5Q==
X-Gm-Message-State: APjAAAV6nrA30ShBKz97li4yrul7hDUZKyYjIAfEEkAuYl+wSZpfEMmk
        f/ESLMkVV/Jfp6rXY21z7P2FsQ==
X-Google-Smtp-Source: APXvYqwBXacny7L4zIXqYBOB+D5E5RZTUwAAxF8cd7e3k8zW8ibiDkQlfPpeCGO1+tCd73IkDYCPAQ==
X-Received: by 2002:adf:a453:: with SMTP id e19mr21803434wra.48.1581952741723;
        Mon, 17 Feb 2020 07:19:01 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:9dbe:964b:c22d:ab7e? ([2a01:e34:ed2f:f020:9dbe:964b:c22d:ab7e])
        by smtp.googlemail.com with ESMTPSA id r1sm1458288wrx.11.2020.02.17.07.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2020 07:19:01 -0800 (PST)
Subject: Re: [PATCH 1/5] scsi: ufs: Add ufs thermal support
To:     Avi Shchislowski <avi.shchislowski@wdc.com>,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        linux-kernel@vger.kernel.org
Cc:     Uri Yanai <uri.yanai@wdc.com>
References: <1580658445-15232-1-git-send-email-avi.shchislowski@wdc.com>
 <1580658445-15232-2-git-send-email-avi.shchislowski@wdc.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <fcac4c1d-9f85-e342-c28d-98a3beb62e75@linaro.org>
Date:   Mon, 17 Feb 2020 16:18:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1580658445-15232-2-git-send-email-avi.shchislowski@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2020 16:47, Avi Shchislowski wrote:
> Support the new temperature notification attributes introduced in
> UFSv3.0. Add exception event mask, and ufs features attributes.
> 
> Signed-off-by: Uri Yanai <uri.yanai@wdc.com>
> Signed-off-by: Avi Shchislowski <avi.shchislowski@wdc.com>

Please resend the series with thermal maintainer in Cc.


> ---
>  drivers/scsi/ufs/Kconfig       |  11 ++++
>  drivers/scsi/ufs/Makefile      |   1 +
>  drivers/scsi/ufs/ufs-thermal.c | 123 +++++++++++++++++++++++++++++++++++++++++
>  drivers/scsi/ufs/ufs-thermal.h |  19 +++++++
>  drivers/scsi/ufs/ufs.h         |  11 ++++
>  drivers/scsi/ufs/ufshcd.c      |   3 +
>  drivers/scsi/ufs/ufshcd.h      |  10 ++++
>  7 files changed, 178 insertions(+)
>  create mode 100644 drivers/scsi/ufs/ufs-thermal.c
>  create mode 100644 drivers/scsi/ufs/ufs-thermal.h
> 
> diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
> index d14c224..bed56ee 100644
> --- a/drivers/scsi/ufs/Kconfig
> +++ b/drivers/scsi/ufs/Kconfig
> @@ -160,3 +160,14 @@ config SCSI_UFS_BSG
>  
>  	  Select this if you need a bsg device node for your UFS controller.
>  	  If unsure, say N.
> +
> +config THERMAL_UFS
> +	bool "Thermal UFS"
> +	depends on THERMAL && SCSI_UFSHCD
> +	help
> +	  A UFS3.0 feature that allows using the ufs device as a temperature
> +	  sensor. it provide notification to the host when the UFS device
> +	  case temperature approaches its pre-defined boundaries.
> +
> +	  Select Y to enable this feature, otherwise say N.
> +	  If unsure, say N.
> \ No newline at end of file
> diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
> index 94c6c5d..fd35941 100644
> --- a/drivers/scsi/ufs/Makefile
> +++ b/drivers/scsi/ufs/Makefile
> @@ -12,3 +12,4 @@ obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) += ufshcd-pltfrm.o
>  obj-$(CONFIG_SCSI_UFS_HISI) += ufs-hisi.o
>  obj-$(CONFIG_SCSI_UFS_MEDIATEK) += ufs-mediatek.o
>  obj-$(CONFIG_SCSI_UFS_TI_J721E) += ti-j721e-ufs.o
> +obj-$(CONFIG_THERMAL_UFS) += ufs-thermal.o
> diff --git a/drivers/scsi/ufs/ufs-thermal.c b/drivers/scsi/ufs/ufs-thermal.c
> new file mode 100644
> index 0000000..469c1ed
> --- /dev/null
> +++ b/drivers/scsi/ufs/ufs-thermal.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * thermal ufs
> + *
> + * Copyright (C) 2020 Western Digital Corporation
> + */
> +#include <linux/thermal.h>
> +#include "ufs-thermal.h"
> +
> +enum {
> +	UFS_THERM_MAX_TEMP,
> +	UFS_THERM_HIGH_TEMP,
> +	UFS_THERM_LOW_TEMP,
> +	UFS_THERM_MIN_TEMP,
> +
> +	/* keep last */
> +	UFS_THERM_MAX_TRIPS
> +};
> +
> +/**
> + *struct ufs_thermal - thermal zone related data
> + * @tzone: thermal zone device data
> + */
> +static struct ufs_thermal {
> +	struct thermal_zone_device *zone;
> +} thermal;
> +
> +static  struct thermal_zone_device_ops ufs_thermal_ops = {
> +	.get_temp = NULL,
> +	.get_trip_temp = NULL,
> +	.get_trip_type = NULL,
> +};
> +
> +static int ufs_thermal_enable_ee(struct ufs_hba *hba)
> +{
> +	/* later */
> +	return -EINVAL;
> +}
> +
> +static void ufs_thermal_zone_unregister(struct ufs_hba *hba)
> +{
> +	if (thermal.zone) {
> +		dev_dbg(hba->dev, "Thermal zone device unregister\n");
> +		thermal_zone_device_unregister(thermal.zone);
> +		thermal.zone = NULL;
> +	}
> +}
> +
> +static int ufs_thermal_register(struct ufs_hba *hba)
> +{
> +	int err = 0;
> +	char name[THERMAL_NAME_LENGTH] = {};
> +
> +	snprintf(name, THERMAL_NAME_LENGTH, "ufs_storage_%d",
> +			hba->host->host_no);
> +
> +	thermal.zone = thermal_zone_device_register(name, UFS_THERM_MAX_TRIPS,
> +			0, hba, &ufs_thermal_ops, NULL, 0, 0);
> +	if (IS_ERR(thermal.zone)) {
> +		err = PTR_ERR(thermal.zone);
> +		dev_err(hba->dev, "Failed to register to thermal zone, err %d\n",
> +				err);
> +		thermal.zone = NULL;
> +		goto out;
> +	}
> +
> +	 /* thermal support is enabled only after successful
> +	  * enablement of thermal exception
> +	  */
> +	if (ufs_thermal_enable_ee(hba)) {
> +		dev_info(hba->dev, "Failed to enable thermal exception\n");
> +		ufs_thermal_zone_unregister(hba);
> +		err = -EINVAL;
> +	}
> +
> +out:
> +	return err;
> +}
> +
> +int ufs_thermal_probe(struct ufs_hba *hba)
> +{
> +	u8 ufs_features;
> +	u8 *desc_buf = NULL;
> +	int err = -EINVAL;
> +
> +	if (!ufshcd_thermal_management_enabled(hba))
> +		goto out;
> +
> +	desc_buf = kzalloc(hba->desc_size.dev_desc, GFP_KERNEL);
> +	if (!desc_buf) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	if (ufshcd_read_desc_param(hba, QUERY_DESC_IDN_DEVICE, 0, 0, desc_buf,
> +			hba->desc_size.dev_desc))
> +		goto out;
> +
> +
> +	ufs_features = desc_buf[DEVICE_DESC_PARAM_UFS_FEAT] &
> +			(UFS_FEATURE_HTEMP | UFS_FEATURE_LTEMP);
> +	if (!ufs_features)
> +		goto out;
> +
> +	err = ufs_thermal_register(hba);
> +	if (err)
> +		goto out;
> +
> +	hba->thermal_features = ufs_features;
> +
> +out:
> +	kfree(desc_buf);
> +	return err;
> +}
> +
> +void ufs_thermal_remove(struct ufs_hba *hba)
> +{
> +	if (!ufshcd_thermal_management_enabled(hba))
> +		return;
> +
> +	 ufs_thermal_zone_unregister(hba);
> +	 hba->thermal_features = 0;
> +}
> diff --git a/drivers/scsi/ufs/ufs-thermal.h b/drivers/scsi/ufs/ufs-thermal.h
> new file mode 100644
> index 0000000..7c0fcbe
> --- /dev/null
> +++ b/drivers/scsi/ufs/ufs-thermal.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 Western Digital Corporation
> + */
> +#ifndef UFS_THERMAL_H
> +#define UFS_THERMAL_H
> +
> +#include "ufshcd.h"
> +#include "ufs.h"
> +
> +#ifdef CONFIG_THERMAL_UFS
> +void ufs_thermal_remove(struct ufs_hba *hba);
> +int ufs_thermal_probe(struct ufs_hba *hba);
> +#else
> +static inline void ufs_thermal_remove(struct ufs_hba *hba) {}
> +static inline int ufs_thermal_probe(struct ufs_hba *hba) {return 0; }
> +#endif /* CONFIG_THERMAL_UFS */
> +
> +#endif /* UFS_THERMAL_H */
> diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
> index dde2eb0..eb729cc 100644
> --- a/drivers/scsi/ufs/ufs.h
> +++ b/drivers/scsi/ufs/ufs.h
> @@ -332,6 +332,17 @@ enum {
>  	UFSHCD_AMP		= 3,
>  };
>  
> +/* UFS Features - to decode bUFSFeaturesSupport */
> +enum {
> +	UFS_FEATURE_FFU		= BIT(0),
> +	UFS_FEATURE_PSA		= BIT(1),
> +	UFS_FEATURE_LIFE		= BIT(2),
> +	UFS_FEATURE_REFRESH		= BIT(3),
> +	UFS_FEATURE_HTEMP		= BIT(4),
> +	UFS_FEATURE_LTEMP		= BIT(5),
> +	UFS_FEATURE_ETEMP		= BIT(6),
> +};
> +
>  #define POWER_DESC_MAX_SIZE			0x62
>  #define POWER_DESC_MAX_ACTV_ICC_LVLS		16
>  
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index abd0e6b..099d2de 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -47,6 +47,7 @@
>  #include "unipro.h"
>  #include "ufs-sysfs.h"
>  #include "ufs_bsg.h"
> +#include "ufs-thermal.h"
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/ufs.h>
> @@ -7111,6 +7112,7 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool async)
>  
>  	/* Enable Auto-Hibernate if configured */
>  	ufshcd_auto_hibern8_enable(hba);
> +	ufs_thermal_probe(hba);
>  
>  out:
>  
> @@ -8278,6 +8280,7 @@ int ufshcd_shutdown(struct ufs_hba *hba)
>   */
>  void ufshcd_remove(struct ufs_hba *hba)
>  {
> +	ufs_thermal_remove(hba);
>  	ufs_bsg_remove(hba);
>  	ufs_sysfs_remove_nodes(hba->dev);
>  	blk_cleanup_queue(hba->tmf_queue);
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index 2ae6c7c..28c0063 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -730,6 +730,11 @@ struct ufs_hba {
>  
>  	struct device		bsg_dev;
>  	struct request_queue	*bsg_queue;
> +
> +#define UFSHCD_CAP_THERMAL_MANAGEMENT (1 << 7)
> +
> +	u8 thermal_features;
> +
>  };
>  
>  /* Returns true if clocks can be gated. Otherwise false */
> @@ -754,6 +759,11 @@ static inline bool ufshcd_is_rpm_autosuspend_allowed(struct ufs_hba *hba)
>  	return hba->caps & UFSHCD_CAP_RPM_AUTOSUSPEND;
>  }
>  
> +static inline bool ufshcd_thermal_management_enabled(struct ufs_hba *hba)
> +{
> +	return hba->caps & UFSHCD_CAP_THERMAL_MANAGEMENT;
> +}
> +
>  static inline bool ufshcd_is_intr_aggr_allowed(struct ufs_hba *hba)
>  {
>  /* DWC UFS Core has the Interrupt aggregation feature but is not detectable*/
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

