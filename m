Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C638C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE5FF2068D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388580AbgFISKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:10:32 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41294 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388153AbgFISF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:05:58 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1jiidG-0001p6-6h; Tue, 09 Jun 2020 19:05:54 +0100
Received: from ben by deadeye with local (Exim 4.94)
        (envelope-from <ben@decadent.org.uk>)
        id 1jiidF-006Vvf-6G; Tue, 09 Jun 2020 19:05:53 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>
Date:   Tue, 09 Jun 2020 19:04:16 +0100
Message-ID: <lsq.1591725832.42461519@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 25/61] scsi: sg: Change next_cmd_len handling to
 mirror upstream
In-Reply-To: <lsq.1591725831.850867383@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.85-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

Change the type of next_cmd_len to unsigned char, done in upstream
commit 65c26a0f3969 "sg: relax 16 byte cdb restriction".

Move the range check from sg_write() to sg_ioctl(), which was done by
that commit and commit bf33f87dd04c "scsi: sg: check length passed to
SG_NEXT_CMD_LEN".  Continue limiting the command length to
MAX_COMMAND_SIZE (16).

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -160,7 +160,7 @@ typedef struct sg_fd {		/* holds the sta
 	char low_dma;		/* as in parent but possibly overridden to 1 */
 	char force_packid;	/* 1 -> pack_id input to read(), 0 -> ignored */
 	char cmd_q;		/* 1 -> allow command queuing, 0 -> don't */
-	char next_cmd_len;	/* 0 -> automatic (def), >0 -> use on next write() */
+	unsigned char next_cmd_len; /* 0: automatic, >0: use on next write() */
 	char keep_orphan;	/* 0 -> drop orphan (def), 1 -> keep for read() */
 	char mmap_called;	/* 0 -> mmap() never called on this fd */
 	struct kref f_ref;
@@ -653,12 +653,6 @@ sg_write(struct file *filp, const char _
 	buf += SZ_SG_HEADER;
 	__get_user(opcode, buf);
 	if (sfp->next_cmd_len > 0) {
-		if (sfp->next_cmd_len > MAX_COMMAND_SIZE) {
-			SCSI_LOG_TIMEOUT(1, printk("sg_write: command length too long\n"));
-			sfp->next_cmd_len = 0;
-			sg_remove_request(sfp, srp);
-			return -EIO;
-		}
 		cmd_size = sfp->next_cmd_len;
 		sfp->next_cmd_len = 0;	/* reset so only this write() effected */
 	} else {
@@ -1045,6 +1039,8 @@ sg_ioctl(struct file *filp, unsigned int
 		result = get_user(val, ip);
 		if (result)
 			return result;
+		if (val > MAX_COMMAND_SIZE)
+			return -ENOMEM;
 		sfp->next_cmd_len = (val > 0) ? val : 0;
 		return 0;
 	case SG_GET_VERSION_NUM:

