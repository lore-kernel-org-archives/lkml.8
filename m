Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E2DC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBAA215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kbnRZ3EQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgC0CLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:11:23 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:46988 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgC0CLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:11:19 -0400
Received: by mail-pl1-f201.google.com with SMTP id x6so5929604plo.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 19:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mRGmq46YXMyZu9YZdo8naIlt7nPQjUFxl7dVtsp0NXQ=;
        b=kbnRZ3EQIaNtTYf2H3t1YorayOkyCZ9RKdvA96rIRVACHiJYkE08MrUDp6wpCuKLg0
         IJX1a7Cu6yG8fQZc5PNMZahlhte37pb5bkOh1YX7gBncLU/bj70C28XMOSivokGDBT42
         E5rJaG5tC4l0mdJiRei2Legye/R4vTo8D3kCVijBKJN6KJzrpKSVPvUDxOa6Gmq1ErbN
         hAv4PpkaMDVCtWklbxaCdrZK9PllMcn3SovnPybqqORINUSD2kKNtBQ7BlM2eI1aP5FS
         LrVM3iaDYcWFGtIvwR6ZfQX8mepmZm30fcYAFIWmZgphD/qrGf7UYa5Fivig6VqH4UyV
         a2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mRGmq46YXMyZu9YZdo8naIlt7nPQjUFxl7dVtsp0NXQ=;
        b=WhxI/jHzY+9EzkZ0VmSgWuio6iafI8Z1ATYWYibDTH69YZfiNVyjZHVDdqh+t3oflS
         BUQ5ku28OykMB4MlmSOFU7qSW53VbpyCb8xBztpjecNfZUpPw6twH3egcm4wxjsHrDxH
         SGZBViNo53d+MnkT7dhSkoaSQqRAzR9e+GU3aWhP3dXmJuMHaJZlBAireh90HvfRnwVC
         cbAdXqesES777Rwn/BuVs8Nem22e2DKBdZ3evSOPM+0kYuoYAOgrrHT2EO/CL7thTOGC
         O1oNi2bmih+qQZ/BMex2/9oFTljUWFVVJptoHgM+0fo5AS5vv9RXC6eHf/a5+dZAL9Hn
         lPYg==
X-Gm-Message-State: ANhLgQ3u/q/liNfIcPbDMozGmWixu65nkB1ZUj5RIrNNvnHbHLyhYjI0
        XxmQnfR04bMloGHXPUlSsM4h0KuDgps=
X-Google-Smtp-Source: ADFU+vvoIGgQXc+TUhUHzmVFdOtuACoigyqHXdt16UNQbmfXwVGrE2GzUA0KzToVG+3fgq7V/E1YO4PHmD4=
X-Received: by 2002:a17:90a:b78e:: with SMTP id m14mr3206364pjr.135.1585275078640;
 Thu, 26 Mar 2020 19:11:18 -0700 (PDT)
Date:   Thu, 26 Mar 2020 19:10:55 -0700
In-Reply-To: <20200327021058.221911-1-walken@google.com>
Message-Id: <20200327021058.221911-8-walken@google.com>
Mime-Version: 1.0
References: <20200327021058.221911-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v2 07/10] mmap locking API: add mmap_read_release() and mmap_read_unlock_non_owner()
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
2.26.0.rc2.310.g2932bb562d-goog

