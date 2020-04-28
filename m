Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92737C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72B672085B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099273;
	bh=BaVgmSjHEIJgkpOKzHo70T1UmYKAxEl2kDM9lEUxyGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gN55ilTlRVwFTTPSHpQuBWRe6jyV3+SgreyKvYQP2vk9im6nuyrP2a+wEXeLccDe2
	 uBaT626KG+XnQfiMKRI9kJFcIXmuy8+RUm/UTlcaYv8TgUBVmAdGj9ZDKO4Ny/b5kt
	 6+EOdneEUMFxdIAC60K0YP5jtlyywW81tSjY07Uk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbgD1SlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:41:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730969AbgD1SlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:41:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5260D2085B;
        Tue, 28 Apr 2020 18:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099268;
        bh=BaVgmSjHEIJgkpOKzHo70T1UmYKAxEl2kDM9lEUxyGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RixPxm9qZoRDmVfsEEZ2hXY6p4KVsSxl3SskNZuqV6RzJKwJUEf9zEv1B0g/Z5LGg
         Sia5JHSIkZepOT2CRjo79mFOOVxfAm2EhoZxgBwnTAYV+ndaQMw5LRKfmBTrNQIUz6
         yLFGApVvIVgPGBkguqZKfCYiCaksIvuQTReku2qI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.19 125/131] UAS: fix deadlock in error handling and PM flushing work
Date:   Tue, 28 Apr 2020 20:25:37 +0200
Message-Id: <20200428182240.988236185@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182224.822179290@linuxfoundation.org>
References: <20200428182224.822179290@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit f6cc6093a729ede1ff5658b493237c42b82ba107 upstream.

A SCSI error handler and block runtime PM must not allocate
memory with GFP_KERNEL. Furthermore they must not wait for
tasks allocating memory with GFP_KERNEL.
That means that they cannot share a workqueue with arbitrary tasks.

Fix this for UAS using a private workqueue.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Fixes: f9dc024a2da1f ("uas: pre_reset and suspend: Fix a few races")
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200415141750.811-2-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/uas.c |   43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -81,6 +81,19 @@ static void uas_free_streams(struct uas_
 static void uas_log_cmd_state(struct scsi_cmnd *cmnd, const char *prefix,
 				int status);
 
+/*
+ * This driver needs its own workqueue, as we need to control memory allocation.
+ *
+ * In the course of error handling and power management uas_wait_for_pending_cmnds()
+ * needs to flush pending work items. In these contexts we cannot allocate memory
+ * by doing block IO as we would deadlock. For the same reason we cannot wait
+ * for anything allocating memory not heeding these constraints.
+ *
+ * So we have to control all work items that can be on the workqueue we flush.
+ * Hence we cannot share a queue and need our own.
+ */
+static struct workqueue_struct *workqueue;
+
 static void uas_do_work(struct work_struct *work)
 {
 	struct uas_dev_info *devinfo =
@@ -109,7 +122,7 @@ static void uas_do_work(struct work_stru
 		if (!err)
 			cmdinfo->state &= ~IS_IN_WORK_LIST;
 		else
-			schedule_work(&devinfo->work);
+			queue_work(workqueue, &devinfo->work);
 	}
 out:
 	spin_unlock_irqrestore(&devinfo->lock, flags);
@@ -134,7 +147,7 @@ static void uas_add_work(struct uas_cmd_
 
 	lockdep_assert_held(&devinfo->lock);
 	cmdinfo->state |= IS_IN_WORK_LIST;
-	schedule_work(&devinfo->work);
+	queue_work(workqueue, &devinfo->work);
 }
 
 static void uas_zap_pending(struct uas_dev_info *devinfo, int result)
@@ -1236,7 +1249,31 @@ static struct usb_driver uas_driver = {
 	.id_table = uas_usb_ids,
 };
 
-module_usb_driver(uas_driver);
+static int __init uas_init(void)
+{
+	int rv;
+
+	workqueue = alloc_workqueue("uas", WQ_MEM_RECLAIM, 0);
+	if (!workqueue)
+		return -ENOMEM;
+
+	rv = usb_register(&uas_driver);
+	if (rv) {
+		destroy_workqueue(workqueue);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void __exit uas_exit(void)
+{
+	usb_deregister(&uas_driver);
+	destroy_workqueue(workqueue);
+}
+
+module_init(uas_init);
+module_exit(uas_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR(


