Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E688C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 09:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E5C208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 09:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WCK37C1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgBWJf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 04:35:58 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:33764 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgBWJf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 04:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582450558; x=1613986558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N6kuTGSNK/OGsUZeQItlE8w82Sio3eDGSQNRqrdqZ08=;
  b=WCK37C1EEZyAEcCCskD0KR+5uTUyNpNOkaPLVspIcTIyeFpeFslg6LnB
   R6qmniE/F3aAKBNEjHRs71oBjVdPZB2QSz4u041IASHFD5Ix6IcBKbonB
   GyfCQ/riNmXaSb82t+RMSADQH7kKR1Q82RyUIBss/rWcjDK+31KGYxGSC
   t4N5TBDGQRxOnblEH3H2GocnSBdOPwUquoF2UbUlymQ194jGw1CJcaaDP
   fOR3XeEYJ9lSnaRbiJlbdLTuzcsj2EetJ1Xk8TzibSjSQPZtFDk3/HO91
   morqIExZco1dRctzBRNHTA3jugzw/qPbF3g8LYal3l5B+h7xwG0EUT6uy
   Q==;
IronPort-SDR: ZhMGrqMSI1b6aVaoD+1rahkE10Vi2yhDnabBurjpBro5jevAFSgOZ84aMyBgEJMs2b9ij+q/eg
 hHlQVBW0aVP2Wce9hHwRCMqHh09YUO89xogGNrTKR93IkNVMh5plVLCJaA40mBO0q6o015kEUj
 IQjA60WfTFDrbzThUIUIlZq6Z1qCn9C0TeREMtrgMgh0mA+5a3Xx5zKIqt03PKHFQ2dAqCfclU
 l5BLTnWyO+pzS0kCkXju6uo3yeSs50cNwIDOpEX5X1pceaMu0QNUFXPYF6lpA31XflEIn8icDH
 hZ4=
X-IronPort-AV: E=Sophos;i="5.70,475,1574092800"; 
   d="scan'208";a="131020055"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2020 17:35:42 +0800
IronPort-SDR: ils6b9XAB8HUVYvrAuYpHsYx87iGRuy6hqx9kz/lSX58QwCcEcSTFLSFWSV9fBdGQVs0UjjIqL
 gTl8NQYr1xY2DP2cCPtRohwLMvcnumwGyBaoj+XvwTk7v/1OjSB9zC3eSYxK6y4RIxYPzzaOfl
 rTElgF3FzPpIBsbUcqvQRpgNz7mdzSdeuk+js7QwgbljqglZHdbmYbVavRNU53UKSUra5pS56T
 7lYX3lZ082QQIRjgF/iJ+KCExu4kKXNkmgrJ+kCKtrC/wIqKMZPSscaJuqo0ewHnrA1ctjq3g9
 s31amIDa6doTVA7CBJErFW6G
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 01:28:11 -0800
IronPort-SDR: didsnNn7AUGo4IK4gP7Acs2CbfxJXyIFYEZCoFIGTq+bsR99Qw+Mhw5fJHgdnYeMhoPAiBmRZG
 52rZ+nwMNNntwABM4fYhw8iAwkIOtvN3YKnwmuMaLV+fg36t5d3A892Qjo8VJXAcSB5Q09YwvT
 y4h0J44lCqGX9INAiBG+3HVTB4oa1wdLeNhhX2P4imrOb+CgAt/zoALVGzOBMG0Hkahhu5O43v
 BlAuYvCOjP+mFbGwDLW0x0sjfmrTTLz21L48fjLLdAyuHWJlZx3eowtaGmBEzy45M9lQ5yMQtj
 ORA=
WDCIronportException: Internal
Received: from kfae419068.sdcorp.global.sandisk.com ([10.0.231.195])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Feb 2020 01:35:36 -0800
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
Subject: [RESEND PATCH 3/5] scsi: ufs: enable thermal exception event
Date:   Sun, 23 Feb 2020 11:35:20 +0200
Message-Id: <1582450522-13256-4-git-send-email-avi.shchislowski@wdc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1582450522-13256-1-git-send-email-avi.shchislowski@wdc.com>
References: <1582450522-13256-1-git-send-email-avi.shchislowski@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avi Shchislowski <avi.shchislowski@sandisk.com>

The host might need to be aware of the device's temperature, when it's
too high or too low. Should such event occur, the device is expected
to notify it to the host by using the exception event mechanism.

E.g. when TOO_HIGH_TEMP in wExceptionEventStatus is raised, it is
recommended to perform thermal throttling or other cooling activities
for lowering the device Tcase temperature. Similarly, when
TOO_LOW_TEMP is raised, it is recommended to take an applicable
actions to increase the device’s Tcase temperature.

Signed-off-by: Avi Shchislowski <avi.shchislowski@sandisk.com>
---
 drivers/scsi/ufs/ufs-thermal.c | 28 ++++++++++++++++++++++++----
 drivers/scsi/ufs/ufs-thermal.h |  6 ++++++
 drivers/scsi/ufs/ufs.h         |  6 +++++-
 drivers/scsi/ufs/ufshcd.c      |  4 ++++
 4 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-thermal.c b/drivers/scsi/ufs/ufs-thermal.c
index 469c1ed..dfa5d68 100644
--- a/drivers/scsi/ufs/ufs-thermal.c
+++ b/drivers/scsi/ufs/ufs-thermal.c
@@ -19,11 +19,32 @@ enum {
 
 /**
  *struct ufs_thermal - thermal zone related data
- * @tzone: thermal zone device data
+ * @trip: trip array
  */
 static struct ufs_thermal {
 	struct thermal_zone_device *zone;
-} thermal;
+	int trip[UFS_THERM_MAX_TRIPS];
+} thermal = {
+		.trip = {
+			[UFS_THERM_MAX_TEMP] = 170 * 1000,
+			[UFS_THERM_MIN_TEMP] = -79 * 1000
+		}
+};
+
+void ufs_thermal_exception_event_handler(struct ufs_hba *hba,
+		u32 exception_status)
+{
+	if (WARN_ON_ONCE(!hba->thermal_features))
+		return;
+
+	if (exception_status & MASK_EE_TOO_HIGH_TEMP) {
+		thermal_notify_framework(thermal.zone, UFS_THERM_HIGH_TEMP);
+		dev_info(hba->dev, "High temperature raised\n");
+	} else if (exception_status & MASK_EE_TOO_LOW_TEMP) {
+		thermal_notify_framework(thermal.zone, UFS_THERM_LOW_TEMP);
+		dev_info(hba->dev, "Low temperature raised\n");
+	}
+}
 
 static  struct thermal_zone_device_ops ufs_thermal_ops = {
 	.get_temp = NULL,
@@ -33,8 +54,7 @@ enum {
 
 static int ufs_thermal_enable_ee(struct ufs_hba *hba)
 {
-	/* later */
-	return -EINVAL;
+	return ufshcd_enable_ee(hba, MASK_EE_URGENT_TEMP);
 }
 
 static void ufs_thermal_zone_unregister(struct ufs_hba *hba)
diff --git a/drivers/scsi/ufs/ufs-thermal.h b/drivers/scsi/ufs/ufs-thermal.h
index 7c0fcbe..285049e 100644
--- a/drivers/scsi/ufs/ufs-thermal.h
+++ b/drivers/scsi/ufs/ufs-thermal.h
@@ -11,9 +11,15 @@
 #ifdef CONFIG_THERMAL_UFS
 void ufs_thermal_remove(struct ufs_hba *hba);
 int ufs_thermal_probe(struct ufs_hba *hba);
+void ufs_thermal_exception_event_handler(struct ufs_hba *hba,
+		u32 exception_status);
 #else
 static inline void ufs_thermal_remove(struct ufs_hba *hba) {}
 static inline int ufs_thermal_probe(struct ufs_hba *hba) {return 0; }
+void ufs_thermal_exception_event_handler(struct ufs_hba *hba,
+		u32 exception_status)
+{
+}
 #endif /* CONFIG_THERMAL_UFS */
 
 #endif /* UFS_THERMAL_H */
diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index eb729cc..8fc0b0c 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -363,7 +363,9 @@ enum power_desc_param_offset {
 /* Exception event mask values */
 enum {
 	MASK_EE_STATUS		= 0xFFFF,
-	MASK_EE_URGENT_BKOPS	= (1 << 2),
+	MASK_EE_URGENT_BKOPS	= BIT(2),
+	MASK_EE_TOO_HIGH_TEMP	= BIT(3),
+	MASK_EE_TOO_LOW_TEMP	= BIT(4),
 };
 
 /* Background operation status */
@@ -375,6 +377,8 @@ enum bkops_status {
 	BKOPS_STATUS_MAX		 = BKOPS_STATUS_CRITICAL,
 };
 
+#define MASK_EE_URGENT_TEMP (MASK_EE_TOO_HIGH_TEMP | MASK_EE_TOO_LOW_TEMP)
+
 /* UTP QUERY Transaction Specific Fields OpCode */
 enum query_opcode {
 	UPIU_QUERY_OPCODE_NOP		= 0x0,
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index f25b93c..45fb52d 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -42,6 +42,7 @@
 #include <linux/nls.h>
 #include <linux/of.h>
 #include <linux/bitfield.h>
+#include <linux/thermal.h>
 #include "ufshcd.h"
 #include "ufs_quirks.h"
 #include "unipro.h"
@@ -5183,6 +5184,9 @@ static void ufshcd_exception_event_handler(struct work_struct *work)
 	if (status & MASK_EE_URGENT_BKOPS)
 		ufshcd_bkops_exception_event_handler(hba);
 
+	if (status & MASK_EE_URGENT_TEMP)
+		ufs_thermal_exception_event_handler(hba, status);
+
 out:
 	ufshcd_scsi_unblock_requests(hba);
 	pm_runtime_put_sync(hba->dev);
-- 
1.9.1

