Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEC6C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC29E207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QbHMgP/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgETF34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 01:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbgETF32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 01:29:28 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676D1C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 22:29:28 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id n36so2426180qvg.22
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 22:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=m0T6T+70wSFyJpcmVviJFbhlAnWz1/NcVo+29dwBHOg=;
        b=QbHMgP/Nig7fT3isiChQjfZKm91tA6CwwAN/Ni4maGfQgte+us6j3UCl2hydLIRd2e
         uCPWpBZi8mxGT5MRc/Z5W6dFC/DSSKJdiaWAyI48ZVRk7imlbTJc7OI/NbMLdgY2Q5Wy
         0Ep6vckOzmrsdSHoDjWtyTasqal/xXzRFtfiA1bn/GZw/aHgcB4ogUOpcnDawY/Lh9hU
         XdAsYW1xG9j4/Ozmw2bs5h8sJWpABV6n7b8ga52ZHY1uGeL0U8Du12SkGrgZvZTQWEmS
         /19vryTT69cYt45ryU2SIsSRLRDAq7SyaXmiJgqSM0IZwMQR+H44cmKKObQOEmEcqeIS
         Nh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m0T6T+70wSFyJpcmVviJFbhlAnWz1/NcVo+29dwBHOg=;
        b=n64Rmf6Ji3e4LNwCivJKhjGypOUNpbexhr4BTmMNw6Rmhprp717KjWsb1aaCLeV6DJ
         e7WWcws09k/a86fa+2KDSiXV0xtwVW5TMqlynQ1p4iHvCOp1RP8MwjW+08xZAHR6NBIF
         Is4miEBCisruGAIiTS1bXVZX1JGqak1FgwtzhUOTAi9z7tMU/b2QKFqmZBA6MS1eT+WK
         U+mPIjsm+SccUtm/yuut0zYJFtQ9oJDrlYZwjk5+o5g/orxHOgR7XGJEhaXT0oHekW6l
         OKtfojvpYpTV55hgWLBQx5TekkniFBIt7o0lYPncInEi7i3l7+n4+RgcNMOszYJEk2gJ
         X6ag==
X-Gm-Message-State: AOAM533v9wPftpjMQg1d7o7jF2WlDfAElkcORR8DaEiK2BNyzaIxrnnX
        kZHbie6aifLoWH+iAG+XSSTOt8CqK7U=
X-Google-Smtp-Source: ABdhPJxoVK6kzfbip/jyp4MIxHt+TXYAM3wE7U0C5wiZEdI/3dI5eGJJjv/gAGIl6SeusJsJcxC/cs8FXlc=
X-Received: by 2002:a0c:f3ca:: with SMTP id f10mr3336511qvm.66.1589952567603;
 Tue, 19 May 2020 22:29:27 -0700 (PDT)
Date:   Tue, 19 May 2020 22:29:03 -0700
In-Reply-To: <20200520052908.204642-1-walken@google.com>
Message-Id: <20200520052908.204642-8-walken@google.com>
Mime-Version: 1.0
References: <20200520052908.204642-1-walken@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v6 07/12] mmap locking API: add mmap_read_trylock_non_owner()
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
        John Hubbard <jhubbard@nvidia.com>,
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
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mmap_lock.h | 14 ++++++++++++++
 kernel/bpf/stackmap.c     | 17 +++++------------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index a757cb30ae77..d1826ce42f00 100644
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
2.26.2.761.g0e0b3e54be-goog

