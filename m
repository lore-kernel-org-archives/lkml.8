Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF75C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA01E20715
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jw5EmA8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbgDQTmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:42:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36604 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730178AbgDQTme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587152552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tw6iakFOYLBCIQFxeQmRTj7YdAKorrHXZZ6y3q0wXB8=;
        b=Jw5EmA8ZuKiUbMBvzmltS8Iy/kxe6+A6qL3Xl2PMWwA8Hqf8C/LWcochUobh4O4lIBWusw
        g1MSP/geNPgkkzszEYzOE0MpggnW+xlL7OKVc2GeyC0oEmXMfjzS8gr/ivSAnDsi4jHQOV
        RDMcwdDDkNMfWxwErSboTusUtGcMPvo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-DdxAzQy7O0W857mAi20rxQ-1; Fri, 17 Apr 2020 15:42:30 -0400
X-MC-Unique: DdxAzQy7O0W857mAi20rxQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 561BC10CE784;
        Fri, 17 Apr 2020 19:42:28 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-114-140.rdu2.redhat.com [10.10.114.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CBC55DA7C;
        Fri, 17 Apr 2020 19:42:26 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liang Chen <cl@rock-chips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC v3 02/11] kthread: Introduce __kthread_queue_work()
Date:   Fri, 17 Apr 2020 15:40:49 -0400
Message-Id: <20200417194145.36350-3-lyude@redhat.com>
In-Reply-To: <20200417194145.36350-1-lyude@redhat.com>
References: <20200417194145.36350-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While kthread_queue_work() is fine for basic kthread_worker usecases,
it's a little limiting if you want to create your own delayed work
implementations that delay off things other than a clock. Looking at
kthread_delayed_works for instance, all of the code shares the lock in
kthread_work so that that both the timer_list and actual kthread_worker
can be inspected and modified together atomically.

Currently, we want to be able to implement a type of delayed
kthread_work in DRM that delays until a specific vblank sequence has
passed, which we refer to as a drm_vblank_work, as opposed to using a
simple time-based delay. Some of the requirements we have for this are
the ability to allow for rescheduling and flushing on drm_vblank_works,
which become a lot harder to do properly if we can't re-queue work under
lock. Additionally, being able to specify a custom position in the
kthread_worker's work_list (which requires being under lock) is
important to be able to do since it's needed for implementing a custom
work flushing mechanism that waits for both the vblank sequence and
kthread_worker to complete once.

So - let's expose an unlocked version of kthread_queue_work() called
__kthread_queue_work(), which also allows for specifying a custom list
position in which to insert the work before.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 include/linux/kthread.h |  3 +++
 kernel/kthread.c        | 34 ++++++++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 8bbcaad7ef0f..02e0c1c157bf 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -179,6 +179,9 @@ __printf(3, 4) struct kthread_worker *
 kthread_create_worker_on_cpu(int cpu, unsigned int flags,
 			     const char namefmt[], ...);
=20
+bool __kthread_queue_work(struct kthread_worker *worker,
+			  struct kthread_work *work,
+			  struct list_head *pos);
 bool kthread_queue_work(struct kthread_worker *worker,
 			struct kthread_work *work);
=20
diff --git a/kernel/kthread.c b/kernel/kthread.c
index bfbfa481be3a..46de56142593 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -816,6 +816,35 @@ static void kthread_insert_work(struct kthread_worke=
r *worker,
 		wake_up_process(worker->task);
 }
=20
+/**
+ * __kthread_queue_work - queue a kthread_work while under lock
+ * @worker: target kthread_worker
+ * @work: kthread_work to queue
+ * @pos: The position in @worker.work_list to insert @work before
+ *
+ * This is the same as kthread_queue_work(), except that it already expe=
cts
+ * the caller to be holding &kthread_worker.lock and allows for specifyi=
ng a
+ * custom position in @worker.work_list to insert @work before.
+ *
+ * This function is mostly useful for users which might need to create t=
heir
+ * own delayed kthread_worker implementations.
+ *
+ * Returns: %true if @work was successfully queued, %false if it was alr=
eady
+ * pending.
+ */
+bool __kthread_queue_work(struct kthread_worker *worker,
+			  struct kthread_work *work,
+			  struct list_head *pos)
+{
+	if (!queuing_blocked(worker, work)) {
+		kthread_insert_work(worker, work, pos);
+		return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(__kthread_queue_work);
+
 /**
  * kthread_queue_work - queue a kthread_work
  * @worker: target kthread_worker
@@ -835,10 +864,7 @@ bool kthread_queue_work(struct kthread_worker *worke=
r,
 	unsigned long flags;
=20
 	raw_spin_lock_irqsave(&worker->lock, flags);
-	if (!queuing_blocked(worker, work)) {
-		kthread_insert_work(worker, work, &worker->work_list);
-		ret =3D true;
-	}
+	ret =3D __kthread_queue_work(worker, work, &worker->work_list);
 	raw_spin_unlock_irqrestore(&worker->lock, flags);
 	return ret;
 }
--=20
2.25.1

