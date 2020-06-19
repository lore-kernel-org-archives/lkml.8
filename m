Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79573C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47EF021556
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=superboring.dev header.i=@superboring.dev header.b="MSWE+Igk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389238AbgFSTeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388742AbgFSTeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:34:09 -0400
Received: from mail.halogenos.org (halogenos.org [IPv6:2a02:c207:2037:5246::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12AAC0613EE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:34:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D97CB150091A;
        Fri, 19 Jun 2020 21:34:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=superboring.dev;
        s=dkim; t=1592595247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d+CE+knSYLETOJdD+XtqkJJJyrhgBATgKoF4zmciQv8=;
        b=MSWE+IgkLumU5b14Z8rCkQnEMPJP3F1JN9s5D97KsiaNljRqlxI1gTg/BxxQUSJTrQOz08
        lKwpyQR/G7czl6Hku2XAuPfFyHjbvDk7ac1lTyv+fjbnJ6vqTGZhEVnah3b84yCtP1hz/D
        aEK6Kxgi7Z/C57zx7MPR6nimZiRLFjUuOEzm2oaRj4vvJPqgFFLxnhuqY4Ktg4fTbP4jrM
        GaHoonymy+9sgEMI3in+SXAsJaJdKmj8GwJZHxY0BPi/TQwM9R2Xk9/kgccT0FojT3aIN1
        BBAopxLk4nATvZKGrJbnaKtpLR6mCTu5UZV4bfjRhfnaxyU6atmgUNrKkjb7dg==
From:   Simao Gomes Viana <devel@superboring.dev>
To:     linux-kernel@vger.kernel.org
Cc:     Simao Gomes Viana <devel@superboring.dev>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 2/9] drivers: cdrom: fix comment style
Date:   Fri, 19 Jun 2020 21:33:34 +0200
Message-Id: <20200619193341.51209-2-devel@superboring.dev>
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

This fixes comment style as reported by
scripts/checkpatch.pl

Signed-off-by: Simao Gomes Viana <devel@superboring.dev>
---
 drivers/cdrom/cdrom.c | 143 ++++++++++++++++++++++++------------------
 drivers/cdrom/gdrom.c |  24 ++++---
 2 files changed, 96 insertions(+), 71 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 4ecd1f287b11..e41743c413c2 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -240,7 +240,8 @@
   Modified by Nigel Kukard <nkukard@lbsd.net> - support DVD+RW
   2.4.x patch by Andy Polyakov <appro@fy.chalmers.se>
 
--------------------------------------------------------------------------*/
+-------------------------------------------------------------------------
+ */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
@@ -248,7 +249,8 @@
 #define VERSION "Id: cdrom.c 3.20 2003/12/17"
 
 /* I use an error-log mask to give fine grain control over the type of
-   messages dumped to the system logs.  The available masks include: */
+ * messages dumped to the system logs.  The available masks include:
+ */
 #define CD_NOTHING      0x0
 #define CD_WARNING	0x1
 #define CD_REG_UNREG	0x2
@@ -329,7 +331,8 @@ do {							\
 #endif
 
 /* The (cdo->capability & ~cdi->mask & CDC_XXX) construct was used in
-   a lot of places. This macro makes the code more clear. */
+ * a lot of places. This macro makes the code more clear.
+ */
 #define CDROM_CAN(type) (cdi->ops->capability & ~cdi->mask & (type))
 
 /*
@@ -1048,7 +1051,8 @@ int open_for_data(struct cdrom_device_info *cdi)
 	tracktype tracks;
 	cd_dbg(CD_OPEN, "entering open_for_data\n");
 	/* Check if the driver can report drive status.  If it can, we
-	   can do clever things.  If it can't, well, we at least tried! */
+	 * can do clever things.  If it can't, well, we at least tried!
+	 */
 	if (cdo->drive_status != NULL) {
 		ret = cdo->drive_status(cdi, CDSL_CURRENT);
 		cd_dbg(CD_OPEN, "drive_status=%d\n", ret);
@@ -1062,10 +1066,11 @@ int open_for_data(struct cdrom_device_info *cdi)
 				if (ret) {
 					cd_dbg(CD_OPEN, "bummer. tried to close the tray but failed.\n");
 					/* Ignore the error from the low
-					level driver.  We don't care why it
-					couldn't close the tray.  We only care 
-					that there is no disc in the drive, 
-					since that is the _REAL_ problem here.*/
+					 * level driver.  We don't care why it
+					 * couldn't close the tray.  We only care
+					 * that there is no disc in the drive,
+					 * since that is the _REAL_ problem here.
+					 */
 					ret = -ENOMEDIUM;
 					goto clean_up_and_return;
 				}
@@ -1098,11 +1103,13 @@ int open_for_data(struct cdrom_device_info *cdi)
 		goto clean_up_and_return;
 	}
 	/* CD-Players which don't use O_NONBLOCK, workman
-	 * for example, need bit CDO_CHECK_TYPE cleared! */
+	 * for example, need bit CDO_CHECK_TYPE cleared!
+	 */
 	if (tracks.data == 0) {
 		if (cdi->options & CDO_CHECK_TYPE) {
 			/* give people a warning shot, now that CDO_CHECK_TYPE
-			   is the default case! */
+			 * is the default case!
+			 */
 			cd_dbg(CD_OPEN, "bummer. wrong media type.\n");
 			cd_dbg(CD_WARNING, "pid %d must open device O_NONBLOCK!\n",
 					(unsigned int)task_pid_nr(current));
@@ -1119,8 +1126,9 @@ int open_for_data(struct cdrom_device_info *cdi)
 	ret = cdo->open(cdi, 0); /* open for data */
 	cd_dbg(CD_OPEN, "opening the device gave me %d\n", ret);
 	/* After all this careful checking, we shouldn't have problems
-	   opening the device, but we don't want the device locked if 
-	   this somehow fails... */
+	 * opening the device, but we don't want the device locked if
+	 * this somehow fails...
+	 */
 	if (ret) {
 		cd_dbg(CD_OPEN, "open device failed\n");
 		goto clean_up_and_return;
@@ -1133,10 +1141,11 @@ int open_for_data(struct cdrom_device_info *cdi)
 	return ret;
 
 	/* Something failed.  Try to unlock the drive, because some drivers
-	(notably ide-cd) lock the drive after every command.  This produced
-	a nasty bug where after mount failed, the drive would remain locked!  
-	This ensures that the drive gets unlocked after a mount fails.  This 
-	is a goto to avoid bloating the driver with redundant code. */ 
+	 * (notably ide-cd) lock the drive after every command.  This produced
+	 * a nasty bug where after mount failed, the drive would remain locked!
+	 * This ensures that the drive gets unlocked after a mount fails.  This
+	 * is a goto to avoid bloating the driver with redundant code.
+	 */
 clean_up_and_return:
 	cd_dbg(CD_OPEN, "open failed\n");
 	if (CDROM_CAN(CDC_LOCK) && cdi->options & CDO_LOCK) {
@@ -1162,7 +1171,8 @@ int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
 	cd_dbg(CD_OPEN, "entering cdrom_open\n");
 
 	/* if this was a O_NONBLOCK open and we should honor the flags,
-	 * do a quick open without drive/disc integrity checks. */
+	 * do a quick open without drive/disc integrity checks.
+	 */
 	cdi->use_count++;
 	if ((mode & FMODE_NDELAY) && (cdi->options & CDO_USE_FFLAGS)) {
 		ret = cdi->ops->open(cdi, 1);
@@ -1201,8 +1211,8 @@ int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
 }
 
 /* This code is similar to that in open_for_data. The routine is called
-   whenever an audio play operation is requested.
-*/
+ * whenever an audio play operation is requested.
+ */
 static int check_for_audio_disc(struct cdrom_device_info *cdi,
 				const struct cdrom_device_ops *cdo)
 {
@@ -1224,10 +1234,11 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
 				if (ret) {
 					cd_dbg(CD_OPEN, "bummer. tried to close tray but failed.\n");
 					/* Ignore the error from the low
-					level driver.  We don't care why it
-					couldn't close the tray.  We only care 
-					that there is no disc in the drive, 
-					since that is the _REAL_ problem here.*/
+					 * level driver.  We don't care why it
+					 * couldn't close the tray.  We only care
+					 * that there is no disc in the drive,
+					 * since that is the _REAL_ problem here.
+					 */
 					return -ENOMEDIUM;
 				}
 			} else {
@@ -1393,9 +1404,10 @@ static int cdrom_load_unload(struct cdrom_device_info *cdi, int slot)
 	cgc.cmd[8] = slot;
 	cgc.timeout = 60 * HZ;
 
-	/* The Sanyo 3 CD changer uses byte 7 of the 
-	GPCMD_TEST_UNIT_READY to command to switch CDs instead of
-	using the GPCMD_LOAD_UNLOAD opcode. */
+	/* The Sanyo 3 CD changer uses byte 7 of the
+	 * GPCMD_TEST_UNIT_READY to command to switch CDs instead of
+	 * using the GPCMD_LOAD_UNLOAD opcode.
+	 */
 	if (cdi->sanyo_slot && -1 < slot) {
 		cgc.cmd[0] = GPCMD_TEST_UNIT_READY;
 		cgc.cmd[7] = slot;
@@ -1448,10 +1460,11 @@ static int cdrom_select_disc(struct cdrom_device_info *cdi, int slot)
 	}
 
 	/* Specifying CDSL_CURRENT will attempt to load the currnet slot,
-	which is useful if it had been previously unloaded.
-	Whether it can or not, it returns the current slot. 
-	Similarly,  if slot happens to be the current one, we still
-	try and load it. */
+	 * which is useful if it had been previously unloaded.
+	 * Whether it can or not, it returns the current slot.
+	 * Similarly,  if slot happens to be the current one, we still
+	 * try and load it.
+	 */
 	if (slot == CDSL_CURRENT)
 		slot = curslot;
 
@@ -1536,9 +1549,10 @@ int media_changed(struct cdrom_device_info *cdi, int queue)
 
 int cdrom_media_changed(struct cdrom_device_info *cdi)
 {
-	/* This talks to the VFS, which doesn't like errors - just 1 or 0.  
-	 * Returning "0" is always safe (media hasn't been changed). Do that 
-	 * if the low-level cdrom driver dosn't support media changed. */ 
+	/* This talks to the VFS, which doesn't like errors - just 1 or 0.
+	 * Returning "0" is always safe (media hasn't been changed). Do that
+	 * if the low-level cdrom driver dosn't support media changed.
+	 */
 	if (cdi == NULL || cdi->ops->media_changed == NULL)
 		return 0;
 	if (!CDROM_CAN(CDC_MEDIA_CHANGED))
@@ -1547,19 +1561,19 @@ int cdrom_media_changed(struct cdrom_device_info *cdi)
 }
 
 /* Requests to the low-level drivers will /always/ be done in the
-   following format convention:
-
-   CDROM_LBA: all data-related requests.
-   CDROM_MSF: all audio-related requests.
-
-   However, a low-level implementation is allowed to refuse this
-   request, and return information in its own favorite format.
-
-   It doesn't make sense /at all/ to ask for a play_audio in LBA
-   format, or ask for multi-session info in MSF format. However, for
-   backward compatibility these format requests will be satisfied, but
-   the requests to the low-level drivers will be sanitized in the more
-   meaningful format indicated above.
+ * following format convention:
+ *
+ * CDROM_LBA: all data-related requests.
+ * CDROM_MSF: all audio-related requests.
+ *
+ * However, a low-level implementation is allowed to refuse this
+ * request, and return information in its own favorite format.
+ *
+ * It doesn't make sense /at all/ to ask for a play_audio in LBA
+ * format, or ask for multi-session info in MSF format. However, for
+ * backward compatibility these format requests will be satisfied, but
+ * the requests to the low-level drivers will be sanitized in the more
+ * meaningful format indicated above.
  */
 
 static
@@ -2852,7 +2866,8 @@ static int cdrom_get_track_info(struct cdrom_device_info *cdi,
 }
 
 /* return the last written block on the CD-R media. this is for the udf
-   file system. */
+ * file system.
+ */
 int cdrom_get_last_written(struct cdrom_device_info *cdi, long *last_written)
 {
 	struct cdrom_tocentry toc;
@@ -2901,9 +2916,10 @@ int cdrom_get_last_written(struct cdrom_device_info *cdi, long *last_written)
 	return 0;
 
 	/* this is where we end up if the drive either can't do a
-	   GPCMD_READ_DISC_INFO or GPCMD_READ_TRACK_RZONE_INFO or if
-	   it doesn't give enough information or fails. then we return
-	   the toc contents. */
+	 * GPCMD_READ_DISC_INFO or GPCMD_READ_TRACK_RZONE_INFO or if
+	 * it doesn't give enough information or fails. then we return
+	 * the toc contents.
+	 */
 use_toc:
 	if (!CDROM_CAN(CDC_PLAY_AUDIO))
 		return -ENOSYS;
@@ -3162,11 +3178,12 @@ static noinline int mmc_ioctl_cdrom_volume(struct cdrom_device_info *cdi,
 	ret = cdrom_mode_sense(cdi, cgc, GPMODE_AUDIO_CTL_PAGE, 0);
 	if (ret)
 		return ret;
-		
+
 	/* originally the code depended on buffer[1] to determine
-	   how much data is available for transfer. buffer[1] is
-	   unfortunately ambigious and the only reliable way seem
-	   to be to simply skip over the block descriptor... */
+	 * how much data is available for transfer. buffer[1] is
+	 * unfortunately ambigious and the only reliable way seem
+	 * to be to simply skip over the block descriptor...
+	 */
 	offset = 8 + be16_to_cpu(*(__be16 *)(buffer + 6));
 
 	if (offset + 16 > sizeof(buffer))
@@ -3186,7 +3203,8 @@ static noinline int mmc_ioctl_cdrom_volume(struct cdrom_device_info *cdi,
 		return -EINVAL;
 
 	/* now we have the current volume settings. if it was only
-	   a CDROMVOLREAD, return these values */
+	 * a CDROMVOLREAD, return these values
+	 */
 	if (cmd == CDROMVOLREAD) {
 		volctrl.channel0 = buffer[offset+9];
 		volctrl.channel1 = buffer[offset+11];
@@ -3324,7 +3342,8 @@ static int mmc_ioctl(struct cdrom_device_info *cdi, unsigned int cmd,
 	memset(&cgc, 0, sizeof(cgc));
 
 	/* build a unified command and queue it through
-	   cdo->generic_packet() */
+	 * cdo->generic_packet()
+	 */
 	switch (cmd) {
 	case CDROMREADRAW:
 	case CDROMREADMODE1:
@@ -3617,9 +3636,10 @@ static int cdrom_sysctl_info(struct ctl_table *ctl, int write,
 }
 
 /* Unfortunately, per device settings are not implemented through
-   procfs/sysctl yet. When they are, this will naturally disappear. For now
-   just update all drives. Later this will become the template on which
-   new registered drives will be based. */
+ * procfs/sysctl yet. When they are, this will naturally disappear. For now
+ * just update all drives. Later this will become the template on which
+ * new registered drives will be based.
+ */
 static void cdrom_update_settings(void)
 {
 	struct cdrom_device_info *cdi;
@@ -3663,8 +3683,9 @@ static int cdrom_sysctl_handler(struct ctl_table *ctl, int write,
 		check_media_type = !!cdrom_sysctl_settings.check;
 
 		/* update the option flags according to the changes. we
-		   don't have per device options through sysctl yet,
-		   but we will have and then this will disappear. */
+		 * don't have per device options through sysctl yet,
+		 * but we will have and then this will disappear.
+		 */
 		cdrom_update_settings();
 	}
 
diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 09b0cd292720..47c2817896f5 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -156,8 +156,9 @@ static void gdrom_identifydevice(void *buf)
 	int c;
 	short *data = buf;
 	/* If the device won't clear it has probably
-	* been hit by a serious failure - but we'll
-	* try to return a sense key even so */
+	 * been hit by a serious failure - but we'll
+	 * try to return a sense key even so
+	 */
 	if (!gdrom_wait_clrbusy()) {
 		gdrom_getsense(NULL);
 		return;
@@ -395,7 +396,8 @@ static int gdrom_hardreset(struct cdrom_device_info *cd_info)
 }
 
 /* keep the function looking like the universal
- * CD Rom specification  - returning int */
+ * CD Rom specification  - returning int
+ */
 static int gdrom_packetcommand(struct cdrom_device_info *cd_info,
 	struct packet_command *command)
 {
@@ -423,7 +425,8 @@ static int gdrom_getsense(short *bufstring)
 	sense_command->cmd[4] = 10;
 	sense_command->buflen = 10;
 	/* even if something is pending try to get
-	* the sense key if possible */
+	 * the sense key if possible
+	 */
 	if (gd.pending && !gdrom_wait_clrbusy()) {
 		err = -EBUSY;
 		goto cleanup_sense_final;
@@ -693,12 +696,13 @@ static int gdrom_init_dma_mode(void)
 	if (!gdrom_wait_busy_sleeps())
 		return -EBUSY;
 	/* Memory protection setting for GDROM DMA
-	* Bits 31 - 16 security: 0x8843
-	* Bits 15 and 7 reserved (0)
-	* Bits 14 - 8 start of transfer range in 1 MB blocks OR'ed with 0x80
-	* Bits 6 - 0 end of transfer range in 1 MB blocks OR'ed with 0x80
-	* (0x40 | 0x80) = start range at 0x0C000000
-	* (0x7F | 0x80) = end range at 0x0FFFFFFF */
+	 * Bits 31 - 16 security: 0x8843
+	 * Bits 15 and 7 reserved (0)
+	 * Bits 14 - 8 start of transfer range in 1 MB blocks OR'ed with 0x80
+	 * Bits 6 - 0 end of transfer range in 1 MB blocks OR'ed with 0x80
+	 * (0x40 | 0x80) = start range at 0x0C000000
+	 * (0x7F | 0x80) = end range at 0x0FFFFFFF
+	 */
 	__raw_writel(0x8843407F, GDROM_DMA_ACCESS_CTRL_REG);
 	__raw_writel(9, GDROM_DMA_WAIT_REG); /* DMA word setting */
 	return 0;
-- 
2.27.0

