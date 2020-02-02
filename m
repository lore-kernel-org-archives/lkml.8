Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5FFC35249
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 15:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576A72067C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 15:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FAnbJKgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgBBPrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 10:47:37 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:15703 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgBBPrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 10:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580658455; x=1612194455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=mL+pSGCYlrKyit46RFmfv6r8QXFWeRdsOxWCMEsG/0g=;
  b=FAnbJKgYiM2iULAvOGaq7xkt3/xUQlWnlNu3ZFkWS6SFUkycnFYq8K1i
   7i9KjFg9f3hH8/TUTuID1XuSMtCzI6BDxEJm8XmPuYBfHvEnxSGXit53B
   ae6CsgcudlNLVCtmrFnCeYiI5HL0N6JGiZ0uWnSOmnO0TSDsEdCOX9Due
   L7ScNTpfgTBItSMBcIP6LF1nNmQtiqmUl8eD8YZaxpFydc/5KKf3N24b+
   hvnYKA3dd2DHqex0sg81l2ZtIaPOAU7ZTKLUSpCQba2bWkAv4HYu9yqFH
   SFZ4HT7kflNhZvtvdw6ptIRNrkaj3IvojnYC10GRBtS+IRMzHG0F+VqR4
   A==;
IronPort-SDR: zu/VGSEBetYuGF/5gtUV34hyc1kqWETTTd1YQJVneRvb9oEEGIhpmPHOh/82JfEKGDPIbOPREq
 Q92aWxbSuHLdqOOmZ4x7CASj63wh76s+Um7xI9cB0B4Xm+dolYr/ODfRGWdsYVf1qFP9P6bPIb
 OcQh4WfJLxNEk3wO/xooYf9I48KIJcSFqor7ZA7zAQNkQkzneS483aDCQGZJG6dCfJb0XHxBPy
 KETBjkgvwrnSHDR/GFqt15SQt9W1PU/yO59bK7lkIg92NSMXBibPLgYT8tISCnsyfk8DFFSB1K
 2iE=
X-IronPort-AV: E=Sophos;i="5.70,394,1574092800"; 
   d="scan'208";a="128932816"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2020 23:47:35 +0800
IronPort-SDR: BT4ViUyMrI/sQEMiNw2HHJgSW/GPewba+2rmZV0K8COeGpofkOCVhcNaMkk8d/DWWI8ljAetn+
 48htDTnzD9YPDpFMfLDelujEajgTuFRWH5Ybl/VU5CbwW4B7/A8I8BY9JLxipOc97dWvwBXkhd
 SF9ZSepZ/D3UfFDbfhL94vYPyuaMVAeYmUX5La2LUdLrqNHLKKHjMNsgxusmzroJCYRB2ttkbW
 4bO2SY7jFGRftgtVi/Vat5lslUEXAPx2sqg9GMThjHuHVNct/kinlDyTYYc0lPAONI/I6pXl1I
 fSMIgh3L3ZAPPtUieLxYxrFx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2020 07:40:41 -0800
IronPort-SDR: b69Im3XvcT75NBHYY2O37ebVaI9rCvNt0n4+eT+JfOYeti6TW0FaRrY3wE5HwS0YL/E+ztPFsp
 PDNV7lGor8I7P0VqzkdofdBbJAFzmYYNdBFHqyK503t6S9uu2ug1cVQlQpjkcXsvDyZ+dweVB1
 KZzU83vF3NZ+Qm51LtLHAyxNBkcNDJnpbph0PXsiSr98Ybmu3zhiIhdXBlUW3iQ89jYyNxlCq2
 FGWA/3QXlY0d5LlZV1Nss5RIpTu4ulopXrFGuhj6ITFJulKzMpE2c4ikIf6n0K/wb/y5A5RAgL
 8Qs=
WDCIronportException: Internal
Received: from kfae419068.sdcorp.global.sandisk.com ([10.0.231.195])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Feb 2020 07:47:34 -0800
From:   Avi Shchislowski <avi.shchislowski@wdc.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        linux-kernel@vger.kernel.org
Cc:     Avi Shchislowski <avi.shchislowski@wdc.com>,
        Uri Yanai <uri.yanai@wdc.com>
Subject: [PATCH 1/5] scsi: ufs: Add ufs thermal support
Date:   Sun,  2 Feb 2020 17:47:21 +0200
Message-Id: <1580658445-15232-2-git-send-email-avi.shchislowski@wdc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1580658445-15232-1-git-send-email-avi.shchislowski@wdc.com>
References: <1580658445-15232-1-git-send-email-avi.shchislowski@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support the new temperature notification attributes introduced in
UFSv3.0. Add exception event mask, and ufs features attributes.

Signed-off-by: Uri Yanai <uri.yanai@wdc.com>
Signed-off-by: Avi Shchislowski <avi.shchislowski@wdc.com>
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

