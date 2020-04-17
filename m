Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E89DC38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05D8420715
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLnmOUmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbgDQTmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:42:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47500 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730709AbgDQTmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587152555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HQHNAYRwAh0SATyuoWLet2QKkrhrh3yzPiTWdLmXyM0=;
        b=JLnmOUmAh5N2uc4YSCjfGrkPY9dz2axUtctlLoadi6xDUhRKE64eS/7SNCP/pq6s532PKy
        VUq2pZUUyOs/fFZDGJ0MXw+w6EUC/4FUOZwMAwCPtmDnLYDj5yt5r7OjI8fbVUjU+Ln6MC
        AaoNiapQaXm04JkhDmBFGw1+sA3gGW4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-5t1BYcikMBKA7uZfFgtXjg-1; Fri, 17 Apr 2020 15:42:31 -0400
X-MC-Unique: 5t1BYcikMBKA7uZfFgtXjg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3F0E1926DA0;
        Fri, 17 Apr 2020 19:42:29 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-114-140.rdu2.redhat.com [10.10.114.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4E5E5D9CA;
        Fri, 17 Apr 2020 19:42:28 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Tejun Heo <tj@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: [RFC v3 03/11] drm/vblank: Add vblank works
Date:   Fri, 17 Apr 2020 15:40:50 -0400
Message-Id: <20200417194145.36350-4-lyude@redhat.com>
In-Reply-To: <20200417194145.36350-1-lyude@redhat.com>
References: <20200417194145.36350-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
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

[based off patches from Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.inte=
l.com>,
change below to signoff later]

Changes since v2:
* Use kthread_workers instead of reinventing the wheel.

Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_vblank.c | 296 ++++++++++++++++++++++++++++++++++-
 include/drm/drm_vblank.h     |  31 ++++
 2 files changed, 326 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index bf8de10c131f..ed0ae3d78b69 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -25,7 +25,9 @@
  */
=20
 #include <linux/export.h>
+#include <linux/kthread.h>
 #include <linux/moduleparam.h>
+#include <uapi/linux/sched/types.h>
=20
 #include <drm/drm_crtc.h>
 #include <drm/drm_drv.h>
@@ -155,6 +157,7 @@
 static bool
 drm_get_last_vbltimestamp(struct drm_device *dev, unsigned int pipe,
 			  ktime_t *tvblank, bool in_vblank_irq);
+static int drm_vblank_get(struct drm_device *dev, unsigned int pipe);
=20
 static unsigned int drm_timestamp_precision =3D 20;  /* Default to 20 us=
ecs. */
=20
@@ -496,9 +499,49 @@ static void drm_vblank_init_release(struct drm_devic=
e *dev, void *ptr)
 	WARN_ON(READ_ONCE(vblank->enabled) &&
 		drm_core_check_feature(dev, DRIVER_MODESET));
=20
+	kthread_destroy_worker(vblank->worker);
 	del_timer_sync(&vblank->disable_timer);
 }
=20
+/**
+ * drm_vblank_work_init - initialize a vblank work item
+ * @work: vblank work item
+ * @crtc: CRTC whose vblank will trigger the work execution
+ * @func: work function to be executed
+ *
+ * Initialize a vblank work item for a specific crtc.
+ */
+void drm_vblank_work_init(struct drm_vblank_work *work, struct drm_crtc =
*crtc,
+			  void (*func)(struct kthread_work *work))
+{
+	kthread_init_work(&work->base, func);
+	INIT_LIST_HEAD(&work->flushers);
+	INIT_LIST_HEAD(&work->pending);
+	work->vblank =3D &crtc->dev->vblank[drm_crtc_index(crtc)];
+}
+EXPORT_SYMBOL(drm_vblank_work_init);
+
+static int vblank_worker_init(struct drm_vblank_crtc *vblank)
+{
+	struct sched_param param =3D {
+		.sched_priority =3D MAX_RT_PRIO - 1,
+	};
+	int ret;
+
+	INIT_LIST_HEAD(&vblank->pending_work);
+	vblank->worker =3D kthread_create_worker(0, "card%d-crtc%d",
+					       vblank->dev->primary->index,
+					       vblank->pipe);
+	if (IS_ERR(vblank->worker))
+		return PTR_ERR(vblank->worker);
+
+	ret =3D sched_setscheduler(vblank->worker->task, SCHED_FIFO, &param);
+	if (ret < 0)
+		kthread_destroy_worker(vblank->worker);
+
+	return ret;
+}
+
 /**
  * drm_vblank_init - initialize vblank support
  * @dev: DRM device
@@ -534,11 +577,17 @@ int drm_vblank_init(struct drm_device *dev, unsigne=
d int num_crtcs)
 		timer_setup(&vblank->disable_timer, vblank_disable_fn, 0);
 		seqlock_init(&vblank->seqlock);
=20
-		ret =3D drmm_add_action(dev, drm_vblank_init_release, vblank);
+		ret =3D vblank_worker_init(vblank);
 		if (ret) {
 			del_timer_sync(&vblank->disable_timer);
 			return ret;
 		}
+
+		ret =3D drmm_add_action(dev, drm_vblank_init_release, vblank);
+		if (ret) {
+			drm_vblank_init_release(dev, vblank);
+			return ret;
+		}
 	}
=20
 	DRM_INFO("Supports vblank timestamp caching Rev 2 (21.10.2013).\n");
@@ -1879,6 +1928,48 @@ static void drm_handle_vblank_events(struct drm_de=
vice *dev, unsigned int pipe)
 	trace_drm_vblank_event(pipe, seq, now, high_prec);
 }
=20
+struct drm_vblank_flush_work {
+	struct kthread_work base;
+	struct completion done;
+};
+
+/* Add a vblank work along with any pending flushes to the kthread_worke=
r */
+static void queue_vblank_work(struct drm_vblank_crtc *vblank,
+			      struct drm_vblank_work *work)
+{
+	struct drm_vblank_flush_work *pos, *tmp;
+
+	__kthread_queue_work(vblank->worker, &work->base,
+			     &vblank->worker->work_list);
+
+	list_for_each_entry_safe(pos, tmp, &work->flushers, base.node) {
+		list_del_init(&work->base.node);
+		__kthread_queue_work(vblank->worker, &pos->base,
+				     work->base.node.next);
+	}
+}
+
+static inline void drm_handle_vblank_works(struct drm_vblank_crtc *vblan=
k)
+{
+	struct drm_vblank_work *work, *next;
+	u64 count =3D atomic64_read(&vblank->count);
+	int put_count =3D 0, i;
+
+	raw_spin_lock(&vblank->worker->lock);
+	list_for_each_entry_safe(work, next, &vblank->pending_work, pending) {
+		if (!vblank_passed(count, work->count))
+			continue;
+
+		put_count++;
+		list_del_init(&work->pending);
+		queue_vblank_work(vblank, work);
+	}
+	raw_spin_unlock(&vblank->worker->lock);
+
+	for (i =3D 0; i < put_count; i++)
+		drm_vblank_put(vblank->dev, vblank->pipe);
+}
+
 /**
  * drm_handle_vblank - handle a vblank event
  * @dev: DRM device
@@ -1920,6 +2011,7 @@ bool drm_handle_vblank(struct drm_device *dev, unsi=
gned int pipe)
=20
 	spin_unlock(&dev->vblank_time_lock);
=20
+	drm_handle_vblank_works(vblank);
 	wake_up(&vblank->queue);
=20
 	/* With instant-off, we defer disabling the interrupt until after
@@ -2130,3 +2222,205 @@ int drm_crtc_queue_sequence_ioctl(struct drm_devi=
ce *dev, void *data,
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
+ * Schedule @work for execution once the crtc vblank count reaches @coun=
t.
+ *
+ * If the crtc vblank count has already reached @count and @nextonmiss i=
s
+ * %false the work starts to execute immediately.
+ *
+ * If the crtc vblank count has already reached @count and @nextonmiss i=
s
+ * %true the work is deferred until the next vblank (as if @count has be=
en
+ * specified as crtc vblank count + 1).
+ *
+ * If @work is already scheduled, this function will reschedule said wor=
k
+ * using the new @count.
+ *
+ * Returns:
+ * 0 on success, error code on failure.
+ */
+int drm_vblank_work_schedule(struct drm_vblank_work *work,
+			     u64 count, bool nextonmiss)
+{
+	struct drm_vblank_crtc *vblank =3D work->vblank;
+	struct drm_device *dev =3D vblank->dev;
+	u64 cur_vbl;
+	unsigned long irqflags;
+	bool passed, rescheduling =3D false;
+	int ret =3D 0;
+
+	/* Grab our vblank ref early, since that grabs spinlocks */
+	ret =3D drm_vblank_get(dev, vblank->pipe);
+	if (ret < 0)
+		return ret;
+
+	raw_spin_lock_irqsave(&vblank->worker->lock, irqflags);
+
+	if (work->base.canceling)
+		goto out;
+
+	if (list_empty(&work->pending))
+		atomic_inc(&vblank->refcount);
+	else if (work->count =3D=3D count) /* Already scheduled w/ same vbl cou=
nt */
+		goto out;
+	else
+		rescheduling =3D true;
+
+	work->count =3D count;
+	cur_vbl =3D atomic64_read(&vblank->count);
+	passed =3D vblank_passed(cur_vbl, count);
+	if (passed)
+		DRM_ERROR("crtc %d vblank %llu already passed (current %llu)\n",
+			  vblank->pipe, count, cur_vbl);
+
+	if (!nextonmiss && passed) {
+		atomic_dec(&vblank->refcount);
+		if (rescheduling)
+			list_del_init(&work->pending);
+		queue_vblank_work(vblank, work);
+	} else {
+		if (rescheduling)
+			list_move_tail(&work->pending, &vblank->pending_work);
+		else
+			list_add_tail(&work->pending, &vblank->pending_work);
+	}
+
+ out:
+	raw_spin_unlock_irqrestore(&vblank->worker->lock, irqflags);
+	drm_vblank_put(dev, vblank->pipe);
+
+	return ret;
+}
+EXPORT_SYMBOL(drm_vblank_work_schedule);
+
+static bool vblank_work_cancel(struct drm_vblank_work *work)
+{
+	struct drm_vblank_flush_work *pos, *tmp;
+
+	if (list_empty(&work->pending))
+		return false;
+
+	list_del_init(&work->pending);
+
+	list_for_each_entry_safe(pos, tmp, &work->flushers, base.node) {
+		list_del(&pos->base.node);
+		complete(&pos->done);
+	}
+
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
+ * True if the work was cancelled before it started to excute, false oth=
erwise.
+ */
+bool drm_vblank_work_cancel(struct drm_vblank_work *work)
+{
+	struct drm_vblank_crtc *vblank =3D work->vblank;
+	bool cancelled;
+
+	raw_spin_lock_irq(&vblank->worker->lock);
+	cancelled =3D vblank_work_cancel(work);
+	raw_spin_unlock_irq(&vblank->worker->lock);
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
+ * True if the work was cancelled before it started to excute, false
+ * otherwise.
+ */
+bool drm_vblank_work_cancel_sync(struct drm_vblank_work *work)
+{
+	struct drm_vblank_crtc *vblank =3D work->vblank;
+	bool queued, cancelled;
+
+	raw_spin_lock_irq(&vblank->worker->lock);
+	cancelled =3D vblank_work_cancel(work);
+	queued =3D !!work->base.worker;
+	if (queued)
+		work->base.canceling++;
+	raw_spin_unlock_irq(&vblank->worker->lock);
+
+	if (cancelled)
+		drm_vblank_put(vblank->dev, vblank->pipe);
+
+	if (queued) {
+		cancelled =3D kthread_cancel_work_sync(&work->base);
+		raw_spin_lock_irq(&vblank->worker->lock);
+		work->base.canceling--;
+		raw_spin_unlock_irq(&vblank->worker->lock);
+	}
+
+	return cancelled;
+}
+EXPORT_SYMBOL(drm_vblank_work_cancel_sync);
+
+static void drm_flush_vblank_work_fn(struct kthread_work *work)
+{
+	struct drm_vblank_flush_work *fwork =3D
+		container_of(work, struct drm_vblank_flush_work, base);
+
+	complete(&fwork->done);
+}
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
+	struct drm_vblank_crtc *vblank =3D work->vblank;
+	struct drm_vblank_flush_work fwork =3D {
+		KTHREAD_WORK_INIT(fwork.base, drm_flush_vblank_work_fn),
+		COMPLETION_INITIALIZER_ONSTACK(fwork.done),
+	};
+
+	raw_spin_lock_irq(&vblank->worker->lock);
+
+	if (!list_empty(&work->pending)) {
+		list_add_tail(&fwork.base.node, &work->flushers);
+	} else if (!list_empty(&work->base.node)) {
+		__kthread_queue_work(vblank->worker, &fwork.base,
+				     work->base.node.next);
+	} else if (vblank->worker->current_work =3D=3D &work->base) {
+		__kthread_queue_work(vblank->worker, &fwork.base,
+				     vblank->worker->work_list.next);
+	} else {
+		raw_spin_unlock_irq(&vblank->worker->lock);
+		return;
+	}
+
+	raw_spin_unlock_irq(&vblank->worker->lock);
+	wait_for_completion(&fwork.done);
+}
+EXPORT_SYMBOL(drm_vblank_work_flush);
diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
index dd9f5b9e56e4..03fc96a533bb 100644
--- a/include/drm/drm_vblank.h
+++ b/include/drm/drm_vblank.h
@@ -27,6 +27,7 @@
 #include <linux/seqlock.h>
 #include <linux/idr.h>
 #include <linux/poll.h>
+#include <linux/kthread.h>
=20
 #include <drm/drm_file.h>
 #include <drm/drm_modes.h>
@@ -203,8 +204,38 @@ struct drm_vblank_crtc {
 	 * disabling functions multiple times.
 	 */
 	bool enabled;
+
+	/**
+	 * @worker: The &kthread_worker used for executing vblank works.
+	 */
+	struct kthread_worker *worker;
+	/**
+	 * @pending_work: A list of scheduled &drm_vblank_work that are
+	 * waiting for a future vblank.
+	 */
+	struct list_head pending_work;
 };
=20
+struct drm_vblank_work {
+	struct kthread_work base;
+	struct drm_vblank_crtc *vblank;
+	u64 count;
+
+	struct list_head pending;
+	struct list_head flushers;
+};
+
+#define to_drm_vblank_work(_work) \
+	container_of((_work), struct drm_vblank_work, base)
+
+int drm_vblank_work_schedule(struct drm_vblank_work *work,
+			     u64 count, bool nextonmiss);
+void drm_vblank_work_init(struct drm_vblank_work *work, struct drm_crtc =
*crtc,
+			  void (*func)(struct kthread_work *work));
+bool drm_vblank_work_cancel(struct drm_vblank_work *work);
+bool drm_vblank_work_cancel_sync(struct drm_vblank_work *work);
+void drm_vblank_work_flush(struct drm_vblank_work *work);
+
 int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs);
 bool drm_dev_has_vblank(const struct drm_device *dev);
 u64 drm_crtc_vblank_count(struct drm_crtc *crtc);
--=20
2.25.1

