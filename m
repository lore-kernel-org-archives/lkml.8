Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D9BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C27A2076A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/dwkiAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgGPTbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 15:31:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38622 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729666AbgGPTbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 15:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594927865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=qxETwBdUi8IQyqE8w1AoWdSu7aZcWlS4JLpVKb6zYWo=;
        b=a/dwkiApbunypCpNgoi4q+rTpnwfhP/cP0zj/vC9890cl27KPcEsQpENr/IXjjezahL8iB
        ZgJ9gM1PZg8tbllNYRzBbU0S3HSB8F6CS8LDXxOvqEoP5s9WoBj+Z5/KuYwJTNEdm2IRkL
        DOsEBy61XCO45GLgColJDV6N8Y2iyOw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-OELazEwUNeGx2Fv-Vvd_RQ-1; Thu, 16 Jul 2020 15:31:01 -0400
X-MC-Unique: OELazEwUNeGx2Fv-Vvd_RQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 692C615C2B;
        Thu, 16 Jul 2020 19:30:59 +0000 (UTC)
Received: from llong.com (ovpn-119-61.rdu2.redhat.com [10.10.119.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5439974F70;
        Thu, 16 Jul 2020 19:30:58 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 5/5] locking/qrwlock: Make qrwlock store writer cpu number
Date:   Thu, 16 Jul 2020 15:29:27 -0400
Message-Id: <20200716192927.12944-6-longman@redhat.com>
In-Reply-To: <20200716192927.12944-1-longman@redhat.com>
References: <20200716192927.12944-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the qrwlock code to store an encoded cpu number (+1 saturated)
for the writer that hold the write lock if desired.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/asm-generic/qrwlock.h | 12 +++++++++++-
 kernel/locking/qrwlock.c      | 11 ++++++-----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 3aefde23dcea..1b1d5253e314 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -15,11 +15,21 @@
 
 #include <asm-generic/qrwlock_types.h>
 
+/*
+ * If __cpu_number_sadd1 (+2 saturated cpu number) is defined, use it as the
+ * writer lock value.
+ */
+#ifdef __cpu_number_sadd1
+#define _QW_LOCKED	__cpu_number_sadd1
+#else
+#define _QW_LOCKED	0xff
+#endif
+
 /*
  * Writer states & reader shift and bias.
  */
 #define	_QW_WAITING	0x100		/* A writer is waiting	   */
-#define	_QW_LOCKED	0x0ff		/* A writer holds the lock */
+#define	_QW_LMASK	0x0ff		/* A writer lock byte mask */
 #define	_QW_WMASK	0x1ff		/* Writer mask		   */
 #define	_QR_SHIFT	9		/* Reader count shift	   */
 #define _QR_BIAS	(1U << _QR_SHIFT)
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index fe9ca92faa2a..394f34db4b8f 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -30,7 +30,7 @@ void queued_read_lock_slowpath(struct qrwlock *lock)
 		 * so spin with ACQUIRE semantics until the lock is available
 		 * without waiting in the queue.
 		 */
-		atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
+		atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LMASK));
 		return;
 	}
 	atomic_sub(_QR_BIAS, &lock->cnts);
@@ -46,7 +46,7 @@ void queued_read_lock_slowpath(struct qrwlock *lock)
 	 * that accesses can't leak upwards out of our subsequent critical
 	 * section in the case that the lock is currently held for write.
 	 */
-	atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
+	atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LMASK));
 
 	/*
 	 * Signal the next one in queue to become queue head
@@ -61,12 +61,14 @@ EXPORT_SYMBOL(queued_read_lock_slowpath);
  */
 void queued_write_lock_slowpath(struct qrwlock *lock)
 {
+	const u8 lockval = _QW_LOCKED;
+
 	/* Put the writer into the wait queue */
 	arch_spin_lock(&lock->wait_lock);
 
 	/* Try to acquire the lock directly if no reader is present */
 	if (!atomic_read(&lock->cnts) &&
-	    (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED) == 0))
+	    (atomic_cmpxchg_acquire(&lock->cnts, 0, lockval) == 0))
 		goto unlock;
 
 	/* Set the waiting flag to notify readers that a writer is pending */
@@ -75,8 +77,7 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 	/* When no more readers or writers, set the locked flag */
 	do {
 		atomic_cond_read_acquire(&lock->cnts, VAL == _QW_WAITING);
-	} while (atomic_cmpxchg_relaxed(&lock->cnts, _QW_WAITING,
-					_QW_LOCKED) != _QW_WAITING);
+	} while (atomic_cmpxchg_relaxed(&lock->cnts, _QW_WAITING, lockval) != _QW_WAITING);
 unlock:
 	arch_spin_unlock(&lock->wait_lock);
 }
-- 
2.18.1

