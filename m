Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707C9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55A9120706
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgHRMKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:10:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:58731 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbgHRMKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:10:17 -0400
IronPort-SDR: ZY/UoZQiqBHmbkLnIATtIk0fnJ4l8iqI8pZBnalYoM+V4EjKij84+H28YUvQhVnMVKLCCFsASj
 NIsY/yUdgV3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="219200396"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="219200396"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 05:10:17 -0700
IronPort-SDR: NiRLWa7pniPOnGQ5riFMZvIC2gtrvvpkTW3KxnoaJbaYB1I2XlvRnEIE/8yI43pOLcYnVOS2GQ
 oHOj9nYbPsng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="326713029"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2020 05:10:13 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 08/13] mei: handle tx queue flushing for vtag connections
Date:   Tue, 18 Aug 2020 14:51:42 +0300
Message-Id: <20200818115147.2567012-9-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200818115147.2567012-1-tomas.winkler@intel.com>
References: <20200818115147.2567012-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Since multiple file pointers (fp) can be associated
with a single host client, upon close() only objects
associated with the fp has to flushed from the tx queues.
The control queues should be flushed only when all
the connections are closed and the client is disconnected.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/client.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 3904fce18261..d5c3f7d54634 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -429,14 +429,16 @@ static void mei_io_list_flush_cl(struct list_head *head,
  *
  * @head: An instance of our list structure
  * @cl: host client
+ * @fp: file pointer (matching cb file object), may be NULL
  */
 static void mei_io_tx_list_free_cl(struct list_head *head,
-				   const struct mei_cl *cl)
+				   const struct mei_cl *cl,
+				   const struct file *fp)
 {
 	struct mei_cl_cb *cb, *next;
 
 	list_for_each_entry_safe(cb, next, head, list) {
-		if (cl == cb->cl)
+		if (cl == cb->cl && (!fp || fp == cb->fp))
 			mei_tx_cb_dequeue(cb);
 	}
 }
@@ -574,13 +576,14 @@ int mei_cl_flush_queues(struct mei_cl *cl, const struct file *fp)
 	dev = cl->dev;
 
 	cl_dbg(dev, cl, "remove list entry belonging to cl\n");
-	mei_io_tx_list_free_cl(&cl->dev->write_list, cl);
-	mei_io_tx_list_free_cl(&cl->dev->write_waiting_list, cl);
-	mei_io_list_flush_cl(&cl->dev->ctrl_wr_list, cl);
-	mei_io_list_flush_cl(&cl->dev->ctrl_rd_list, cl);
-	/* free pending cb only in final flush */
-	if (!fp)
+	mei_io_tx_list_free_cl(&cl->dev->write_list, cl, fp);
+	mei_io_tx_list_free_cl(&cl->dev->write_waiting_list, cl, fp);
+	/* free pending and control cb only in final flush */
+	if (!fp) {
+		mei_io_list_flush_cl(&cl->dev->ctrl_wr_list, cl);
+		mei_io_list_flush_cl(&cl->dev->ctrl_rd_list, cl);
 		mei_cl_free_pending(cl);
+	}
 	spin_lock(&cl->rd_completed_lock);
 	mei_io_list_free_fp(&cl->rd_completed, fp);
 	spin_unlock(&cl->rd_completed_lock);
@@ -798,8 +801,8 @@ static void mei_cl_set_disconnected(struct mei_cl *cl)
 		return;
 
 	cl->state = MEI_FILE_DISCONNECTED;
-	mei_io_tx_list_free_cl(&dev->write_list, cl);
-	mei_io_tx_list_free_cl(&dev->write_waiting_list, cl);
+	mei_io_tx_list_free_cl(&dev->write_list, cl, NULL);
+	mei_io_tx_list_free_cl(&dev->write_waiting_list, cl, NULL);
 	mei_io_list_flush_cl(&dev->ctrl_rd_list, cl);
 	mei_io_list_flush_cl(&dev->ctrl_wr_list, cl);
 	mei_cl_wake_all(cl);
-- 
2.25.4

