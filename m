Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE91C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CF3207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n+aTmufP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgCZHC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:02:58 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:39976 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbgCZHCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:02:55 -0400
Received: by mail-pj1-f73.google.com with SMTP id d10so3599071pjz.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 00:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DpjYosebPVpuPQwYrgnmEYhswUaFUaz4jId1cdbBdEg=;
        b=n+aTmufP6JMctYFU46YmDT0hJMNBwCoGeQ2H4e1Y87B+NthqtKUlorXmg3J9jwPZSs
         Ypc/TZCr5rq/49yZbePRrlndFCIHAsT0y3visA2ncO3JloeeHZaGM01yv7oqY2ZnAs87
         uL1BKaOmjXgdyE3bFI339A3v0yGXMoP218gWE4JgTrwJc41oZfto4Pnj8LAnHyva7OWM
         jZm9JOA6/9wn6Rzab1gJcMc4UqT3i1tgXmqv6eVUEk8xArcYCSESF3U3JaqArLXTx1po
         0YYgzzgL+7zDLiLPiXFd+vBdrYPNNlZiDk/eU8OlSBcdxgiAhT7kUSOIPX9kgZ+F4yNX
         +9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DpjYosebPVpuPQwYrgnmEYhswUaFUaz4jId1cdbBdEg=;
        b=fMqvvapnk61DCtWswnarGxa/b8ScH+tgWQrJ69Bme38bJt1fsur/Z+NWv9yJJqWuzs
         HYVLhBHmIFGhbIEcFEdtE3WXJa6/M6RpqcXhWN5Og1FN1UlahCx/HC/VUdxxSlmnvRqN
         DUDfw6Hu/otpBV/OS9o2nvdrfHj7Aj2/ScIeuhFHBXc1HSy5vsVTEaOZkcvXLHReMcGP
         GEarxkW8omA1n9NbIGB5XWQW7phxaT6sbSIZ6ikJ2TTgjBrvZzi+/0EQr+REw+bJ5ewc
         3KsDwY5qpSM1cQKULlNJCE0oMW/Y+U+1LCJ1wZS9kBAfaVFI+fX5JbB4xM+93ZM/xRIW
         +ukg==
X-Gm-Message-State: ANhLgQ0AREgiMwvCyYwmL7krq7EScLGBpwZcQ3EkrSDapUw2YFPZ+66V
        A6eS+WqyrgTz8Ga7U/YZ46noZOr9d/I=
X-Google-Smtp-Source: ADFU+vsBGhjPN1+jWZAin0MSjTA//3xgFIkfN//a4ht+5wmtVuoYamcyNWXv7PgVPkU7CJSVWKZzA7QUhb0=
X-Received: by 2002:a17:90a:4809:: with SMTP id a9mr1536611pjh.73.1585206173836;
 Thu, 26 Mar 2020 00:02:53 -0700 (PDT)
Date:   Thu, 26 Mar 2020 00:02:34 -0700
In-Reply-To: <20200326070236.235835-1-walken@google.com>
Message-Id: <20200326070236.235835-7-walken@google.com>
Mime-Version: 1.0
References: <20200326070236.235835-1-walken@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH 6/8] mmap locking API: add mmap_read_release() and mmap_read_unlock_non_owner()
From:   Michel Lespinasse <walken@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Michel Lespinasse <walken@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a couple APIs to allow splitting mmap_read_unlock() into two calls:
- mmap_read_release(), called by the task that had taken the mmap lock;
- mmap_read_unlock_non_owner(), called from a work queue.

These apis are used by kernel/bpf/stackmap.c only.

Signed-off-by: Michel Lespinasse <walken@google.com>
---
 include/linux/mmap_lock.h | 10 ++++++++++
 kernel/bpf/stackmap.c     |  9 ++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 40a972a26857..00d6cc02581d 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -62,6 +62,16 @@ static inline void mmap_read_unlock(struct mm_struct *mm)
 	up_read(&mm->mmap_sem);
 }
 
+static inline void mmap_read_release(struct mm_struct *mm, unsigned long ip)
+{
+	rwsem_release(&mm->mmap_sem.dep_map, ip);
+}
+
+static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
+{
+	up_read_non_owner(&mm->mmap_sem);
+}
+
 static inline bool mmap_is_locked(struct mm_struct *mm)
 {
 	return rwsem_is_locked(&mm->mmap_sem) != 0;
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index f2115f691577..413b512a99eb 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -33,7 +33,7 @@ struct bpf_stack_map {
 /* irq_work to run up_read() for build_id lookup in nmi context */
 struct stack_map_irq_work {
 	struct irq_work irq_work;
-	struct rw_semaphore *sem;
+	struct mm_struct *mm;
 };
 
 static void do_up_read(struct irq_work *entry)
@@ -41,8 +41,7 @@ static void do_up_read(struct irq_work *entry)
 	struct stack_map_irq_work *work;
 
 	work = container_of(entry, struct stack_map_irq_work, irq_work);
-	up_read_non_owner(work->sem);
-	work->sem = NULL;
+	mmap_read_unlock_non_owner(work->mm);
 }
 
 static DEFINE_PER_CPU(struct stack_map_irq_work, up_read_work);
@@ -332,14 +331,14 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 	if (!work) {
 		mmap_read_unlock(current->mm);
 	} else {
-		work->sem = &current->mm->mmap_sem;
+		work->mm = current->mm;
 		irq_work_queue(&work->irq_work);
 		/*
 		 * The irq_work will release the mmap_sem with
 		 * up_read_non_owner(). The rwsem_release() is called
 		 * here to release the lock from lockdep's perspective.
 		 */
-		rwsem_release(&current->mm->mmap_sem.dep_map, _RET_IP_);
+		mmap_read_release(current->mm, _RET_IP_);
 	}
 }
 
-- 
2.25.1.696.g5e7596f4ac-goog

