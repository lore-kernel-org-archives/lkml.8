Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45338C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F33224955
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccD4DIUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgEHUsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 16:48:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43875 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727856AbgEHUsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 16:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588970918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y3ztGSvpGSNklTeWYiWdNFt5RlfGyDcXrVhuIPQxxoU=;
        b=ccD4DIUWt1eUZNnR25gkQUvmHPHnKdMXfoDoF5KgO2P3SgMP7NJW075e9x5bnMI+DyQJw/
        YOb4/dp3QIH9X0LFtZwJ0T7sJ86P4Jena82sG++78hBIIH2o8WRtFk6oN1gNBHECkbh5/L
        7VXSqz+1A8f1FbAj3LnJS+d+B1gDAwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-1imByPr6OTqACWsgByTREQ-1; Fri, 08 May 2020 16:48:33 -0400
X-MC-Unique: 1imByPr6OTqACWsgByTREQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34EAF835B49;
        Fri,  8 May 2020 20:48:31 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-118-29.rdu2.redhat.com [10.10.118.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1054A5D9CA;
        Fri,  8 May 2020 20:48:26 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Liang Chen <cl@rock-chips.com>
Subject: [RFC v4 01/12] kthread: Add kthread_queue_flush_work()
Date:   Fri,  8 May 2020 16:46:51 -0400
Message-Id: <20200508204751.155488-2-lyude@redhat.com>
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

Currently, it's only possible to flush on a kthread_work in contexts
where it's possible to block. This can be kind of painful though when
trying to implement new types of delayed work which use kthread_work,
since it means we'd need to drop any spinlocks for new delayed work
implementations before we can actually call kthread_flush_work().

In the time between dropping locks and calling kthread_flush_work(), the
work might have already executed once and have gotten re-queued by the
time we're ready. This would mean that once the user finally executes
kthread_flush_work(), we'd accidentally wait for someone else's queued
work instead of our own.

For DRM vblank works it's preferable that we just return immediately
during such races, instead of blocking on the re-queue. Additionally, we
also want to be able to use kthread_flush_work structs in our own
contexts so that we can block until a vblank work's target vblank has
passed, _and_ said work has executed once since. And finally, we also
want to be able to finish flushing on a work early if it's been
cancelled at any point (e.g. before or after it's actually been queued
on the kthread_worker).

So, let's make all of these things possible by exposing struct
kthread_flush_work, and then splitting kthread_flush_work() into two
functions: kthread_queue_flush_work(); which handles possibly queuing up
the kthread_flush_work on the work's respective kthread_worker, and
kthread_flush_work(); which performs a simple synchronous flush just
like before. We also add a DEFINE_KTHREAD_FLUSH_WORK() macro, which
simply initializes a kthread_flush_work struct inline (I can't see
anyone needing to use a kthread_flush_work that gets used outside of the
scope of a single function, and that seems like it would be a bit
overkill anyway).

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Tejun Heo <tj@kernel.org>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 include/linux/kthread.h | 16 ++++++++
 kernel/kthread.c        | 87 ++++++++++++++++++++++++++---------------
 2 files changed, 71 insertions(+), 32 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 8bbcaad7ef0f..0006540ce7f9 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -105,6 +105,11 @@ struct kthread_delayed_work {
 	struct timer_list timer;
 };
 
+struct kthread_flush_work {
+	struct kthread_work	work;
+	struct completion	done;
+};
+
 #define KTHREAD_WORKER_INIT(worker)	{				\
 	.lock = __RAW_SPIN_LOCK_UNLOCKED((worker).lock),		\
 	.work_list = LIST_HEAD_INIT((worker).work_list),		\
@@ -122,6 +127,11 @@ struct kthread_delayed_work {
 				     TIMER_IRQSAFE),			\
 	}
 
+#define KTHREAD_FLUSH_WORK_INIT(fwork) { \
+	KTHREAD_WORK_INIT((fwork).work, __kthread_flush_work_fn), \
+	COMPLETION_INITIALIZER_ONSTACK((fwork).done), \
+	}
+
 #define DEFINE_KTHREAD_WORKER(worker)					\
 	struct kthread_worker worker = KTHREAD_WORKER_INIT(worker)
 
@@ -132,6 +142,9 @@ struct kthread_delayed_work {
 	struct kthread_delayed_work dwork =				\
 		KTHREAD_DELAYED_WORK_INIT(dwork, fn)
 
+#define DEFINE_KTHREAD_FLUSH_WORK(fwork) \
+	struct kthread_flush_work fwork = KTHREAD_FLUSH_WORK_INIT(fwork);
+
 /*
  * kthread_worker.lock needs its own lockdep class key when defined on
  * stack with lockdep enabled.  Use the following macros in such cases.
@@ -190,6 +203,9 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
 			      struct kthread_delayed_work *dwork,
 			      unsigned long delay);
 
+bool kthread_queue_flush_work(struct kthread_work *work,
+			      struct kthread_flush_work *fwork);
+void __kthread_flush_work_fn(struct kthread_work *work);
 void kthread_flush_work(struct kthread_work *work);
 void kthread_flush_worker(struct kthread_worker *worker);
 
diff --git a/kernel/kthread.c b/kernel/kthread.c
index bfbfa481be3a..c1f8ec9d5836 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -943,52 +943,78 @@ bool kthread_queue_delayed_work(struct kthread_worker *worker,
 }
 EXPORT_SYMBOL_GPL(kthread_queue_delayed_work);
 
-struct kthread_flush_work {
-	struct kthread_work	work;
-	struct completion	done;
-};
-
-static void kthread_flush_work_fn(struct kthread_work *work)
-{
-	struct kthread_flush_work *fwork =
-		container_of(work, struct kthread_flush_work, work);
-	complete(&fwork->done);
-}
-
 /**
- * kthread_flush_work - flush a kthread_work
- * @work: work to flush
+ * kthread_queue_flush_work - try queuing a kthread_flush_work after a
+ * queued kthread_work to synchronize with later.
+ * @work: The &kthread_work to synchronize with later
+ * @fwork: The &kthread_flush_work to queue
+ *
+ * When working with &kthread_work structs in contexts where sleeping isn't
+ * possible it may be desirable to synchronize with a &kthread_work that's
+ * currently queued, but only after we've entered a context where it's safe to
+ * sleep again, and while making sure we don't block on any later re-queues of
+ * the work.
+ *
+ * If @work is queued or executing when kthread_queue_flush_work() is called,
+ * @fwork will be scheduled for execution immediately after @work. The caller
+ * can then later synchronize on @fwork.done, which will complete once @work
+ * has executed once or been cancelled since kthread_queue_flush_work() was
+ * called.
+ *
+ * Returns: %true% if @fwork was queued,and the caller needs to call
+ * wait_for_completion() on @fwork.done to finish synchronizing, %false%
+ * otherwise.
  *
- * If @work is queued or executing, wait for it to finish execution.
  */
-void kthread_flush_work(struct kthread_work *work)
+bool kthread_queue_flush_work(struct kthread_work *work,
+			      struct kthread_flush_work *fwork)
 {
-	struct kthread_flush_work fwork = {
-		KTHREAD_WORK_INIT(fwork.work, kthread_flush_work_fn),
-		COMPLETION_INITIALIZER_ONSTACK(fwork.done),
-	};
 	struct kthread_worker *worker;
-	bool noop = false;
+	unsigned long flags;
+	bool queued = true;
 
 	worker = work->worker;
 	if (!worker)
-		return;
+		return false;
 
-	raw_spin_lock_irq(&worker->lock);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 	/* Work must not be used with >1 worker, see kthread_queue_work(). */
 	WARN_ON_ONCE(work->worker != worker);
 
 	if (!list_empty(&work->node))
-		kthread_insert_work(worker, &fwork.work, work->node.next);
+		kthread_insert_work(worker, &fwork->work, work->node.next);
 	else if (worker->current_work == work)
-		kthread_insert_work(worker, &fwork.work,
+		kthread_insert_work(worker, &fwork->work,
 				    worker->work_list.next);
 	else
-		noop = true;
+		queued = false;
 
-	raw_spin_unlock_irq(&worker->lock);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
+	return queued;
+}
+EXPORT_SYMBOL_GPL(kthread_queue_flush_work);
+
+void __kthread_flush_work_fn(struct kthread_work *work)
+{
+	struct kthread_flush_work *fwork =
+		container_of(work, struct kthread_flush_work, work);
+	complete(&fwork->done);
+}
+EXPORT_SYMBOL_GPL(__kthread_flush_work_fn);
+
+/**
+ * kthread_flush_work - flush a kthread_work
+ * @work: work to flush
+ *
+ * If @work is queued or executing, wait for it to finish execution.
+ */
+void kthread_flush_work(struct kthread_work *work)
+{
+	bool queued;
+	DEFINE_KTHREAD_FLUSH_WORK(fwork);
 
-	if (!noop)
+	queued = kthread_queue_flush_work(work, &fwork);
+	if (queued)
 		wait_for_completion(&fwork.done);
 }
 EXPORT_SYMBOL_GPL(kthread_flush_work);
@@ -1170,10 +1196,7 @@ EXPORT_SYMBOL_GPL(kthread_cancel_delayed_work_sync);
  */
 void kthread_flush_worker(struct kthread_worker *worker)
 {
-	struct kthread_flush_work fwork = {
-		KTHREAD_WORK_INIT(fwork.work, kthread_flush_work_fn),
-		COMPLETION_INITIALIZER_ONSTACK(fwork.done),
-	};
+	DEFINE_KTHREAD_FLUSH_WORK(fwork);
 
 	kthread_queue_work(worker, &fwork.work);
 	wait_for_completion(&fwork.done);
-- 
2.25.4

