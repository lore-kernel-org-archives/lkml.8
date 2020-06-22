Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F076DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE8A620776
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7G1WHvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbgFVUIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:08:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28557 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728539AbgFVUIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592856482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NgQjDm8/kZfx4WO8HaUv51ziwWACe5zT151qo/rP4Ms=;
        b=W7G1WHvJWiCXQB6083ND6cP+Xh22qh4pOa8KlYuwKPovZobMMmLDp3H1D7RDVZRqQ+f13x
        pR4tiiewlVceq6M1MB4cQv8ux279xRrU2D5IYyJAax/zgFrvUws+VlsYxPE1c+qoOSt6q5
        8U6B+9X7nfEUQx2cTqspxsrBL1pFtJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-Vt2xni4vNauTokuGIb8dHg-1; Mon, 22 Jun 2020 16:08:00 -0400
X-MC-Unique: Vt2xni4vNauTokuGIb8dHg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC7F8107ACF2;
        Mon, 22 Jun 2020 20:07:58 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-117-166.rdu2.redhat.com [10.10.117.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B8C65C1BD;
        Mon, 22 Jun 2020 20:07:57 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v5 02/10] drm/vblank: Add vblank works
Date:   Mon, 22 Jun 2020 16:07:22 -0400
Message-Id: <20200622200730.120716-3-lyude@redhat.com>
In-Reply-To: <20200622200730.120716-1-lyude@redhat.com>
References: <20200622200730.120716-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Tejun Heo <tj@kernel.org>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_vblank.c | 266 +++++++++++++++++++++++++++++++++++
 include/drm/drm_vblank.h     |  49 +++++++
 2 files changed, 315 insertions(+)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index ce5c1e1d29963..4d76eb2fed5e9 100644
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
@@ -155,6 +157,8 @@
 static bool
 drm_get_last_vbltimestamp(struct drm_device *dev, unsigned int pipe,
 			  ktime_t *tvblank, bool in_vblank_irq);
+static int drm_vblank_get(struct drm_device *dev, unsigned int pipe);
+static void drm_vblank_put(struct drm_device *dev, unsigned int pipe);
 
 static unsigned int drm_timestamp_precision = 20;  /* Default to 20 usecs. */
 
@@ -490,6 +494,35 @@ static void vblank_disable_fn(struct timer_list *t)
 	spin_unlock_irqrestore(&dev->vbl_lock, irqflags);
 }
 
+static void drm_vblank_work_release(struct drm_vblank_crtc *vblank)
+{
+	struct kthread_worker *worker = vblank->worker;
+	struct drm_vblank_work *work, *tmp;
+	bool wake = false;
+
+	if (!worker)
+		return;
+
+	spin_lock_irq(&vblank->work_lock);
+	vblank->worker = NULL;
+
+	list_for_each_entry_safe(work, tmp, &vblank->pending_work, node) {
+		drm_vblank_put(vblank->dev, vblank->pipe);
+		list_del(&work->node);
+
+		if (!--work->pending) {
+			write_seqcount_invalidate(&work->seqcount);
+			wake = true;
+		}
+	}
+
+	spin_unlock_irq(&vblank->work_lock);
+
+	if (wake)
+		wake_up_all(&vblank->work_wait_queue);
+	kthread_destroy_worker(worker);
+}
+
 static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
 {
 	struct drm_vblank_crtc *vblank = ptr;
@@ -497,9 +530,66 @@ static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
 	drm_WARN_ON(dev, READ_ONCE(vblank->enabled) &&
 		    drm_core_check_feature(dev, DRIVER_MODESET));
 
+	drm_vblank_work_release(vblank);
 	del_timer_sync(&vblank->disable_timer);
 }
 
+static void vblank_work_fn(struct kthread_work *base)
+{
+	struct drm_vblank_work *work =
+		container_of(base, struct drm_vblank_work, base);
+	struct drm_vblank_crtc *vblank = work->vblank;
+
+	work->func(work);
+
+	spin_lock_irq(&vblank->work_lock);
+	work->pending--;
+
+	write_seqcount_invalidate(&work->seqcount);
+	wake_up_all(&vblank->work_wait_queue);
+	spin_unlock_irq(&vblank->work_lock);
+}
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
+			  void (*func)(struct drm_vblank_work *work))
+{
+	kthread_init_work(&work->base, vblank_work_fn);
+	work->func = func;
+	INIT_LIST_HEAD(&work->node);
+	seqcount_init(&work->seqcount);
+	work->vblank = &crtc->dev->vblank[drm_crtc_index(crtc)];
+}
+EXPORT_SYMBOL(drm_vblank_work_init);
+
+static int vblank_worker_init(struct drm_vblank_crtc *vblank)
+{
+	struct sched_param param = {
+		.sched_priority = MAX_RT_PRIO - 1,
+	};
+	struct kthread_worker *worker;
+
+	INIT_LIST_HEAD(&vblank->pending_work);
+	spin_lock_init(&vblank->work_lock);
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
+
 /**
  * drm_vblank_init - initialize vblank support
  * @dev: DRM device
@@ -539,6 +629,10 @@ int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
 					       vblank);
 		if (ret)
 			return ret;
+
+		ret = vblank_worker_init(vblank);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -1891,6 +1985,24 @@ static void drm_handle_vblank_events(struct drm_device *dev, unsigned int pipe)
 	trace_drm_vblank_event(pipe, seq, now, high_prec);
 }
 
+static void drm_handle_vblank_works(struct drm_vblank_crtc *vblank)
+{
+	struct drm_vblank_work *work, *next;
+	u64 count = atomic64_read(&vblank->count);
+
+	spin_lock(&vblank->work_lock);
+	list_for_each_entry_safe(work, next, &vblank->pending_work, node) {
+		if (!vblank_passed(count, work->count))
+			continue;
+
+		list_del_init(&work->node);
+		drm_vblank_put(vblank->dev, vblank->pipe);
+		if (!kthread_queue_work(vblank->worker, &work->base))
+			work->pending--;
+	}
+	spin_unlock(&vblank->work_lock);
+}
+
 /**
  * drm_handle_vblank - handle a vblank event
  * @dev: DRM device
@@ -1932,6 +2044,7 @@ bool drm_handle_vblank(struct drm_device *dev, unsigned int pipe)
 
 	spin_unlock(&dev->vblank_time_lock);
 
+	drm_handle_vblank_works(vblank);
 	wake_up(&vblank->queue);
 
 	/* With instant-off, we defer disabling the interrupt until after
@@ -2146,3 +2259,156 @@ int drm_crtc_queue_sequence_ioctl(struct drm_device *dev, void *data,
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
+	if (!vblank->worker || work->cancelling)
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
+	passed = vblank_passed(cur_vbl, count);
+	if (passed)
+		DRM_ERROR("crtc %d vblank %llu already passed (current %llu)\n",
+			  vblank->pipe, count, cur_vbl);
+
+	if (!nextonmiss && passed) {
+		drm_vblank_put(dev, vblank->pipe);
+		work->pending += kthread_queue_work(vblank->worker,
+						    &work->base);
+		if (rescheduling) {
+			list_del_init(&work->node);
+			work->pending--;
+		}
+	} else if (rescheduling) {
+		list_move_tail(&work->node, &vblank->pending_work);
+	} else {
+		list_add_tail(&work->node, &vblank->pending_work);
+		work->pending++;
+	}
+
+ out:
+	spin_unlock_irqrestore(&vblank->work_lock, irqflags);
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
+ * On return @work is no longer guaraneed to be executing.
+ *
+ * Returns:
+ * %True if the work was cancelled before it started to execute, %false
+ * otherwise.
+ */
+bool drm_vblank_work_cancel_sync(struct drm_vblank_work *work)
+{
+	struct drm_vblank_crtc *vblank = work->vblank;
+	bool ret = false, cancelled, queued;
+
+	spin_lock_irq(&vblank->work_lock);
+
+	if (!list_empty(&work->node)) {
+		list_del_init(&work->node);
+		drm_vblank_put(vblank->dev, vblank->pipe);
+		work->pending--;
+		ret = true;
+	}
+
+	queued = work->pending;
+	if (queued)
+		work->cancelling++;
+	spin_unlock_irq(&vblank->work_lock);
+
+	if (!queued)
+		return false;
+
+	cancelled = kthread_cancel_work_sync(&work->base);
+
+	spin_lock_irq(&vblank->work_lock);
+	if (cancelled) {
+		ret = true;
+		work->pending--;
+	}
+
+	write_seqcount_invalidate(&work->seqcount);
+	wake_up_all(&vblank->work_wait_queue);
+
+	work->cancelling--;
+	drm_WARN_ON_ONCE(vblank->dev, work->pending);
+	spin_unlock_irq(&vblank->work_lock);
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
+	unsigned int seq;
+
+	seq = read_seqcount_begin(&work->seqcount);
+	if (!work->pending)
+		return;
+
+	/* Once the sequence counter has changed, our work instance has
+	 * finished
+	 */
+	wait_event(vblank->work_wait_queue,
+		   read_seqcount_retry(&work->seqcount, seq));
+}
+EXPORT_SYMBOL(drm_vblank_work_flush);
diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
index dd9f5b9e56e4e..b1cd6ee9f5b65 100644
--- a/include/drm/drm_vblank.h
+++ b/include/drm/drm_vblank.h
@@ -27,6 +27,7 @@
 #include <linux/seqlock.h>
 #include <linux/idr.h>
 #include <linux/poll.h>
+#include <linux/kthread.h>
 
 #include <drm/drm_file.h>
 #include <drm/drm_modes.h>
@@ -203,8 +204,56 @@ struct drm_vblank_crtc {
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
+	 * @work_lock: The spinlock that protects @pending_work, along with
+	 * any modifications to &drm_vblank_work items
+	 */
+	spinlock_t work_lock;
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
 
+struct drm_vblank_work {
+	struct kthread_work base;
+	void (*func)(struct drm_vblank_work *work);
+	struct drm_vblank_crtc *vblank;
+	u64 count;
+
+	int cancelling; /* The number of cancelling calls currently running */
+	u8 pending; /* How many instances of this work item are pending */
+
+	/* Updated every time this work item finishes executing or is
+	 * cancelled.
+	 */
+	seqcount_t seqcount;
+
+	struct list_head node;
+};
+
+int drm_vblank_work_schedule(struct drm_vblank_work *work,
+			     u64 count, bool nextonmiss);
+void drm_vblank_work_init(struct drm_vblank_work *work, struct drm_crtc *crtc,
+			  void (*func)(struct drm_vblank_work *work));
+bool drm_vblank_work_cancel_sync(struct drm_vblank_work *work);
+void drm_vblank_work_flush(struct drm_vblank_work *work);
+
 int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs);
 bool drm_dev_has_vblank(const struct drm_device *dev);
 u64 drm_crtc_vblank_count(struct drm_crtc *crtc);
-- 
2.26.2

