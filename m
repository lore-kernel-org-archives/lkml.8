Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50301C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28F86223BF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgEVOUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:20:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:59240 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729399AbgEVOUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:20:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EE843B15F;
        Fri, 22 May 2020 14:20:48 +0000 (UTC)
Date:   Fri, 22 May 2020 07:15:14 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Michel Lespinasse <walken@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v6 07/12] mmap locking API: add
 mmap_read_trylock_non_owner()
Message-ID: <20200522141514.ctpmu4ksw4lj6udu@linux-p48b>
Mail-Followup-To: Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>
References: <20200520052908.204642-1-walken@google.com>
 <20200520052908.204642-8-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200520052908.204642-8-walken@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 May 2020, Michel Lespinasse wrote:

>Add a couple APIs used by kernel/bpf/stackmap.c only:
>- mmap_read_trylock_non_owner()
>- mmap_read_unlock_non_owner() (may be called from a work queue).
>
>It's still not ideal that bpf/stackmap subverts the lock ownership
>in this way. Thanks to Peter Zijlstra for suggesting this API as the
>least-ugly way of addressing this in the short term.
>
>Signed-off-by: Michel Lespinasse <walken@google.com>
>Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
>Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Sigh, bpf, but ok.

Reviewed-by: Davidlohr Bueso <dbueso@suse.de>

>---
> include/linux/mmap_lock.h | 14 ++++++++++++++
> kernel/bpf/stackmap.c     | 17 +++++------------
> 2 files changed, 19 insertions(+), 12 deletions(-)
>
>diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
>index a757cb30ae77..d1826ce42f00 100644
>--- a/include/linux/mmap_lock.h
>+++ b/include/linux/mmap_lock.h
>@@ -56,4 +56,18 @@ static inline void mmap_read_unlock(struct mm_struct *mm)
> 	up_read(&mm->mmap_sem);
> }
>
>+static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
>+{
>+	if (down_read_trylock(&mm->mmap_sem)) {
>+		rwsem_release(&mm->mmap_sem.dep_map, _RET_IP_);
>+		return true;
>+	}
>+	return false;
>+}
>+
>+static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
>+{
>+	up_read_non_owner(&mm->mmap_sem);
>+}
>+
> #endif /* _LINUX_MMAP_LOCK_H */
>diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>index 11d41f0c7005..998968659892 100644
>--- a/kernel/bpf/stackmap.c
>+++ b/kernel/bpf/stackmap.c
>@@ -33,7 +33,7 @@ struct bpf_stack_map {
> /* irq_work to run up_read() for build_id lookup in nmi context */
> struct stack_map_irq_work {
> 	struct irq_work irq_work;
>-	struct rw_semaphore *sem;
>+	struct mm_struct *mm;
> };
>
> static void do_up_read(struct irq_work *entry)
>@@ -44,8 +44,7 @@ static void do_up_read(struct irq_work *entry)
> 		return;
>
> 	work = container_of(entry, struct stack_map_irq_work, irq_work);
>-	up_read_non_owner(work->sem);
>-	work->sem = NULL;
>+	mmap_read_unlock_non_owner(work->mm);
> }
>
> static DEFINE_PER_CPU(struct stack_map_irq_work, up_read_work);
>@@ -317,7 +316,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
> 	 * with build_id.
> 	 */
> 	if (!user || !current || !current->mm || irq_work_busy ||
>-	    mmap_read_trylock(current->mm) == 0) {
>+	    !mmap_read_trylock_non_owner(current->mm)) {
> 		/* cannot access current->mm, fall back to ips */
> 		for (i = 0; i < trace_nr; i++) {
> 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
>@@ -342,16 +341,10 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
> 	}
>
> 	if (!work) {
>-		mmap_read_unlock(current->mm);
>+		mmap_read_unlock_non_owner(current->mm);
> 	} else {
>-		work->sem = &current->mm->mmap_sem;
>+		work->mm = current->mm;
> 		irq_work_queue(&work->irq_work);
>-		/*
>-		 * The irq_work will release the mmap_sem with
>-		 * up_read_non_owner(). The rwsem_release() is called
>-		 * here to release the lock from lockdep's perspective.
>-		 */
>-		rwsem_release(&current->mm->mmap_sem.dep_map, _RET_IP_);
> 	}
> }
>
>-- 
>2.26.2.761.g0e0b3e54be-goog
>
