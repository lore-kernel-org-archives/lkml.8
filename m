Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199E4C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E814820735
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHEsdusq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgDVAOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgDVAOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:14:43 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D048C061BD3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:14:42 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id o5so578435pfp.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=trhg9Yk7vVwhm5tzbCAJRNxhtIH/dkjCFeCx4usvKdo=;
        b=BHEsdusqub6ITSFVJH1OMaviWdq8JZTGu52eYcgWIfShAzJitgHwHUZS3IvSOm1BNK
         JoTHHdeOuTWVSp3Aou4Wk3xTIFTTRqDcwpW5wgRDbQQS4DxJIytHgthOHaGUvHwNjkQe
         oWa4Qmnw57wWVZ2tndrp4TK2iFfiZ92Halo7sVxnJxPaolU+K9JmS8I4jrq4jhbbgvzB
         JS1k9LoBdeRYsIdS5zOLVvh5XXfUBfumGNrf/bEdBVphpikbeiEhVjLZcTM799RvpEMp
         U4XZNdb62rmL8l+SiqDEJ+cKSBOrXG5vnp8CblZGvTiay4osZPNIOplUBnMK+AHVlXKu
         JQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=trhg9Yk7vVwhm5tzbCAJRNxhtIH/dkjCFeCx4usvKdo=;
        b=cpNhaNOjpJzkqBQ/oHlPdamXv92/RVKXLT6li6tmr81jkv3xaT1CIwTbV4Q5wxcAVn
         TIkWbjLo+2Hkjh5m1JFlQUKv/o3ABcXWf7iKhoZildtsVfFr9A9/tNydUmBtJpjHwgaK
         CFSYvOQcxEfW0jXruKiaPaQQHORFF3gAK/dy1lH2kafP1n4ae8mQo5Mjp+k5qypmC3MK
         TJfIqW3VBd7YDZZJZO2K3apW411hBsmKcZjCvoR9G7i96LAI8i/YUgPlWFvmhaRlpEMK
         S8xG4mlznXdX/mDSD1K4n0OWAb4UK6aIA4tULh6DSh47ycK6mR1GpA/IlKbZqNabQYLa
         2ZFw==
X-Gm-Message-State: AGi0PuafInXo4ranIw0RJ3tAlA1PlDvXMdhC6caypa/JgxRgcavXQI7e
        q6a/nbpsamXGbWett0LWlc8oY0fn5dc=
X-Google-Smtp-Source: APiQypKCBgqau9oBZcw41su0qMphAJhDDfKbrccQB8zcf2ElgGBtskpCaousaW7ZlmKXUWUS3kvrDn3koqM=
X-Received: by 2002:a17:90a:dc83:: with SMTP id j3mr6004567pjv.6.1587514481568;
 Tue, 21 Apr 2020 17:14:41 -0700 (PDT)
Date:   Tue, 21 Apr 2020 17:14:19 -0700
In-Reply-To: <20200422001422.232330-1-walken@google.com>
Message-Id: <20200422001422.232330-8-walken@google.com>
Mime-Version: 1.0
References: <20200422001422.232330-1-walken@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v5 07/10] mmap locking API: add mmap_read_trylock_non_owner()
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
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
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
2.26.1.301.g55bc3eb7cb9-goog

