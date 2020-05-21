Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7590AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 03:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F10D2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 03:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590031401;
	bh=l4LFB2adLL8Fwr8y3Ullwx1wKTu/CijGRZHMau1S3BM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WwNX0C9ULPL2KQXRs1BY4yAfVi5PYRSBmCTOOvftqZn7ENo1KiT7DgAjZ7yslNPkV
	 8Juc7AYgl1c2GknL7znmqeZYU8gbQQnZuL5irkZtWJIRv+bOJoRStNBPCbp4v/OCFG
	 WGhSbTpcfdACw3MjQweeoxRKkyryQqUGtlbXLv6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgEUDXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 23:23:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbgEUDXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 23:23:20 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B190F20709;
        Thu, 21 May 2020 03:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590031398;
        bh=l4LFB2adLL8Fwr8y3Ullwx1wKTu/CijGRZHMau1S3BM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hgkSAmpn3UjiPftlBcqCwQBjtVbcwDRD2pY3YAH3r13ALnBRXu3HEk6GjuSP/tYi6
         ZQZ60+cglfgcbXqW+f2pWTBF3CaBRHhpvfWD4x1ujadaabEo9PkpVHO9MHBaaTGJEC
         8c2hMJQX+tCfvZeY8qmfzO5ZmiKc11u2K1AoPtNY=
Date:   Wed, 20 May 2020 20:23:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
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
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v6 05/12] mmap locking API: convert mmap_sem call sites
 missed by coccinelle
Message-Id: <20200520202317.1f7515649dd711b388e40d3f@linux-foundation.org>
In-Reply-To: <20200520052908.204642-6-walken@google.com>
References: <20200520052908.204642-1-walken@google.com>
        <20200520052908.204642-6-walken@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 May 2020 22:29:01 -0700 Michel Lespinasse <walken@google.com> wrote:

> Convert the last few remaining mmap_sem rwsem calls to use the new
> mmap locking API. These were missed by coccinelle for some reason
> (I think coccinelle does not support some of the preprocessor
> constructs in these files ?)


From: Andrew Morton <akpm@linux-foundation.org>
Subject: mmap-locking-api-convert-mmap_sem-call-sites-missed-by-coccinelle-fix

convert linux-next leftovers

Cc: Michel Lespinasse <walken@google.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Laurent Dufour <ldufour@linux.ibm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: David Rientjes <rientjes@google.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jerome Glisse <jglisse@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Liam Howlett <Liam.Howlett@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ying Han <yinghan@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/arm64/kvm/mmu.c |   14 +++++++-------
 lib/test_hmm.c       |   14 +++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)

--- a/lib/test_hmm.c~mmap-locking-api-convert-mmap_sem-call-sites-missed-by-coccinelle-fix
+++ a/lib/test_hmm.c
@@ -243,9 +243,9 @@ static int dmirror_range_fault(struct dm
 		}
 
 		range->notifier_seq = mmu_interval_read_begin(range->notifier);
-		down_read(&mm->mmap_sem);
+		mmap_read_lock(mm);
 		ret = hmm_range_fault(range);
-		up_read(&mm->mmap_sem);
+		mmap_read_unlock(mm);
 		if (ret) {
 			if (ret == -EBUSY)
 				continue;
@@ -684,7 +684,7 @@ static int dmirror_migrate(struct dmirro
 	if (!mmget_not_zero(mm))
 		return -EINVAL;
 
-	down_read(&mm->mmap_sem);
+	mmap_read_lock(mm);
 	for (addr = start; addr < end; addr = next) {
 		vma = find_vma(mm, addr);
 		if (!vma || addr < vma->vm_start ||
@@ -711,7 +711,7 @@ static int dmirror_migrate(struct dmirro
 		dmirror_migrate_finalize_and_map(&args, dmirror);
 		migrate_vma_finalize(&args);
 	}
-	up_read(&mm->mmap_sem);
+	mmap_read_unlock(mm);
 	mmput(mm);
 
 	/* Return the migrated data for verification. */
@@ -731,7 +731,7 @@ static int dmirror_migrate(struct dmirro
 	return ret;
 
 out:
-	up_read(&mm->mmap_sem);
+	mmap_read_unlock(mm);
 	mmput(mm);
 	return ret;
 }
@@ -823,9 +823,9 @@ static int dmirror_range_snapshot(struct
 
 		range->notifier_seq = mmu_interval_read_begin(range->notifier);
 
-		down_read(&mm->mmap_sem);
+		mmap_read_lock(mm);
 		ret = hmm_range_fault(range);
-		up_read(&mm->mmap_sem);
+		mmap_read_unlock(mm);
 		if (ret) {
 			if (ret == -EBUSY)
 				continue;
--- a/arch/arm64/kvm/mmu.c~mmap-locking-api-convert-mmap_sem-call-sites-missed-by-coccinelle-fix
+++ a/arch/arm64/kvm/mmu.c
@@ -1084,7 +1084,7 @@ void stage2_unmap_vm(struct kvm *kvm)
 	int idx;
 
 	idx = srcu_read_lock(&kvm->srcu);
-	down_read(&current->mm->mmap_sem);
+	mmap_read_lock(current->mm);
 	spin_lock(&kvm->mmu_lock);
 
 	slots = kvm_memslots(kvm);
@@ -1092,7 +1092,7 @@ void stage2_unmap_vm(struct kvm *kvm)
 		stage2_unmap_memslot(kvm, memslot);
 
 	spin_unlock(&kvm->mmu_lock);
-	up_read(&current->mm->mmap_sem);
+	mmap_read_unlock(current->mm);
 	srcu_read_unlock(&kvm->srcu, idx);
 }
 
@@ -1848,11 +1848,11 @@ static int user_mem_abort(struct kvm_vcp
 	}
 
 	/* Let's check if we will get back a huge page backed by hugetlbfs */
-	down_read(&current->mm->mmap_sem);
+	mmap_read_lock(current->mm);
 	vma = find_vma_intersection(current->mm, hva, hva + 1);
 	if (unlikely(!vma)) {
 		kvm_err("Failed to find VMA for hva 0x%lx\n", hva);
-		up_read(&current->mm->mmap_sem);
+		mmap_read_unlock(current->mm);
 		return -EFAULT;
 	}
 
@@ -1879,7 +1879,7 @@ static int user_mem_abort(struct kvm_vcp
 	if (vma_pagesize == PMD_SIZE ||
 	    (vma_pagesize == PUD_SIZE && kvm_stage2_has_pmd(kvm)))
 		gfn = (fault_ipa & huge_page_mask(hstate_vma(vma))) >> PAGE_SHIFT;
-	up_read(&current->mm->mmap_sem);
+	mmap_read_unlock(current->mm);
 
 	/* We need minimum second+third level pages */
 	ret = mmu_topup_memory_cache(memcache, kvm_mmu_cache_min_pages(kvm),
@@ -2456,7 +2456,7 @@ int kvm_arch_prepare_memory_region(struc
 	    (kvm_phys_size(kvm) >> PAGE_SHIFT))
 		return -EFAULT;
 
-	down_read(&current->mm->mmap_sem);
+	mmap_read_lock(current->mm);
 	/*
 	 * A memory region could potentially cover multiple VMAs, and any holes
 	 * between them, so iterate over all of them to find out if we can map
@@ -2515,7 +2515,7 @@ int kvm_arch_prepare_memory_region(struc
 		stage2_flush_memslot(kvm, memslot);
 	spin_unlock(&kvm->mmu_lock);
 out:
-	up_read(&current->mm->mmap_sem);
+	mmap_read_unlock(current->mm);
 	return ret;
 }
 
_

