Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E9DC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D37F20828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgBXOmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 09:42:16 -0500
Received: from foss.arm.com ([217.140.110.172]:38166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbgBXOmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 09:42:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D17311B3;
        Mon, 24 Feb 2020 06:42:12 -0800 (PST)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 636DD3F534;
        Mon, 24 Feb 2020 06:42:11 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com
Subject: [RFC PATCH v3 05/13] firmware: arm_scmi: Add notification protocol-registration
Date:   Mon, 24 Feb 2020 14:41:16 +0000
Message-Id: <20200224144124.2008-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200224144124.2008-1-cristian.marussi@arm.com>
References: <20200224144124.2008-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add core SCMI Notifications protocol-registration support: allow protocols
to register their own set of supported events, during their initialization
phase. Notification core can track multiple platform instances.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
V2 --> V3
- added scmi_notify_instance to track target platform instance
V1 --> V2
- splitted out of V1 patch 04
- moved from IDR maps to real HashTables to store events
- scmi_notifications_initialized is now an atomic_t
- reviewed protocol registration/unregistration to use devres
- fixed:
  drivers/firmware/arm_scmi/notify.c:483:18-23: ERROR:
  	reference preceded by free on line 482

Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
---
 drivers/firmware/arm_scmi/Makefile |   2 +-
 drivers/firmware/arm_scmi/common.h |   4 +
 drivers/firmware/arm_scmi/notify.c | 497 +++++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/notify.h |  59 ++++
 include/linux/scmi_protocol.h      |   9 +
 5 files changed, 570 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/notify.c
 create mode 100644 drivers/firmware/arm_scmi/notify.h

diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 6694d0d908d6..24a03a36aee4 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y	= scmi-bus.o scmi-driver.o scmi-protocols.o scmi-transport.o
 scmi-bus-y = bus.o
-scmi-driver-y = driver.o
+scmi-driver-y = driver.o notify.o
 scmi-transport-y = mailbox.o shmem.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o
 obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) += scmi_pm_domain.o
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 3c2e5d0d7b68..2106c35195ce 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -6,6 +6,8 @@
  *
  * Copyright (C) 2018 ARM Ltd.
  */
+#ifndef _SCMI_COMMON_H
+#define _SCMI_COMMON_H
 
 #include <linux/bitfield.h>
 #include <linux/completion.h>
@@ -232,3 +234,5 @@ void shmem_fetch_notification(struct scmi_shared_mem __iomem *shmem,
 void shmem_clear_notification(struct scmi_shared_mem __iomem *shmem);
 bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
 		     struct scmi_xfer *xfer);
+
+#endif /* _SCMI_COMMON_H */
diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
new file mode 100644
index 000000000000..f032c4e9fd89
--- /dev/null
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -0,0 +1,497 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Management Interface (SCMI) Notification support
+ *
+ * Copyright (C) 2019 ARM Ltd.
+ *
+ * SCMI Protocol specification allows the platform to signal events to
+ * interested agents via notification messages: this is an implementation
+ * of the dispatch and delivery of such notifications to the interested users
+ * inside the Linux kernel.
+ *
+ * An SCMI Notification core instance is initialized for each active platform
+ * instance identified by the means of the usual @scmi_handle.
+ *
+ * Each SCMI Protocol implementation, during its initialization, registers with
+ * this core its set of supported events using @scmi_register_protocol_events():
+ * all the needed descriptors are stored in the @registered_protocols and
+ * @registered_events hashtables.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/atomic.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/hashtable.h>
+#include <linux/kernel.h>
+#include <linux/kfifo.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/refcount.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include "notify.h"
+
+#define	SCMI_ALL_SRC_IDS		0xffffUL
+/*
+ * Builds an unsigned 32bit key from the given input tuple to be used
+ * as a key in hashtables.
+ */
+#define MAKE_HASH_KEY(p, e, s)			\
+	((u32)(((p) << 24) | ((e) << 16) | ((s) & SCMI_ALL_SRC_IDS)))
+
+#define MAKE_PROTO_KEY(p)			\
+	MAKE_HASH_KEY((p), 0, SCMI_ALL_SRC_IDS)
+
+#define MAKE_REVT_KEY(p, e)			\
+	MAKE_HASH_KEY((p), (e), SCMI_ALL_SRC_IDS)
+
+/**
+ * Assumes that the stored obj includes its own hash-key in a field named 'key':
+ * with this simplification this macro can be equally used for all the objects'
+ * types hashed by this implementation.
+ *
+ * @__ht: The hashtable name
+ * @__obj: A pointer to the object type to be retrieved from the hashtable;
+ *	   it will be used as a cursor while scanning the hastable and it will
+ *	   be possibly left as NULL when @__k is not found
+ * @__k: The key to search for
+ */
+#define KEY_FIND(__ht, __obj, __k)				\
+({								\
+	hash_for_each_possible((__ht), (__obj), hash, (__k))	\
+		if (likely((__obj)->key == (__k)))		\
+			break;					\
+	__obj;							\
+})
+
+/**
+ * scmi_notify_instance  - Represents an instance of the notification core
+ *
+ * Each platform instance, represented by a handle, has its own instance of
+ * the notification subsystem.
+ *
+ * @gid: GroupID used for devres
+ * @handle: A reference to the platform instance
+ * @initialized: A flag that indicates if the core resources have been allocated
+ *		 and protocols are allowed to register their supported events
+ * @disabled: A flag to indicate when event's handlers registration phase has
+ *	      completed and events can be enabled and start flowing
+ * @registered_protocols: An hashtable containing all protocol-level specific
+ *			  information related to events' handling
+ * @registered_events: An hashtable containing all events' descriptors
+ *		       registered by the protocols, together with their
+ *		       ancillary data
+ */
+struct scmi_notify_instance {
+	void				*gid;
+	struct scmi_handle		*handle;
+	atomic_t			initialized;
+	atomic_t			disabled;
+
+	DECLARE_HASHTABLE(registered_protocols, 4);
+	DECLARE_HASHTABLE(registered_events, 5);
+};
+
+/**
+ * events_queue  - Describes a queue and its associated worker
+ *
+ * Each protocol has its own dedicated events_queue descriptor.
+ *
+ * @sz: Size in bytes of the related kfifo
+ * @qbuf: Pre-allocated buffer of @sz bytes to be used by the kfifo
+ * @kfifo: A dedicated Kernel kfifo descriptor
+ */
+struct events_queue {
+	size_t				sz;
+	u8				*qbuf;
+	struct kfifo			kfifo;
+};
+
+/**
+ * scmi_registered_protocol_events_desc  - Protocol Specific information
+ *
+ * All protocols that registers at least one event have their protocol-specific
+ * information stored here, together with the embedded allocated events_queue.
+ * These descriptors are stored in the @registered_protocols hashtable.
+ *
+ * @key: The used hashkey
+ * @id: Protocol ID
+ * @ops: Protocol specific and event-related operations
+ * @equeue: The embedded per-protocol events_queue
+ * @hash: The hlist_node used for collision handling
+ * @ni: A reference to the initialized instance descriptor
+ * @gid: The associated devres group id, for cleanup purposes
+ */
+struct scmi_registered_protocol_events_desc {
+	u32					key;
+	u8					id;
+	const struct scmi_protocol_event_ops	*ops;
+	struct events_queue			equeue;
+	struct hlist_node			hash;
+	struct scmi_notify_instance		*ni;
+	void					*gid;
+};
+
+/**
+ * scmi_registered_event  - Event Specific Information
+ *
+ * All registered events are represented by one of these structures.
+ * These descriptors are stored in the @registered_events hashtable.
+ *
+ * @key: The used hashkey
+ * @proto: A reference to the associated protocol descriptor
+ * @evt: A reference to the associated event descriptor (as provided at
+ *       registration time)
+ * @scratch_isr: A pre-allocated buffer to be used as a scratch area by ISR
+ * @scratch_bh: A pre-allocated buffer to be used as a scratch area by the
+ *		deferred worker
+ * @report: A pre-allocated buffer used by the deferred worker to fill a
+ *	    customized event report
+ * @hash: The hlist_node used for collision handling
+ * @num_sources: The number of possible sources for this event as stated at
+ *		 events' registration time
+ * @sources: A reference to a dynamically allocated array used to refcount the
+ *	     events' enable requests for all the existing sources
+ * @sources_mtx: A mutex to serialize the access to @sources
+ */
+struct scmi_registered_event {
+	u32						key;
+	struct scmi_registered_protocol_events_desc	*proto;
+	const struct scmi_event				*evt;
+	void						*scratch_isr;
+	void						*scratch_bh;
+	void						*report;
+	struct hlist_node				hash;
+	u32						num_sources;
+	refcount_t					*sources;
+	struct mutex					sources_mtx;
+};
+
+/**
+ * scmi_event_header  - A utility header
+ *
+ * This header is prepended to each received event message payload before
+ * queueing it on the related events_queue: it carries ancillary information
+ * for the attached event message payload.
+ *
+ * @timestamp: The timestamp, in nanoseconds (boottime), which was associated
+ *	       to this event as soon as it entered the SCMI RX ISR
+ * @proto_id: Protocol ID
+ * @evt_id: Event ID (corresponds to the Event MsgID for this Protocol)
+ * @payld_sz: Effective size of the embedded message payload which follows
+ * @payld: A reference to the embedded event payload
+ */
+struct scmi_event_header {
+	u64	timestamp;
+	u8	proto_id;
+	u8	evt_id;
+	size_t	payld_sz;
+	u8	payld[];
+} __packed;
+
+/**
+ * scmi_initialize_events_queue  - Allocate/Initialize a kfifo buffer
+ *
+ * Allocate a buffer for the kfifo and initialize it.
+ *
+ * @ni: A reference to the notification instance to use
+ * @equeue: The events_queue to initialize
+ * @sz: Size of the kfifo buffer to allocate
+ *
+ * Return: 0 on Success
+ */
+static int scmi_initialize_events_queue(struct scmi_notify_instance *ni,
+					struct events_queue *equeue, size_t sz)
+{
+	int ret;
+
+	equeue->qbuf = devm_kzalloc(ni->handle->dev, sz, GFP_KERNEL);
+	if (!equeue->qbuf)
+		return -ENOMEM;
+	equeue->sz = sz;
+
+	ret = kfifo_init(&equeue->kfifo, equeue->qbuf, equeue->sz);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * scmi_allocate_registered_protocol_desc  - Allocate a registered protocol
+ * events' descriptor
+ *
+ * Descriptor is used to keep protocol specific information related to events
+ * handling for any protocol which has registered at least one event.
+ *
+ * @ni: A reference to the notification instance to use
+ * @gid: Devres group id to be stored
+ * @proto_id: Protocol ID
+ * @queue_sz: Size of the associated queue to allocate
+ * @ops: Pointer to a struct holding references to protocol specific helpers
+ *	 needed during events handling
+ */
+static struct scmi_registered_protocol_events_desc *
+scmi_allocate_registered_protocol_desc(struct scmi_notify_instance *ni,
+				       void *gid, u8 proto_id, size_t queue_sz,
+				const struct scmi_protocol_event_ops *ops)
+{
+	int ret;
+	struct scmi_registered_protocol_events_desc *pd;
+	u32 proto_key = MAKE_PROTO_KEY(proto_id);
+
+	pd = KEY_FIND(ni->registered_protocols, pd, proto_key);
+	if (pd)
+		return pd;
+
+	pd = devm_kzalloc(ni->handle->dev, sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return ERR_PTR(-ENOMEM);
+	pd->key = proto_key;
+	pd->id = proto_id;
+	pd->ops = ops;
+	pd->ni = ni;
+
+	ret = scmi_initialize_events_queue(ni, &pd->equeue, queue_sz);
+	if (ret)
+		return ERR_PTR(ret);
+
+	hash_add(ni->registered_protocols, &pd->hash, pd->key);
+
+	return pd;
+}
+
+/**
+ * scmi_register_protocol_events  - Register Protocol Events with the core
+ *
+ * Used by SCMI Protocols initialization code to register with the notification
+ * core the list of supported events and their descriptors: takes care to
+ * pre-allocate and store all needed descriptors, scratch buffers and event
+ * queues.
+ *
+ * @handle: The handle identifying the platform instance against which the
+ *	    the protocol's events are registered
+ * @proto_id: Protocol ID
+ * @queue_sz: Size in bytes of the associated queue to be allocated
+ * @ops: Protocol specific event-related operations
+ * @evt: Event descriptor array
+ * @num_events: Number of events in @evt array
+ * @num_sources: Number of possible sources for this protocol on this
+ *		 platform.
+ *
+ * Return: 0 on Success
+ */
+int scmi_register_protocol_events(const struct scmi_handle *handle,
+				  u8 proto_id, size_t queue_sz,
+				  const struct scmi_protocol_event_ops *ops,
+				  const struct scmi_event *evt, int num_events,
+				  int num_sources)
+{
+	int i;
+	void *gid;
+	struct scmi_registered_protocol_events_desc *pd;
+	struct scmi_notify_instance *ni = handle->notify_priv;
+
+	if (!ops || !evt)
+		return -EINVAL;
+	/* Ensure atomic value is updated */
+	smp_mb__before_atomic();
+	if (unlikely(!ni || !atomic_read(&ni->initialized)))
+		return -EAGAIN;
+
+	gid = devres_open_group(ni->handle->dev, NULL, GFP_KERNEL);
+	if (!gid)
+		return -ENOMEM;
+
+	pd = scmi_allocate_registered_protocol_desc(ni, gid, proto_id,
+						    queue_sz, ops);
+	if (IS_ERR(pd))
+		goto err;
+
+	for (i = 0; i < num_events; i++, evt++) {
+		struct scmi_registered_event *r_evt;
+
+		r_evt = devm_kzalloc(ni->handle->dev, sizeof(*r_evt),
+				     GFP_KERNEL);
+		if (!r_evt)
+			goto err;
+		r_evt->proto = pd;
+		r_evt->evt = evt;
+
+		r_evt->sources = devm_kcalloc(ni->handle->dev, num_sources,
+					      sizeof(refcount_t), GFP_KERNEL);
+		if (!r_evt->sources)
+			goto err;
+		r_evt->num_sources = num_sources;
+		mutex_init(&r_evt->sources_mtx);
+
+		r_evt->scratch_isr = devm_kzalloc(ni->handle->dev,
+					sizeof(struct scmi_event_header) +
+					evt->max_payld_sz, GFP_KERNEL);
+		if (!r_evt->scratch_isr)
+			goto err;
+
+		r_evt->scratch_bh = devm_kzalloc(ni->handle->dev,
+						 evt->max_payld_sz, GFP_KERNEL);
+		if (!r_evt->scratch_bh)
+			goto err;
+
+		r_evt->report = devm_kzalloc(ni->handle->dev,
+					     evt->max_report_sz, GFP_KERNEL);
+		if (!r_evt->report)
+			goto err;
+
+		r_evt->key = MAKE_REVT_KEY(r_evt->proto->id,
+					   r_evt->evt->evt_id);
+		hash_add(ni->registered_events, &r_evt->hash, r_evt->key);
+
+		pr_info("SCMI Notifications: registered event - key:%X\n",
+			r_evt->key);
+	}
+	devres_close_group(ni->handle->dev, NULL);
+
+	return 0;
+
+err:
+	pr_warn("SCMI Notifications - Proto:%X - Registration Failed !\n",
+		proto_id);
+	devres_release_group(ni->handle->dev, NULL);
+
+	return -ENOMEM;
+}
+
+/**
+ * scmi_unregister_protocol_events  - Unregister protocol-event resources
+ *
+ * Removes all registered events related to this protocol descriptor and
+ * frees all the underlying resources associated with this protocol devres
+ * group id.
+ *
+ * Assumes that the caller has already taken care to stop events dispatching
+ * and to flush the related queues.
+ *
+ * @handle: The handle identifying the platform instance against which the
+ *	    the protocol's events are unregistered
+ * @proto_id: The protocol to act upon
+ *
+ * Return: The number of released non-group resources
+ */
+int scmi_unregister_protocol_events(const struct scmi_handle *handle,
+				    u8 proto_id)
+{
+	int bkt;
+	struct scmi_registered_event *r_evt;
+	struct scmi_registered_protocol_events_desc *pd;
+	struct scmi_notify_instance *ni = handle->notify_priv;
+
+	if (unlikely(!ni || !atomic_read(&ni->initialized)))
+		return 0;
+
+	pd = KEY_FIND(ni->registered_protocols, pd, MAKE_PROTO_KEY(proto_id));
+	if (unlikely(!pd))
+		return 0;
+
+	/*
+	 * Remove all registered events for this protocol and the
+	 * protocol descriptor itself.
+	 */
+	hash_for_each(ni->registered_events, bkt, r_evt, hash)
+		if (r_evt->proto == pd)
+			hash_del(&r_evt->hash);
+	hash_del(&pd->hash);
+
+	/* Free all underlying resources */
+	return devres_release_group(ni->handle->dev, pd->gid);
+}
+
+/**
+ * scmi_notification_init  - Initializes Notification Core Support
+ *
+ * This function lays out all the basic resources needed by the notification
+ * core instance identified by this handle: once done, all SCMI Protocols can
+ * register their events with the core during their own initializations.
+ *
+ * Note that failing to initialize the core notifications support does not
+ * cause the whole SCMI Protocols stack to fail its initialization.
+ *
+ * SCMI Notification Initialization happens in 3 phases:
+ *
+ *  - initialization: basic common allocations (this function) -> .initialized
+ *  - registration: protocols asynchronously come into life and registers their
+ *		    own supported list of events with the core; this causes
+ *		    further per-protocol allocations.
+ *		    Notifications' dispatching remains globally .disabled till
+ *		    all defined and implemented protocols have been successfully
+ *		    initialized: this way access to @registered_events table
+ *		    needs not to be synchronized, which is critical since it's
+ *		    accessed heavily at dispatch time in interrupt context.
+ *		    Any user's callback registration attempt happening during
+ *		    this phase, if referring a still not initialized event, it's
+ *		    delayed till this phase completes.
+ *  - enable: once all implemented protocols have completed their registration
+ *	      phase, (if any...refcounting on @pending_protocols), a completion
+ *	      is used to kick @init_work, which in turn finally processes and
+ *	      binds any pending handler: after that, notifications are finally
+ *	      enabled as a whole and dispatch and delivery of events can start.
+ *
+ * @handle: The handle identifying the platform instance to initialize
+ *
+ * Return: 0 on Success
+ */
+int scmi_notification_init(struct scmi_handle *handle)
+{
+	void *gid;
+	struct scmi_notify_instance *ni;
+
+	gid = devres_open_group(handle->dev, NULL, GFP_KERNEL);
+	if (!gid)
+		return -ENOMEM;
+
+	ni = devm_kzalloc(handle->dev, sizeof(*ni), GFP_KERNEL);
+	if (!ni)
+		goto err;
+
+	ni->gid = gid;
+	ni->handle = handle;
+
+	hash_init(ni->registered_protocols);
+	hash_init(ni->registered_events);
+
+	handle->notify_priv = ni;
+
+	atomic_set(&ni->disabled, 1);
+	atomic_set(&ni->initialized, 1);
+	/* Ensure atomic values are updated */
+	smp_mb__after_atomic();
+
+	pr_info("SCMI Notifications Core Initializing.\n");
+
+	devres_close_group(handle->dev, NULL);
+
+	return 0;
+
+err:
+	pr_warn("SCMI Notifications - Initialization Failed.\n");
+	devres_release_group(handle->dev, NULL);
+	return -ENOMEM;
+}
+
+/**
+ * scmi_notification_exit  - Shutdown and clean Notification core
+ */
+void scmi_notification_exit(struct scmi_handle *handle)
+{
+	struct scmi_notify_instance *ni = handle->notify_priv;
+
+	if (unlikely(!ni || !atomic_read(&ni->initialized)))
+		return;
+
+	devres_release_group(ni->handle->dev, ni->gid);
+
+	pr_info("SCMI Notifications Core Cleaned.\n");
+}
diff --git a/drivers/firmware/arm_scmi/notify.h b/drivers/firmware/arm_scmi/notify.h
new file mode 100644
index 000000000000..8de19a3b75ab
--- /dev/null
+++ b/drivers/firmware/arm_scmi/notify.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * System Control and Management Interface (SCMI) Message Protocol
+ * notification header file containing some definitions, structures
+ * and function prototypes related to SCMI Notification handling.
+ *
+ * Copyright (C) 2019 ARM Ltd.
+ */
+#ifndef _SCMI_NOTIFY_H
+#define _SCMI_NOTIFY_H
+
+#include <linux/device.h>
+#include <linux/types.h>
+
+/**
+ * scmi_event  - Describes an event to be supported
+ *
+ * Each SCMI protocol, during its initialization phase, can describe the events
+ * it wishes to support in a few struct scmi_event and pass them to the core
+ * using scmi_register_protocol_events().
+ *
+ * @evt_id: Event ID
+ * @max_payld_sz: Max possible size for the payload of a notif msg of this kind
+ * @max_report_sz: Max possible size for the report of a notif msg of this kind
+ */
+struct scmi_event {
+	u8	evt_id;
+	size_t	max_payld_sz;
+	size_t	max_report_sz;
+
+};
+
+/**
+ * scmi_protocol_event_ops  - Helpers called by notification core.
+ *
+ * These are called only in process context.
+ *
+ * @set_notify_enabled: Enable/disable the required evt_id/src_id notifications
+ *			using the proper custom protocol commands.
+ *			Return true if at least one the required src_id
+ *			has been successfully enabled/disabled
+ */
+struct scmi_protocol_event_ops {
+	bool (*set_notify_enabled)(const struct scmi_handle *handle,
+				   u8 evt_id, u32 src_id, bool enabled);
+};
+
+int scmi_notification_init(struct scmi_handle *handle);
+void scmi_notification_exit(struct scmi_handle *handle);
+
+int scmi_register_protocol_events(const struct scmi_handle *handle,
+				  u8 proto_id, size_t queue_sz,
+				  const struct scmi_protocol_event_ops *ops,
+				  const struct scmi_event *evt, int num_events,
+				  int num_sources);
+int scmi_unregister_protocol_events(const struct scmi_handle *handle,
+				    u8 proto_id);
+
+#endif /* _SCMI_NOTIFY_H */
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 5c873a59b387..0679f10ab05e 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -4,6 +4,10 @@
  *
  * Copyright (C) 2018 ARM Ltd.
  */
+
+#ifndef _LINUX_SCMI_PROTOCOL_H
+#define _LINUX_SCMI_PROTOCOL_H
+
 #include <linux/device.h>
 #include <linux/types.h>
 
@@ -227,6 +231,8 @@ struct scmi_reset_ops {
  *	protocol(for internal use only)
  * @reset_priv: pointer to private data structure specific to reset
  *	protocol(for internal use only)
+ * @notify_priv: pointer to private data structure specific to notifications
+ *	(for internal use only)
  */
 struct scmi_handle {
 	struct device *dev;
@@ -242,6 +248,7 @@ struct scmi_handle {
 	void *power_priv;
 	void *sensor_priv;
 	void *reset_priv;
+	void *notify_priv;
 };
 
 enum scmi_std_protocol {
@@ -319,3 +326,5 @@ static inline void scmi_driver_unregister(struct scmi_driver *driver) {}
 typedef int (*scmi_prot_init_fn_t)(struct scmi_handle *);
 int scmi_protocol_register(int protocol_id, scmi_prot_init_fn_t fn);
 void scmi_protocol_unregister(int protocol_id);
+
+#endif /* _LINUX_SCMI_PROTOCOL_H */
-- 
2.17.1

