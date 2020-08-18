Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B157C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4623220706
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgHRMKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:10:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:58731 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgHRMKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:10:15 -0400
IronPort-SDR: MvR4RzrTYnz8SAIA1v00CbbK7hey3+OufHjJaCBETnB50J8BBo4BCbm6iPICGJQ6LnAs+s2sN5
 JKAWIP71Hw5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="219200389"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="219200389"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 05:10:13 -0700
IronPort-SDR: T+OgtRGbE+UU4I5kT3lKd777rtaW7rPJOpKvcN4Gm6PMFiYCeog2VEtImBJ61Q0TTHvM0M5+Ng
 obt7aFnV6B9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="326713015"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2020 05:10:09 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 07/13] mei: add a vtag map for each client
Date:   Tue, 18 Aug 2020 14:51:41 +0300
Message-Id: <20200818115147.2567012-8-tomas.winkler@intel.com>
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

Vtag map is a list of tuples of vtag and file pointer (struct
mei_cl_vtag) associated with a particular me host client.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/client.c  | 168 ++++++++++++++++++++++++++++++++++++-
 drivers/misc/mei/client.h  |   3 +
 drivers/misc/mei/main.c    |  68 ++++++++++++++-
 drivers/misc/mei/mei_dev.h |  17 ++++
 4 files changed, 251 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 276021f99666..3904fce18261 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -354,6 +354,27 @@ static inline void mei_tx_cb_dequeue(struct mei_cl_cb *cb)
 	mei_io_cb_free(cb);
 }
 
+/**
+ * mei_cl_set_read_by_fp - set pending_read flag to vtag struct for given fp
+ *
+ * Locking: called under "dev->device_lock" lock
+ *
+ * @cl: mei client
+ * @fp: pointer to file structure
+ */
+static void mei_cl_set_read_by_fp(const struct mei_cl *cl,
+				  const struct file *fp)
+{
+	struct mei_cl_vtag *cl_vtag;
+
+	list_for_each_entry(cl_vtag, &cl->vtag_map, list) {
+		if (cl_vtag->fp == fp) {
+			cl_vtag->pending_read = true;
+			return;
+		}
+	}
+}
+
 /**
  * mei_io_cb_init - allocate and initialize io callback
  *
@@ -435,6 +456,19 @@ static void mei_io_list_free_fp(struct list_head *head, const struct file *fp)
 			mei_io_cb_free(cb);
 }
 
+/**
+ * mei_cl_free_pending - free pending cb
+ *
+ * @cl: host client
+ */
+static void mei_cl_free_pending(struct mei_cl *cl)
+{
+	struct mei_cl_cb *cb;
+
+	cb = list_first_entry_or_null(&cl->rd_pending, struct mei_cl_cb, list);
+	mei_io_cb_free(cb);
+}
+
 /**
  * mei_cl_alloc_cb - a convenient wrapper for allocating read cb
  *
@@ -544,7 +578,9 @@ int mei_cl_flush_queues(struct mei_cl *cl, const struct file *fp)
 	mei_io_tx_list_free_cl(&cl->dev->write_waiting_list, cl);
 	mei_io_list_flush_cl(&cl->dev->ctrl_wr_list, cl);
 	mei_io_list_flush_cl(&cl->dev->ctrl_rd_list, cl);
-	mei_io_list_free_fp(&cl->rd_pending, fp);
+	/* free pending cb only in final flush */
+	if (!fp)
+		mei_cl_free_pending(cl);
 	spin_lock(&cl->rd_completed_lock);
 	mei_io_list_free_fp(&cl->rd_completed, fp);
 	spin_unlock(&cl->rd_completed_lock);
@@ -565,6 +601,7 @@ static void mei_cl_init(struct mei_cl *cl, struct mei_device *dev)
 	init_waitqueue_head(&cl->rx_wait);
 	init_waitqueue_head(&cl->tx_wait);
 	init_waitqueue_head(&cl->ev_wait);
+	INIT_LIST_HEAD(&cl->vtag_map);
 	spin_lock_init(&cl->rd_completed_lock);
 	INIT_LIST_HEAD(&cl->rd_completed);
 	INIT_LIST_HEAD(&cl->rd_pending);
@@ -1237,8 +1274,117 @@ static int mei_cl_tx_flow_ctrl_creds_reduce(struct mei_cl *cl)
 	return 0;
 }
 
+/**
+ * mei_cl_vtag_alloc - allocate and fill the vtag structure
+ *
+ * @fp: pointer to file structure
+ * @vtag: vm tag
+ *
+ * Return:
+ * * Pointer to allocated struct - on success
+ * * ERR_PTR(-ENOMEM) on memory allocation failure
+ */
+struct mei_cl_vtag *mei_cl_vtag_alloc(struct file *fp, u8 vtag)
+{
+	struct mei_cl_vtag *cl_vtag;
+
+	cl_vtag = kzalloc(sizeof(*cl_vtag), GFP_KERNEL);
+	if (!cl_vtag)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&cl_vtag->list);
+	cl_vtag->vtag = vtag;
+	cl_vtag->fp = fp;
+
+	return cl_vtag;
+}
+
+/**
+ * mei_cl_fp_by_vtag - obtain the file pointer by vtag
+ *
+ * @cl: host client
+ * @vtag: vm tag
+ *
+ * Return:
+ * * A file pointer - on success
+ * * ERR_PTR(-ENOENT) if vtag is not found in the client vtag list
+ */
+const struct file *mei_cl_fp_by_vtag(const struct mei_cl *cl, u8 vtag)
+{
+	struct mei_cl_vtag *vtag_l;
+
+	list_for_each_entry(vtag_l, &cl->vtag_map, list)
+		if (vtag_l->vtag == vtag)
+			return vtag_l->fp;
+
+	return ERR_PTR(-ENOENT);
+}
+
+/**
+ * mei_cl_reset_read_by_vtag - reset pending_read flag by given vtag
+ *
+ * @cl: host client
+ * @vtag: vm tag
+ */
+static void mei_cl_reset_read_by_vtag(const struct mei_cl *cl, u8 vtag)
+{
+	struct mei_cl_vtag *vtag_l;
+
+	list_for_each_entry(vtag_l, &cl->vtag_map, list) {
+		if (vtag_l->vtag == vtag) {
+			vtag_l->pending_read = false;
+			break;
+		}
+	}
+}
+
+/**
+ * mei_cl_read_vtag_add_fc - add flow control for next pending reader
+ *                           in the vtag list
+ *
+ * @cl: host client
+ */
+static void mei_cl_read_vtag_add_fc(struct mei_cl *cl)
+{
+	struct mei_cl_vtag *cl_vtag;
+
+	list_for_each_entry(cl_vtag, &cl->vtag_map, list) {
+		if (cl_vtag->pending_read) {
+			if (mei_cl_enqueue_ctrl_wr_cb(cl,
+						      mei_cl_mtu(cl),
+						      MEI_FOP_READ,
+						      cl_vtag->fp))
+				cl->rx_flow_ctrl_creds++;
+			break;
+		}
+	}
+}
+
+/**
+ * mei_cl_vt_support_check - check if client support vtags
+ *
+ * @cl: host client
+ *
+ * Return:
+ * * 0 - supported, or not connected at all
+ * * -EOPNOTSUPP - vtags are not supported by client
+ */
+int mei_cl_vt_support_check(const struct mei_cl *cl)
+{
+	struct mei_device *dev = cl->dev;
+
+	if (!dev->hbm_f_vt_supported)
+		return -EOPNOTSUPP;
+
+	if (!cl->me_cl)
+		return 0;
+
+	return cl->me_cl->props.vt_supported ? 0 : -EOPNOTSUPP;
+}
+
 /**
  * mei_cl_add_rd_completed - add read completed callback to list with lock
+ *                           and vtag check
  *
  * @cl: host client
  * @cb: callback block
@@ -1246,6 +1392,20 @@ static int mei_cl_tx_flow_ctrl_creds_reduce(struct mei_cl *cl)
  */
 void mei_cl_add_rd_completed(struct mei_cl *cl, struct mei_cl_cb *cb)
 {
+	const struct file *fp;
+
+	if (!mei_cl_vt_support_check(cl)) {
+		fp = mei_cl_fp_by_vtag(cl, cb->vtag);
+		if (IS_ERR(fp)) {
+			/* client already disconnected, discarding */
+			mei_io_cb_free(cb);
+			return;
+		}
+		cb->fp = fp;
+		mei_cl_reset_read_by_vtag(cl, cb->vtag);
+		mei_cl_read_vtag_add_fc(cl);
+	}
+
 	spin_lock(&cl->rd_completed_lock);
 	list_add_tail(&cb->list, &cl->rd_completed);
 	spin_unlock(&cl->rd_completed_lock);
@@ -1520,13 +1680,17 @@ int mei_cl_read_start(struct mei_cl *cl, size_t length, const struct file *fp)
 		return 0;
 
 	/* HW currently supports only one pending read */
-	if (cl->rx_flow_ctrl_creds)
+	if (cl->rx_flow_ctrl_creds) {
+		mei_cl_set_read_by_fp(cl, fp);
 		return -EBUSY;
+	}
 
 	cb = mei_cl_enqueue_ctrl_wr_cb(cl, length, MEI_FOP_READ, fp);
 	if (!cb)
 		return -ENOMEM;
 
+	mei_cl_set_read_by_fp(cl, fp);
+
 	rets = pm_runtime_get(dev->dev);
 	if (rets < 0 && rets != -EINPROGRESS) {
 		pm_runtime_put_noidle(dev->dev);
diff --git a/drivers/misc/mei/client.h b/drivers/misc/mei/client.h
index bd57c64f6c1a..64143d4ec758 100644
--- a/drivers/misc/mei/client.h
+++ b/drivers/misc/mei/client.h
@@ -146,6 +146,9 @@ struct mei_cl_cb *mei_cl_enqueue_ctrl_wr_cb(struct mei_cl *cl, size_t length,
 					    const struct file *fp);
 int mei_cl_flush_queues(struct mei_cl *cl, const struct file *fp);
 
+struct mei_cl_vtag *mei_cl_vtag_alloc(struct file *fp, u8 vtag);
+const struct file *mei_cl_fp_by_vtag(const struct mei_cl *cl, u8 vtag);
+int mei_cl_vt_support_check(const struct mei_cl *cl);
 /*
  *  MEI input output function prototype
  */
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 441bdea4d4c1..401bf8743689 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -80,6 +80,27 @@ static int mei_open(struct inode *inode, struct file *file)
 	return err;
 }
 
+/**
+ * mei_cl_vtag_remove_by_fp - remove vtag that corresponds to fp from list
+ *
+ * @cl: host client
+ * @fp: pointer to file structure
+ *
+ */
+static void mei_cl_vtag_remove_by_fp(const struct mei_cl *cl,
+				     const struct file *fp)
+{
+	struct mei_cl_vtag *vtag_l, *next;
+
+	list_for_each_entry_safe(vtag_l, next, &cl->vtag_map, list) {
+		if (vtag_l->fp == fp) {
+			list_del(&vtag_l->list);
+			kfree(vtag_l);
+			return;
+		}
+	}
+}
+
 /**
  * mei_release - the release function
  *
@@ -101,17 +122,35 @@ static int mei_release(struct inode *inode, struct file *file)
 
 	mutex_lock(&dev->device_lock);
 
+	mei_cl_vtag_remove_by_fp(cl, file);
+
+	if (!list_empty(&cl->vtag_map)) {
+		cl_dbg(dev, cl, "not the last vtag\n");
+		mei_cl_flush_queues(cl, file);
+		rets = 0;
+		goto out;
+	}
+
 	rets = mei_cl_disconnect(cl);
+	/*
+	 * Check again: This is necessary since disconnect releases the lock
+	 * and another client can connect in the meantime.
+	 */
+	if (!list_empty(&cl->vtag_map)) {
+		cl_dbg(dev, cl, "not the last vtag after disconnect\n");
+		mei_cl_flush_queues(cl, file);
+		goto out;
+	}
 
-	mei_cl_flush_queues(cl, file);
+	mei_cl_flush_queues(cl, NULL);
 	cl_dbg(dev, cl, "removing\n");
 
 	mei_cl_unlink(cl);
+	kfree(cl);
 
+out:
 	file->private_data = NULL;
 
-	kfree(cl);
-
 	mutex_unlock(&dev->device_lock);
 	return rets;
 }
@@ -237,6 +276,28 @@ static ssize_t mei_read(struct file *file, char __user *ubuf,
 	mutex_unlock(&dev->device_lock);
 	return rets;
 }
+
+/**
+ * mei_cl_vtag_by_fp - obtain the vtag by file pointer
+ *
+ * @cl: host client
+ * @fp: pointer to file structure
+ *
+ * Return: vtag value on success, otherwise 0
+ */
+static u8 mei_cl_vtag_by_fp(const struct mei_cl *cl, const struct file *fp)
+{
+	struct mei_cl_vtag *cl_vtag;
+
+	if (!fp)
+		return 0;
+
+	list_for_each_entry(cl_vtag, &cl->vtag_map, list)
+		if (cl_vtag->fp == fp)
+			return cl_vtag->vtag;
+	return 0;
+}
+
 /**
  * mei_write - the write function.
  *
@@ -314,6 +375,7 @@ static ssize_t mei_write(struct file *file, const char __user *ubuf,
 		rets = -ENOMEM;
 		goto out;
 	}
+	cb->vtag = mei_cl_vtag_by_fp(cl, file);
 
 	rets = copy_from_user(cb->buf.data, ubuf, length);
 	if (rets) {
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 1219edea3243..2f4cc1a8aae8 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -193,6 +193,21 @@ struct mei_cl_cb {
 	u32 blocking:1;
 };
 
+/**
+ * struct mei_cl_vtag - file pointer to vtag mapping structure
+ *
+ * @list: link in map queue
+ * @fp: file pointer
+ * @vtag: corresponding vtag
+ * @pending_read: the read is pending on this file
+ */
+struct mei_cl_vtag {
+	struct list_head list;
+	const struct file *fp;
+	u8 vtag;
+	u8 pending_read:1;
+};
+
 /**
  * struct mei_cl - me client host representation
  *    carried in file->private_data
@@ -209,6 +224,7 @@ struct mei_cl_cb {
  * @me_cl: fw client connected
  * @fp: file associated with client
  * @host_client_id: host id
+ * @vtag_map: vtag map
  * @tx_flow_ctrl_creds: transmit flow credentials
  * @rx_flow_ctrl_creds: receive flow credentials
  * @timer_count:  watchdog timer for operation completion
@@ -235,6 +251,7 @@ struct mei_cl {
 	struct mei_me_client *me_cl;
 	const struct file *fp;
 	u8 host_client_id;
+	struct list_head vtag_map;
 	u8 tx_flow_ctrl_creds;
 	u8 rx_flow_ctrl_creds;
 	u8 timer_count;
-- 
2.25.4

