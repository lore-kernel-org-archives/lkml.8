Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A46C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54AA621556
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=superboring.dev header.i=@superboring.dev header.b="kjDztErl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389467AbgFSTeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389104AbgFSTeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:34:10 -0400
Received: from mail.halogenos.org (halogenos.org [IPv6:2a02:c207:2037:5246::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B1FC0613EF
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:34:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 63A7F1500CE8;
        Fri, 19 Jun 2020 21:34:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=superboring.dev;
        s=dkim; t=1592595248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w6AFkZMu3a8CBzesd1vEjNDpv/HxkWMNqrOCGsd3Vac=;
        b=kjDztErlXnzAUcfeAGrOpT8nq8MKwAVOVpSCU7qOOmEKc0RStf8IYwTFnQYsauJ/h2Jjlb
        bHYnaEk6tw/3GzrEN6Foq/FAGfLzWo5ehzvNhinqa9vjnrjeamYdsJ1+5Jk6tThU3QT8vH
        feQ/Rjl9E8TCZbTpPZcZW8+p71Nn3M3TxPPYrC1NvddzhuARm7pAUUREQg0sXwuTtQ++zK
        4QHu0iw9eHLdQjAfRdWrZNhh9KWWLbcDltEr+MDKbPbai71HaorcGgchNX7Lni2lhlhcjH
        AyBYid2GSC/Nc72RENrn3khsTnlVHaQAL6M3e26W/DQIKc8yGLVkH/Guq/NQZw==
From:   Simao Gomes Viana <devel@superboring.dev>
To:     linux-kernel@vger.kernel.org
Cc:     Simao Gomes Viana <devel@superboring.dev>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 6/9] drivers: cdrom: add missing newlines (vertical space)
Date:   Fri, 19 Jun 2020 21:33:38 +0200
Message-Id: <20200619193341.51209-6-devel@superboring.dev>
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

These were reported by scripts/checkpatch.pl, so I added
some vertical space.

Signed-off-by: Simao Gomes Viana <devel@superboring.dev>
---
 drivers/cdrom/cdrom.c | 19 +++++++++++++++++++
 drivers/cdrom/gdrom.c |  5 +++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 53e592423adb..f1c02d4d5583 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -1004,6 +1004,7 @@ static void cdrom_count_tracks(struct cdrom_device_info *cdi, tracktype *tracks)
 	struct cdrom_tochdr header;
 	struct cdrom_tocentry entry;
 	int ret, i;
+
 	tracks->data = 0;
 	tracks->audio = 0;
 	tracks->cdi = 0;
@@ -1089,6 +1090,7 @@ int open_for_data(struct cdrom_device_info *cdi)
 				ret = -ENOMEDIUM;
 				goto clean_up_and_return;
 			}
+
 			/* Ok, the door should be closed now.. Check again */
 			ret = cdo->drive_status(cdi, CDSL_CURRENT);
 			if ((ret == CDS_NO_DISC) || (ret==CDS_TRAY_OPEN)) {
@@ -1106,6 +1108,7 @@ int open_for_data(struct cdrom_device_info *cdi)
 			goto clean_up_and_return;
 		}
 	}
+
 	cdrom_count_tracks(cdi, &tracks);
 	if (tracks.error == CDS_NO_DISC) {
 		cd_dbg(CD_OPEN, "bummer. no disc.\n");
@@ -1232,6 +1235,7 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
 	cd_dbg(CD_OPEN, "entering %s()\n", __func__);
 	if (!(cdi->options & CDO_CHECK_TYPE))
 		return 0;
+
 	if (cdo->drive_status != NULL) {
 		ret = cdo->drive_status(cdi, CDSL_CURRENT);
 		cd_dbg(CD_OPEN, "drive_status=%d\n", ret);
@@ -1269,6 +1273,7 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
 			cd_dbg(CD_OPEN, "the tray is now closed\n");
 		}
 	}
+
 	cdrom_count_tracks(cdi, &tracks);
 	if (tracks.error)
 		return(tracks.error);
@@ -1603,6 +1608,7 @@ void sanitize_format(union cdrom_addr *addr,
 			75 * (addr->msf.second - 2 + 60 * addr->msf.minute);
 	} else {                        /* CDROM_MSF */
 		int lba = addr->lba;
+
 		addr->msf.frame = lba % 75;
 		lba /= 75;
 		lba += 2;
@@ -1780,6 +1786,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 			ai->type = DVD_AUTH_FAILURE;
 			return ret;
 		}
+
 		ai->type = DVD_AUTH_ESTABLISHED;
 		break;
 
@@ -1792,6 +1799,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		ret = cdo->generic_packet(cdi, &cgc);
 		if (ret)
 			return ret;
+
 		break;
 
 	/* Get region settings */
@@ -1822,6 +1830,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		ret = cdo->generic_packet(cdi, &cgc);
 		if (ret)
 			return ret;
+
 		break;
 
 	default:
@@ -2388,6 +2397,7 @@ static int cdrom_ioctl_eject(struct cdrom_device_info *cdi)
 		return -EBUSY;
 	if (CDROM_CAN(CDC_LOCK)) {
 		int ret = cdi->ops->lock_door(cdi, 0);
+
 		if (ret)
 			return ret;
 	}
@@ -2957,6 +2967,7 @@ int cdrom_get_last_written(struct cdrom_device_info *cdi, long *last_written)
 	ret = cdi->ops->audio_ioctl(cdi, CDROMREADTOCENTRY, &toc);
 	if (ret)
 		return ret;
+
 	sanitize_format(&toc.cdte_addr, &toc.cdte_format, CDROM_LBA);
 	*last_written = toc.cdte_addr.lba;
 	return 0;
@@ -3126,6 +3137,7 @@ static noinline int mmc_ioctl_cdrom_subchannel(struct cdrom_device_info *cdi,
 	int ret;
 	struct cdrom_subchnl q;
 	u_char requested, back;
+
 	if (copy_from_user(&q, (struct cdrom_subchnl __user *)arg, sizeof(q)))
 		return -EFAULT;
 	requested = q.cdsc_format;
@@ -3151,6 +3163,7 @@ static noinline int mmc_ioctl_cdrom_play_msf(struct cdrom_device_info *cdi,
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	struct cdrom_msf msf;
+
 	cd_dbg(CD_DO_IOCTL, "entering CDROMPLAYMSF\n");
 	if (copy_from_user(&msf, (struct cdrom_msf __user *)arg, sizeof(msf)))
 		return -EFAULT;
@@ -3171,6 +3184,7 @@ static noinline int mmc_ioctl_cdrom_play_blk(struct cdrom_device_info *cdi,
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	struct cdrom_blk blk;
+
 	cd_dbg(CD_DO_IOCTL, "entering CDROMPLAYBLK\n");
 	if (copy_from_user(&blk, (struct cdrom_blk __user *)arg, sizeof(blk)))
 		return -EFAULT;
@@ -3267,6 +3281,7 @@ static noinline int mmc_ioctl_cdrom_start_stop(struct cdrom_device_info *cdi,
 					       int cmd)
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
+
 	cd_dbg(CD_DO_IOCTL, "entering CDROMSTART/CDROMSTOP\n");
 	cgc->cmd[0] = GPCMD_START_STOP_UNIT;
 	cgc->cmd[1] = 1;
@@ -3280,6 +3295,7 @@ static noinline int mmc_ioctl_cdrom_pause_resume(struct cdrom_device_info *cdi,
 						 int cmd)
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
+
 	cd_dbg(CD_DO_IOCTL, "entering CDROMPAUSE/CDROMRESUME\n");
 	cgc->cmd[0] = GPCMD_PAUSE_RESUME;
 	cgc->cmd[8] = (cmd == CDROMRESUME) ? 1 : 0;
@@ -3320,6 +3336,7 @@ static noinline int mmc_ioctl_dvd_auth(struct cdrom_device_info *cdi,
 {
 	int ret;
 	dvd_authinfo ai;
+
 	if (!CDROM_CAN(CDC_DVD))
 		return -ENOSYS;
 	cd_dbg(CD_DO_IOCTL, "entering DVD_AUTH\n");
@@ -3338,6 +3355,7 @@ static noinline int mmc_ioctl_cdrom_next_writable(struct cdrom_device_info *cdi,
 {
 	int ret;
 	long next = 0;
+
 	cd_dbg(CD_DO_IOCTL, "entering CDROM_NEXT_WRITABLE\n");
 	ret = cdrom_get_next_writable(cdi, &next);
 	if (ret)
@@ -3352,6 +3370,7 @@ static noinline int mmc_ioctl_cdrom_last_written(struct cdrom_device_info *cdi,
 {
 	int ret;
 	long last = 0;
+
 	cd_dbg(CD_DO_IOCTL, "entering CDROM_LAST_WRITTEN\n");
 	ret = cdrom_get_last_written(cdi, &last);
 	if (ret)
diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 47c2817896f5..1b4fd34f2687 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -134,6 +134,7 @@ static bool gdrom_data_request(void)
 static bool gdrom_wait_clrbusy(void)
 {
 	unsigned long timeout = jiffies + GDROM_DEFAULT_TIMEOUT;
+
 	while ((__raw_readb(GDROM_ALTSTATUS_REG) & 0x80) &&
 		(time_before(jiffies, timeout)))
 		cpu_relax();
@@ -229,6 +230,7 @@ static char gdrom_execute_diagnostic(void)
 static int gdrom_preparedisk_cmd(void)
 {
 	struct packet_command *spin_command;
+
 	spin_command = kzalloc(sizeof(struct packet_command), GFP_KERNEL);
 	if (!spin_command)
 		return -ENOMEM;
@@ -368,6 +370,7 @@ static int gdrom_drivestatus(struct cdrom_device_info *cd_info, int ignore)
 {
 	/* read the sense key */
 	char sense = __raw_readb(GDROM_ERROR_REG);
+
 	sense &= 0xF0;
 	if (sense == 0)
 		return CDS_DISC_OK;
@@ -389,6 +392,7 @@ static unsigned int gdrom_check_events(struct cdrom_device_info *cd_info,
 static int gdrom_hardreset(struct cdrom_device_info *cd_info)
 {
 	int count;
+
 	__raw_writel(0x1fffff, GDROM_RESET_REG);
 	for (count = 0xa0000000; count < 0xa0200000; count += 4)
 		__raw_readl(count);
@@ -850,6 +854,7 @@ static struct platform_driver gdrom_driver = {
 static int __init init_gdrom(void)
 {
 	int rc;
+
 	gd.toc = NULL;
 	rc = platform_driver_register(&gdrom_driver);
 	if (rc)
-- 
2.27.0

