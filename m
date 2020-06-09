Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7153C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE62620734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388310AbgFISHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:07:17 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41482 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388186AbgFISF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:05:59 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1jiidG-0001pa-MQ; Tue, 09 Jun 2020 19:05:54 +0100
Received: from ben by deadeye with local (Exim 4.94)
        (envelope-from <ben@decadent.org.uk>)
        id 1jiidF-006VwI-IO; Tue, 09 Jun 2020 19:05:53 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Hannes Reinecke" <hare@suse.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Sasha Levin" <alexander.levin@microsoft.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Johannes Thumshirn" <jthumshirn@suse.de>,
        "Christoph Hellwig" <hch@lst.de>
Date:   Tue, 09 Jun 2020 19:04:28 +0100
Message-ID: <lsq.1591725832.9336726@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 37/61] scsi: sg: check for valid direction before
 starting the request
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

From: Johannes Thumshirn <jthumshirn@suse.de>

commit 28676d869bbb5257b5f14c0c95ad3af3a7019dd5 upstream.

Check for a valid direction before starting the request, otherwise we
risk running into an assertion in the scsi midlayer checking for valid
requests.

[mkp: fixed typo]

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Link: http://www.spinics.net/lists/linux-scsi/msg104400.html
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Hannes Reinecke <hare@suse.com>
Tested-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/scsi/sg.c | 46 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -701,18 +701,14 @@ sg_write(struct file *filp, const char _
 	 * is a non-zero input_size, so emit a warning.
 	 */
 	if (hp->dxfer_direction == SG_DXFER_TO_FROM_DEV) {
-		static char cmd[TASK_COMM_LEN];
-		if (strcmp(current->comm, cmd)) {
-			printk_ratelimited(KERN_WARNING
-					   "sg_write: data in/out %d/%d bytes "
-					   "for SCSI command 0x%x-- guessing "
-					   "data in;\n   program %s not setting "
-					   "count and/or reply_len properly\n",
-					   old_hdr.reply_len - (int)SZ_SG_HEADER,
-					   input_size, (unsigned int) cmnd[0],
-					   current->comm);
-			strcpy(cmd, current->comm);
-		}
+		printk_ratelimited(KERN_WARNING
+				   "sg_write: data in/out %d/%d bytes "
+				   "for SCSI command 0x%x-- guessing "
+				   "data in;\n   program %s not setting "
+				   "count and/or reply_len properly\n",
+				   old_hdr.reply_len - (int)SZ_SG_HEADER,
+				   input_size, (unsigned int) cmnd[0],
+				   current->comm);
 	}
 	k = sg_common_write(sfp, srp, cmnd, sfp->timeout, blocking);
 	return (k < 0) ? k : count;
@@ -790,6 +786,29 @@ sg_new_write(Sg_fd *sfp, struct file *fi
 	return count;
 }
 
+static bool sg_is_valid_dxfer(sg_io_hdr_t *hp)
+{
+	switch (hp->dxfer_direction) {
+	case SG_DXFER_NONE:
+		if (hp->dxferp || hp->dxfer_len > 0)
+			return false;
+		return true;
+	case SG_DXFER_TO_DEV:
+	case SG_DXFER_FROM_DEV:
+	case SG_DXFER_TO_FROM_DEV:
+		if (!hp->dxferp || hp->dxfer_len == 0)
+			return false;
+		return true;
+	case SG_DXFER_UNKNOWN:
+		if ((!hp->dxferp && hp->dxfer_len) ||
+		    (hp->dxferp && hp->dxfer_len == 0))
+			return false;
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int
 sg_common_write(Sg_fd * sfp, Sg_request * srp,
 		unsigned char *cmnd, int timeout, int blocking)
@@ -809,6 +828,9 @@ sg_common_write(Sg_fd * sfp, Sg_request
 	SCSI_LOG_TIMEOUT(4, printk("sg_common_write:  scsi opcode=0x%02x, cmd_size=%d\n",
 			  (int) cmnd[0], (int) hp->cmd_len));
 
+	if (!sg_is_valid_dxfer(hp))
+		return -EINVAL;
+
 	k = sg_start_req(srp, cmnd);
 	if (k) {
 		SCSI_LOG_TIMEOUT(1, printk("sg_common_write: start_req err=%d\n", k));

