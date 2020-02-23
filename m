Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DA2C35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 09:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36FE208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 09:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j5cVyPpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgBWJfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 04:35:33 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58089 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgBWJfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 04:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582450533; x=1613986533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=mhiWEj9jo20GQL25VpTAaLZQKkx3v3e0N2wZusW2hwc=;
  b=j5cVyPpaelOsKtmx/MN9oiro4zE8MKz2NUyf3FOAyNkV6MD6bFMb5EVj
   PDYN2/1jmWL9un9u1jj9vaXr5rRdPbYKOv9/HWKPfbE9PfZpMcYpwe0Y0
   4m86F4Ajr5Kn9rRN9u61AwIuhwUx+3O2GuM50Nde3ppwJkq9QA8rvXYZw
   C79eR0J9JCEkr5vrlfKXf5hoILJS7yqf7JtbnnnRXHftGLX2xw/UgQfhp
   Snm5a/Ulrj22Rkv8g4roFG8WlkC8KYU4t3oQXCGcSDghVnE8uXQds5Y2k
   3krezKi+nTb2oH6z2/Z/u4GbQbYr4bIhon54qb8AtYrlbT7ZVd9rREDOV
   A==;
IronPort-SDR: dIkXvVqhw4s1KKurAM+pg6IIyAKvjAB8wPSCqs5wkIbE92nNAGeTgcX7q8UdN0Ukhh99JCQ2hX
 tYmw6Oq3T1FondiYCpcCNHJgOVj0SplJw5C/8mNUfaau+/UE5ktWQnrSKMBFrrJmAvqE1dUo/s
 wcnSzudDWmL3h3QIZRRwZbJdJ2JvpZ1YiiE1bC7PVYRHRYrOiHA6vmdlIRsD0xr6oqmgCvTH8H
 LTZc5oD7S6D5tFa4DkreDR13yprzP4YS1KAW+YygOwVzdMGo/Zq3DKxcWkr/nvJLpe3nAxLEC5
 +ic=
X-IronPort-AV: E=Sophos;i="5.70,475,1574092800"; 
   d="scan'208";a="131020040"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2020 17:35:32 +0800
IronPort-SDR: G0MiEzUq4Ttq7etjWmpAD3bzuo71NKnJAt0TjD9DgbMGgcvu30HYsfCI3gWPhlwPnNHTCJq42y
 +Jor7m+BiYUsK48/YYw261/TlXzfPGofV3o8/4p7+zqeF0f8YiNaMIk2HrC48RtNQXi/hhrO1j
 cCcJFC5jPuwYdjlkoY0fVdbfTVzntUF3e6i8rHsdLQp1v2t5cjSHdpM3zGcS/40EO3y5lmAvr9
 EIpYlWQ6YXNIEQdFCW7LT0mYRhg4lZuBn1T2QsG2wU8ISpHAgY8jDCTrc3nVE8ud3tAc5o3huU
 hxRLFOQg3+Taf1pEdeUjvZB7
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 01:28:02 -0800
IronPort-SDR: vkg74PVnGq6B1tFm6fec1mWdYEn3SSrQVepFFpkYui/J+zCQpBVWdA+gD7DqzCHH5A3FXBoyPW
 Hov/cpCZ/+WEDg3jfLwuSkbdWrDZZTapaGx/v2F1ZBfPdPa4bvCrM24Erj1VPOKM112rWRVP0L
 lApEwmL900ZXH9QDCnifuWRioPL+h+x9dBYKSD3IeueVWIiLhyr02Zuy3+xXVjXxJ4Z57UMm2R
 c8eL+EXbCGFkTxBBHH30sZKqWrJTnUsTrTdn7LCpamFzADYrCUjXKRRxAiQ1T7O/bO28orONJu
 uU4=
WDCIronportException: Internal
Received: from kfae419068.sdcorp.global.sandisk.com ([10.0.231.195])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Feb 2020 01:35:27 -0800
From:   Avi Shchislowski <avi.shchislowski@wdc.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, avri.altman@wdc.com,
        avi.shchislowski@wdc.com
Cc:     Avi.shchislowski@wdc.com,
        Avi Shchislowski <avi.shchislowski@sandisk.com>
Subject: [RESEND PATCH 1/5] scsi: ufs: Add ufs thermal support
Date:   Sun, 23 Feb 2020 11:35:18 +0200
Message-Id: <1582450522-13256-2-git-send-email-avi.shchislowski@wdc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1582450522-13256-1-git-send-email-avi.shchislowski@wdc.com>
References: <1582450522-13256-1-git-send-email-avi.shchislowski@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avi Shchislowski <avi.shchislowski@sandisk.com>

Support the new temperature notification attributes introduced in
UFSv3.0. Add exception event mask, and ufs features attributes.

Signed-off-by: Avi Shchislowski <avi.shchislowski@sandisk.com>
---
 drivers/scsi/ufs/Kconfig       |  11 ++++
 drivers/scsi/ufs/Makefile      |   1 +
 drivers/scsi/ufs/ufs-thermal.c | 123 +++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufs-thermal.h |  19 +++++++
 drivers/scsi/ufs/ufs.h         |  11 ++++
 drivers/scsi/ufs/ufshcd.c      |   3 +
 drivers/scsi/ufs/ufshcd.h      |  10 ++++
 7 files changed, 178 insertions(+)
 create mode 100644 drivers/scsi/ufs/ufs-thermal.c
 create mode 100644 drivers/scsi/ufs/ufs-thermal.h

diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
index d14c224..bed56ee 100644
--- a/drivers/scsi/ufs/Kconfig
+++ b/drivers/scsi/ufs/Kconfig
@@ -160,3 +160,14 @@ config SCSI_UFS_BSG
 
 	  Select this if you need a bsg device node for your UFS controller.
 	  If unsure, say N.
+
+config THERMAL_UFS
+	bool "Thermal UFS"
+	depends on THERMAL && SCSI_UFSHCD
+	help
+	  A UFS3.0 feature that allows using the ufs device as a temperature
+	  sensor. it provide notification to the host when the UFS device
+	  case temperature approaches its pre-defined boundaries.
+
+	  Select Y to enable this feature, otherwise say N.
+	  If unsure, say N.
\ No newline at end of file
diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
index 94c6c5d..fd35941 100644
--- a/drivers/scsi/ufs/Makefile
+++ b/drivers/scsi/ufs/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) += ufshcd-pltfrm.o
 obj-$(CONFIG_SCSI_UFS_HISI) += ufs-hisi.o
 obj-$(CONFIG_SCSI_UFS_MEDIATEK) += ufs-mediatek.o
 obj-$(CONFIG_SCSI_UFS_TI_J721E) += ti-j721e-ufs.o
+obj-$(CONFIG_THERMAL_UFS) += ufs-thermal.o
diff --git a/drivers/scsi/ufs/ufs-thermal.c b/drivers/scsi/ufs/ufs-thermal.c
new file mode 100644
index 0000000..469c1ed
--- /dev/null
+++ b/drivers/scsi/ufs/ufs-thermal.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * thermal ufs
+ *
+ * Copyright (C) 2020 Western Digital Corporation
+ */
+#include <linux/thermal.h>
+#include "ufs-thermal.h"
+
+enum {
+	UFS_THERM_MAX_TEMP,
+	UFS_THERM_HIGH_TEMP,
+	UFS_THERM_LOW_TEMP,
+	UFS_THERM_MIN_TEMP,
+
+	/* keep last */
+	UFS_THERM_MAX_TRIPS
+};
+
+/**
+ *struct ufs_thermal - thermal zone related data
+ * @tzone: thermal zone device data
+ */
+static struct ufs_thermal {
+	struct thermal_zone_device *zone;
+} thermal;
+
+static  struct thermal_zone_device_ops ufs_thermal_ops = {
+	.get_temp = NULL,
+	.get_trip_temp = NULL,
+	.get_trip_type = NULL,
+};
+
+static int ufs_thermal_enable_ee(struct ufs_hba *hba)
+{
+	/* later */
+	return -EINVAL;
+}
+
+static void ufs_thermal_zone_unregister(struct ufs_hba *hba)
+{
+	if (thermal.zone) {
+		dev_dbg(hba->dev, "Thermal zone device unregister\n");
+		thermal_zone_device_unregister(thermal.zone);
+		thermal.zone = NULL;
+	}
+}
+
+static int ufs_thermal_register(struct ufs_hba *hba)
+{
+	int err = 0;
+	char name[THERMAL_NAME_LENGTH] = {};
+
+	snprintf(name, THERMAL_NAME_LENGTH, "ufs_storage_%d",
+			hba->host->host_no);
+
+	thermal.zone = thermal_zone_device_register(name, UFS_THERM_MAX_TRIPS,
+			0, hba, &ufs_thermal_ops, NULL, 0, 0);
+	if (IS_ERR(thermal.zone)) {
+		err = PTR_ERR(thermal.zone);
+		dev_err(hba->dev, "Failed to register to thermal zone, err %d\n",
+				err);
+		thermal.zone = NULL;
+		goto out;
+	}
+
+	 /* thermal support is enabled only after successful
+	  * enablement of thermal exception
+	  */
+	if (ufs_thermal_enable_ee(hba)) {
+		dev_info(hba->dev, "Failed to enable thermal exception\n");
+		ufs_thermal_zone_unregister(hba);
+		err = -EINVAL;
+	}
+
+out:
+	return err;
+}
+
+int ufs_thermal_probe(struct ufs_hba *hba)
+{
+	u8 ufs_features;
+	u8 *desc_buf = NULL;
+	int err = -EINVAL;
+
+	if (!ufshcd_thermal_management_enabled(hba))
+		goto out;
+
+	desc_buf = kzalloc(hba->desc_size.dev_desc, GFP_KERNEL);
+	if (!desc_buf) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	if (ufshcd_read_desc_param(hba, QUERY_DESC_IDN_DEVICE, 0, 0, desc_buf,
+			hba->desc_size.dev_desc))
+		goto out;
+
+
+	ufs_features = desc_buf[DEVICE_DESC_PARAM_UFS_FEAT] &
+			(UFS_FEATURE_HTEMP | UFS_FEATURE_LTEMP);
+	if (!ufs_features)
+		goto out;
+
+	err = ufs_thermal_register(hba);
+	if (err)
+		goto out;
+
+	hba->thermal_features = ufs_features;
+
+out:
+	kfree(desc_buf);
+	return err;
+}
+
+void ufs_thermal_remove(struct ufs_hba *hba)
+{
+	if (!ufshcd_thermal_management_enabled(hba))
+		return;
+
+	 ufs_thermal_zone_unregister(hba);
+	 hba->thermal_features = 0;
+}
diff --git a/drivers/scsi/ufs/ufs-thermal.h b/drivers/scsi/ufs/ufs-thermal.h
new file mode 100644
index 0000000..7c0fcbe
--- /dev/null
+++ b/drivers/scsi/ufs/ufs-thermal.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Western Digital Corporation
+ */
+#ifndef UFS_THERMAL_H
+#define UFS_THERMAL_H
+
+#include "ufshcd.h"
+#include "ufs.h"
+
+#ifdef CONFIG_THERMAL_UFS
+void ufs_thermal_remove(struct ufs_hba *hba);
+int ufs_thermal_probe(struct ufs_hba *hba);
+#else
+static inline void ufs_thermal_remove(struct ufs_hba *hba) {}
+static inline int ufs_thermal_probe(struct ufs_hba *hba) {return 0; }
+#endif /* CONFIG_THERMAL_UFS */
+
+#endif /* UFS_THERMAL_H */
diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index dde2eb0..eb729cc 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -332,6 +332,17 @@ enum {
 	UFSHCD_AMP		= 3,
 };
 
+/* UFS Features - to decode bUFSFeaturesSupport */
+enum {
+	UFS_FEATURE_FFU		= BIT(0),
+	UFS_FEATURE_PSA		= BIT(1),
+	UFS_FEATURE_LIFE		= BIT(2),
+	UFS_FEATURE_REFRESH		= BIT(3),
+	UFS_FEATURE_HTEMP		= BIT(4),
+	UFS_FEATURE_LTEMP		= BIT(5),
+	UFS_FEATURE_ETEMP		= BIT(6),
+};
+
 #define POWER_DESC_MAX_SIZE			0x62
 #define POWER_DESC_MAX_ACTV_ICC_LVLS		16
 
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index abd0e6b..099d2de 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -47,6 +47,7 @@
 #include "unipro.h"
 #include "ufs-sysfs.h"
 #include "ufs_bsg.h"
+#include "ufs-thermal.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/ufs.h>
@@ -7111,6 +7112,7 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool async)
 
 	/* Enable Auto-Hibernate if configured */
 	ufshcd_auto_hibern8_enable(hba);
+	ufs_thermal_probe(hba);
 
 out:
 
@@ -8278,6 +8280,7 @@ int ufshcd_shutdown(struct ufs_hba *hba)
  */
 void ufshcd_remove(struct ufs_hba *hba)
 {
+	ufs_thermal_remove(hba);
 	ufs_bsg_remove(hba);
 	ufs_sysfs_remove_nodes(hba->dev);
 	blk_cleanup_queue(hba->tmf_queue);
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 2ae6c7c..28c0063 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -730,6 +730,11 @@ struct ufs_hba {
 
 	struct device		bsg_dev;
 	struct request_queue	*bsg_queue;
+
+#define UFSHCD_CAP_THERMAL_MANAGEMENT (1 << 7)
+
+	u8 thermal_features;
+
 };
 
 /* Returns true if clocks can be gated. Otherwise false */
@@ -754,6 +759,11 @@ static inline bool ufshcd_is_rpm_autosuspend_allowed(struct ufs_hba *hba)
 	return hba->caps & UFSHCD_CAP_RPM_AUTOSUSPEND;
 }
 
+static inline bool ufshcd_thermal_management_enabled(struct ufs_hba *hba)
+{
+	return hba->caps & UFSHCD_CAP_THERMAL_MANAGEMENT;
+}
+
 static inline bool ufshcd_is_intr_aggr_allowed(struct ufs_hba *hba)
 {
 /* DWC UFS Core has the Interrupt aggregation feature but is not detectable*/
-- 
1.9.1

