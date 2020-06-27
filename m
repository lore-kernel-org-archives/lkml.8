Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027D9C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 19:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADA9B2067D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 19:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WmuON/kW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgF0TrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 15:47:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49932 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726057AbgF0TrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 15:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593287235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5iqK6rpMWwHMywaQ2T2LKtEGsHj5cqueTjCdUTh3Lic=;
        b=WmuON/kWyRguHf/XYhJKjvD0bL0PTnf4ePrDiMNPyricwR2GH0npMQ/7p1xkSWAxjJ6/1A
        GVda3kmykfheeYuKm0LcF6tYt/vzA1sPVDVzITxiVsVo1wnFzGwM0pXF+kPMOTljcrtMw3
        awFjilmp6RdEOLL6OT5M4FwSp+3SNV4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-jGbLf37iPRCWoMTfuAIHdQ-1; Sat, 27 Jun 2020 15:47:11 -0400
X-MC-Unique: jGbLf37iPRCWoMTfuAIHdQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8B6410059A5;
        Sat, 27 Jun 2020 19:47:09 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-112-223.rdu2.redhat.com [10.10.112.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 329657F4F9;
        Sat, 27 Jun 2020 19:47:08 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Tejun Heo <tj@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v8 3/9] drm/vblank: Add vblank works
Date:   Sat, 27 Jun 2020 15:46:51 -0400
Message-Id: <20200627194657.156514-4-lyude@redhat.com>
In-Reply-To: <20200627194657.156514-1-lyude@redhat.com>
References: <20200627194657.156514-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some kind of vblank workers. The interface is similar to regular
delayed works, and is mostly based off kthread_work. It allows for
scheduling delayed works that execute once a particular vblank sequence
has passed. It also allows for accurate flushing of scheduled vblank
works - in that flushing waits for both the vblank sequence and job
execution to complete, or for the work to get cancelled - whichever
comes first.

Whatever hardware programming we do in the work must be fast (must at
least complete during the vblank or scanout period, sometimes during the
first few scanlines of the vblank). As such we use a high-priority
per-CRTC thread to accomplish this.

Changes since v7:
* Stuff drm_vblank_internal.h and drm_vblank_work_internal.h contents
  into drm_internal.h
* Get rid of unnecessary spinlock in drm_crtc_vblank_on()
* Remove !vblank->worker check
* Grab vbl_lock in drm_vblank_work_schedule()
* Mention self-rearming work items in drm_vblank_work_schedule() kdocs
* Return 1 from drm_vblank_work_schedule() if the work was scheduled
  successfully, 0 or error code otherwise
* Use drm_dbg_core() instead of DRM_DEV_ERROR() in
  drm_vblank_work_schedule()
* Remove vblank->worker checks in drm_vblank_destroy_worker() and
  drm_vblank_flush_worker()
Changes since v6:
* Get rid of ->pending and seqcounts, and implement flushing through
  simpler means - danvet
* Get rid of work_lock, just use drm_device->event_lock
* Move drm_vblank_work item cleanup into drm_crtc_vblank_off() so that
  we ensure that all vblank work has finished before disabling vblanks
* Add checks into drm_crtc_vblank_reset() so we yell if it gets called
  while there's vblank workers active
* Grab event_lock in both drm_crtc_vblank_on()/drm_crtc_vblank_off(),
  the main reason for this is so that other threads calling
  drm_vblank_work_schedule() are blocked from attempting to schedule
  while we're in the middle of enabling/disabling vblanks.
* Move drm_handle_vblank_works() call below drm_handle_vblank_events()
* Simplify drm_vblank_work_cancel_sync()
* Fix drm_vblank_work_cancel_sync() documentation
* Move wake_up_all() calls out of spinlock where we can. The only one I
  left was the call to wake_up_all() in drm_vblank_handle_works() as
  this seemed like it made more sense just living in that function
  (which is all technically under lock)
* Move drm_vblank_work related functions into their own source files
* Add drm_vblank_internal.h so we can export some functions we don't
  want drivers using, but that we do need to use in drm_vblank_work.c
* Add a bunch of documentation
Changes since v4:
* Get rid of kthread interfaces we tried adding and move all of the
  locking into drm_vblank.c. For implementing drm_vblank_work_flush(),
  we now use a wait_queue and sequence counters in order to
  differentiate between multiple work item executions.
* Get rid of drm_vblank_work_cancel() - this would have been pretty
  difficult to actually reimplement and it occurred to me that neither
  nouveau or i915 are even planning to use this function. Since there's
  also no async cancel function for most of the work interfaces in the
  kernel, it seems a bit unnecessary anyway.
* Get rid of to_drm_vblank_work() since we now are also able to just
  pass the struct drm_vblank_work to work item callbacks anyway
Changes since v3:
* Use our own spinlocks, don't integrate so tightly with kthread_works
Changes since v2:
* Use kthread_workers instead of reinventing the wheel.

Cc: Tejun Heo <tj@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Co-developed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 Documentation/gpu/drm-kms.rst     |  15 ++
 drivers/gpu/drm/Makefile          |   2 +-
 drivers/gpu/drm/drm_internal.h    |  27 +++
 drivers/gpu/drm/drm_vblank.c      |  44 +++--
 drivers/gpu/drm/drm_vblank_work.c | 267 ++++++++++++++++++++++++++++++
 include/drm/drm_vblank.h          |  20 +++
 include/drm/drm_vblank_work.h     |  71 ++++++++
 7 files changed, 430 insertions(+), 16 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_vblank_work.c
 create mode 100644 include/drm/drm_vblank_work.h

diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
index 975cfeb8a3532..3c5ae4f6dfd23 100644
--- a/Documentation/gpu/drm-kms.rst
+++ b/Documentation/gpu/drm-kms.rst
@@ -543,3 +543,18 @@ Vertical Blanking and Interrupt Handling Functions Reference
 
 .. kernel-doc:: drivers/gpu/drm/drm_vblank.c
    :export:
+
+Vertical Blank Work
+===================
+
+.. kernel-doc:: drivers/gpu/drm/drm_vblank_work.c
+   :doc: vblank works
+
+Vertical Blank Work Functions Reference
+---------------------------------------
+
+.. kernel-doc:: include/drm/drm_vblank_work.h
+   :internal:
+
+.. kernel-doc:: drivers/gpu/drm/drm_vblank_work.c
+   :export:
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 2c0e5a7e59536..02ee5faf1a925 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -18,7 +18,7 @@ drm-y       :=	drm_auth.o drm_cache.o \
 		drm_dumb_buffers.o drm_mode_config.o drm_vblank.o \
 		drm_syncobj.o drm_lease.o drm_writeback.o drm_client.o \
 		drm_client_modeset.o drm_atomic_uapi.o drm_hdcp.o \
-		drm_managed.o
+		drm_managed.o drm_vblank_work.o
 
 drm-$(CONFIG_DRM_LEGACY) += drm_legacy_misc.o drm_bufs.o drm_context.o drm_dma.o drm_scatter.o drm_lock.o
 drm-$(CONFIG_DRM_LIB_RANDOM) += lib/drm_random.o
diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
index 2470a352730b5..8e01caaf95cc4 100644
--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -21,7 +21,10 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/kthread.h>
+
 #include <drm/drm_ioctl.h>
+#include <drm/drm_vblank.h>
 
 #define DRM_IF_MAJOR 1
 #define DRM_IF_MINOR 4
@@ -38,6 +41,7 @@ struct drm_master;
 struct drm_minor;
 struct drm_prime_file_private;
 struct drm_printer;
+struct drm_vblank_crtc;
 
 /* drm_file.c */
 extern struct mutex drm_global_mutex;
@@ -93,7 +97,30 @@ void drm_minor_release(struct drm_minor *minor);
 void drm_managed_release(struct drm_device *dev);
 
 /* drm_vblank.c */
+static inline bool drm_vblank_passed(u64 seq, u64 ref)
+{
+	return (seq - ref) <= (1 << 23);
+}
+
 void drm_vblank_disable_and_save(struct drm_device *dev, unsigned int pipe);
+int drm_vblank_get(struct drm_device *dev, unsigned int pipe);
+void drm_vblank_put(struct drm_device *dev, unsigned int pipe);
+u64 drm_vblank_count(struct drm_device *dev, unsigned int pipe);
+
+/* drm_vblank_work.c */
+static inline void drm_vblank_flush_worker(struct drm_vblank_crtc *vblank)
+{
+	kthread_flush_worker(vblank->worker);
+}
+
+static inline void drm_vblank_destroy_worker(struct drm_vblank_crtc *vblank)
+{
+	kthread_destroy_worker(vblank->worker);
+}
+
+int drm_vblank_worker_init(struct drm_vblank_crtc *vblank);
+void drm_vblank_cancel_pending_works(struct drm_vblank_crtc *vblank);
+void drm_handle_vblank_works(struct drm_vblank_crtc *vblank);
 
 /* IOCTLS */
 int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index e895f5331fdb4..16d1b5132b8f8 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -25,6 +25,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/kthread.h>
 #include <linux/moduleparam.h>
 
 #include <drm/drm_crtc.h>
@@ -363,7 +364,7 @@ static void drm_update_vblank_count(struct drm_device *dev, unsigned int pipe,
 	store_vblank(dev, pipe, diff, t_vblank, cur_vblank);
 }
 
-static u64 drm_vblank_count(struct drm_device *dev, unsigned int pipe)
+u64 drm_vblank_count(struct drm_device *dev, unsigned int pipe)
 {
 	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
 	u64 count;
@@ -497,6 +498,7 @@ static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
 	drm_WARN_ON(dev, READ_ONCE(vblank->enabled) &&
 		    drm_core_check_feature(dev, DRIVER_MODESET));
 
+	drm_vblank_destroy_worker(vblank);
 	del_timer_sync(&vblank->disable_timer);
 }
 
@@ -539,6 +541,10 @@ int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
 					       vblank);
 		if (ret)
 			return ret;
+
+		ret = drm_vblank_worker_init(vblank);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -1135,7 +1141,7 @@ static int drm_vblank_enable(struct drm_device *dev, unsigned int pipe)
 	return ret;
 }
 
-static int drm_vblank_get(struct drm_device *dev, unsigned int pipe)
+int drm_vblank_get(struct drm_device *dev, unsigned int pipe)
 {
 	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
 	unsigned long irqflags;
@@ -1178,7 +1184,7 @@ int drm_crtc_vblank_get(struct drm_crtc *crtc)
 }
 EXPORT_SYMBOL(drm_crtc_vblank_get);
 
-static void drm_vblank_put(struct drm_device *dev, unsigned int pipe)
+void drm_vblank_put(struct drm_device *dev, unsigned int pipe)
 {
 	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
 
@@ -1281,13 +1287,16 @@ void drm_crtc_vblank_off(struct drm_crtc *crtc)
 	unsigned int pipe = drm_crtc_index(crtc);
 	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
 	struct drm_pending_vblank_event *e, *t;
-
 	ktime_t now;
 	u64 seq;
 
 	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
 		return;
 
+	/*
+	 * Grab event_lock early to prevent vblank work from being scheduled
+	 * while we're in the middle of shutting down vblank interrupts
+	 */
 	spin_lock_irq(&dev->event_lock);
 
 	spin_lock(&dev->vbl_lock);
@@ -1324,11 +1333,18 @@ void drm_crtc_vblank_off(struct drm_crtc *crtc)
 		drm_vblank_put(dev, pipe);
 		send_vblank_event(dev, e, seq, now);
 	}
+
+	/* Cancel any leftover pending vblank work */
+	drm_vblank_cancel_pending_works(vblank);
+
 	spin_unlock_irq(&dev->event_lock);
 
 	/* Will be reset by the modeset helpers when re-enabling the crtc by
 	 * calling drm_calc_timestamping_constants(). */
 	vblank->hwmode.crtc_clock = 0;
+
+	/* Wait for any vblank work that's still executing to finish */
+	drm_vblank_flush_worker(vblank);
 }
 EXPORT_SYMBOL(drm_crtc_vblank_off);
 
@@ -1363,6 +1379,7 @@ void drm_crtc_vblank_reset(struct drm_crtc *crtc)
 	spin_unlock_irqrestore(&dev->vbl_lock, irqflags);
 
 	drm_WARN_ON(dev, !list_empty(&dev->vblank_event_list));
+	drm_WARN_ON(dev, !list_empty(&vblank->pending_work));
 }
 EXPORT_SYMBOL(drm_crtc_vblank_reset);
 
@@ -1589,11 +1606,6 @@ int drm_legacy_modeset_ctl_ioctl(struct drm_device *dev, void *data,
 	return 0;
 }
 
-static inline bool vblank_passed(u64 seq, u64 ref)
-{
-	return (seq - ref) <= (1 << 23);
-}
-
 static int drm_queue_vblank_event(struct drm_device *dev, unsigned int pipe,
 				  u64 req_seq,
 				  union drm_wait_vblank *vblwait,
@@ -1650,7 +1662,7 @@ static int drm_queue_vblank_event(struct drm_device *dev, unsigned int pipe,
 	trace_drm_vblank_event_queued(file_priv, pipe, req_seq);
 
 	e->sequence = req_seq;
-	if (vblank_passed(seq, req_seq)) {
+	if (drm_vblank_passed(seq, req_seq)) {
 		drm_vblank_put(dev, pipe);
 		send_vblank_event(dev, e, seq, now);
 		vblwait->reply.sequence = seq;
@@ -1805,7 +1817,7 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
 	}
 
 	if ((flags & _DRM_VBLANK_NEXTONMISS) &&
-	    vblank_passed(seq, req_seq)) {
+	    drm_vblank_passed(seq, req_seq)) {
 		req_seq = seq + 1;
 		vblwait->request.type &= ~_DRM_VBLANK_NEXTONMISS;
 		vblwait->request.sequence = req_seq;
@@ -1824,7 +1836,7 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
 		drm_dbg_core(dev, "waiting on vblank count %llu, crtc %u\n",
 			     req_seq, pipe);
 		wait = wait_event_interruptible_timeout(vblank->queue,
-			vblank_passed(drm_vblank_count(dev, pipe), req_seq) ||
+			drm_vblank_passed(drm_vblank_count(dev, pipe), req_seq) ||
 				      !READ_ONCE(vblank->enabled),
 			msecs_to_jiffies(3000));
 
@@ -1873,7 +1885,7 @@ static void drm_handle_vblank_events(struct drm_device *dev, unsigned int pipe)
 	list_for_each_entry_safe(e, t, &dev->vblank_event_list, base.link) {
 		if (e->pipe != pipe)
 			continue;
-		if (!vblank_passed(seq, e->sequence))
+		if (!drm_vblank_passed(seq, e->sequence))
 			continue;
 
 		drm_dbg_core(dev, "vblank event on %llu, current %llu\n",
@@ -1943,6 +1955,7 @@ bool drm_handle_vblank(struct drm_device *dev, unsigned int pipe)
 		       !atomic_read(&vblank->refcount));
 
 	drm_handle_vblank_events(dev, pipe);
+	drm_handle_vblank_works(vblank);
 
 	spin_unlock_irqrestore(&dev->event_lock, irqflags);
 
@@ -2096,7 +2109,7 @@ int drm_crtc_queue_sequence_ioctl(struct drm_device *dev, void *data,
 	if (flags & DRM_CRTC_SEQUENCE_RELATIVE)
 		req_seq += seq;
 
-	if ((flags & DRM_CRTC_SEQUENCE_NEXT_ON_MISS) && vblank_passed(seq, req_seq))
+	if ((flags & DRM_CRTC_SEQUENCE_NEXT_ON_MISS) && drm_vblank_passed(seq, req_seq))
 		req_seq = seq + 1;
 
 	e->pipe = pipe;
@@ -2125,7 +2138,7 @@ int drm_crtc_queue_sequence_ioctl(struct drm_device *dev, void *data,
 
 	e->sequence = req_seq;
 
-	if (vblank_passed(seq, req_seq)) {
+	if (drm_vblank_passed(seq, req_seq)) {
 		drm_crtc_vblank_put(crtc);
 		send_vblank_event(dev, e, seq, now);
 		queue_seq->sequence = seq;
@@ -2145,3 +2158,4 @@ int drm_crtc_queue_sequence_ioctl(struct drm_device *dev, void *data,
 	kfree(e);
 	return ret;
 }
+
diff --git a/drivers/gpu/drm/drm_vblank_work.c b/drivers/gpu/drm/drm_vblank_work.c
new file mode 100644
index 0000000000000..7ac0fc0a9415d
--- /dev/null
+++ b/drivers/gpu/drm/drm_vblank_work.c
@@ -0,0 +1,267 @@
+// SPDX-License-Identifier: MIT
+
+#include <uapi/linux/sched/types.h>
+
+#include <drm/drm_print.h>
+#include <drm/drm_vblank.h>
+#include <drm/drm_vblank_work.h>
+#include <drm/drm_crtc.h>
+
+#include "drm_internal.h"
+
+/**
+ * DOC: vblank works
+ *
+ * Many DRM drivers need to program hardware in a time-sensitive manner, many
+ * times with a deadline of starting and finishing within a certain region of
+ * the scanout. Most of the time the safest way to accomplish this is to
+ * simply do said time-sensitive programming in the driver's IRQ handler,
+ * which allows drivers to avoid being preempted during these critical
+ * regions. Or even better, the hardware may even handle applying such
+ * time-critical programming independently of the CPU.
+ *
+ * While there's a decent amount of hardware that's designed so that the CPU
+ * doesn't need to be concerned with extremely time-sensitive programming,
+ * there's a few situations where it can't be helped. Some unforgiving
+ * hardware may require that certain time-sensitive programming be handled
+ * completely by the CPU, and said programming may even take too long to
+ * handle in an IRQ handler. Another such situation would be where the driver
+ * needs to perform a task that needs to complete within a specific scanout
+ * period, but might possibly block and thus cannot be handled in an IRQ
+ * context. Both of these situations can't be solved perfectly in Linux since
+ * we're not a realtime kernel, and thus the scheduler may cause us to miss
+ * our deadline if it decides to preempt us. But for some drivers, it's good
+ * enough if we can lower our chance of being preempted to an absolute
+ * minimum.
+ *
+ * This is where &drm_vblank_work comes in. &drm_vblank_work provides a simple
+ * generic delayed work implementation which delays work execution until a
+ * particular vblank has passed, and then executes the work at realtime
+ * priority. This provides the best possible chance at performing
+ * time-sensitive hardware programming on time, even when the system is under
+ * heavy load. &drm_vblank_work also supports rescheduling, so that self
+ * re-arming work items can be easily implemented.
+ */
+
+void drm_handle_vblank_works(struct drm_vblank_crtc *vblank)
+{
+	struct drm_vblank_work *work, *next;
+	u64 count = atomic64_read(&vblank->count);
+	bool wake = false;
+
+	assert_spin_locked(&vblank->dev->event_lock);
+
+	list_for_each_entry_safe(work, next, &vblank->pending_work, node) {
+		if (!drm_vblank_passed(count, work->count))
+			continue;
+
+		list_del_init(&work->node);
+		drm_vblank_put(vblank->dev, vblank->pipe);
+		kthread_queue_work(vblank->worker, &work->base);
+		wake = true;
+	}
+	if (wake)
+		wake_up_all(&vblank->work_wait_queue);
+}
+
+/* Handle cancelling any pending vblank work items and drop respective vblank
+ * references in response to vblank interrupts being disabled.
+ */
+void drm_vblank_cancel_pending_works(struct drm_vblank_crtc *vblank)
+{
+	struct drm_vblank_work *work, *next;
+
+	assert_spin_locked(&vblank->dev->event_lock);
+
+	list_for_each_entry_safe(work, next, &vblank->pending_work, node) {
+		list_del_init(&work->node);
+		drm_vblank_put(vblank->dev, vblank->pipe);
+	}
+
+	wake_up_all(&vblank->work_wait_queue);
+}
+
+/**
+ * drm_vblank_work_schedule - schedule a vblank work
+ * @work: vblank work to schedule
+ * @count: target vblank count
+ * @nextonmiss: defer until the next vblank if target vblank was missed
+ *
+ * Schedule @work for execution once the crtc vblank count reaches @count.
+ *
+ * If the crtc vblank count has already reached @count and @nextonmiss is
+ * %false the work starts to execute immediately.
+ *
+ * If the crtc vblank count has already reached @count and @nextonmiss is
+ * %true the work is deferred until the next vblank (as if @count has been
+ * specified as crtc vblank count + 1).
+ *
+ * If @work is already scheduled, this function will reschedule said work
+ * using the new @count. This can be used for self-rearming work items.
+ *
+ * Returns:
+ * %1 if @work was successfully (re)scheduled, %0 if it was either already
+ * scheduled or cancelled, or a negative error code on failure.
+ */
+int drm_vblank_work_schedule(struct drm_vblank_work *work,
+			     u64 count, bool nextonmiss)
+{
+	struct drm_vblank_crtc *vblank = work->vblank;
+	struct drm_device *dev = vblank->dev;
+	u64 cur_vbl;
+	unsigned long irqflags;
+	bool passed, inmodeset, rescheduling = false, wake = false;
+	int ret = 0;
+
+	spin_lock_irqsave(&dev->event_lock, irqflags);
+	if (work->cancelling)
+		goto out;
+
+	spin_lock(&dev->vbl_lock);
+	inmodeset = vblank->inmodeset;
+	spin_unlock(&dev->vbl_lock);
+	if (inmodeset)
+		goto out;
+
+	if (list_empty(&work->node)) {
+		ret = drm_vblank_get(dev, vblank->pipe);
+		if (ret < 0)
+			goto out;
+	} else if (work->count == count) {
+		/* Already scheduled w/ same vbl count */
+		goto out;
+	} else {
+		rescheduling = true;
+	}
+
+	work->count = count;
+	cur_vbl = drm_vblank_count(dev, vblank->pipe);
+	passed = drm_vblank_passed(cur_vbl, count);
+	if (passed)
+		drm_dbg_core(dev,
+			     "crtc %d vblank %llu already passed (current %llu)\n",
+			     vblank->pipe, count, cur_vbl);
+
+	if (!nextonmiss && passed) {
+		drm_vblank_put(dev, vblank->pipe);
+		ret = kthread_queue_work(vblank->worker, &work->base);
+
+		if (rescheduling) {
+			list_del_init(&work->node);
+			wake = true;
+		}
+	} else {
+		if (!rescheduling)
+			list_add_tail(&work->node, &vblank->pending_work);
+		ret = true;
+	}
+
+out:
+	spin_unlock_irqrestore(&dev->event_lock, irqflags);
+	if (wake)
+		wake_up_all(&vblank->work_wait_queue);
+	return ret;
+}
+EXPORT_SYMBOL(drm_vblank_work_schedule);
+
+/**
+ * drm_vblank_work_cancel_sync - cancel a vblank work and wait for it to
+ * finish executing
+ * @work: vblank work to cancel
+ *
+ * Cancel an already scheduled vblank work and wait for its
+ * execution to finish.
+ *
+ * On return, @work is guaranteed to no longer be scheduled or running, even
+ * if it's self-arming.
+ *
+ * Returns:
+ * %True if the work was cancelled before it started to execute, %false
+ * otherwise.
+ */
+bool drm_vblank_work_cancel_sync(struct drm_vblank_work *work)
+{
+	struct drm_vblank_crtc *vblank = work->vblank;
+	struct drm_device *dev = vblank->dev;
+	bool ret = false;
+
+	spin_lock_irq(&dev->event_lock);
+	if (!list_empty(&work->node)) {
+		list_del_init(&work->node);
+		drm_vblank_put(vblank->dev, vblank->pipe);
+		ret = true;
+	}
+
+	work->cancelling++;
+	spin_unlock_irq(&dev->event_lock);
+
+	wake_up_all(&vblank->work_wait_queue);
+
+	if (kthread_cancel_work_sync(&work->base))
+		ret = true;
+
+	spin_lock_irq(&dev->event_lock);
+	work->cancelling--;
+	spin_unlock_irq(&dev->event_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(drm_vblank_work_cancel_sync);
+
+/**
+ * drm_vblank_work_flush - wait for a scheduled vblank work to finish
+ * executing
+ * @work: vblank work to flush
+ *
+ * Wait until @work has finished executing once.
+ */
+void drm_vblank_work_flush(struct drm_vblank_work *work)
+{
+	struct drm_vblank_crtc *vblank = work->vblank;
+	struct drm_device *dev = vblank->dev;
+
+	spin_lock_irq(&dev->event_lock);
+	wait_event_lock_irq(vblank->work_wait_queue, list_empty(&work->node),
+			    dev->event_lock);
+	spin_unlock_irq(&dev->event_lock);
+
+	kthread_flush_work(&work->base);
+}
+EXPORT_SYMBOL(drm_vblank_work_flush);
+
+/**
+ * drm_vblank_work_init - initialize a vblank work item
+ * @work: vblank work item
+ * @crtc: CRTC whose vblank will trigger the work execution
+ * @func: work function to be executed
+ *
+ * Initialize a vblank work item for a specific crtc.
+ */
+void drm_vblank_work_init(struct drm_vblank_work *work, struct drm_crtc *crtc,
+			  void (*func)(struct kthread_work *work))
+{
+	kthread_init_work(&work->base, func);
+	INIT_LIST_HEAD(&work->node);
+	work->vblank = &crtc->dev->vblank[drm_crtc_index(crtc)];
+}
+EXPORT_SYMBOL(drm_vblank_work_init);
+
+int drm_vblank_worker_init(struct drm_vblank_crtc *vblank)
+{
+	struct sched_param param = {
+		.sched_priority = MAX_RT_PRIO - 1,
+	};
+	struct kthread_worker *worker;
+
+	INIT_LIST_HEAD(&vblank->pending_work);
+	init_waitqueue_head(&vblank->work_wait_queue);
+	worker = kthread_create_worker(0, "card%d-crtc%d",
+				       vblank->dev->primary->index,
+				       vblank->pipe);
+	if (IS_ERR(worker))
+		return PTR_ERR(worker);
+
+	vblank->worker = worker;
+
+	return sched_setscheduler(vblank->worker->task, SCHED_FIFO, &param);
+}
diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
index dd9f5b9e56e4e..dd125f8c766cf 100644
--- a/include/drm/drm_vblank.h
+++ b/include/drm/drm_vblank.h
@@ -27,12 +27,14 @@
 #include <linux/seqlock.h>
 #include <linux/idr.h>
 #include <linux/poll.h>
+#include <linux/kthread.h>
 
 #include <drm/drm_file.h>
 #include <drm/drm_modes.h>
 
 struct drm_device;
 struct drm_crtc;
+struct drm_vblank_work;
 
 /**
  * struct drm_pending_vblank_event - pending vblank event tracking
@@ -203,6 +205,24 @@ struct drm_vblank_crtc {
 	 * disabling functions multiple times.
 	 */
 	bool enabled;
+
+	/**
+	 * @worker: The &kthread_worker used for executing vblank works.
+	 */
+	struct kthread_worker *worker;
+
+	/**
+	 * @pending_work: A list of scheduled &drm_vblank_work items that are
+	 * waiting for a future vblank.
+	 */
+	struct list_head pending_work;
+
+	/**
+	 * @work_wait_queue: The wait queue used for signaling that a
+	 * &drm_vblank_work item has either finished executing, or was
+	 * cancelled.
+	 */
+	wait_queue_head_t work_wait_queue;
 };
 
 int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs);
diff --git a/include/drm/drm_vblank_work.h b/include/drm/drm_vblank_work.h
new file mode 100644
index 0000000000000..f0439c039f7ce
--- /dev/null
+++ b/include/drm/drm_vblank_work.h
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: MIT
+
+#ifndef _DRM_VBLANK_WORK_H_
+#define _DRM_VBLANK_WORK_H_
+
+#include <linux/kthread.h>
+
+struct drm_crtc;
+
+/**
+ * struct drm_vblank_work - A delayed work item which delays until a target
+ * vblank passes, and then executes at realtime priority outside of IRQ
+ * context.
+ *
+ * See also:
+ * drm_vblank_work_schedule()
+ * drm_vblank_work_init()
+ * drm_vblank_work_cancel_sync()
+ * drm_vblank_work_flush()
+ */
+struct drm_vblank_work {
+	/**
+	 * @base: The base &kthread_work item which will be executed by
+	 * &drm_vblank_crtc.worker. Drivers should not interact with this
+	 * directly, and instead rely on drm_vblank_work_init() to initialize
+	 * this.
+	 */
+	struct kthread_work base;
+
+	/**
+	 * @vblank: A pointer to &drm_vblank_crtc this work item belongs to.
+	 */
+	struct drm_vblank_crtc *vblank;
+
+	/**
+	 * @count: The target vblank this work will execute on. Drivers should
+	 * not modify this value directly, and instead use
+	 * drm_vblank_work_schedule()
+	 */
+	u64 count;
+
+	/**
+	 * @cancelling: The number of drm_vblank_work_cancel_sync() calls that
+	 * are currently running. A work item cannot be rescheduled until all
+	 * calls have finished.
+	 */
+	int cancelling;
+
+	/**
+	 * @node: The position of this work item in
+	 * &drm_vblank_crtc.pending_work.
+	 */
+	struct list_head node;
+};
+
+/**
+ * to_drm_vblank_work - Retrieve the respective &drm_vblank_work item from a
+ * &kthread_work
+ * @_work: The &kthread_work embedded inside a &drm_vblank_work
+ */
+#define to_drm_vblank_work(_work) \
+	container_of((_work), struct drm_vblank_work, base)
+
+int drm_vblank_work_schedule(struct drm_vblank_work *work,
+			     u64 count, bool nextonmiss);
+void drm_vblank_work_init(struct drm_vblank_work *work, struct drm_crtc *crtc,
+			  void (*func)(struct kthread_work *work));
+bool drm_vblank_work_cancel_sync(struct drm_vblank_work *work);
+void drm_vblank_work_flush(struct drm_vblank_work *work);
+
+#endif /* !_DRM_VBLANK_WORK_H_ */
-- 
2.26.2

