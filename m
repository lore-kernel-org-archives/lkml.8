Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD089C35249
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 15:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B982067C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 15:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CWBUJy3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgBBPrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 10:47:49 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:15703 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgBBPrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 10:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580658466; x=1612194466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=rAReo7Ghhyllt4vhzaYwGGfwgZx7+2h3+bZQ0IC2fB4=;
  b=CWBUJy3j2PX5uqUlgKdGVOgg8rOl5sWWI3qsIDtkk7j+wPRtoky+Rwcw
   EJsO8c7Gi1OVM2goykBd2h068siLZWLXvqHm9+6nMN7P9BLreeScJMVaU
   zHLU2ALFCETNwiuY4yFKM8Q73tz8849+/mK7bV1D/8dE5HQ0FwKJU0PU3
   TNtKopgvw6fQx3hm15ssxLOdJi/gCZEI6ct79nL+G27Nk2CKCYfUOeCne
   6ev//etyR1eh7LEZaLYpqhkxd2MG17b6hUU13c/gJxKizTqzhYfAtAoN/
   zjTEQXjDoXdPJ9U3ft7vUceB1V6Tj88X3oX5D0xJVF48ivpXWdwCX3maQ
   g==;
IronPort-SDR: LV722q0NaDtVMO/sduRBiPBBr1bdM9cGarsBr3io57Zu8XmcJJ6l3eV5ehpELVVzpiaUPyap9H
 0xgLKeucsin0LFRewWYd5AndTc5oPJTS2gbKeNNqmJCrrJKPLcr0/6u0xR5l/jOw4saEYMm+9B
 bGOScKkqPvAp0EJAbJ/u0sCD8gFPgrScmMvJ0OA0CPeOD1/likh2nMS577QtAVNQuycHVemY5f
 Zg1GpkEOf/tHzrbbVV6mWZKgwgutF2FHKsAll1f4ccG9MVQOj/nZPyW8wwKCQmeXNkL4xW0kI/
 QzI=
X-IronPort-AV: E=Sophos;i="5.70,394,1574092800"; 
   d="scan'208";a="128932825"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2020 23:47:46 +0800
IronPort-SDR: TVrMQKFd12mBMm0J4ZdfKkIro5fWV6KHALXdDIRqRDBHsc8QbAKaJLJCeZkqCkcJdwmZ8FXi93
 fEsth+0ad8sAp6WTGU+qYrOmIRVw+f5bcyUdm7xZNcWC6GsaWXSAkvJsM+Yn1as4Vr+AGjfQfy
 KpoU0jWElZq1lmqTChCX/sTCq6SmqTaFj3yg2WXFdJEmKOf9VHWV6/Sknz5rlp6hWXfIMXYtLM
 yQRujku6uPqzYrRXdK9yjS22GyuQdQ4Mn7VXhsmWzGHTxesR5/raf7dNLz+lR4shvv7bCVBW02
 M9HZYGNAATDTvzCmWHXqdtSY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2020 07:40:52 -0800
IronPort-SDR: ja2sVxNlWSWVr0eGS5Bk2OcCLxkh8s42kydRC0/F5ydfYw8KlLF5YviS0nfeTVFLa9ALlHLtFu
 ufoJaokkYUIA4TK68Ja8YLxukDGtleU+W88BJjwY0Ga09Up0fGjwcuDXZRF+LROq38a19yJZt3
 08HvPSQvZJNMrIDFJtkJnDTIqn9EbE0axAwxQo01xPraHW7QLoUw4VbvE6VemXQ6JLkPA1lb/E
 rYGHg6r2qmMJh8eXght50VdiT+clmMDQ6NLJ+nRu02q8L+JY+h5+cECLFz19PceklMtr7Fpjzw
 0Mg=
WDCIronportException: Internal
Received: from kfae419068.sdcorp.global.sandisk.com ([10.0.231.195])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Feb 2020 07:47:44 -0800
From:   Avi Shchislowski <avi.shchislowski@wdc.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        linux-kernel@vger.kernel.org
Cc:     Avi Shchislowski <avi.shchislowski@wdc.com>,
        Uri Yanai <uri.yanai@wdc.com>
Subject: [PATCH 4/5] scsi: ufs-thermal: implement thermal file ops
Date:   Sun,  2 Feb 2020 17:47:24 +0200
Message-Id: <1580658445-15232-5-git-send-email-avi.shchislowski@wdc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1580658445-15232-1-git-send-email-avi.shchislowski@wdc.com>
References: <1580658445-15232-1-git-send-email-avi.shchislowski@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal interface adds a new thermal zone device sensor under
/sys/class/thermal/ folder.

Signed-off-by: Uri Yanai <uri.yanai@wdc.com>
Signed-off-by: Avi Shchislowski <avi.shchislowski@wdc.com>
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

