Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B4AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC492158C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=superboring.dev header.i=@superboring.dev header.b="YQCeKGMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389285AbgFSTeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388902AbgFSTeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:34:09 -0400
Received: from mail.halogenos.org (halogenos.org [IPv6:2a02:c207:2037:5246::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FFAC0613EF
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:34:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 62B031500CE3;
        Fri, 19 Jun 2020 21:34:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=superboring.dev;
        s=dkim; t=1592595247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awsFxEF/sNjp0VX4lCp7zqPmM4Wdw/eUKaN6ptw5AeM=;
        b=YQCeKGMni/WatpHR8m9auurSAzi3E9y4+R+DUdb6iaJeM2W70xwjumGASsnifYf/O7w0e4
        sehplCi5f4Z4oB30ZRTzM9uQaq023VhlgyEVuRd1JF2kAKCHZdccs+9kCvhQwF24rt4Hha
        TXybFPezla5tSOoWt6dmCaJ2lQzuy7RacL2zbLcl2kMXl8lJWTMdF6ggEd85O9mCWlaiRg
        R7ucYHWzFcp5QylgsSUFxM0+FJrLS+nL4VcdmHM8LOS2xpzEmHruo2UJkJXyV/GlWZsrn9
        x3lhSwMiSUcuS8gVhCQYeZWpk+L2Igd9U6mPkX16QomFXL2QU50OUABjsZ3RpQ==
From:   Simao Gomes Viana <devel@superboring.dev>
To:     linux-kernel@vger.kernel.org
Cc:     Simao Gomes Viana <devel@superboring.dev>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 3/9] drivers: cdrom: replace func name by __func__
Date:   Fri, 19 Jun 2020 21:33:35 +0200
Message-Id: <20200619193341.51209-3-devel@superboring.dev>
In-Reply-To: <20200619193341.51209-1-devel@superboring.dev>
References: <20200619180834.8032-1-devel@superboring.dev>
 <20200619193341.51209-1-devel@superboring.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These were reported by scripts/checkpatch.pl

Signed-off-by: Simao Gomes Viana <devel@superboring.dev>
---
 drivers/cdrom/cdrom.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index e41743c413c2..e27af76199eb 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -594,7 +594,7 @@ int register_cdrom(struct gendisk *disk, struct cdrom_device_info *cdi)
 	static char banner_printed;
 	const struct cdrom_device_ops *cdo = cdi->ops;
 
-	cd_dbg(CD_OPEN, "entering register_cdrom\n");
+	cd_dbg(CD_OPEN, "entering %s()\n", __func__);
 
 	if (cdo->open == NULL || cdo->release == NULL)
 		return -EINVAL;
@@ -649,7 +649,7 @@ int register_cdrom(struct gendisk *disk, struct cdrom_device_info *cdi)
 
 void unregister_cdrom(struct cdrom_device_info *cdi)
 {
-	cd_dbg(CD_OPEN, "entering unregister_cdrom\n");
+	cd_dbg(CD_OPEN, "entering %s()\n", __func__);
 
 	mutex_lock(&cdrom_mutex);
 	list_del(&cdi->list);
@@ -1001,7 +1001,8 @@ static void cdrom_count_tracks(struct cdrom_device_info *cdi, tracktype *tracks)
 	tracks->cdi = 0;
 	tracks->xa = 0;
 	tracks->error = 0;
-	cd_dbg(CD_COUNT_TRACKS, "entering cdrom_count_tracks\n");
+
+	cd_dbg(CD_COUNT_TRACKS, "entering %s()\n", __func__);
 
 	if (!CDROM_CAN(CDC_PLAY_AUDIO)) {
 		tracks->error = CDS_NO_INFO;
@@ -1049,7 +1050,8 @@ int open_for_data(struct cdrom_device_info *cdi)
 	int ret;
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	tracktype tracks;
-	cd_dbg(CD_OPEN, "entering open_for_data\n");
+
+	cd_dbg(CD_OPEN, "entering %s()\n", __func__);
 	/* Check if the driver can report drive status.  If it can, we
 	 * can do clever things.  If it can't, well, we at least tried!
 	 */
@@ -1168,7 +1170,7 @@ int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
 {
 	int ret;
 
-	cd_dbg(CD_OPEN, "entering cdrom_open\n");
+	cd_dbg(CD_OPEN, "entering %s()\n", __func__);
 
 	/* if this was a O_NONBLOCK open and we should honor the flags,
 	 * do a quick open without drive/disc integrity checks.
@@ -1218,7 +1220,8 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
 {
 	int ret;
 	tracktype tracks;
-	cd_dbg(CD_OPEN, "entering check_for_audio_disc\n");
+
+	cd_dbg(CD_OPEN, "entering %s()\n", __func__);
 	if (!(cdi->options & CDO_CHECK_TYPE))
 		return 0;
 	if (cdo->drive_status != NULL) {
@@ -1273,7 +1276,7 @@ void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	int opened_for_data;
 
-	cd_dbg(CD_CLOSE, "entering cdrom_release\n");
+	cd_dbg(CD_CLOSE, "entering %s()\n", __func__);
 
 	if (cdi->use_count > 0)
 		cdi->use_count--;
@@ -1343,7 +1346,7 @@ static int cdrom_slot_status(struct cdrom_device_info *cdi, int slot)
 	struct cdrom_changer_info *info;
 	int ret;
 
-	cd_dbg(CD_CHANGER, "entering cdrom_slot_status()\n");
+	cd_dbg(CD_CHANGER, "entering %s()\n", __func__);
 	if (cdi->sanyo_slot)
 		return CDS_NO_INFO;
 
@@ -1373,7 +1376,7 @@ int cdrom_number_of_slots(struct cdrom_device_info *cdi)
 	int nslots = 1;
 	struct cdrom_changer_info *info;
 
-	cd_dbg(CD_CHANGER, "entering cdrom_number_of_slots()\n");
+	cd_dbg(CD_CHANGER, "entering %s()\n", __func__);
 	/* cdrom_read_mech_status requires a valid value for capacity: */
 	cdi->capacity = 0;
 
@@ -1394,7 +1397,7 @@ static int cdrom_load_unload(struct cdrom_device_info *cdi, int slot)
 {
 	struct packet_command cgc;
 
-	cd_dbg(CD_CHANGER, "entering cdrom_load_unload()\n");
+	cd_dbg(CD_CHANGER, "entering %s()\n", __func__);
 	if (cdi->sanyo_slot && slot < 0)
 		return 0;
 
@@ -1424,7 +1427,7 @@ static int cdrom_select_disc(struct cdrom_device_info *cdi, int slot)
 	int curslot;
 	int ret;
 
-	cd_dbg(CD_CHANGER, "entering cdrom_select_disc()\n");
+	cd_dbg(CD_CHANGER, "entering %s()\n", __func__);
 	if (!CDROM_CAN(CDC_SELECT_DISC))
 		return -EDRIVE_CANT_DO_THIS;
 
-- 
2.27.0

