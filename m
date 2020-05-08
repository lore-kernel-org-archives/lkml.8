Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298FAC54E49
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0861D2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9qfvKHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgEHUsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 16:48:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35190 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727860AbgEHUsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 16:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588970919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QheNznjVPmakQiU+O7e0zvxyU/NmorAuqat6FWMl4Ds=;
        b=I9qfvKHxs7c5tVvVLitLQ15A56VtqWrrELkU2qLpkg7HXfifv4l0R+jEiaKj2ng0b7O1/A
        EIBAh9GRFyV1Okjfva5sxzS4oaiJW2HFolGPHWI24s9cEPeAIg0QHz6j1u1Zbz4HaTLiWv
        uncLVtPZViGsvowEKhWXc/dC8e1p27U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-u4tyqxqjM3mP7LzECjmJAg-1; Fri, 08 May 2020 16:48:36 -0400
X-MC-Unique: u4tyqxqjM3mP7LzECjmJAg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20B871005510;
        Fri,  8 May 2020 20:48:34 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-118-29.rdu2.redhat.com [10.10.118.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B942E5D9CA;
        Fri,  8 May 2020 20:48:32 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liang Chen <cl@rock-chips.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC v4 02/12] kthread: Add kthread_(un)block_work_queuing() and kthread_work_queuable()
Date:   Fri,  8 May 2020 16:46:52 -0400
Message-Id: <20200508204751.155488-3-lyude@redhat.com>
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

Add some simple wrappers around incrementing/decrementing
kthread_work.cancelling under lock, along with checking whether queuing
is currently allowed on a given kthread_work, which we'll use want to
implement work cancelling with DRM's vblank work helpers.

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Tejun Heo <tj@kernel.org>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 include/linux/kthread.h | 19 +++++++++++++++++
 kernel/kthread.c        | 46 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 0006540ce7f9..c6fee200fced 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -211,9 +211,28 @@ void kthread_flush_worker(struct kthread_worker *worker);
 
 bool kthread_cancel_work_sync(struct kthread_work *work);
 bool kthread_cancel_delayed_work_sync(struct kthread_delayed_work *work);
+void kthread_block_work_queuing(struct kthread_worker *worker,
+				struct kthread_work *work);
+void kthread_unblock_work_queuing(struct kthread_worker *worker,
+				  struct kthread_work *work);
 
 void kthread_destroy_worker(struct kthread_worker *worker);
 
+/**
+ * kthread_work_queuable - whether or not a kthread work can be queued
+ * @work: The kthread work to check
+ *
+ * Checks whether or not queuing @work is currently blocked from queuing,
+ * either by kthread_cancel_work_sync() and friends or
+ * kthread_block_work_queuing().
+ *
+ * Returns: whether or not the @work may be queued.
+ */
+static inline bool kthread_work_queuable(struct kthread_work *work)
+{
+	return READ_ONCE(work->canceling) == 0;
+}
+
 struct cgroup_subsys_state;
 
 #ifdef CONFIG_BLK_CGROUP
diff --git a/kernel/kthread.c b/kernel/kthread.c
index c1f8ec9d5836..f8a5c5a87cc6 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1187,6 +1187,52 @@ bool kthread_cancel_delayed_work_sync(struct kthread_delayed_work *dwork)
 }
 EXPORT_SYMBOL_GPL(kthread_cancel_delayed_work_sync);
 
+/**
+ * kthread_block_work_queuing - prevent a kthread_work from being queued
+ * without actually cancelling it
+ * @worker: kthread worker to use
+ * @work: work to block queuing on
+ *
+ * Prevents @work from being queued using kthread_queue_work() and friends,
+ * but doesn't attempt to cancel any previous queuing. The caller must unblock
+ * queuing later by calling kthread_unblock_work_queuing(). This call can be
+ * called multiple times.
+ *
+ * See also: kthread_work_queuable()
+ */
+void kthread_block_work_queuing(struct kthread_worker *worker,
+				struct kthread_work *work)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&worker->lock, flags);
+	work->canceling++;
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
+}
+EXPORT_SYMBOL_GPL(kthread_block_work_queuing);
+
+/**
+ * kthread_unblock_work_queuing - unblock queuing on a kthread_work
+ * @worker: kthread worker to use
+ * @work: work to unblock queuing on
+ *
+ * Removes a request to prevent @work from being queued with
+ * kthread_queue_work() and friends, so that it may potentially be queued
+ * again.
+ *
+ * See also: kthread_work_queuable()
+ */
+void kthread_unblock_work_queuing(struct kthread_worker *worker,
+				  struct kthread_work *work)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&worker->lock, flags);
+	WARN_ON_ONCE(--work->canceling < 0);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
+}
+EXPORT_SYMBOL_GPL(kthread_unblock_work_queuing);
+
 /**
  * kthread_flush_worker - flush all current works on a kthread_worker
  * @worker: worker to flush
-- 
2.25.4

