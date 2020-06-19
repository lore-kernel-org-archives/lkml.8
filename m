Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A36C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A38521556
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=superboring.dev header.i=@superboring.dev header.b="54S9j+O+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389110AbgFSTeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388669AbgFSTeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:34:09 -0400
Received: from mail.halogenos.org (halogenos.org [IPv6:2a02:c207:2037:5246::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA4CC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:34:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AC42515002FD;
        Fri, 19 Jun 2020 21:34:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=superboring.dev;
        s=dkim; t=1592595244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=njiDGODH/92W7moo/qJOu1XORA/TJZy2aru2zrUTeHg=;
        b=54S9j+O+iU2p6qquGY6wgm0iPSH16sV/uBCFtww4ZastQXrgv+hhwf4tF4YhZoxuDUZOFA
        h0/ECycf105/lrCdpQw7HgHWDvTARRvcbTfJ6Tb7HCTIEyDztQL3CADbHskGc0w/tfsfMv
        2Tv1LKC+6/bbfYBPZMfvAbUBoumoM+lYIpF0HebC6K7N6KVbW/bBTghAf/bm5f4eNZMEJN
        WRqVPD74tK+FjnOfoutKpqA/QuBPV1dO0Qv2y/+/wp5STByn1B2m6NoWWoMs1dtLTGQ/kj
        ikQS0Hbo6ir27m3knpbgOlccS+sor7iC6WrtaD9n4hNPnTZLwg8re5Xr534ntw==
From:   Simao Gomes Viana <devel@superboring.dev>
To:     linux-kernel@vger.kernel.org
Cc:     Simao Gomes Viana <devel@superboring.dev>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 1/9] drivers: cdrom: fix horizontal whitespace
Date:   Fri, 19 Jun 2020 21:33:33 +0200
Message-Id: <20200619193341.51209-1-devel@superboring.dev>
In-Reply-To: <20200619180834.8032-1-devel@superboring.dev>
References: <20200619180834.8032-1-devel@superboring.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add, remove and adjust whitespace as needed.
This includes:
 * Missing spaces around operators
 * Removing trailing whitespace
 * Removing whitespace from tabs
 * Converting spaces to tabs
 * Fixing wrong indentation

These whitespace errors were mainly reported
by scripts/checkpatch.pl

Signed-off-by: Simao Gomes Viana <devel@superboring.dev>
---
 drivers/cdrom/cdrom.c | 149 +++++++++++++++++++++---------------------
 1 file changed, 74 insertions(+), 75 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index d82b3b7658bd..4ecd1f287b11 100644
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
@@ -273,7 +273,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
-#include <linux/slab.h> 
+#include <linux/slab.h>
 #include <linux/cdrom.h>
 #include <linux/sysctl.h>
 #include <linux/proc_fs.h>
@@ -289,7 +289,7 @@
 /* used to tell the module to turn on full debugging messages */
 static bool debug;
 /* default compatibility mode */
-static bool autoclose=1;
+static bool autoclose = 1;
 static bool autoeject;
 static bool lockdoor = 1;
 /* will we ever get to use this... sigh. */
@@ -539,7 +539,7 @@ static int cdrom_mrw_exit(struct cdrom_device_info *cdi)
 	int ret;
 
 	ret = cdrom_get_disc_info(cdi, &di);
-	if (ret < 0 || ret < (int)offsetof(typeof(di),disc_type))
+	if (ret < 0 || ret < (int)offsetof(typeof(di), disc_type))
 		return 1;
 
 	ret = 0;
@@ -702,7 +702,7 @@ static int cdrom_get_random_writable(struct cdrom_device_info *cdi,
 	if ((ret = cdi->ops->generic_packet(cdi, &cgc)))
 		return ret;
 
-	memcpy(rfd, &buffer[sizeof(struct feature_header)], sizeof (*rfd));
+	memcpy(rfd, &buffer[sizeof(struct feature_header)], sizeof(*rfd));
 	return 0;
 }
 
@@ -790,7 +790,7 @@ static int cdrom_mrw_open_write(struct cdrom_device_info *cdi)
 	}
 
 	ret = cdrom_get_disc_info(cdi, &di);
-	if (ret < 0 || ret < offsetof(typeof(di),disc_type))
+	if (ret < 0 || ret < offsetof(typeof(di), disc_type))
 		return 1;
 
 	if (!di.erasable)
@@ -910,7 +910,7 @@ static int cdrom_open_write(struct cdrom_device_info *cdi)
 		ram_write = 1;
 	else
 		(void) cdrom_is_random_writable(cdi, &ram_write);
-	
+
 	if (mrw)
 		cdi->mask &= ~CDC_MRW;
 	else
@@ -930,9 +930,9 @@ static int cdrom_open_write(struct cdrom_device_info *cdi)
 		ret = cdrom_mrw_open_write(cdi);
 	else if (CDROM_CAN(CDC_DVD_RAM))
 		ret = cdrom_dvdram_open_write(cdi);
- 	else if (CDROM_CAN(CDC_RAM) &&
- 		 !CDROM_CAN(CDC_CD_R|CDC_CD_RW|CDC_DVD|CDC_DVD_R|CDC_MRW|CDC_MO_DRIVE))
- 		ret = cdrom_ram_open_write(cdi);
+	else if (CDROM_CAN(CDC_RAM) &&
+		!CDROM_CAN(CDC_CD_R|CDC_CD_RW|CDC_DVD|CDC_DVD_R|CDC_MRW|CDC_MO_DRIVE))
+		ret = cdrom_ram_open_write(cdi);
 	else if (CDROM_CAN(CDC_MO_DRIVE))
 		ret = mo_open_write(cdi);
 	else if (!cdrom_is_dvd_rw(cdi))
@@ -1058,7 +1058,7 @@ int open_for_data(struct cdrom_device_info *cdi)
 			if (CDROM_CAN(CDC_CLOSE_TRAY) &&
 			    cdi->options & CDO_AUTO_CLOSE) {
 				cd_dbg(CD_OPEN, "trying to close the tray\n");
-				ret=cdo->tray_move(cdi,0);
+				ret = cdo->tray_move(cdi, 0);
 				if (ret) {
 					cd_dbg(CD_OPEN, "bummer. tried to close the tray but failed.\n");
 					/* Ignore the error from the low
@@ -1066,12 +1066,12 @@ int open_for_data(struct cdrom_device_info *cdi)
 					couldn't close the tray.  We only care 
 					that there is no disc in the drive, 
 					since that is the _REAL_ problem here.*/
-					ret=-ENOMEDIUM;
+					ret = -ENOMEDIUM;
 					goto clean_up_and_return;
 				}
 			} else {
 				cd_dbg(CD_OPEN, "bummer. this drive can't close the tray.\n");
-				ret=-ENOMEDIUM;
+				ret = -ENOMEDIUM;
 				goto clean_up_and_return;
 			}
 			/* Ok, the door should be closed now.. Check again */
@@ -1079,14 +1079,14 @@ int open_for_data(struct cdrom_device_info *cdi)
 			if ((ret == CDS_NO_DISC) || (ret==CDS_TRAY_OPEN)) {
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
@@ -1094,23 +1094,22 @@ int open_for_data(struct cdrom_device_info *cdi)
 	cdrom_count_tracks(cdi, &tracks);
 	if (tracks.error == CDS_NO_DISC) {
 		cd_dbg(CD_OPEN, "bummer. no disc.\n");
-		ret=-ENOMEDIUM;
+		ret = -ENOMEDIUM;
 		goto clean_up_and_return;
 	}
 	/* CD-Players which don't use O_NONBLOCK, workman
 	 * for example, need bit CDO_CHECK_TYPE cleared! */
-	if (tracks.data==0) {
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
+			   is the default case! */
+			cd_dbg(CD_OPEN, "bummer. wrong media type.\n");
+			cd_dbg(CD_WARNING, "pid %d must open device O_NONBLOCK!\n",
+					(unsigned int)task_pid_nr(current));
+			ret = -EMEDIUMTYPE;
+			goto clean_up_and_return;
+		} else {
+			cd_dbg(CD_OPEN, "wrong media type, but CDO_CHECK_TYPE not set\n");
 		}
 	}
 
@@ -1127,8 +1126,8 @@ int open_for_data(struct cdrom_device_info *cdi)
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
@@ -1141,8 +1140,8 @@ int open_for_data(struct cdrom_device_info *cdi)
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
@@ -1207,7 +1206,7 @@ int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
 static int check_for_audio_disc(struct cdrom_device_info *cdi,
 				const struct cdrom_device_ops *cdo)
 {
-        int ret;
+	int ret;
 	tracktype tracks;
 	cd_dbg(CD_OPEN, "entering check_for_audio_disc\n");
 	if (!(cdi->options & CDO_CHECK_TYPE))
@@ -1221,7 +1220,7 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
 			if (CDROM_CAN(CDC_CLOSE_TRAY) &&
 			    cdi->options & CDO_AUTO_CLOSE) {
 				cd_dbg(CD_OPEN, "trying to close the tray\n");
-				ret=cdo->tray_move(cdi,0);
+				ret = cdo->tray_move(cdi, 0);
 				if (ret) {
 					cd_dbg(CD_OPEN, "bummer. tried to close tray but failed.\n");
 					/* Ignore the error from the low
@@ -1237,22 +1236,22 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
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
 	cdrom_count_tracks(cdi, &tracks);
-	if (tracks.error) 
+	if (tracks.error)
 		return(tracks.error);
 
-	if (tracks.audio==0)
+	if (tracks.audio == 0)
 		return -EMEDIUMTYPE;
 
 	return 0;
@@ -1296,7 +1295,7 @@ void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
 	}
 }
 
-static int cdrom_read_mech_status(struct cdrom_device_info *cdi, 
+static int cdrom_read_mech_status(struct cdrom_device_info *cdi,
 				  struct cdrom_changer_info *buf)
 {
 	struct packet_command cgc;
@@ -1336,7 +1335,7 @@ static int cdrom_slot_status(struct cdrom_device_info *cdi, int slot)
 	cd_dbg(CD_CHANGER, "entering cdrom_slot_status()\n");
 	if (cdi->sanyo_slot)
 		return CDS_NO_INFO;
-	
+
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
@@ -1354,10 +1353,10 @@ static int cdrom_slot_status(struct cdrom_device_info *cdi, int slot)
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
@@ -1365,7 +1364,7 @@ int cdrom_number_of_slots(struct cdrom_device_info *cdi)
 
 	cd_dbg(CD_CHANGER, "entering cdrom_number_of_slots()\n");
 	/* cdrom_read_mech_status requires a valid value for capacity: */
-	cdi->capacity = 0; 
+	cdi->capacity = 0;
 
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
@@ -1380,7 +1379,7 @@ int cdrom_number_of_slots(struct cdrom_device_info *cdi)
 
 
 /* If SLOT < 0, unload the current slot.  Otherwise, try to load SLOT. */
-static int cdrom_load_unload(struct cdrom_device_info *cdi, int slot) 
+static int cdrom_load_unload(struct cdrom_device_info *cdi, int slot)
 {
 	struct packet_command cgc;
 
@@ -1565,7 +1564,7 @@ int cdrom_media_changed(struct cdrom_device_info *cdi)
 
 static
 void sanitize_format(union cdrom_addr *addr,
-		     u_char * curr, u_char requested)
+		     u_char *curr, u_char requested)
 {
 	if (*curr == requested)
 		return;                 /* nothing to be done! */
@@ -1597,8 +1596,8 @@ void init_cdrom_command(struct packet_command *cgc, void *buf, int len,
 
 /* DVD handling */
 
-#define copy_key(dest,src)	memcpy((dest), (src), sizeof(dvd_key))
-#define copy_chal(dest,src)	memcpy((dest), (src), sizeof(dvd_challenge))
+#define copy_key(dest, src) memcpy((dest), (src), sizeof(dvd_key))
+#define copy_chal(dest, src) memcpy((dest), (src), sizeof(dvd_challenge))
 
 static void setup_report_key(struct packet_command *cgc, unsigned agid, unsigned type)
 {
@@ -1989,7 +1988,7 @@ static int dvd_read_struct(struct cdrom_device_info *cdi, dvd_struct *s,
 
 	case DVD_STRUCT_MANUFACT:
 		return dvd_read_manufact(cdi, s, cgc);
-		
+
 	default:
 		cd_dbg(CD_WARNING, ": Invalid DVD structure read requested (%d)\n",
 		       s->type);
@@ -2115,7 +2114,7 @@ static int cdrom_read_block(struct cdrom_device_info *cdi,
 	cgc->cmd[7] = (nblocks >>  8) & 0xff;
 	cgc->cmd[8] = nblocks & 0xff;
 	cgc->buflen = blksize * nblocks;
-	
+
 	/* set the header info returned */
 	switch (blksize) {
 	case CD_FRAMESIZE_RAW0	: cgc->cmd[9] = 0x58; break;
@@ -2123,7 +2122,7 @@ static int cdrom_read_block(struct cdrom_device_info *cdi,
 	case CD_FRAMESIZE_RAW	: cgc->cmd[9] = 0xf8; break;
 	default			: cgc->cmd[9] = 0x10;
 	}
-	
+
 	return cdo->generic_packet(cdi, cgc);
 }
 
@@ -2292,7 +2291,7 @@ static int cdrom_read_cdda(struct cdrom_device_info *cdi, __u8 __user *ubuf,
 
 	pr_info("dropping to old style cdda (sense=%x)\n", cdi->last_sense);
 	cdi->cdda_method = CDDA_OLD;
-	return cdrom_read_cdda_old(cdi, ubuf, lba, nframes);	
+	return cdrom_read_cdda_old(cdi, ubuf, lba, nframes);
 }
 
 int cdrom_multisession(struct cdrom_device_info *cdi,
@@ -3198,7 +3197,7 @@ static noinline int mmc_ioctl_cdrom_volume(struct cdrom_device_info *cdi,
 			return -EFAULT;
 		return 0;
 	}
-		
+
 	/* get the volume mask */
 	cgc->buffer = mask;
 	ret = cdrom_mode_sense(cdi, cgc, GPMODE_AUDIO_CTL_PAGE, 1);
@@ -3535,12 +3534,12 @@ static int cdrom_print_info(const char *header, int val, char *info,
 }
 
 static int cdrom_sysctl_info(struct ctl_table *ctl, int write,
-                           void *buffer, size_t *lenp, loff_t *ppos)
+				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int pos;
 	char *info = cdrom_sysctl_settings.info;
 	const int max_size = sizeof(cdrom_sysctl_settings.info);
-	
+
 	if (!*lenp || (*ppos && !write)) {
 		*lenp = 0;
 		return 0;
@@ -3549,7 +3548,7 @@ static int cdrom_sysctl_info(struct ctl_table *ctl, int write,
 	mutex_lock(&cdrom_mutex);
 
 	pos = sprintf(info, "CD-ROM information, " VERSION "\n");
-	
+
 	if (cdrom_print_info("\ndrive name:\t", 0, info, &pos, CTL_NAME))
 		goto done;
 	if (cdrom_print_info("\ndrive speed:\t", 0, info, &pos, CTL_SPEED))
@@ -3651,11 +3650,11 @@ static int cdrom_sysctl_handler(struct ctl_table *ctl, int write,
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
@@ -3669,14 +3668,14 @@ static int cdrom_sysctl_handler(struct ctl_table *ctl, int write,
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
-- 
2.27.0

