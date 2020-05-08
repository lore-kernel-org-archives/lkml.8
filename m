Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BDCC54E4A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A7E024967
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZuvX00d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgEHUss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 16:48:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53915 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727867AbgEHUsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 16:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588970920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hY0l3zHIsGRY+PR7SgsUIMupSuU04xYcOdGubfauIf8=;
        b=cZuvX00dGuCDbKsuWeiQNBnpNiwSkp+m9pCM3x4N4V6Vjog/5m46iRT8zcdq3N/tg6gCSA
        g79KsKL6ro7Llqgd8BqHCLnba09NfkAPoG3Iwk9tvbZ2yF07II/Mg1vYnugTCeFKNICpjn
        HEURbjR3q0xpvpD2nl3F1+n6vw13lx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-JHm91Ck4MbagqItyRRwjfQ-1; Fri, 08 May 2020 16:48:38 -0400
X-MC-Unique: JHm91Ck4MbagqItyRRwjfQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 153F81005510;
        Fri,  8 May 2020 20:48:37 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-118-29.rdu2.redhat.com [10.10.118.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 069AE5D9CA;
        Fri,  8 May 2020 20:48:35 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>
Subject: [RFC v4 04/12] drm/vblank: Add vblank works
Date:   Fri,  8 May 2020 16:46:54 -0400
Message-Id: <20200508204751.155488-5-lyude@redhat.com>
In-Reply-To: <20200508204751.155488-1-lyude@redhat.com>
References: <20200508204751.155488-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

[based off patches from Ville Syrjälä <ville.syrjala@linux.intel.com>,
change below to signoff later]

Changes since v3:
* Use our own spinlocks, don't integrate so tightly with kthread_works
Changes since v2:
* Use kthread_workers instead of reinventing the wheel.

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Tejun Heo <tj@kernel.org>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_vblank.c | 259 +++++++++++++++++++++++++++++++++++
 include/drm/drm_vblank.h     |  35 +++++
 2 files changed, 294 insertions(+)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index a4a9013584e2..5b10277553e4 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -25,7 +25,9 @@
  */
 
 #include <linux/export.h>
+#include <linux/kthread.h>
 #include <linux/moduleparam.h>
+#include <uapi/linux/sched/types.h>
 
 #include <drm/drm_crtc.h>
 #include <drm/drm_drv.h>
@@ -155,6 +157,7 @@
 static bool
 drm_get_last_vbltimestamp(struct drm_device *dev, unsigned int pipe,
 			  ktime_t *tvblank, bool in_vblank_irq);
+static int drm_vblank_get(struct drm_device *dev, unsigned int pipe);
 
 static unsigned int drm_timestamp_precision = 20;  /* Default to 20 usecs. */
 
@@ -496,9 +499,46 @@ static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
 	WARN_ON(READ_ONCE(vblank->enabled) &&
 		drm_core_check_feature(dev, DRIVER_MODESET));
 
+	if (vblank->worker && !IS_ERR(vblank->worker))
+		kthread_destroy_worker(vblank->worker);
 	del_timer_sync(&vblank->disable_timer);
 }
 
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
+	INIT_LIST_HEAD(&work->flush_work);
+	INIT_LIST_HEAD(&work->pending);
+	work->vblank = &crtc->dev->vblank[drm_crtc_index(crtc)];
+}
+EXPORT_SYMBOL(drm_vblank_work_init);
+
+static int vblank_worker_init(struct drm_vblank_crtc *vblank)
+{
+	struct sched_param param = {
+		.sched_priority = MAX_RT_PRIO - 1,
+	};
+
+	INIT_LIST_HEAD(&vblank->pending_work);
+	spin_lock_init(&vblank->work_lock);
+	vblank->worker = kthread_create_worker(0, "card%d-crtc%d",
+					       vblank->dev->primary->index,
+					       vblank->pipe);
+	if (IS_ERR(vblank->worker))
+		return PTR_ERR(vblank->worker);
+
+	return sched_setscheduler(vblank->worker->task, SCHED_FIFO, &param);
+}
+
 /**
  * drm_vblank_init - initialize vblank support
  * @dev: DRM device
@@ -538,6 +578,10 @@ int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
 					       vblank);
 		if (ret)
 			return ret;
+
+		ret = vblank_worker_init(vblank);
+		if (ret)
+			return ret;
 	}
 
 	DRM_INFO("Supports vblank timestamp caching Rev 2 (21.10.2013).\n");
@@ -1878,6 +1922,45 @@ static void drm_handle_vblank_events(struct drm_device *dev, unsigned int pipe)
 	trace_drm_vblank_event(pipe, seq, now, high_prec);
 }
 
+static void queue_vbl_work(struct drm_vblank_work *work)
+{
+	struct kthread_flush_work *fwork, *tmp;
+	bool busy, reinit = false;
+
+	busy = kthread_queue_work(work->vblank->worker, &work->base);
+	list_for_each_entry_safe(fwork, tmp, &work->flush_work, work.node) {
+		if (busy) {
+			list_del_init(&fwork->work.node);
+			busy = kthread_queue_flush_work(&work->base, fwork);
+			if (!busy)
+				complete(&fwork->done);
+		} else {
+			complete(&fwork->done);
+			reinit = true;
+		}
+	}
+
+	if (reinit)
+		INIT_LIST_HEAD(&work->flush_work);
+}
+
+static void drm_handle_vblank_works(struct drm_vblank_crtc *vblank)
+{
+	struct drm_vblank_work *work, *next;
+	u64 count = atomic64_read(&vblank->count);
+
+	spin_lock(&vblank->work_lock);
+	list_for_each_entry_safe(work, next, &vblank->pending_work, pending) {
+		if (!vblank_passed(count, work->count))
+			continue;
+
+		list_del_init(&work->pending);
+		drm_vblank_put(vblank->dev, vblank->pipe);
+		queue_vbl_work(work);
+	}
+	spin_unlock(&vblank->work_lock);
+}
+
 /**
  * drm_handle_vblank - handle a vblank event
  * @dev: DRM device
@@ -1919,6 +2002,7 @@ bool drm_handle_vblank(struct drm_device *dev, unsigned int pipe)
 
 	spin_unlock(&dev->vblank_time_lock);
 
+	drm_handle_vblank_works(vblank);
 	wake_up(&vblank->queue);
 
 	/* With instant-off, we defer disabling the interrupt until after
@@ -2129,3 +2213,178 @@ int drm_crtc_queue_sequence_ioctl(struct drm_device *dev, void *data,
 	kfree(e);
 	return ret;
 }
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
+ * using the new @count.
+ *
+ * Returns:
+ * 0 on success, error code on failure.
+ */
+int drm_vblank_work_schedule(struct drm_vblank_work *work,
+			     u64 count, bool nextonmiss)
+{
+	struct drm_vblank_crtc *vblank = work->vblank;
+	struct drm_device *dev = vblank->dev;
+	u64 cur_vbl;
+	unsigned long irqflags;
+	bool passed, rescheduling = false;
+	int ret = 0;
+
+	spin_lock_irqsave(&vblank->work_lock, irqflags);
+	if (!kthread_work_queuable(&work->base))
+		goto out;
+
+	if (list_empty(&work->pending)) {
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
+	passed = vblank_passed(cur_vbl, count);
+	if (passed)
+		DRM_ERROR("crtc %d vblank %llu already passed (current %llu)\n",
+			  vblank->pipe, count, cur_vbl);
+
+	if (!nextonmiss && passed) {
+		drm_vblank_put(dev, vblank->pipe);
+		if (rescheduling)
+			list_del_init(&work->pending);
+		queue_vbl_work(work);
+	} else if (rescheduling) {
+		list_move_tail(&work->pending, &vblank->pending_work);
+	} else {
+		list_add_tail(&work->pending, &vblank->pending_work);
+	}
+
+ out:
+	spin_unlock_irqrestore(&vblank->work_lock, irqflags);
+	return ret;
+}
+EXPORT_SYMBOL(drm_vblank_work_schedule);
+
+static bool vblank_work_cancel(struct drm_vblank_work *work)
+{
+	struct kthread_flush_work *pos, *tmp;
+
+	if (list_empty(&work->pending))
+		return false;
+
+	list_for_each_entry_safe(pos, tmp, &work->flush_work, work.node)
+		complete(&pos->done);
+
+	list_del_init(&work->pending);
+	INIT_LIST_HEAD(&work->flush_work);
+	return true;
+}
+
+/**
+ * drm_vblank_work_cancel - cancel a vblank work
+ * @work: vblank work to cancel
+ *
+ * Cancel an already scheduled vblank work.
+ *
+ * On return @work may still be executing, unless the return
+ * value is %true.
+ *
+ * Returns:
+ * True if the work was cancelled before it started to excute, false otherwise.
+ */
+bool drm_vblank_work_cancel(struct drm_vblank_work *work)
+{
+	struct drm_vblank_crtc *vblank = work->vblank;
+	bool cancelled;
+
+	spin_lock_irq(&vblank->work_lock);
+	cancelled = vblank_work_cancel(work);
+	spin_unlock_irq(&vblank->work_lock);
+	if (cancelled)
+		drm_vblank_put(vblank->dev, vblank->pipe);
+
+	return cancelled;
+}
+EXPORT_SYMBOL(drm_vblank_work_cancel);
+
+/**
+ * drm_vblank_work_cancel_sync - cancel a vblank work and wait for it to
+ * finish executing
+ * @work: vblank work to cancel
+ *
+ * Cancel an already scheduled vblank work and wait for its
+ * execution to finish.
+ *
+ * On return @work is no longer guaraneed to be executing.
+ *
+ * Returns:
+ * %True if the work was cancelled before it started to execute, %false
+ * otherwise.
+ */
+bool drm_vblank_work_cancel_sync(struct drm_vblank_work *work)
+{
+	struct drm_vblank_crtc *vblank = work->vblank;
+	bool vbl_put, cancelled;
+
+	spin_lock_irq(&vblank->work_lock);
+	cancelled = vblank_work_cancel(work);
+	vbl_put = cancelled;
+
+	kthread_block_work_queuing(vblank->worker, &work->base);
+	spin_unlock_irq(&vblank->work_lock);
+
+	cancelled |= kthread_cancel_work_sync(&work->base);
+	if (vbl_put)
+		drm_vblank_put(vblank->dev, vblank->pipe);
+
+	kthread_unblock_work_queuing(vblank->worker, &work->base);
+
+	return cancelled;
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
+	bool scheduled;
+	DEFINE_KTHREAD_FLUSH_WORK(fwork);
+
+	spin_lock_irq(&vblank->work_lock);
+
+	scheduled = !list_empty(&work->pending);
+	if (scheduled)
+		list_add_tail(&fwork.work.node, &work->flush_work);
+	else
+		scheduled = kthread_queue_flush_work(&work->base, &fwork);
+
+	spin_unlock_irq(&vblank->work_lock);
+	if (scheduled)
+		wait_for_completion(&fwork.done);
+}
+EXPORT_SYMBOL(drm_vblank_work_flush);
diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
index dd9f5b9e56e4..020f48bc8473 100644
--- a/include/drm/drm_vblank.h
+++ b/include/drm/drm_vblank.h
@@ -27,6 +27,7 @@
 #include <linux/seqlock.h>
 #include <linux/idr.h>
 #include <linux/poll.h>
+#include <linux/kthread.h>
 
 #include <drm/drm_file.h>
 #include <drm/drm_modes.h>
@@ -203,8 +204,42 @@ struct drm_vblank_crtc {
 	 * disabling functions multiple times.
 	 */
 	bool enabled;
+
+	/**
+	 * @worker: The &kthread_worker used for executing vblank works.
+	 */
+	struct kthread_worker *worker;
+	/**
+	 * @work_lock: The spinlock that protects @pending_work
+	 */
+	spinlock_t work_lock;
+	/**
+	 * @pending_work: A list of scheduled &drm_vblank_work that are
+	 * waiting for a future vblank.
+	 */
+	struct list_head pending_work;
+};
+
+struct drm_vblank_work {
+	struct kthread_work base;
+	struct drm_vblank_crtc *vblank;
+	u64 count;
+
+	struct list_head pending;
+	struct list_head flush_work;
 };
 
+#define to_drm_vblank_work(_work) \
+	container_of((_work), struct drm_vblank_work, base)
+
+int drm_vblank_work_schedule(struct drm_vblank_work *work,
+			     u64 count, bool nextonmiss);
+void drm_vblank_work_init(struct drm_vblank_work *work, struct drm_crtc *crtc,
+			  void (*func)(struct kthread_work *work));
+bool drm_vblank_work_cancel(struct drm_vblank_work *work);
+bool drm_vblank_work_cancel_sync(struct drm_vblank_work *work);
+void drm_vblank_work_flush(struct drm_vblank_work *work);
+
 int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs);
 bool drm_dev_has_vblank(const struct drm_device *dev);
 u64 drm_crtc_vblank_count(struct drm_crtc *crtc);
-- 
2.25.4

