Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36A2C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 12:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E3512074B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 12:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgGRMcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 08:32:20 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:53360 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgGRMcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 08:32:20 -0400
Received: from MUA
        by vps-vb.mhejs.net with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.93.0.4)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1jwm0m-0004fW-J7; Sat, 18 Jul 2020 14:32:16 +0200
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] hwmon: (drivetemp) Avoid SCT usage on Toshiba DT01ACA family drives
Date:   Sat, 18 Jul 2020 14:32:10 +0200
Message-Id: <0cb2e7022b66c6d21d3f189a12a97878d0e7511b.1595075458.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been observed that Toshiba DT01ACA family drives have
WRITE FPDMA QUEUED command timeouts and sometimes just freeze until
power-cycled under heavy write loads when their temperature is getting
polled in SCT mode. The SMART mode seems to be fine, though.

Let's make sure we don't use SCT mode for these drives then.

While only the 3 TB model was actually caught exhibiting the problem let's
play safe here to avoid data corruption and extend the ban to the whole
family.

Fixes: 5b46903d8bf3 ("hwmon: Driver for disk and solid state drives with temperature sensors")
Cc: stable@vger.kernel.org
Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---

Notes:
    This behavior was observed on two different DT01ACA3 drives.
    
    Usually, a series of queued WRITE FPDMA QUEUED commands just time out,
    but sometimes the whole drive freezes. Merely disconnecting and
    reconnecting SATA interface cable then does not unfreeze the drive.
    
    One has to disconnect and reconnect the drive power connector for the
    drive to be detected again (suggesting the drive firmware itself has
    crashed).
    
    This only happens when the drive temperature is polled very often (like
    every second), so occasional SCT usage via smartmontools is probably
    safe.
    
    Changes from v1:
    'SCT blacklist' -> 'SCT avoid models'
    
    Changes from v2:
    * Switch to prefix matching and use it to match the DT01ACAx family,
    
    * Use "!" instead of "== 0",
    
    * Add a comment about the contents of the "model" field.

 drivers/hwmon/drivetemp.c | 43 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/hwmon/drivetemp.c b/drivers/hwmon/drivetemp.c
index 0d4f3d97ffc6..72c760373957 100644
--- a/drivers/hwmon/drivetemp.c
+++ b/drivers/hwmon/drivetemp.c
@@ -285,6 +285,42 @@ static int drivetemp_get_scttemp(struct drivetemp_data *st, u32 attr, long *val)
 	return err;
 }
 
+static const char * const sct_avoid_models[] = {
+/*
+ * These drives will have WRITE FPDMA QUEUED command timeouts and sometimes just
+ * freeze until power-cycled under heavy write loads when their temperature is
+ * getting polled in SCT mode. The SMART mode seems to be fine, though.
+ *
+ * While only the 3 TB model (DT01ACA3) was actually caught exhibiting the
+ * problem let's play safe here to avoid data corruption and ban the whole
+ * DT01ACAx family.
+
+ * The models from this array are prefix-matched.
+ */
+	"TOSHIBA DT01ACA",
+};
+
+static bool drivetemp_sct_avoid(struct drivetemp_data *st)
+{
+	struct scsi_device *sdev = st->sdev;
+	unsigned int ctr;
+
+	if (!sdev->model)
+		return false;
+
+	/*
+	 * The "model" field contains just the raw SCSI INQUIRY response
+	 * "product identification" field, which has a width of 16 bytes.
+	 * This field is space-filled, but is NOT NULL-terminated.
+	 */
+	for (ctr = 0; ctr < ARRAY_SIZE(sct_avoid_models); ctr++)
+		if (!strncmp(sdev->model, sct_avoid_models[ctr],
+			     strlen(sct_avoid_models[ctr])))
+			return true;
+
+	return false;
+}
+
 static int drivetemp_identify_sata(struct drivetemp_data *st)
 {
 	struct scsi_device *sdev = st->sdev;
@@ -326,6 +362,13 @@ static int drivetemp_identify_sata(struct drivetemp_data *st)
 	/* bail out if this is not a SATA device */
 	if (!is_ata || !is_sata)
 		return -ENODEV;
+
+	if (have_sct && drivetemp_sct_avoid(st)) {
+		dev_notice(&sdev->sdev_gendev,
+			   "will avoid using SCT for temperature monitoring\n");
+		have_sct = false;
+	}
+
 	if (!have_sct)
 		goto skip_sct;
 
