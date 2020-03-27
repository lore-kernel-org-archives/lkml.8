Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9514C2D0F2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD56C20838
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DtamsBkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgC0Wv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:51:28 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:34720 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgC0WvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:51:25 -0400
Received: by mail-pg1-f201.google.com with SMTP id 12so9175255pgv.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 15:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5xyZLq6kEBxznhgqIwr0OhxZhHlqJjOXii0nwjMRAug=;
        b=DtamsBkgzkP7B1XBVLdKndq6+3upxZDAmgGKmti+fqXF+VX6Bu+IrZnVN97mheuQqg
         0K5q84r6w3VZ8YMHETx15fcjD+zhEdyOul3AaBuatOhx4eHWhUMZeBr8vzY38L/H1/B2
         n7Q9bf6gcGJFgJeFMnO421VIcqSOfuKKUu4WuumN1lVsbumfYYIr775nAlhBgLKzVceb
         xwA1lcqG/f9Oj5UMeOxa59jS4DiZ/OUJOlU943HJOxg3B30kR4uOy3SBgLHsLPtRRcZ6
         Cr85CorHtVhTXxOq47DJaR2BDuwUIMt8fKb7GpKpz1KZsavqmlgWo6EIi5RuOAyztOJI
         Vx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5xyZLq6kEBxznhgqIwr0OhxZhHlqJjOXii0nwjMRAug=;
        b=PYha6oRtajDr3FO+NkXyhbPu72MUm5FOLBuTqcHFpza228REbGHKxYqz2PwpxHGUMz
         H5XEW0bV6jE82vnmwnlR4//guG0PyJzkEV4joGJkmzDoOhdmAFYiYfI0xptwzjNk2mzo
         ATBUKG1OqecO6JGywQF5yBdxhQWj5Qc6THThx0v+Xmp8nrmAYo7AIg+yZtDvI3UnoXmQ
         7QtUi4nEoyvnWuImxyf/moPzqEX9PU1rMzFMiB/kuUMndQz1327q+ERu35zx8g1piliZ
         x8NQ0/eXPf30WNI54GFCTXMucNmhyJtfQLXfBalA9G7a10sTZ31LsUWtfD7iEqBcAWGt
         dIOw==
X-Gm-Message-State: ANhLgQ2Tb5maBSYew0yH7qT/Zyfh25An0uEW14JOSi4rL384V77o1Qhi
        oALNTY8IlR3kFeRKXzfq6EuvC+bUWp4=
X-Google-Smtp-Source: ADFU+vvTlAXhjp0EkSEWUvLEfpeO7L9FHvOCSALv4WBxIJwVLD9O2V2Nbds1LDlVgla0NKApequRttEkV2M=
X-Received: by 2002:a63:2166:: with SMTP id s38mr1524435pgm.83.1585349482143;
 Fri, 27 Mar 2020 15:51:22 -0700 (PDT)
Date:   Fri, 27 Mar 2020 15:50:59 -0700
In-Reply-To: <20200327225102.25061-1-walken@google.com>
Message-Id: <20200327225102.25061-8-walken@google.com>
Mime-Version: 1.0
References: <20200327225102.25061-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v3 07/10] mmap locking API: add mmap_read_release() and mmap_read_unlock_non_owner()
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
        Jason Gunthorpe <jgg@ziepe.ca>,
        Markus Elfring <Markus.Elfring@web.de>,
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
index 36fb758401d6..a80cf9695514 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -62,4 +62,14 @@ static inline void mmap_read_unlock(struct mm_struct *mm)
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
 #endif /* _LINUX_MMAP_LOCK_H */
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
2.26.0.rc2.310.g2932bb562d-goog

