Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F714C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1669E20DD4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=superboring.dev header.i=@superboring.dev header.b="Fu6IPVIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390383AbgFSSRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389373AbgFSSRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:17:03 -0400
X-Greylist: delayed 467 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 Jun 2020 11:17:03 PDT
Received: from mail.halogenos.org (halogenos.org [IPv6:2a02:c207:2037:5246::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BA4C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 11:17:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BCB33150090E;
        Fri, 19 Jun 2020 20:09:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=superboring.dev;
        s=dkim; t=1592590150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/asy8IlfZCAJ0DGPo45QuYyftHWeIEUx92mSulL2Co8=;
        b=Fu6IPVINF5RkeeL+WfNok3/nHosm1sn+4IBGJFIVkPfz53Ywhj+d5GvDLS5EWcAl846uCR
        xXWq+QfoPrxWzObkoQJACJAVAqnnZWVXRmurlZAe6svOGEkOUjAzW/deAMknlfPYt6cM9Q
        qsM6FDQ2w58lUdKHlg02hAHTghyErLCMs09HwlKpaWZt3IdhbIYaQD6uXoVW43QKnoz1CA
        oLPS0X+5bCt9xaAHjflaxMwZ+IUeAKhHtQ3eQLCKcYBoSkvl7Nuv0LnkXUtIOCMsatE2GB
        OXT+8LS48dLsyajRt+2mhYmifDqBlFNNys9yyhCyJm8F/Uy+0a7Z9mtiAFVDzQ==
From:   Simao Gomes Viana <devel@superboring.dev>
To:     linux-kernel@vger.kernel.org
Cc:     Simao Gomes Viana <devel@superboring.dev>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] drivers: cdrom: fix all errors reported by checkpatch
Date:   Fri, 19 Jun 2020 20:08:33 +0200
Message-Id: <20200619180834.8032-1-devel@superboring.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes all errors that scripts/checkpatch.pl
reports about drivers/cdrom/*.c and a lot of warnings
as well. I skipped warnings that I don't know whether
fixing them will break anything.

Before:
drivers/cdrom/cdrom.c:
    total: 118 errors, 126 warnings, 3794 lines checked
drivers/cdrom/gdrom.c:
    total: 0 errors, 16 warnings, 873 lines checked

After:
drivers/cdrom/cdrom.c:
    total: 0 errors, 38 warnings, 3866 lines checked
drivers/cdrom/gdrom.c:
    total: 0 errors, 3 warnings, 882 lines checked

Test: scripts/checkpatch.pl --file drivers/cdrom/*.c
Test: make drivers/cdrom/cdrom.o
Test: make CONFIG_GDROM=y drivers/cdrom/gdrom.o # partial
Test: compiles, boots on 5.7.4
Test: CD ROM works (tested with Audio CD)
Signed-off-by: Simao Gomes Viana <devel@superboring.dev>
---
 drivers/cdrom/cdrom.c | 454 ++++++++++++++++++++++++------------------
 drivers/cdrom/gdrom.c |  31 ++-
 2 files changed, 283 insertions(+), 202 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index d82b3b7658bd..8e3df970e4c2 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -63,8 +63,8 @@
 
 2.12  Jan  24, 1998 -- Erik Andersen <andersee@debian.org>
   -- Fixed a bug in the IOCTL_IN and IOCTL_OUT macros.  It turns out that
-  copy_*_user does not return EFAULT on error, but instead returns the number 
-  of bytes not copied.  I was returning whatever non-zero stuff came back from 
+  copy_*_user does not return EFAULT on error, but instead returns the number
+  of bytes not copied.  I was returning whatever non-zero stuff came back from
   the copy_*_user functions directly, which would result in strange errors.
 
 2.13  July 17, 1998 -- Erik Andersen <andersee@debian.org>
@@ -78,7 +78,7 @@
 
   2.14 August 17, 1998 -- Erik Andersen <andersee@debian.org>
   -- Fixed a bug in cdrom_media_changed and handling of reporting that
-  the media had changed for devices that _don't_ implement media_changed.  
+  the media had changed for devices that _don't_ implement media_changed.
   Thanks to Grant R. Guenther <grant@torque.net> for spotting this bug.
   -- Made a few things more pedanticly correct.
 
@@ -86,12 +86,12 @@
   -- New maintainers! Erik was too busy to continue the work on the driver,
   so now Chris Zwilling <chris@cloudnet.com> and Jens Axboe <axboe@image.dk>
   will do their best to follow in his footsteps
-  
+
   2.51 Dec 20, 1998 - Jens Axboe <axboe@image.dk>
   -- Check if drive is capable of doing what we ask before blindly changing
   cdi->options in various ioctl.
   -- Added version to proc entry.
-  
+
   2.52 Jan 16, 1999 - Jens Axboe <axboe@image.dk>
   -- Fixed an error in open_for_data where we would sometimes not return
   the correct error value. Thanks Huba Gaspar <huba@softcell.hu>.
@@ -100,7 +100,7 @@
   modules had entries in dev. Feb 02 - real bug was in sysctl.c where
   dev would be removed even though it was used. cdrom.c just illuminated
   that bug.
-  
+
   2.53 Feb 22, 1999 - Jens Axboe <axboe@image.dk>
   -- Fixup of several ioctl calls, in particular CDROM_SET_OPTIONS has
   been "rewritten" because capabilities and options aren't in sync. They
@@ -110,16 +110,16 @@
   -- Added CDROM_DEBUG ioctl. Enable debug messages on-the-fly.
   -- Added CDROM_GET_CAPABILITY ioctl. This relieves userspace programs
   from parsing /proc/sys/dev/cdrom/info.
-  
+
   2.54 Mar 15, 1999 - Jens Axboe <axboe@image.dk>
   -- Check capability mask from low level driver when counting tracks as
   per suggestion from Corey J. Scotts <cstotts@blue.weeg.uiowa.edu>.
-  
+
   2.55 Apr 25, 1999 - Jens Axboe <axboe@image.dk>
   -- autoclose was mistakenly checked against CDC_OPEN_TRAY instead of
   CDC_CLOSE_TRAY.
   -- proc info didn't mask against capabilities mask.
-  
+
   3.00 Aug 5, 1999 - Jens Axboe <axboe@image.dk>
   -- Unified audio ioctl handling across CD-ROM drivers. A lot of the
   code was duplicated before. Drives that support the generic packet
@@ -137,13 +137,13 @@
   -- Now default to checking media type.
   -- CDROM_SEND_PACKET ioctl added. The infrastructure was in place for
   doing this anyway, with the generic_packet addition.
-  
+
   3.01 Aug 6, 1999 - Jens Axboe <axboe@image.dk>
   -- Fix up the sysctl handling so that the option flags get set
   correctly.
   -- Fix up ioctl handling so the device specific ones actually get
   called :).
-  
+
   3.02 Aug 8, 1999 - Jens Axboe <axboe@image.dk>
   -- Fixed volume control on SCSI drives (or others with longer audio
   page).
@@ -152,7 +152,7 @@
   DVD structures and ioctls in the first place! He designed the original
   DVD patches for ide-cd and while I rearranged and unified them, the
   interface is still the same.
-  
+
   3.03 Sep 1, 1999 - Jens Axboe <axboe@image.dk>
   -- Moved the rest of the audio ioctls from the CD-ROM drivers here. Only
   CDROMREADTOCENTRY and CDROMREADTOCHDR are left.
@@ -177,7 +177,7 @@
   for ide-cd to handle multisession discs.
   -- Export cdrom_mode_sense and cdrom_mode_select.
   -- init_cdrom_command() for setting up a cgc command.
-  
+
   3.05 Oct 24, 1999 - Jens Axboe <axboe@image.dk>
   -- Changed the interface for CDROM_SEND_PACKET. Before it was virtually
   impossible to send the drive data in a sensible way.
@@ -210,7 +210,7 @@
   DVD_HOST_SEND_RPC_STATE did not set buffer size in cdb, and
   dvd_do_auth passed uninitialized data to drive because init_cdrom_command
   did not clear a 0 sized buffer.
-  
+
   3.09 May 12, 2000 - Jens Axboe <axboe@suse.de>
   -- Fix Video-CD on SCSI drives that don't support READ_CD command. In
   that case switch block size and issue plain READ_10 again, then switch
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
@@ -273,7 +275,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
-#include <linux/slab.h> 
+#include <linux/slab.h>
 #include <linux/cdrom.h>
 #include <linux/sysctl.h>
 #include <linux/proc_fs.h>
@@ -289,7 +291,7 @@
 /* used to tell the module to turn on full debugging messages */
 static bool debug;
 /* default compatibility mode */
-static bool autoclose=1;
+static bool autoclose = 1;
 static bool autoeject;
 static bool lockdoor = 1;
 /* will we ever get to use this... sigh. */
@@ -329,7 +331,8 @@ do {							\
 #endif
 
 /* The (cdo->capability & ~cdi->mask & CDC_XXX) construct was used in
-   a lot of places. This macro makes the code more clear. */
+ * a lot of places. This macro makes the code more clear.
+ */
 #define CDROM_CAN(type) (cdi->ops->capability & ~cdi->mask & (type))
 
 /*
@@ -458,7 +461,8 @@ static int cdrom_is_mrw(struct cdrom_device_info *cdi, int *write)
 	cgc.cmd[8] = sizeof(buffer);
 	cgc.quiet = 1;
 
-	if ((ret = cdi->ops->generic_packet(cdi, &cgc)))
+	ret = cdi->ops->generic_packet(cdi, &cgc);
+	if (ret)
 		return ret;
 
 	mfd = (struct mrw_feature_desc *)&buffer[sizeof(struct feature_header)];
@@ -466,7 +470,8 @@ static int cdrom_is_mrw(struct cdrom_device_info *cdi, int *write)
 		return 1;
 	*write = mfd->write;
 
-	if ((ret = cdrom_mrw_probe_pc(cdi))) {
+	ret = cdrom_mrw_probe_pc(cdi);
+	if (ret) {
 		*write = 0;
 		return ret;
 	}
@@ -539,7 +544,7 @@ static int cdrom_mrw_exit(struct cdrom_device_info *cdi)
 	int ret;
 
 	ret = cdrom_get_disc_info(cdi, &di);
-	if (ret < 0 || ret < (int)offsetof(typeof(di),disc_type))
+	if (ret < 0 || ret < (int)offsetof(typeof(di), disc_type))
 		return 1;
 
 	ret = 0;
@@ -591,7 +596,7 @@ int register_cdrom(struct gendisk *disk, struct cdrom_device_info *cdi)
 	static char banner_printed;
 	const struct cdrom_device_ops *cdo = cdi->ops;
 
-	cd_dbg(CD_OPEN, "entering register_cdrom\n");
+	cd_dbg(CD_OPEN, "entering %s()\n", __func__);
 
 	if (cdo->open == NULL || cdo->release == NULL)
 		return -EINVAL;
@@ -646,7 +651,7 @@ int register_cdrom(struct gendisk *disk, struct cdrom_device_info *cdi)
 
 void unregister_cdrom(struct cdrom_device_info *cdi)
 {
-	cd_dbg(CD_OPEN, "entering unregister_cdrom\n");
+	cd_dbg(CD_OPEN, "entering %s()\n", __func__);
 
 	mutex_lock(&cdrom_mutex);
 	list_del(&cdi->list);
@@ -699,10 +704,11 @@ static int cdrom_get_random_writable(struct cdrom_device_info *cdi,
 	cgc.cmd[8] = sizeof(buffer);		/* often 0x18 */
 	cgc.quiet = 1;
 
-	if ((ret = cdi->ops->generic_packet(cdi, &cgc)))
+	ret = cdi->ops->generic_packet(cdi, &cgc);
+	if (ret)
 		return ret;
 
-	memcpy(rfd, &buffer[sizeof(struct feature_header)], sizeof (*rfd));
+	memcpy(rfd, &buffer[sizeof(struct feature_header)], sizeof(*rfd));
 	return 0;
 }
 
@@ -720,7 +726,8 @@ static int cdrom_has_defect_mgt(struct cdrom_device_info *cdi)
 	cgc.cmd[8] = sizeof(buffer);
 	cgc.quiet = 1;
 
-	if ((ret = cdi->ops->generic_packet(cdi, &cgc)))
+	ret = cdi->ops->generic_packet(cdi, &cgc);
+	if (ret)
 		return ret;
 
 	feature_code = (__be16 *) &buffer[sizeof(struct feature_header)];
@@ -738,10 +745,11 @@ static int cdrom_is_random_writable(struct cdrom_device_info *cdi, int *write)
 
 	*write = 0;
 
-	if ((ret = cdrom_get_random_writable(cdi, &rfd)))
+	ret = cdrom_get_random_writable(cdi, &rfd);
+	if (ret)
 		return ret;
 
-	if (CDF_RWRT == be16_to_cpu(rfd.feature_code))
+	if (be16_to_cpu(rfd.feature_code) == CDF_RWRT)
 		*write = 1;
 
 	return 0;
@@ -790,7 +798,7 @@ static int cdrom_mrw_open_write(struct cdrom_device_info *cdi)
 	}
 
 	ret = cdrom_get_disc_info(cdi, &di);
-	if (ret < 0 || ret < offsetof(typeof(di),disc_type))
+	if (ret < 0 || ret < offsetof(typeof(di), disc_type))
 		return 1;
 
 	if (!di.erasable)
@@ -848,12 +856,14 @@ static int cdrom_ram_open_write(struct cdrom_device_info *cdi)
 	struct rwrt_feature_desc rfd;
 	int ret;
 
-	if ((ret = cdrom_has_defect_mgt(cdi)))
+	ret = cdrom_has_defect_mgt(cdi);
+	if (ret)
 		return ret;
 
-	if ((ret = cdrom_get_random_writable(cdi, &rfd)))
+	ret = cdrom_get_random_writable(cdi, &rfd);
+	if (ret)
 		return ret;
-	else if (CDF_RWRT == be16_to_cpu(rfd.feature_code))
+	else if (be16_to_cpu(rfd.feature_code) == CDF_RWRT)
 		ret = !rfd.curr;
 
 	cd_dbg(CD_OPEN, "can open for random write\n");
@@ -874,7 +884,8 @@ static void cdrom_mmc3_profile(struct cdrom_device_info *cdi)
 	cgc.cmd[8] = sizeof(buffer);		/* Allocation Length */
 	cgc.quiet = 1;
 
-	if ((ret = cdi->ops->generic_packet(cdi, &cgc)))
+	ret = cdi->ops->generic_packet(cdi, &cgc);
+	if (ret)
 		mmc3_profile = 0xffff;
 	else
 		mmc3_profile = (buffer[6] << 8) | buffer[7];
@@ -910,7 +921,7 @@ static int cdrom_open_write(struct cdrom_device_info *cdi)
 		ram_write = 1;
 	else
 		(void) cdrom_is_random_writable(cdi, &ram_write);
-	
+
 	if (mrw)
 		cdi->mask &= ~CDC_MRW;
 	else
@@ -930,9 +941,9 @@ static int cdrom_open_write(struct cdrom_device_info *cdi)
 		ret = cdrom_mrw_open_write(cdi);
 	else if (CDROM_CAN(CDC_DVD_RAM))
 		ret = cdrom_dvdram_open_write(cdi);
- 	else if (CDROM_CAN(CDC_RAM) &&
- 		 !CDROM_CAN(CDC_CD_R|CDC_CD_RW|CDC_DVD|CDC_DVD_R|CDC_MRW|CDC_MO_DRIVE))
- 		ret = cdrom_ram_open_write(cdi);
+	else if (CDROM_CAN(CDC_RAM) &&
+			!CDROM_CAN(CDC_CD_R|CDC_CD_RW|CDC_DVD|CDC_DVD_R|CDC_MRW|CDC_MO_DRIVE))
+		ret = cdrom_ram_open_write(cdi);
 	else if (CDROM_CAN(CDC_MO_DRIVE))
 		ret = mo_open_write(cdi);
 	else if (!cdrom_is_dvd_rw(cdi))
@@ -993,12 +1004,14 @@ static void cdrom_count_tracks(struct cdrom_device_info *cdi, tracktype *tracks)
 	struct cdrom_tochdr header;
 	struct cdrom_tocentry entry;
 	int ret, i;
+
 	tracks->data = 0;
 	tracks->audio = 0;
 	tracks->cdi = 0;
 	tracks->xa = 0;
 	tracks->error = 0;
-	cd_dbg(CD_COUNT_TRACKS, "entering cdrom_count_tracks\n");
+
+	cd_dbg(CD_COUNT_TRACKS, "entering %s()\n", __func__);
 
 	if (!CDROM_CAN(CDC_PLAY_AUDIO)) {
 		tracks->error = CDS_NO_INFO;
@@ -1046,9 +1059,11 @@ int open_for_data(struct cdrom_device_info *cdi)
 	int ret;
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	tracktype tracks;
-	cd_dbg(CD_OPEN, "entering open_for_data\n");
+
+	cd_dbg(CD_OPEN, "entering %s()\n", __func__);
 	/* Check if the driver can report drive status.  If it can, we
-	   can do clever things.  If it can't, well, we at least tried! */
+	 * can do clever things.  If it can't, well, we at least tried!
+	 */
 	if (cdo->drive_status != NULL) {
 		ret = cdo->drive_status(cdi, CDSL_CURRENT);
 		cd_dbg(CD_OPEN, "drive_status=%d\n", ret);
@@ -1058,59 +1073,63 @@ int open_for_data(struct cdrom_device_info *cdi)
 			if (CDROM_CAN(CDC_CLOSE_TRAY) &&
 			    cdi->options & CDO_AUTO_CLOSE) {
 				cd_dbg(CD_OPEN, "trying to close the tray\n");
-				ret=cdo->tray_move(cdi,0);
+				ret = cdo->tray_move(cdi, 0);
 				if (ret) {
 					cd_dbg(CD_OPEN, "bummer. tried to close the tray but failed.\n");
 					/* Ignore the error from the low
-					level driver.  We don't care why it
-					couldn't close the tray.  We only care 
-					that there is no disc in the drive, 
-					since that is the _REAL_ problem here.*/
-					ret=-ENOMEDIUM;
+					 * level driver.  We don't care why it
+					 * couldn't close the tray.  We only care
+					 * that there is no disc in the drive,
+					 * since that is the _REAL_ problem here.
+					 */
+					ret = -ENOMEDIUM;
 					goto clean_up_and_return;
 				}
 			} else {
 				cd_dbg(CD_OPEN, "bummer. this drive can't close the tray.\n");
-				ret=-ENOMEDIUM;
+				ret = -ENOMEDIUM;
 				goto clean_up_and_return;
 			}
+
 			/* Ok, the door should be closed now.. Check again */
 			ret = cdo->drive_status(cdi, CDSL_CURRENT);
-			if ((ret == CDS_NO_DISC) || (ret==CDS_TRAY_OPEN)) {
+			if (ret == CDS_NO_DISC || ret == CDS_TRAY_OPEN) {
 				cd_dbg(CD_OPEN, "bummer. the tray is still not closed.\n");
 				cd_dbg(CD_OPEN, "tray might not contain a medium\n");
-				ret=-ENOMEDIUM;
+				ret = -ENOMEDIUM;
 				goto clean_up_and_return;
 			}
 			cd_dbg(CD_OPEN, "the tray is now closed\n");
 		}
 		/* the door should be closed now, check for the disc */
 		ret = cdo->drive_status(cdi, CDSL_CURRENT);
-		if (ret!=CDS_DISC_OK) {
+		if (ret != CDS_DISC_OK) {
 			ret = -ENOMEDIUM;
 			goto clean_up_and_return;
 		}
 	}
+
 	cdrom_count_tracks(cdi, &tracks);
 	if (tracks.error == CDS_NO_DISC) {
 		cd_dbg(CD_OPEN, "bummer. no disc.\n");
-		ret=-ENOMEDIUM;
+		ret = -ENOMEDIUM;
 		goto clean_up_and_return;
 	}
 	/* CD-Players which don't use O_NONBLOCK, workman
-	 * for example, need bit CDO_CHECK_TYPE cleared! */
-	if (tracks.data==0) {
+	 * for example, need bit CDO_CHECK_TYPE cleared!
+	 */
+	if (tracks.data == 0) {
 		if (cdi->options & CDO_CHECK_TYPE) {
-		    /* give people a warning shot, now that CDO_CHECK_TYPE
-		       is the default case! */
-		    cd_dbg(CD_OPEN, "bummer. wrong media type.\n");
-		    cd_dbg(CD_WARNING, "pid %d must open device O_NONBLOCK!\n",
-			   (unsigned int)task_pid_nr(current));
-		    ret=-EMEDIUMTYPE;
-		    goto clean_up_and_return;
-		}
-		else {
-		    cd_dbg(CD_OPEN, "wrong media type, but CDO_CHECK_TYPE not set\n");
+			/* give people a warning shot, now that CDO_CHECK_TYPE
+			 * is the default case!
+			 */
+			cd_dbg(CD_OPEN, "bummer. wrong media type.\n");
+			cd_dbg(CD_WARNING, "pid %d must open device O_NONBLOCK!\n",
+					(unsigned int)task_pid_nr(current));
+			ret = -EMEDIUMTYPE;
+			goto clean_up_and_return;
+		} else {
+			cd_dbg(CD_OPEN, "wrong media type, but CDO_CHECK_TYPE not set\n");
 		}
 	}
 
@@ -1120,29 +1139,31 @@ int open_for_data(struct cdrom_device_info *cdi)
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
 	}
 	if (CDROM_CAN(CDC_LOCK) && (cdi->options & CDO_LOCK)) {
-			cdo->lock_door(cdi, 1);
-			cd_dbg(CD_OPEN, "door locked\n");
+		cdo->lock_door(cdi, 1);
+		cd_dbg(CD_OPEN, "door locked\n");
 	}
 	cd_dbg(CD_OPEN, "device opened successfully\n");
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
-			cdo->lock_door(cdi, 0);
-			cd_dbg(CD_OPEN, "door unlocked\n");
+		cdo->lock_door(cdi, 0);
+		cd_dbg(CD_OPEN, "door unlocked\n");
 	}
 	return ret;
 }
@@ -1160,10 +1181,11 @@ int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
 {
 	int ret;
 
-	cd_dbg(CD_OPEN, "entering cdrom_open\n");
+	cd_dbg(CD_OPEN, "entering %s()\n", __func__);
 
 	/* if this was a O_NONBLOCK open and we should honor the flags,
-	 * do a quick open without drive/disc integrity checks. */
+	 * do a quick open without drive/disc integrity checks.
+	 */
 	cdi->use_count++;
 	if ((mode & FMODE_NDELAY) && (cdi->options & CDO_USE_FFLAGS)) {
 		ret = cdi->ops->open(cdi, 1);
@@ -1202,33 +1224,35 @@ int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
 }
 
 /* This code is similar to that in open_for_data. The routine is called
-   whenever an audio play operation is requested.
-*/
+ * whenever an audio play operation is requested.
+ */
 static int check_for_audio_disc(struct cdrom_device_info *cdi,
 				const struct cdrom_device_ops *cdo)
 {
-        int ret;
+	int ret;
 	tracktype tracks;
-	cd_dbg(CD_OPEN, "entering check_for_audio_disc\n");
+
+	cd_dbg(CD_OPEN, "entering %s()\n", __func__);
 	if (!(cdi->options & CDO_CHECK_TYPE))
 		return 0;
+
 	if (cdo->drive_status != NULL) {
 		ret = cdo->drive_status(cdi, CDSL_CURRENT);
 		cd_dbg(CD_OPEN, "drive_status=%d\n", ret);
 		if (ret == CDS_TRAY_OPEN) {
 			cd_dbg(CD_OPEN, "the tray is open...\n");
 			/* can/may i close it? */
-			if (CDROM_CAN(CDC_CLOSE_TRAY) &&
-			    cdi->options & CDO_AUTO_CLOSE) {
+			if (CDROM_CAN(CDC_CLOSE_TRAY) && cdi->options & CDO_AUTO_CLOSE) {
 				cd_dbg(CD_OPEN, "trying to close the tray\n");
-				ret=cdo->tray_move(cdi,0);
+				ret = cdo->tray_move(cdi, 0);
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
@@ -1237,22 +1261,23 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
 			}
 			/* Ok, the door should be closed now.. Check again */
 			ret = cdo->drive_status(cdi, CDSL_CURRENT);
-			if ((ret == CDS_NO_DISC) || (ret==CDS_TRAY_OPEN)) {
+			if ((ret == CDS_NO_DISC) || (ret == CDS_TRAY_OPEN)) {
 				cd_dbg(CD_OPEN, "bummer. the tray is still not closed.\n");
 				return -ENOMEDIUM;
-			}	
-			if (ret!=CDS_DISC_OK) {
+			}
+			if (ret != CDS_DISC_OK) {
 				cd_dbg(CD_OPEN, "bummer. disc isn't ready.\n");
 				return -EIO;
-			}	
+			}
 			cd_dbg(CD_OPEN, "the tray is now closed\n");
-		}	
+		}
 	}
+
 	cdrom_count_tracks(cdi, &tracks);
-	if (tracks.error) 
+	if (tracks.error)
 		return(tracks.error);
 
-	if (tracks.audio==0)
+	if (tracks.audio == 0)
 		return -EMEDIUMTYPE;
 
 	return 0;
@@ -1263,7 +1288,7 @@ void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	int opened_for_data;
 
-	cd_dbg(CD_CLOSE, "entering cdrom_release\n");
+	cd_dbg(CD_CLOSE, "entering %s()\n", __func__);
 
 	if (cdi->use_count > 0)
 		cdi->use_count--;
@@ -1296,7 +1321,7 @@ void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
 	}
 }
 
-static int cdrom_read_mech_status(struct cdrom_device_info *cdi, 
+static int cdrom_read_mech_status(struct cdrom_device_info *cdi,
 				  struct cdrom_changer_info *buf)
 {
 	struct packet_command cgc;
@@ -1333,15 +1358,16 @@ static int cdrom_slot_status(struct cdrom_device_info *cdi, int slot)
 	struct cdrom_changer_info *info;
 	int ret;
 
-	cd_dbg(CD_CHANGER, "entering cdrom_slot_status()\n");
+	cd_dbg(CD_CHANGER, "entering %s()\n", __func__);
 	if (cdi->sanyo_slot)
 		return CDS_NO_INFO;
-	
+
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
-	if ((ret = cdrom_read_mech_status(cdi, info)))
+	ret = cdrom_read_mech_status(cdi, info);
+	if (ret)
 		goto out_free;
 
 	if (info->slots[slot].disc_present)
@@ -1354,24 +1380,25 @@ static int cdrom_slot_status(struct cdrom_device_info *cdi, int slot)
 	return ret;
 }
 
-/* Return the number of slots for an ATAPI/SCSI cdrom, 
- * return 1 if not a changer. 
+/* Return the number of slots for an ATAPI/SCSI cdrom,
+ * return 1 if not a changer.
  */
-int cdrom_number_of_slots(struct cdrom_device_info *cdi) 
+int cdrom_number_of_slots(struct cdrom_device_info *cdi)
 {
 	int status;
 	int nslots = 1;
 	struct cdrom_changer_info *info;
 
-	cd_dbg(CD_CHANGER, "entering cdrom_number_of_slots()\n");
+	cd_dbg(CD_CHANGER, "entering %s()\n", __func__);
 	/* cdrom_read_mech_status requires a valid value for capacity: */
-	cdi->capacity = 0; 
+	cdi->capacity = 0;
 
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
-	if ((status = cdrom_read_mech_status(cdi, info)) == 0)
+	status = cdrom_read_mech_status(cdi, info);
+	if (status == 0)
 		nslots = info->hdr.nslots;
 
 	kfree(info);
@@ -1380,11 +1407,11 @@ int cdrom_number_of_slots(struct cdrom_device_info *cdi)
 
 
 /* If SLOT < 0, unload the current slot.  Otherwise, try to load SLOT. */
-static int cdrom_load_unload(struct cdrom_device_info *cdi, int slot) 
+static int cdrom_load_unload(struct cdrom_device_info *cdi, int slot)
 {
 	struct packet_command cgc;
 
-	cd_dbg(CD_CHANGER, "entering cdrom_load_unload()\n");
+	cd_dbg(CD_CHANGER, "entering %s()\n", __func__);
 	if (cdi->sanyo_slot && slot < 0)
 		return 0;
 
@@ -1394,9 +1421,10 @@ static int cdrom_load_unload(struct cdrom_device_info *cdi, int slot)
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
@@ -1413,7 +1441,7 @@ static int cdrom_select_disc(struct cdrom_device_info *cdi, int slot)
 	int curslot;
 	int ret;
 
-	cd_dbg(CD_CHANGER, "entering cdrom_select_disc()\n");
+	cd_dbg(CD_CHANGER, "entering %s()\n", __func__);
 	if (!CDROM_CAN(CDC_SELECT_DISC))
 		return -EDRIVE_CANT_DO_THIS;
 
@@ -1432,7 +1460,8 @@ static int cdrom_select_disc(struct cdrom_device_info *cdi, int slot)
 	if (!info)
 		return -ENOMEM;
 
-	if ((ret = cdrom_read_mech_status(cdi, info))) {
+	ret = cdrom_read_mech_status(cdi, info);
+	if (ret) {
 		kfree(info);
 		return ret;
 	}
@@ -1441,24 +1470,26 @@ static int cdrom_select_disc(struct cdrom_device_info *cdi, int slot)
 	kfree(info);
 
 	if (cdi->use_count > 1 || cdi->keeplocked) {
-		if (slot == CDSL_CURRENT) {
-	    		return curslot;
-		} else {
+		if (slot == CDSL_CURRENT)
+			return curslot;
+		else
 			return -EBUSY;
-		}
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
 
 	/* set media changed bits on both queues */
 	cdi->mc_flags = 0x3;
-	if ((ret = cdrom_load_unload(cdi, slot)))
+
+	ret = cdrom_load_unload(cdi, slot);
+	if (ret)
 		return ret;
 
 	return slot;
@@ -1537,9 +1568,10 @@ int media_changed(struct cdrom_device_info *cdi, int queue)
 
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
@@ -1548,24 +1580,24 @@ int cdrom_media_changed(struct cdrom_device_info *cdi)
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
 void sanitize_format(union cdrom_addr *addr,
-		     u_char * curr, u_char requested)
+		     u_char *curr, u_char requested)
 {
 	if (*curr == requested)
 		return;                 /* nothing to be done! */
@@ -1574,6 +1606,7 @@ void sanitize_format(union cdrom_addr *addr,
 			75 * (addr->msf.second - 2 + 60 * addr->msf.minute);
 	} else {                        /* CDROM_MSF */
 		int lba = addr->lba;
+
 		addr->msf.frame = lba % 75;
 		lba /= 75;
 		lba += 2;
@@ -1597,10 +1630,10 @@ void init_cdrom_command(struct packet_command *cgc, void *buf, int len,
 
 /* DVD handling */
 
-#define copy_key(dest,src)	memcpy((dest), (src), sizeof(dvd_key))
-#define copy_chal(dest,src)	memcpy((dest), (src), sizeof(dvd_challenge))
+#define copy_key(dest, src) memcpy((dest), (src), sizeof(dvd_key))
+#define copy_chal(dest, src) memcpy((dest), (src), sizeof(dvd_challenge))
 
-static void setup_report_key(struct packet_command *cgc, unsigned agid, unsigned type)
+static void setup_report_key(struct packet_command *cgc, unsigned int agid, unsigned int type)
 {
 	cgc->cmd[0] = GPCMD_REPORT_KEY;
 	cgc->cmd[10] = type | (agid << 6);
@@ -1622,7 +1655,7 @@ static void setup_report_key(struct packet_command *cgc, unsigned agid, unsigned
 	cgc->data_direction = CGC_DATA_READ;
 }
 
-static void setup_send_key(struct packet_command *cgc, unsigned agid, unsigned type)
+static void setup_send_key(struct packet_command *cgc, unsigned int agid, unsigned int type)
 {
 	cgc->cmd[0] = GPCMD_SEND_KEY;
 	cgc->cmd[10] = type | (agid << 6);
@@ -1662,7 +1695,8 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		cgc.quiet = 1;
 		setup_report_key(&cgc, ai->lsa.agid, 0);
 
-		if ((ret = cdo->generic_packet(cdi, &cgc)))
+		ret = cdo->generic_packet(cdi, &cgc);
+		if (ret)
 			return ret;
 
 		ai->lsa.agid = buf[7] >> 6;
@@ -1673,7 +1707,8 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		cd_dbg(CD_DVD, "entering DVD_LU_SEND_KEY1\n");
 		setup_report_key(&cgc, ai->lsk.agid, 2);
 
-		if ((ret = cdo->generic_packet(cdi, &cgc)))
+		ret = cdo->generic_packet(cdi, &cgc);
+		if (ret)
 			return ret;
 
 		copy_key(ai->lsk.key, &buf[4]);
@@ -1684,7 +1719,8 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		cd_dbg(CD_DVD, "entering DVD_LU_SEND_CHALLENGE\n");
 		setup_report_key(&cgc, ai->lsc.agid, 1);
 
-		if ((ret = cdo->generic_packet(cdi, &cgc)))
+		ret = cdo->generic_packet(cdi, &cgc);
+		if (ret)
 			return ret;
 
 		copy_chal(ai->lsc.chal, &buf[4]);
@@ -1701,7 +1737,8 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		cgc.cmd[3] = ai->lstk.lba >> 16;
 		cgc.cmd[2] = ai->lstk.lba >> 24;
 
-		if ((ret = cdo->generic_packet(cdi, &cgc)))
+		ret = cdo->generic_packet(cdi, &cgc);
+		if (ret)
 			return ret;
 
 		ai->lstk.cpm = (buf[4] >> 7) & 1;
@@ -1714,8 +1751,9 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 	case DVD_LU_SEND_ASF:
 		cd_dbg(CD_DVD, "entering DVD_LU_SEND_ASF\n");
 		setup_report_key(&cgc, ai->lsasf.agid, 5);
-		
-		if ((ret = cdo->generic_packet(cdi, &cgc)))
+
+		ret = cdo->generic_packet(cdi, &cgc);
+		if (ret)
 			return ret;
 
 		ai->lsasf.asf = buf[7] & 1;
@@ -1728,7 +1766,8 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		buf[1] = 0xe;
 		copy_chal(&buf[4], ai->hsc.chal);
 
-		if ((ret = cdo->generic_packet(cdi, &cgc)))
+		ret = cdo->generic_packet(cdi, &cgc);
+		if (ret)
 			return ret;
 
 		ai->type = DVD_LU_SEND_KEY1;
@@ -1740,10 +1779,12 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		buf[1] = 0xa;
 		copy_key(&buf[4], ai->hsk.key);
 
-		if ((ret = cdo->generic_packet(cdi, &cgc))) {
+		ret = cdo->generic_packet(cdi, &cgc);
+		if (ret) {
 			ai->type = DVD_AUTH_FAILURE;
 			return ret;
 		}
+
 		ai->type = DVD_AUTH_ESTABLISHED;
 		break;
 
@@ -1752,8 +1793,11 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		cgc.quiet = 1;
 		cd_dbg(CD_DVD, "entering DVD_INVALIDATE_AGID\n");
 		setup_report_key(&cgc, ai->lsa.agid, 0x3f);
-		if ((ret = cdo->generic_packet(cdi, &cgc)))
+
+		ret = cdo->generic_packet(cdi, &cgc);
+		if (ret)
 			return ret;
+
 		break;
 
 	/* Get region settings */
@@ -1763,7 +1807,8 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		memset(&rpc_state, 0, sizeof(rpc_state_t));
 		cgc.buffer = (char *) &rpc_state;
 
-		if ((ret = cdo->generic_packet(cdi, &cgc)))
+		ret = cdo->generic_packet(cdi, &cgc);
+		if (ret)
 			return ret;
 
 		ai->lrpcs.type = rpc_state.type_code;
@@ -1780,8 +1825,10 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		buf[1] = 6;
 		buf[4] = ai->hrpcs.pdrc;
 
-		if ((ret = cdo->generic_packet(cdi, &cgc)))
+		ret = cdo->generic_packet(cdi, &cgc);
+		if (ret)
 			return ret;
+
 		break;
 
 	default:
@@ -1989,7 +2036,7 @@ static int dvd_read_struct(struct cdrom_device_info *cdi, dvd_struct *s,
 
 	case DVD_STRUCT_MANUFACT:
 		return dvd_read_manufact(cdi, s, cgc);
-		
+
 	default:
 		cd_dbg(CD_WARNING, ": Invalid DVD structure read requested (%d)\n",
 		       s->type);
@@ -2043,7 +2090,8 @@ static int cdrom_read_subchannel(struct cdrom_device_info *cdi,
 	cgc.cmd[3] = mcn ? 2 : 1;
 	cgc.cmd[8] = 16;
 
-	if ((ret = cdo->generic_packet(cdi, &cgc)))
+	ret = cdo->generic_packet(cdi, &cgc);
+	if (ret)
 		return ret;
 
 	subchnl->cdsc_audiostatus = cgc.buffer[1];
@@ -2115,15 +2163,22 @@ static int cdrom_read_block(struct cdrom_device_info *cdi,
 	cgc->cmd[7] = (nblocks >>  8) & 0xff;
 	cgc->cmd[8] = nblocks & 0xff;
 	cgc->buflen = blksize * nblocks;
-	
+
 	/* set the header info returned */
 	switch (blksize) {
-	case CD_FRAMESIZE_RAW0	: cgc->cmd[9] = 0x58; break;
-	case CD_FRAMESIZE_RAW1	: cgc->cmd[9] = 0x78; break;
-	case CD_FRAMESIZE_RAW	: cgc->cmd[9] = 0xf8; break;
-	default			: cgc->cmd[9] = 0x10;
+	case CD_FRAMESIZE_RAW0:
+		cgc->cmd[9] = 0x58;
+		break;
+	case CD_FRAMESIZE_RAW1:
+		cgc->cmd[9] = 0x78;
+		break;
+	case CD_FRAMESIZE_RAW:
+		cgc->cmd[9] = 0xf8;
+		break;
+	default:
+		cgc->cmd[9] = 0x10;
 	}
-	
+
 	return cdo->generic_packet(cdi, cgc);
 }
 
@@ -2292,7 +2347,7 @@ static int cdrom_read_cdda(struct cdrom_device_info *cdi, __u8 __user *ubuf,
 
 	pr_info("dropping to old style cdda (sense=%x)\n", cdi->last_sense);
 	cdi->cdda_method = CDDA_OLD;
-	return cdrom_read_cdda_old(cdi, ubuf, lba, nframes);	
+	return cdrom_read_cdda_old(cdi, ubuf, lba, nframes);
 }
 
 int cdrom_multisession(struct cdrom_device_info *cdi,
@@ -2347,6 +2402,7 @@ static int cdrom_ioctl_eject(struct cdrom_device_info *cdi)
 		return -EBUSY;
 	if (CDROM_CAN(CDC_LOCK)) {
 		int ret = cdi->ops->lock_door(cdi, 0);
+
 		if (ret)
 			return ret;
 	}
@@ -2853,7 +2909,8 @@ static int cdrom_get_track_info(struct cdrom_device_info *cdi,
 }
 
 /* return the last written block on the CD-R media. this is for the udf
-   file system. */
+ * file system.
+ */
 int cdrom_get_last_written(struct cdrom_device_info *cdi, long *last_written)
 {
 	struct cdrom_tocentry toc;
@@ -2902,17 +2959,20 @@ int cdrom_get_last_written(struct cdrom_device_info *cdi, long *last_written)
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
 
 	toc.cdte_format = CDROM_MSF;
 	toc.cdte_track = CDROM_LEADOUT;
-	if ((ret = cdi->ops->audio_ioctl(cdi, CDROMREADTOCENTRY, &toc)))
+	ret = cdi->ops->audio_ioctl(cdi, CDROMREADTOCENTRY, &toc);
+	if (ret)
 		return ret;
+
 	sanitize_format(&toc.cdte_addr, &toc.cdte_format, CDROM_LBA);
 	*last_written = toc.cdte_addr.lba;
 	return 0;
@@ -2960,13 +3020,12 @@ static int cdrom_get_next_writable(struct cdrom_device_info *cdi,
 
 use_last_written:
 	ret = cdrom_get_last_written(cdi, next_writable);
-	if (ret) {
+	if (ret)
 		*next_writable = 0;
-		return ret;
-	} else {
+	else
 		*next_writable += 7;
-		return 0;
-	}
+
+	return ret;
 }
 
 static noinline int mmc_ioctl_cdrom_read_data(struct cdrom_device_info *cdi,
@@ -3082,6 +3141,7 @@ static noinline int mmc_ioctl_cdrom_subchannel(struct cdrom_device_info *cdi,
 	int ret;
 	struct cdrom_subchnl q;
 	u_char requested, back;
+
 	if (copy_from_user(&q, (struct cdrom_subchnl __user *)arg, sizeof(q)))
 		return -EFAULT;
 	requested = q.cdsc_format;
@@ -3107,6 +3167,7 @@ static noinline int mmc_ioctl_cdrom_play_msf(struct cdrom_device_info *cdi,
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	struct cdrom_msf msf;
+
 	cd_dbg(CD_DO_IOCTL, "entering CDROMPLAYMSF\n");
 	if (copy_from_user(&msf, (struct cdrom_msf __user *)arg, sizeof(msf)))
 		return -EFAULT;
@@ -3127,6 +3188,7 @@ static noinline int mmc_ioctl_cdrom_play_blk(struct cdrom_device_info *cdi,
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	struct cdrom_blk blk;
+
 	cd_dbg(CD_DO_IOCTL, "entering CDROMPLAYBLK\n");
 	if (copy_from_user(&blk, (struct cdrom_blk __user *)arg, sizeof(blk)))
 		return -EFAULT;
@@ -3163,11 +3225,12 @@ static noinline int mmc_ioctl_cdrom_volume(struct cdrom_device_info *cdi,
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
@@ -3187,7 +3250,8 @@ static noinline int mmc_ioctl_cdrom_volume(struct cdrom_device_info *cdi,
 		return -EINVAL;
 
 	/* now we have the current volume settings. if it was only
-	   a CDROMVOLREAD, return these values */
+	 * a CDROMVOLREAD, return these values
+	 */
 	if (cmd == CDROMVOLREAD) {
 		volctrl.channel0 = buffer[offset+9];
 		volctrl.channel1 = buffer[offset+11];
@@ -3198,7 +3262,7 @@ static noinline int mmc_ioctl_cdrom_volume(struct cdrom_device_info *cdi,
 			return -EFAULT;
 		return 0;
 	}
-		
+
 	/* get the volume mask */
 	cgc->buffer = mask;
 	ret = cdrom_mode_sense(cdi, cgc, GPMODE_AUDIO_CTL_PAGE, 1);
@@ -3221,6 +3285,7 @@ static noinline int mmc_ioctl_cdrom_start_stop(struct cdrom_device_info *cdi,
 					       int cmd)
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
+
 	cd_dbg(CD_DO_IOCTL, "entering CDROMSTART/CDROMSTOP\n");
 	cgc->cmd[0] = GPCMD_START_STOP_UNIT;
 	cgc->cmd[1] = 1;
@@ -3234,6 +3299,7 @@ static noinline int mmc_ioctl_cdrom_pause_resume(struct cdrom_device_info *cdi,
 						 int cmd)
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
+
 	cd_dbg(CD_DO_IOCTL, "entering CDROMPAUSE/CDROMRESUME\n");
 	cgc->cmd[0] = GPCMD_PAUSE_RESUME;
 	cgc->cmd[8] = (cmd == CDROMRESUME) ? 1 : 0;
@@ -3274,6 +3340,7 @@ static noinline int mmc_ioctl_dvd_auth(struct cdrom_device_info *cdi,
 {
 	int ret;
 	dvd_authinfo ai;
+
 	if (!CDROM_CAN(CDC_DVD))
 		return -ENOSYS;
 	cd_dbg(CD_DO_IOCTL, "entering DVD_AUTH\n");
@@ -3292,6 +3359,7 @@ static noinline int mmc_ioctl_cdrom_next_writable(struct cdrom_device_info *cdi,
 {
 	int ret;
 	long next = 0;
+
 	cd_dbg(CD_DO_IOCTL, "entering CDROM_NEXT_WRITABLE\n");
 	ret = cdrom_get_next_writable(cdi, &next);
 	if (ret)
@@ -3306,6 +3374,7 @@ static noinline int mmc_ioctl_cdrom_last_written(struct cdrom_device_info *cdi,
 {
 	int ret;
 	long last = 0;
+
 	cd_dbg(CD_DO_IOCTL, "entering CDROM_LAST_WRITTEN\n");
 	ret = cdrom_get_last_written(cdi, &last);
 	if (ret)
@@ -3325,7 +3394,8 @@ static int mmc_ioctl(struct cdrom_device_info *cdi, unsigned int cmd,
 	memset(&cgc, 0, sizeof(cgc));
 
 	/* build a unified command and queue it through
-	   cdo->generic_packet() */
+	 * cdo->generic_packet()
+	 */
 	switch (cmd) {
 	case CDROMREADRAW:
 	case CDROMREADMODE1:
@@ -3535,12 +3605,12 @@ static int cdrom_print_info(const char *header, int val, char *info,
 }
 
 static int cdrom_sysctl_info(struct ctl_table *ctl, int write,
-                           void *buffer, size_t *lenp, loff_t *ppos)
+							void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int pos;
 	char *info = cdrom_sysctl_settings.info;
 	const int max_size = sizeof(cdrom_sysctl_settings.info);
-	
+
 	if (!*lenp || (*ppos && !write)) {
 		*lenp = 0;
 		return 0;
@@ -3549,7 +3619,7 @@ static int cdrom_sysctl_info(struct ctl_table *ctl, int write,
 	mutex_lock(&cdrom_mutex);
 
 	pos = sprintf(info, "CD-ROM information, " VERSION "\n");
-	
+
 	if (cdrom_print_info("\ndrive name:\t", 0, info, &pos, CTL_NAME))
 		goto done;
 	if (cdrom_print_info("\ndrive speed:\t", 0, info, &pos, CTL_SPEED))
@@ -3618,9 +3688,10 @@ static int cdrom_sysctl_info(struct ctl_table *ctl, int write,
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
@@ -3651,11 +3722,11 @@ static int cdrom_sysctl_handler(struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
-	
+
 	ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
 
 	if (write) {
-	
+
 		/* we only care for 1 or 0. */
 		autoclose        = !!cdrom_sysctl_settings.autoclose;
 		autoeject        = !!cdrom_sysctl_settings.autoeject;
@@ -3664,19 +3735,20 @@ static int cdrom_sysctl_handler(struct ctl_table *ctl, int write,
 		check_media_type = !!cdrom_sysctl_settings.check;
 
 		/* update the option flags according to the changes. we
-		   don't have per device options through sysctl yet,
-		   but we will have and then this will disappear. */
+		 * don't have per device options through sysctl yet,
+		 * but we will have and then this will disappear.
+		 */
 		cdrom_update_settings();
 	}
 
-        return ret;
+	return ret;
 }
 
 /* Place files in /proc/sys/dev/cdrom */
 static struct ctl_table cdrom_table[] = {
 	{
 		.procname	= "info",
-		.data		= &cdrom_sysctl_settings.info, 
+		.data		= &cdrom_sysctl_settings.info,
 		.maxlen		= CDROM_STR_SIZE,
 		.mode		= 0444,
 		.proc_handler	= cdrom_sysctl_info,
diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 09b0cd292720..a52d515408ee 100644
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
@@ -156,8 +157,9 @@ static void gdrom_identifydevice(void *buf)
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
@@ -228,6 +230,7 @@ static char gdrom_execute_diagnostic(void)
 static int gdrom_preparedisk_cmd(void)
 {
 	struct packet_command *spin_command;
+
 	spin_command = kzalloc(sizeof(struct packet_command), GFP_KERNEL);
 	if (!spin_command)
 		return -ENOMEM;
@@ -367,6 +370,7 @@ static int gdrom_drivestatus(struct cdrom_device_info *cd_info, int ignore)
 {
 	/* read the sense key */
 	char sense = __raw_readb(GDROM_ERROR_REG);
+
 	sense &= 0xF0;
 	if (sense == 0)
 		return CDS_DISC_OK;
@@ -388,6 +392,7 @@ static unsigned int gdrom_check_events(struct cdrom_device_info *cd_info,
 static int gdrom_hardreset(struct cdrom_device_info *cd_info)
 {
 	int count;
+
 	__raw_writel(0x1fffff, GDROM_RESET_REG);
 	for (count = 0xa0000000; count < 0xa0200000; count += 4)
 		__raw_readl(count);
@@ -395,7 +400,8 @@ static int gdrom_hardreset(struct cdrom_device_info *cd_info)
 }
 
 /* keep the function looking like the universal
- * CD Rom specification  - returning int */
+ * CD Rom specification  - returning int
+ */
 static int gdrom_packetcommand(struct cdrom_device_info *cd_info,
 	struct packet_command *command)
 {
@@ -423,7 +429,8 @@ static int gdrom_getsense(short *bufstring)
 	sense_command->cmd[4] = 10;
 	sense_command->buflen = 10;
 	/* even if something is pending try to get
-	* the sense key if possible */
+	 * the sense key if possible
+	 */
 	if (gd.pending && !gdrom_wait_clrbusy()) {
 		err = -EBUSY;
 		goto cleanup_sense_final;
@@ -501,7 +508,7 @@ static unsigned int gdrom_bdops_check_events(struct gendisk *disk,
 }
 
 static int gdrom_bdops_ioctl(struct block_device *bdev, fmode_t mode,
-	unsigned cmd, unsigned long arg)
+	unsigned int cmd, unsigned long arg)
 {
 	int ret;
 
@@ -693,12 +700,13 @@ static int gdrom_init_dma_mode(void)
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
@@ -846,6 +854,7 @@ static struct platform_driver gdrom_driver = {
 static int __init init_gdrom(void)
 {
 	int rc;
+
 	gd.toc = NULL;
 	rc = platform_driver_register(&gdrom_driver);
 	if (rc)
-- 
2.27.0

