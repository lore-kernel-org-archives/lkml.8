Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA11DC35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 09:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C98208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 09:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AGmxGv3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgBWJf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 04:35:59 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:33764 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbgBWJf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 04:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582450558; x=1613986558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=MCaxS1cxBQjYWUX34ixMu6TpXxrzDXEmdNY7B98w0eE=;
  b=AGmxGv3Hgw0i9p3Qy1FQCPSpv7a5nCBakLGBn9sEazBpCu/q7VMyJP0a
   g8Lkv613GgC4obAASBaGxrkiDyKdgi9bRNCPP1OE7Liy7Q6CDAeTP59au
   TQ53rtv7bzfgU7Y+YOBBBer+bA0fLHYybtBj0KdNn5kjryrdDeLQs+S2n
   4lgd+BWofSfsK5kpDv0Gi/o7Rc9t+wxEDOw5xwQ8vR66CRpgZeDaFLQd+
   u3DvbCuwW7+XPxeiSYze18p3Ymo/ceEl/kqCRTu4GYBC+46h+Joazw2wa
   uH3ooCIBQPsN28ShZo7RhxmKrZ954WaACvSe3gWUqe3+zSApr0JonMtj4
   w==;
IronPort-SDR: 2ZIYa/RwKdES51fZ3bTpll8bcVvOd2cnJktGHZKKkgQ+1Rm1UOExp/aXLostACEW8dHOhvq2s/
 ZSejQ2+7qp7uVi/2phKZanj/y8EEck8q8CHAyV7EPcg3XAL32rKd+4h/TytUkAngm2BQGdK+/Y
 q3iHp8gQqE23JeJLuqvNDlA2lW05VrNItTQ0l6gNw7ci32iC70F0bZH9S16h53xGZ0tYQMUpS7
 E1qZg98zUOwINENAJNLsnEdXiFOnZk1y/NGtczIOKPeIy9MFfij9xHarqiBy4MYMFtSpug9dc8
 Dps=
X-IronPort-AV: E=Sophos;i="5.70,475,1574092800"; 
   d="scan'208";a="131020060"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2020 17:35:46 +0800
IronPort-SDR: /LY3ZP6LgGZACLDplcjOvOdumFQAtjRTJppRcgtL0Bl00DIv9jXZj+IFKtaF1nsfl1ww/wU/ip
 dXIIqjHMvPN9QQ7hO5/8gxXuilOtA/psaliAyTY9OipR68N1AL0eEkYE4MDVaksqdY1PE9eI0l
 uw2FSaFUfeDT3H9X6PKoSO6UP+1zwS27xAQjWVfPszW5zrJTj8J8bDlrGgh3bvO5c7Trq226kf
 sL2/n9W4LlOLeY+klmWeMePo5KnQUSYFXBP9UHjDqAvB1mh2W29EXoP5B6uF3so4KuNDjl0ZzE
 onnhZ0wW541habbYbH7wBNu2
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 01:28:16 -0800
IronPort-SDR: X+2ZyEbsntDnnyVMIPWX1VW3o3s75m6gyAV2Mb4f5q43/YykjxfnV4/B8uFOq9I2zDply0PwqG
 b6hNqej8Q48D1o6Dk0Sn2iqRAkHdxzwfjsgssV/BzMoLF0C1f6n5WK2des2yE0JCxOmbNUbkMX
 HpEx92QAtbDOkyqYphz0LEhB/2r62KToSu1DF4DE+GHKDZgXrwY+RHLHkt+ugHNeo4SplUNbwY
 zmV5E+m0EHxsleG5WtheAqCKoACcfIh4BlIxdk1iew4H2mxDc6DXPHgoz60tz/TRjlVThGNS3p
 IQM=
WDCIronportException: Internal
Received: from kfae419068.sdcorp.global.sandisk.com ([10.0.231.195])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Feb 2020 01:35:41 -0800
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
Subject: [RESEND PATCH 4/5] scsi: ufs-thermal: implement thermal file ops
Date:   Sun, 23 Feb 2020 11:35:21 +0200
Message-Id: <1582450522-13256-5-git-send-email-avi.shchislowski@wdc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1582450522-13256-1-git-send-email-avi.shchislowski@wdc.com>
References: <1582450522-13256-1-git-send-email-avi.shchislowski@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avi Shchislowski <avi.shchislowski@sandisk.com>

The thermal interface adds a new thermal zone device sensor under
/sys/class/thermal/ folder.

Signed-off-by: Avi Shchislowski <avi.shchislowski@sandisk.com>
---
 drivers/scsi/ufs/ufs-thermal.c | 122 ++++++++++++++++++++++++++++++++++++++---
 drivers/scsi/ufs/ufs.h         |   3 +
 2 files changed, 117 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-thermal.c b/drivers/scsi/ufs/ufs-thermal.c
index dfa5d68..23e4ac1 100644
--- a/drivers/scsi/ufs/ufs-thermal.c
+++ b/drivers/scsi/ufs/ufs-thermal.c
@@ -31,6 +31,99 @@ enum {
 		}
 };
 
+#define attr2milicelcius(attr) (((0xFF & attr) - 80) * 1000)
+
+static int ufs_thermal_get_temp(struct thermal_zone_device *device,
+				  int *temperature)
+{
+	struct ufs_hba *hba = (struct ufs_hba *)device->devdata;
+	u32 temp;
+	int err;
+
+	err = ufshcd_query_attr(hba,
+			UPIU_QUERY_OPCODE_READ_ATTR,
+			QUERY_ATTR_IDN_ROUGH_TEMP,
+			0, 0, &temp);
+	if (err)
+		return -EINVAL;
+
+	*temperature = attr2milicelcius(temp);
+	return 0;
+}
+
+static int ufs_thermal_get_trip_temp(
+		struct thermal_zone_device *device,
+				 int trip, int *temp)
+{
+
+	if (trip < 0 || trip >= UFS_THERM_MAX_TRIPS)
+		return -EINVAL;
+
+	*temp = thermal.trip[trip];
+
+	return 0;
+}
+
+static int ufs_thermal_get_trip_type(
+		struct thermal_zone_device *device,
+		int trip, enum thermal_trip_type *type)
+{
+	if (trip < 0 || trip >= UFS_THERM_MAX_TRIPS)
+		return -EINVAL;
+
+	*type = THERMAL_TRIP_PASSIVE;
+
+	return 0;
+}
+
+static int ufs_thermal_get_boundary(struct ufs_hba *hba,
+					int trip, int *boundary)
+{
+	enum attr_idn idn;
+	int err = 0;
+	u32 val;
+
+	idn = trip == UFS_THERM_HIGH_TEMP ?
+			QUERY_ATTR_IDN_TOO_HIGH_TEMP :
+			QUERY_ATTR_IDN_TOO_LOW_TEMP;
+
+	err = ufshcd_query_attr(hba,
+			UPIU_QUERY_OPCODE_READ_ATTR,
+			idn, 0, 0, &val);
+	if (err) {
+		dev_err(hba->dev,
+		"Failed to get device too %s temperature boundary\n",
+		trip == UFS_THERM_HIGH_TEMP ? "high" : "low");
+		goto out;
+	}
+
+	if (val < 1 || val > 250) {
+		dev_err(hba->dev, "out of device temperature boundary\n");
+		err = -EINVAL;
+		goto out;
+	}
+
+	*boundary = attr2milicelcius(val);
+
+out:
+	return err;
+}
+
+static int ufs_thermal_set_trip(struct ufs_hba *hba, int trip)
+{
+	int temp;
+	int err = 0;
+
+	err = ufs_thermal_get_boundary(hba, trip, &temp);
+	if (err)
+		return err;
+
+	thermal.trip[trip] = temp;
+
+	return err;
+
+}
+
 void ufs_thermal_exception_event_handler(struct ufs_hba *hba,
 		u32 exception_status)
 {
@@ -46,17 +139,12 @@ void ufs_thermal_exception_event_handler(struct ufs_hba *hba,
 	}
 }
 
-static  struct thermal_zone_device_ops ufs_thermal_ops = {
-	.get_temp = NULL,
-	.get_trip_temp = NULL,
-	.get_trip_type = NULL,
-};
-
 static int ufs_thermal_enable_ee(struct ufs_hba *hba)
 {
 	return ufshcd_enable_ee(hba, MASK_EE_URGENT_TEMP);
 }
 
+
 static void ufs_thermal_zone_unregister(struct ufs_hba *hba)
 {
 	if (thermal.zone) {
@@ -66,7 +154,13 @@ static void ufs_thermal_zone_unregister(struct ufs_hba *hba)
 	}
 }
 
-static int ufs_thermal_register(struct ufs_hba *hba)
+static  struct thermal_zone_device_ops ufs_thermal_ops = {
+	.get_temp = ufs_thermal_get_temp,
+	.get_trip_temp = ufs_thermal_get_trip_temp,
+	.get_trip_type = ufs_thermal_get_trip_type,
+};
+
+static int ufs_thermal_register(struct ufs_hba *hba, u8 ufs_features)
 {
 	int err = 0;
 	char name[THERMAL_NAME_LENGTH] = {};
@@ -74,6 +168,18 @@ static int ufs_thermal_register(struct ufs_hba *hba)
 	snprintf(name, THERMAL_NAME_LENGTH, "ufs_storage_%d",
 			hba->host->host_no);
 
+	if (ufs_features & UFS_FEATURE_HTEMP) {
+		err = ufs_thermal_set_trip(hba, UFS_THERM_HIGH_TEMP);
+		if (err)
+			goto out;
+	}
+
+	if (ufs_features & UFS_FEATURE_LTEMP) {
+		err = ufs_thermal_set_trip(hba, UFS_THERM_LOW_TEMP);
+		if (err)
+			goto out;
+	}
+
 	thermal.zone = thermal_zone_device_register(name, UFS_THERM_MAX_TRIPS,
 			0, hba, &ufs_thermal_ops, NULL, 0, 0);
 	if (IS_ERR(thermal.zone)) {
@@ -122,7 +228,7 @@ int ufs_thermal_probe(struct ufs_hba *hba)
 	if (!ufs_features)
 		goto out;
 
-	err = ufs_thermal_register(hba);
+	err = ufs_thermal_register(hba, ufs_features);
 	if (err)
 		goto out;
 
diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index 8fc0b0c..9f8224b 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -167,6 +167,9 @@ enum attr_idn {
 	QUERY_ATTR_IDN_FFU_STATUS		= 0x14,
 	QUERY_ATTR_IDN_PSA_STATE		= 0x15,
 	QUERY_ATTR_IDN_PSA_DATA_SIZE		= 0x16,
+	QUERY_ATTR_IDN_ROUGH_TEMP		= 0x18,
+	QUERY_ATTR_IDN_TOO_HIGH_TEMP		= 0x19,
+	QUERY_ATTR_IDN_TOO_LOW_TEMP		= 0x1A,
 };
 
 /* Descriptor idn for Query requests */
-- 
1.9.1

