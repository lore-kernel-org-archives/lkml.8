Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4EDC11D32
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDFA20838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgBXOmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 09:42:25 -0500
Received: from foss.arm.com ([217.140.110.172]:38192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbgBXOmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 09:42:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B49D31B;
        Mon, 24 Feb 2020 06:42:16 -0800 (PST)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C8923F534;
        Mon, 24 Feb 2020 06:42:15 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com
Subject: [RFC PATCH v3 08/13] firmware: arm_scmi: Enable notification core
Date:   Mon, 24 Feb 2020 14:41:19 +0000
Message-Id: <20200224144124.2008-9-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200224144124.2008-1-cristian.marussi@arm.com>
References: <20200224144124.2008-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize and enable SCMI Notifications core support during bus/driver
init and probe phases, so that protocols can start registering their
supported events during their initialization, and later users can start
enrolling their callbacks for the subset of events their interested in.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
V2 --> V3
- reviewed core initialization: all implemented protocols must complete
  their protocol-events registration phases before notifications can be
  enabled as a whole; in the meantime any user's callback registration
  requests possibly issued while the notifications were not enabled
  remain pending: a dedicated worker completes the handlers registration
  once all protocols have been initialized.
  NOTE THAT this can lead to ISSUES with late inserted or missing SCMI
  modules (i.e. for protocols defined in the DT and implemented by the
  platform but lazily loaded or not loaded at all.), since in these
  scenarios notifications dispatching will be enabled later or never.
- reviewed core exit: protocol users (devices) are accounted on probe/
  remove, and protocols' events are unregisteredonce last user go
  (can happen only at shutdown)
V1 --> V2
- added timestamping
- moved notification init/exit and using devres
---
 drivers/firmware/arm_scmi/bus.c    |  25 +++--
 drivers/firmware/arm_scmi/driver.c |  12 +++
 drivers/firmware/arm_scmi/notify.c | 168 +++++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/notify.h |   6 ++
 4 files changed, 201 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index db55c43a2cbd..e4f2e629b88f 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 
 #include "common.h"
+#include "notify.h"
 
 static DEFINE_IDA(scmi_bus_id);
 static DEFINE_IDR(scmi_protocols);
@@ -53,16 +54,17 @@ static int scmi_dev_match(struct device *dev, struct device_driver *drv)
 
 static int scmi_protocol_init(int protocol_id, struct scmi_handle *handle)
 {
+	int ret;
 	scmi_prot_init_fn_t fn = idr_find(&scmi_protocols, protocol_id);
 
-	if (unlikely(!fn))
-		return -EINVAL;
-	return fn(handle);
-}
+	if (!fn)
+		return 0;
 
-static int scmi_protocol_dummy_init(struct scmi_handle *handle)
-{
-	return 0;
+	idr_remove(&scmi_protocols, protocol_id);
+	ret = fn(handle);
+	scmi_notification_set_proto_initialized(handle);
+
+	return ret;
 }
 
 static int scmi_dev_probe(struct device *dev)
@@ -83,9 +85,9 @@ static int scmi_dev_probe(struct device *dev)
 	if (ret)
 		return ret;
 
-	/* Skip protocol initialisation for additional devices */
-	idr_replace(&scmi_protocols, &scmi_protocol_dummy_init,
-		    scmi_dev->protocol_id);
+	/* Count this device */
+	scmi_notification_inc_proto_users(scmi_dev->handle,
+					  scmi_dev->protocol_id);
 
 	return scmi_drv->probe(scmi_dev);
 }
@@ -95,6 +97,9 @@ static int scmi_dev_remove(struct device *dev)
 	struct scmi_driver *scmi_drv = to_scmi_driver(dev->driver);
 	struct scmi_device *scmi_dev = to_scmi_dev(dev);
 
+	scmi_notification_dec_proto_users(scmi_dev->handle,
+					  scmi_dev->protocol_id);
+
 	if (scmi_drv->remove)
 		scmi_drv->remove(scmi_dev);
 
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 868cc36a07c9..0268cfe3849e 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 
 #include "common.h"
+#include "notify.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/scmi.h>
@@ -204,11 +205,13 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo, struct scmi_xfer *xfer)
 
 static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 {
+	u64 ts;
 	struct scmi_xfer *xfer;
 	struct device *dev = cinfo->dev;
 	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
 	struct scmi_xfers_info *minfo = &info->rx_minfo;
 
+	ts = ktime_get_boottime_ns();
 	xfer = scmi_xfer_get(cinfo->handle, minfo);
 	if (IS_ERR(xfer)) {
 		dev_err(dev, "failed to get free message slot (%ld)\n",
@@ -221,6 +224,8 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 	scmi_dump_header_dbg(dev, &xfer->hdr);
 	info->desc->ops->fetch_notification(cinfo, info->desc->max_msg_size,
 					    xfer);
+	scmi_notify(cinfo->handle, xfer->hdr.protocol_id,
+		    xfer->hdr.id, xfer->rx.buf, xfer->rx.len, ts);
 
 	trace_scmi_rx_done(xfer->transfer_id, xfer->hdr.id,
 			   xfer->hdr.protocol_id, xfer->hdr.seq,
@@ -771,6 +776,9 @@ static int scmi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (scmi_notification_init(handle))
+		dev_err(dev, "SCMI Notifications NOT available.\n");
+
 	ret = scmi_base_protocol_init(handle);
 	if (ret) {
 		dev_err(dev, "unable to communicate with SCMI(%d)\n", ret);
@@ -796,8 +804,10 @@ static int scmi_probe(struct platform_device *pdev)
 			continue;
 		}
 
+		scmi_notification_set_proto_pending(handle);
 		scmi_create_protocol_devices(child, info, prot_id);
 	}
+	scmi_notification_set_proto_initialized(handle);
 
 	return 0;
 }
@@ -813,6 +823,8 @@ static int scmi_remove(struct platform_device *pdev)
 	struct scmi_info *info = platform_get_drvdata(pdev);
 	struct idr *idr = &info->tx_idr;
 
+	scmi_notification_exit(&info->handle);
+
 	mutex_lock(&scmi_list_mutex);
 	if (info->users)
 		ret = -EBUSY;
diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index e4e4916aeb42..6bab1c23a1a0 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -70,9 +70,11 @@
 #include <linux/atomic.h>
 #include <linux/bitfield.h>
 #include <linux/bug.h>
+#include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/hashtable.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/kfifo.h>
 #include <linux/list.h>
@@ -145,6 +147,12 @@
  *		 and protocols are allowed to register their supported events
  * @disabled: A flag to indicate when event's handlers registration phase has
  *	      completed and events can be enabled and start flowing
+ * @pending_protocols: A refcount to the number of protocols still pending
+ *		       initialization: once this drops to zero @init_completion
+ *		       is completed, unblocking @init_work as a consequence
+ * @init_complete: A completion used to stall @init_work till all pending
+ *		   protocols have completed their registration phase
+ * @init_work: A work item to perform final initializations of pending handlers
  * @notify_wq: A reference to the allocated Kernel cmwq
  * @events_handlers_mtx: A mutex to protect @registered_events_handlers access
  * @registered_protocols: An hashtable containing all protocol-level specific
@@ -162,6 +170,10 @@ struct scmi_notify_instance {
 	atomic_t			initialized;
 	atomic_t			disabled;
 
+	refcount_t			pending_protocols;
+	struct completion		init_complete;
+	struct work_struct		init_work;
+
 	struct workqueue_struct		*notify_wq;
 
 	struct mutex			events_handlers_mtx;
@@ -203,6 +215,8 @@ struct events_queue {
  * @hash: The hlist_node used for collision handling
  * @ni: A reference to the initialized instance descriptor
  * @gid: The associated devres group id, for cleanup purposes
+ * @users: The number of active protocol users, when it drops to zero (at system
+ *	   shutdown) protocol is unregistered and resources are freed
  */
 struct scmi_registered_protocol_events_desc {
 	u32					key;
@@ -212,6 +226,7 @@ struct scmi_registered_protocol_events_desc {
 	struct hlist_node			hash;
 	struct scmi_notify_instance		*ni;
 	void					*gid;
+	refcount_t				users;
 };
 
 /**
@@ -317,6 +332,7 @@ static inline void scmi_discard_bad_evt_payload(struct kfifo *kq,
 
 	pr_warn("SCMI Notifications: WQ skipping bad EVT Payload - %d bytes\n",
 		count);
+
 	/* Discard stale pending queued payload. */
 	for (i = 0; i < count; i++)
 		kfifo_skip(kq);
@@ -552,6 +568,7 @@ scmi_allocate_registered_protocol_desc(struct scmi_notify_instance *ni,
 	pd->id = proto_id;
 	pd->ops = ops;
 	pd->ni = ni;
+	refcount_set(&pd->users, 1);
 
 	ret = scmi_initialize_events_queue(ni, &pd->equeue, queue_sz);
 	if (ret)
@@ -724,6 +741,70 @@ int scmi_unregister_protocol_events(const struct scmi_handle *handle,
 	return devres_release_group(ni->handle->dev, pd->gid);
 }
 
+/**
+ * scmi_notification_inc_proto_users  - Helper to account for protocols' users
+ *
+ * @handle: The handle identifying the platform instance
+ * @proto_id: The protocol to act upon
+ */
+void scmi_notification_inc_proto_users(const struct scmi_handle *handle,
+				       const u32 proto_id)
+{
+	struct scmi_registered_protocol_events_desc *pd;
+	struct scmi_notify_instance *ni = handle->notify_priv;
+
+	if (unlikely(!ni || !atomic_read(&ni->initialized)))
+		return;
+
+	pd = KEY_FIND(ni->registered_protocols, pd, MAKE_PROTO_KEY(proto_id));
+	if (!pd)
+		return;
+
+	refcount_inc(&pd->users);
+}
+
+/**
+ * scmi_notification_dec_proto_users - Helper to account for protocols' users
+ *
+ * Once no more users are active for this protocol stop ISR dispatching as a
+ * whole and flush protocol queue: after this point no more events will be
+ * queued for this protocol.
+ * Events dispatching won't be enabled anymore, we are shutting down.
+ *
+ * Note that normally when we get here any user of the notification subsystem
+ * would have already unregistered their callbacks and caused the events
+ * generation to be stopped: here we want to address also the possibility that
+ * a faulty platform keeps on emitting notification messages, even after having
+ * being asked explicitly to stop, by forcibly stopping the dispatching and
+ * emptying the queues.
+ *
+ * @handle: The handle identifying the platform instance to target
+ * @proto_id: The protocol to act upon
+ */
+void scmi_notification_dec_proto_users(const struct scmi_handle *handle,
+				       const u32 proto_id)
+{
+	struct scmi_registered_protocol_events_desc *pd;
+	struct scmi_notify_instance *ni = handle->notify_priv;
+
+	if (unlikely(!ni || !atomic_read(&ni->initialized)))
+		return;
+
+	pd = KEY_FIND(ni->registered_protocols, pd, MAKE_PROTO_KEY(proto_id));
+	if (!pd)
+		return;
+
+	if (refcount_dec_and_test(&pd->users)) {
+		atomic_set(&ni->disabled, 1);
+		/* Ensure atomic value is updated */
+		smp_mb__after_atomic();
+
+		cancel_work_sync(&pd->equeue.notify_work);
+
+		scmi_unregister_protocol_events(handle, proto_id);
+	}
+}
+
 /**
  * scmi_allocate_event_handler  - Allocate Event handler
  *
@@ -1135,6 +1216,88 @@ static int scmi_unregister_notifier(const struct scmi_handle *handle,
 	return 0;
 }
 
+/**
+ * scmi_notification_set_proto_pending  - Helper for protocol-initialization
+ *
+ * Account for one protocol initialization pending
+ *
+ * @handle: The handle identifying the platform instance which is initializing
+ */
+void scmi_notification_set_proto_pending(const struct scmi_handle *handle)
+{
+	struct scmi_notify_instance *ni = handle->notify_priv;
+
+	if (unlikely(!ni || !atomic_read(&ni->initialized)))
+		return;
+
+	refcount_inc(&ni->pending_protocols);
+}
+
+/**
+ * scmi_notification_set_proto_initialized - Helper for protocol-initialization
+ *
+ * Account for one protocol initialization completed. Once no more protocols are
+ * pending initialization, a completion is used to kick @init_work for final
+ * binding of pending handlers.
+ *
+ * @handle: The handle identifying the platform instance which is initializing
+ */
+void scmi_notification_set_proto_initialized(const struct scmi_handle *handle)
+{
+	struct scmi_notify_instance *ni = handle->notify_priv;
+
+	if (unlikely(!ni || !atomic_read(&ni->initialized)))
+		return;
+
+	if (refcount_dec_and_test(&ni->pending_protocols)) {
+		pr_info("SCMI Notifications Core Initialized.\n");
+		complete(&ni->init_complete);
+	}
+}
+
+/**
+ * scmi_protocols_late_init  - Worker for late initialization
+ *
+ * This kicks in once the all the pending protocols have initialized, and tries
+ * to finalize the registration of pending handlers, binding the underlying
+ * associated registered events and enabling events' generation for pending
+ * handlers; still failing to bind handlers are removed.
+ *
+ * @work: The work item to use associated to the proper SCMI instance
+ */
+static void scmi_protocols_late_init(struct work_struct *work)
+{
+	int bkt;
+	struct scmi_event_handler *hndl;
+	struct scmi_notify_instance *ni;
+
+	ni = container_of(work, struct scmi_notify_instance, init_work);
+	wait_for_completion(&ni->init_complete);
+
+	mutex_lock(&ni->events_handlers_mtx);
+	hash_for_each(ni->registered_events_handlers, bkt, hndl, hash) {
+		int ret = 0;
+		bool was_deferred = hndl->deferred_enable;
+
+		/*
+		 * Register pending registrations (r_evt == NULL)...
+		 * no further delay is allowed, since all the possible
+		 * events should have been already registered by now.
+		 */
+		if (!hndl->r_evt)
+			ret = scmi_bind_event_handler(ni, hndl, false);
+		if (!ret && was_deferred)
+			ret = scmi_event_handler_enable_events(hndl);
+		if (ret)
+			scmi_free_event_handler(hndl);
+	}
+	mutex_unlock(&ni->events_handlers_mtx);
+	atomic_set(&ni->disabled, 0);
+	/* Ensure atomic value is updated */
+	smp_mb__after_atomic();
+	pr_info("SCMI Notifications Core Enabled.\n");
+}
+
 /*
  * notify_ops are attached to the handle so that can be accessed
  * directly from an scmi_driver to register its own notifiers.
@@ -1205,15 +1368,20 @@ int scmi_notification_init(struct scmi_handle *handle)
 	hash_init(ni->registered_events_handlers);
 	mutex_init(&ni->events_handlers_mtx);
 
+	init_completion(&ni->init_complete);
+	INIT_WORK(&ni->init_work, scmi_protocols_late_init);
+
 	handle->notify_priv = ni;
 	handle->notify_ops = &notify_ops;
 
 	atomic_set(&ni->disabled, 1);
+	refcount_set(&ni->pending_protocols, 1);
 	atomic_set(&ni->initialized, 1);
 	/* Ensure atomic values are updated */
 	smp_mb__after_atomic();
 
 	pr_info("SCMI Notifications Core Initializing.\n");
+	schedule_work(&ni->init_work);
 
 	devres_close_group(handle->dev, NULL);
 
diff --git a/drivers/firmware/arm_scmi/notify.h b/drivers/firmware/arm_scmi/notify.h
index fbb2c5247531..014ec1a4bb9b 100644
--- a/drivers/firmware/arm_scmi/notify.h
+++ b/drivers/firmware/arm_scmi/notify.h
@@ -67,6 +67,12 @@ struct scmi_protocol_event_ops {
 
 int scmi_notification_init(struct scmi_handle *handle);
 void scmi_notification_exit(struct scmi_handle *handle);
+void scmi_notification_set_proto_pending(const struct scmi_handle *handle);
+void scmi_notification_set_proto_initialized(const struct scmi_handle *handle);
+void scmi_notification_inc_proto_users(const struct scmi_handle *handle,
+				       const u32 proto_id);
+void scmi_notification_dec_proto_users(const struct scmi_handle *handle,
+				       const u32 proto_id);
 
 int scmi_register_protocol_events(const struct scmi_handle *handle,
 				  u8 proto_id, size_t queue_sz,
-- 
2.17.1

