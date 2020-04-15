Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD5CC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A85402076C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j2mj8y6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634679AbgDOArJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2634609AbgDOAoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 20:44:13 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8923C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:44:13 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id i26so1398155pfk.20
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=W/v3+M/LWfOzs3/FZNGrbIM1gxpJLCv1N1Vd1+pldaA=;
        b=j2mj8y6mS6PkrzUFtRlLk6MSDpFJnBFHJMwSaTTAd3UOVKRe9MVLx0m54Z1gRUuyl0
         ixVszlruHE07ytSByL8p5M6+AvxWxNI14AdIkkHGqccSniAyFLzqwnPfP3QEhIbrlf0Y
         4kkTm5CeFhbBGoO2TRwi4Te5P0AQAxPg8EybmZsg+8D7AikDPHY9KDtORGy+4EI4PKkG
         RLGbepFP9xj0tTA4cGy2vpV8MqIIX6ezqX0p5paF/6e/0PTh0LxmAPCAxr3Ds3TUP+ab
         oez2T8VF8eln54Yog2Ec6E9nE5rGjrP0e4S4NDMXDrRmHtQOB0YJRSF3MSe6IwqzFgPU
         zIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=W/v3+M/LWfOzs3/FZNGrbIM1gxpJLCv1N1Vd1+pldaA=;
        b=VVBrZc+p8lX4cz1q2bAjDCkvz/Lb79v+pgxf7fyf8VPjAif5yroq+Sbmml0j2CpIBZ
         culvZ4NZjIbOKyZpGKmFdUez4zXkLy3uXrsaHdWYrK+4zFK8wY6fG8nSW2UJGJ8Cb08l
         7h8Bnd2Xx5yHS3rZv11LIGarwtWROSwzrI91PnFuXaDph3eezWGeQAvGpnOt65k1i5h9
         ao5UxjE5xkb3vNAnPO2lTxTuWc2otv2b69+Ixog4E+UI3fqKx1URKhyNaUOBDlEPcWj3
         7yRHITVT81p4iosDTy5KPGokfbyRkDunax1ffkx64CwbVPOUPZfh+zD/DJzI8T1PqImp
         hW5A==
X-Gm-Message-State: AGi0PuY7TZVLMv6l5SSZ9zNOLb142AvrTFjkKRPQYkS14RzOuDNU3TXd
        48Y/03LmE9XSEZzOjai2jHDPLg/5QqU=
X-Google-Smtp-Source: APiQypJAv6NRWZVPw+zLkQyYQ4PLNAZh/M8C8AdziwMW8P44l6wCvQkIrjiBt5eRFbVPbPRbtYA7nKmqq8k=
X-Received: by 2002:a17:90a:bb8d:: with SMTP id v13mr3232376pjr.150.1586911453265;
 Tue, 14 Apr 2020 17:44:13 -0700 (PDT)
Date:   Tue, 14 Apr 2020 17:43:50 -0700
In-Reply-To: <20200415004353.130248-1-walken@google.com>
Message-Id: <20200415004353.130248-8-walken@google.com>
Mime-Version: 1.0
References: <20200415004353.130248-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v4 07/10] mmap locking API: add mmap_read_trylock_non_owner()
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
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michel Lespinasse <walken@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a couple APIs used by kernel/bpf/stackmap.c only:
- mmap_read_trylock_non_owner()
- mmap_read_unlock_non_owner() (may be called from a work queue).

It's still not ideal that bpf/stackmap subverts the lock ownership
in this way. Thanks to Peter Zijlstra for suggesting this API as the
least-ugly way of addressing this in the short term.

Signed-off-by: Michel Lespinasse <walken@google.com>
---
 include/linux/mmap_lock.h | 14 ++++++++++++++
 kernel/bpf/stackmap.c     | 17 +++++------------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 9d34b0690403..1050257361aa 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -56,4 +56,18 @@ static inline void mmap_read_unlock(struct mm_struct *mm)
 	up_read(&mm->mmap_sem);
 }
 
+static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
+{
+	if (down_read_trylock(&mm->mmap_sem)) {
+		rwsem_release(&mm->mmap_sem.dep_map, _RET_IP_);
+		return true;
+	}
+	return false;
+}
+
+static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
+{
+	up_read_non_owner(&mm->mmap_sem);
+}
+
 #endif /* _LINUX_MMAP_LOCK_H */
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 11d41f0c7005..998968659892 100644
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
@@ -44,8 +44,7 @@ static void do_up_read(struct irq_work *entry)
 		return;
 
 	work = container_of(entry, struct stack_map_irq_work, irq_work);
-	up_read_non_owner(work->sem);
-	work->sem = NULL;
+	mmap_read_unlock_non_owner(work->mm);
 }
 
 static DEFINE_PER_CPU(struct stack_map_irq_work, up_read_work);
@@ -317,7 +316,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 	 * with build_id.
 	 */
 	if (!user || !current || !current->mm || irq_work_busy ||
-	    mmap_read_trylock(current->mm) == 0) {
+	    !mmap_read_trylock_non_owner(current->mm)) {
 		/* cannot access current->mm, fall back to ips */
 		for (i = 0; i < trace_nr; i++) {
 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
@@ -342,16 +341,10 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 	}
 
 	if (!work) {
-		mmap_read_unlock(current->mm);
+		mmap_read_unlock_non_owner(current->mm);
 	} else {
-		work->sem = &current->mm->mmap_sem;
+		work->mm = current->mm;
 		irq_work_queue(&work->irq_work);
-		/*
-		 * The irq_work will release the mmap_sem with
-		 * up_read_non_owner(). The rwsem_release() is called
-		 * here to release the lock from lockdep's perspective.
-		 */
-		rwsem_release(&current->mm->mmap_sem.dep_map, _RET_IP_);
 	}
 }
 
-- 
2.26.0.110.g2183baf09c-goog

