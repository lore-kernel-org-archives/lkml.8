Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0978EC3B19D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CBC2467B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387471AbgBNPgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:36:35 -0500
Received: from foss.arm.com ([217.140.110.172]:34764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729592AbgBNPgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:36:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACEDB11FB;
        Fri, 14 Feb 2020 07:36:31 -0800 (PST)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9365D3F68E;
        Fri, 14 Feb 2020 07:36:30 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com
Subject: [RFC PATCH v2 05/13] firmware: arm_scmi: Add notification protocol-registration
Date:   Fri, 14 Feb 2020 15:35:27 +0000
Message-Id: <20200214153535.32046-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200214153535.32046-1-cristian.marussi@arm.com>
References: <20200214153535.32046-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add core SCMI Notifications protocol-registration support: allow protocols
to register their own set of supported events, during their initialization
phase.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
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
 drivers/firmware/arm_scmi/notify.c | 425 +++++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/notify.h |  56 ++++
 4 files changed, 486 insertions(+), 1 deletion(-)
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
index 000000000000..d496522dea72
--- /dev/null
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -0,0 +1,425 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Management Interface (SCMI) Notification support
+ *
+ * Copyright (C) 2019 ARM Ltd.
+ *
+ * SCMI Protocol specification allows the platform to signal events to
+ * interested agents via notification messages: this in an implementation
+ * of the dispatch and delivery of such notifications to the interested users
+ * inside the Linux kernel.
+ *
+ * Each SCMI Protocol implementation, during its initialization, registers with
+ * this core notification framework its set of supported events using
+ * @scmi_register_protocol_events(): all these protocols and events descriptors
+ * are stored in the @scmi_registered_protocols and @scmi_registered_events
+ * hashtables.
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
+#include <linux/mutex.h>
+#include <linux/refcount.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include "notify.h"
+
+#define	SCMI_ALL_SRC_IDS		0xffffUL
+
+/*
+ * Builds an unsigned 32bit key from the given input tuple to be used
+ * as a key in hashtables.
+ */
+#define MAKE_HASH_KEY(p, e, s)			\
+	((u32)(((p) << 24) | ((e) << 16) | ((s) & SCMI_ALL_SRC_IDS)))
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
+ * events_queue  - Describes a queue and its associated worker
+ *
+ * Each protocol has its own dedicated events_queue descriptor.
+ *
+ * @sz: Size in bytes of the related kfifo
+ * @qbuf: Pre-allocated buffer of @sz bytes to be used by the kfifo
+ * @kfifo: A dedicated Kernel kfifo
+ */
+struct events_queue {
+	size_t			sz;
+	u8			*qbuf;
+	struct kfifo		kfifo;
+};
+
+/**
+ * scmi_registered_protocol_events_desc  - Protocol Specific information
+ *
+ * All protocols that registers at least one event have their protocol-specific
+ * information stored here, together with a ref to the allocated events_queue.
+ * These descriptors are stored in the @scmi_registered_protocols hashtable.
+ *
+ * @key: The used hashkey
+ * @id: Protocol ID
+ * @ops: Protocol specific and event-related operations
+ * @equeue: A reference to the associated per-protocol events_queue
+ * @hash: The hash list_node used for collision handling
+ * @gid: The associated devres group id, for cleanup purposes
+ */
+struct scmi_registered_protocol_events_desc {
+	u32					key;
+	u8					id;
+	const struct scmi_protocol_event_ops	*ops;
+	struct events_queue			*equeue;
+	struct hlist_node			hash;
+	void					*gid;
+};
+
+/**
+ * scmi_registered_event  - Event Specific Information
+ *
+ * All registered events are represented by one of these structures.
+ * These descriptors are stored in the @scmi_registered_events hashtable.
+ *
+ * @key: The used hashkey
+ * @proto: A reference to the associated protocol descriptor
+ * @evt: A reference to the associated event descriptor (as provided at
+ *       registration time)
+ * @scratch_isr: A pre-allocated buffer to be used as a scratch area by ISR
+ * @scratch_isr: A pre-allocated buffer to be used as a scratch area by the
+ *		 deferred worker
+ * @hash: The hash list_node used for collision handling
+ * @num_sources: The number of possible sources for this event as stated at
+ *		 events' registration time
+ * @sources: A reference to a dynamically allocated array used to refcount the
+ *	     events' enables for all the existing sources.
+ * @sources_mtx: A mutex to serialize the access to @sources
+ */
+struct scmi_registered_event {
+	u32						key;
+	struct scmi_registered_protocol_events_desc	*proto;
+	const struct scmi_event				*evt;
+	void						*scratch_isr;
+	void						*scratch_bh;
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
+ * @payld_sz: Effective size of the attached message payload which follows
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
+/*
+ * A few hashtables, of various size, to track:
+ *
+ * - @scmi_registered_protocols: All protocol-level specific information related
+ *				 to events' handling
+ * - @scmi_registered_events: All events' descriptors registered by the
+ *			      protocols, together with their ancillary data
+ */
+static DECLARE_HASHTABLE(scmi_registered_protocols, 4);
+static DECLARE_HASHTABLE(scmi_registered_events, 5);
+
+static atomic_t scmi_notifications_initialized = ATOMIC_INIT(0);
+
+/**
+ * scmi_allocate_events_queue  - Allocate/Initialize an events_queue descriptor
+ *
+ * Allocate an events_queue, a kfifo of the requested size and initialize the
+ * associated worker.
+ *
+ * @dev: Device to use for devres
+ * @sz: Size of the kfifo to initialize
+ *
+ * Return: A valid pointer to the allocated events_queue on Success
+ */
+static struct events_queue *scmi_allocate_events_queue(struct device *dev,
+						       size_t sz)
+{
+	int ret;
+	struct events_queue *equeue;
+
+	equeue = devm_kzalloc(dev, sizeof(*equeue), GFP_KERNEL);
+	if (!equeue)
+		return ERR_PTR(-ENOMEM);
+
+	equeue->qbuf = devm_kzalloc(dev, sz, GFP_KERNEL);
+	if (!equeue->qbuf)
+		return ERR_PTR(-ENOMEM);
+	equeue->sz = sz;
+
+	ret = kfifo_init(&equeue->kfifo, equeue->qbuf, equeue->sz);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return equeue;
+}
+
+/**
+ * scmi_allocate_registered_protocol_desc  - Allocate a registered protocol
+ * events' descriptor
+ *
+ * Used to keep protocol specific information related to events handling for any
+ * protocol which has registered at least one event.
+ *
+ * @dev: Device to use for devres
+ * @gid: Devres group id to be stored
+ * @proto_id: Protocol ID
+ * @queue_sz: Size of the associated queue to allocate
+ * @ops: Pointer to a struct holding references to protocol specific helpers
+ *	 needed during events handling
+ */
+static struct scmi_registered_protocol_events_desc *
+scmi_allocate_registered_protocol_desc(struct device *dev, void *gid,
+				       u8 proto_id, size_t queue_sz,
+				const struct scmi_protocol_event_ops *ops)
+{
+	struct scmi_registered_protocol_events_desc *pdesc;
+	u32 proto_key = MAKE_HASH_KEY(proto_id, 0, SCMI_ALL_SRC_IDS);
+
+	pdesc = KEY_FIND(scmi_registered_protocols, pdesc, proto_key);
+	if (pdesc)
+		return pdesc;
+
+	pdesc = devm_kzalloc(dev, sizeof(*pdesc), GFP_KERNEL);
+	if (!pdesc)
+		return ERR_PTR(-ENOMEM);
+	pdesc->key = proto_key;
+	pdesc->id = proto_id;
+	pdesc->ops = ops;
+	pdesc->gid = gid;
+
+	pdesc->equeue = scmi_allocate_events_queue(dev, queue_sz);
+	if (IS_ERR(pdesc->equeue))
+		return ERR_PTR(PTR_ERR(pdesc->equeue));
+
+	hash_add(scmi_registered_protocols, &pdesc->hash, pdesc->key);
+
+	return pdesc;
+}
+
+/**
+ * scmi_register_protocol_events  - Register Protocol Events with the core
+ *
+ * Used by SCMI Protocols initialization code to register with the notification
+ * core the list of supported events and their descriptors: takes care to
+ * pre-allocate amd store all needed descriptors, scratch buffers and event
+ * queues.
+ *
+ * @dev: Device to use for devres
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
+int scmi_register_protocol_events(struct device *dev,
+				  u8 proto_id, size_t queue_sz,
+				  const struct scmi_protocol_event_ops *ops,
+				  const struct scmi_event *evt, int num_events,
+				  int num_sources)
+{
+	int i;
+	void *gid;
+	struct scmi_registered_protocol_events_desc *pdesc;
+
+	/* Ensure atomic value is updated */
+	smp_mb__before_atomic();
+	if (!ops || !evt ||
+	    unlikely(!atomic_read(&scmi_notifications_initialized)))
+		return -EINVAL;
+
+	gid = devres_open_group(dev, NULL, GFP_KERNEL);
+	if (!gid)
+		return -ENOMEM;
+
+	pdesc = scmi_allocate_registered_protocol_desc(dev, gid, proto_id,
+						       queue_sz, ops);
+	if (IS_ERR(pdesc))
+		goto err;
+
+	for (i = 0; i < num_events; i++, evt++) {
+		struct scmi_registered_event *r_evt;
+
+		r_evt = devm_kzalloc(dev, sizeof(*r_evt), GFP_KERNEL);
+		if (!r_evt)
+			goto err;
+		r_evt->proto = pdesc;
+		r_evt->evt = evt;
+
+		r_evt->sources = devm_kcalloc(dev, num_sources,
+					      sizeof(refcount_t), GFP_KERNEL);
+		if (!r_evt->sources)
+			goto err;
+		r_evt->num_sources = num_sources;
+		mutex_init(&r_evt->sources_mtx);
+
+		r_evt->scratch_isr = devm_kzalloc(dev,
+					sizeof(struct scmi_event_header) +
+					evt->max_payld_sz, GFP_KERNEL);
+		if (!r_evt->scratch_isr)
+			goto err;
+
+		r_evt->scratch_bh = devm_kzalloc(dev, evt->max_payld_sz,
+						 GFP_KERNEL);
+		if (!r_evt->scratch_bh)
+			goto err;
+
+		r_evt->key = MAKE_HASH_KEY(r_evt->proto->id,
+					   r_evt->evt->evt_id,
+					   SCMI_ALL_SRC_IDS);
+		hash_add(scmi_registered_events, &r_evt->hash, r_evt->key);
+
+		pr_info("SCMI Notifications: registered event - key:%X\n",
+			r_evt->key);
+	}
+	devres_close_group(dev, NULL);
+
+	return 0;
+
+err:
+	pr_warn("SCMI Notifications - Proto:%X - Registration Failed !\n",
+		proto_id);
+	devres_release_group(dev, NULL);
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
+ * and to flush the related queue. (via scmi_stop_and_flush_protocol_events)
+ *
+ * @dev: Device to use for devres
+ * @proto_id: The protocol to act upon
+ *
+ * Return: The number of released non-group resources
+ */
+int scmi_unregister_protocol_events(struct device *dev, u8 proto_id)
+{
+	int bkt;
+	struct scmi_registered_event *r_evt;
+	struct scmi_registered_protocol_events_desc *pdesc;
+
+	pdesc = KEY_FIND(scmi_registered_protocols, pdesc,
+			 MAKE_HASH_KEY(proto_id, 0, SCMI_ALL_SRC_IDS));
+	if (!pdesc)
+		return 0;
+
+	/* Remove all registered events for pdesc and pdesc itself */
+	hash_for_each(scmi_registered_events, bkt, r_evt, hash)
+		if (r_evt->proto == pdesc)
+			hash_del(&r_evt->hash);
+	hash_del(&pdesc->hash);
+
+	/* Free all underlying resources */
+	return devres_release_group(dev, pdesc->gid);
+}
+
+/**
+ * scmi_stop_and_flush_protocol_events  - Stop events processing
+ *
+ * Stop ISR dispatching and flush protocol queue: after this point no more
+ * events will be queued for this protocol and so, most importantly lookups
+ * on scmi_registered_events cannot happen anymore.
+ * Note that here we want to address also the possibility that a faulty
+ * platform keeps on emitting notification message even after having being
+ * asked to stop after the last user has gone.
+ *
+ * @proto_id: The protocol to act upon
+ *
+ * Return: False if protocol not found, True otherwise
+ */
+bool scmi_stop_and_flush_protocol_events(u8 proto_id)
+{
+	struct scmi_registered_protocol_events_desc *pdesc;
+
+	pdesc = KEY_FIND(scmi_registered_protocols, pdesc,
+			 MAKE_HASH_KEY(proto_id, 0, SCMI_ALL_SRC_IDS));
+	if (!pdesc)
+		return false;
+
+	atomic_set(&scmi_notifications_initialized, 0);
+	/* Ensure atomic value is updated */
+	smp_mb__after_atomic();
+
+	return true;
+}
+
+/**
+ * scmi_notification_init  - Initializes Notification Core Support
+ *
+ * Return: 0 on Success
+ */
+int __init scmi_notification_init(void)
+{
+	hash_init(scmi_registered_protocols);
+	hash_init(scmi_registered_events);
+
+	atomic_set(&scmi_notifications_initialized, 1);
+	/* Ensure atomic value is updated */
+	smp_mb__after_atomic();
+
+	pr_info("SCMI Notifications Core enabled.\n");
+
+	return 0;
+}
+
+/**
+ * scmi_notification_exit  - Shutdown and clean Notification core
+ */
+void __exit scmi_notification_exit(void)
+{
+	pr_info("SCMI Notifications Core disabled.\n");
+}
diff --git a/drivers/firmware/arm_scmi/notify.h b/drivers/firmware/arm_scmi/notify.h
new file mode 100644
index 000000000000..3f8a69c85a36
--- /dev/null
+++ b/drivers/firmware/arm_scmi/notify.h
@@ -0,0 +1,56 @@
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
+	bool (*set_notify_enabled)(u8 evt_id, u32 src_id, bool enabled);
+};
+
+int scmi_notification_init(void);
+void scmi_notification_exit(void);
+int scmi_register_protocol_events(struct device *dev,
+				  u8 proto_id, size_t queue_sz,
+				  const struct scmi_protocol_event_ops *ops,
+				  const struct scmi_event *evt, int num_events,
+				  int num_sources);
+int scmi_unregister_protocol_events(struct device *dev, u8 proto_id);
+bool scmi_stop_and_flush_protocol_events(u8 proto_id);
+
+#endif /* _SCMI_NOTIFY_H */
-- 
2.17.1

