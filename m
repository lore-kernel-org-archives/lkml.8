Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562FDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 03:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3599D2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 03:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590031367;
	bh=CZ1I0nklSnkaDJwauZgG+9Dbgoyu9fZHiW90vV3R5W0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=EnJE38kfV9REbCxrq+8DPI+B4bDaY1o6O0yN7tWbKcqGATQtH8dSqOExnLIyjoRx7
	 keSLkMPnmv5uRm07/nUDhqbu5VgsBfSaC0MfR1hzToQyyncyaKz30SO0J4Yqj1F4pQ
	 pfytDjdC50adJi72q1L/CzOW02W/jjNhl/e76uPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgEUDWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 23:22:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbgEUDWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 23:22:44 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44F7020709;
        Thu, 21 May 2020 03:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590031363;
        bh=CZ1I0nklSnkaDJwauZgG+9Dbgoyu9fZHiW90vV3R5W0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GmGcqKEXOlWyyxcYWYYL1pBDOUeUPB2f8ABMVVPGP6m2d0fV+ZAcsnUyRPCJvuE5X
         m0moyJC1vKRetNb30ghtKWYkeLZIZdv5+emYSimOqBAEBcNvn08mDS/Pci13cMkRCD
         bW2glvtmkRitz82QDNcRFeW/M3vRBUFs6cMUH93k=
Date:   Wed, 20 May 2020 20:22:42 -0700
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
Subject: Re: [PATCH v6 12/12] mmap locking API: convert mmap_sem comments
Message-Id: <20200520202242.dec6b520f0bab4a66a510d73@linux-foundation.org>
In-Reply-To: <20200520052908.204642-13-walken@google.com>
References: <20200520052908.204642-1-walken@google.com>
        <20200520052908.204642-13-walken@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 May 2020 22:29:08 -0700 Michel Lespinasse <walken@google.com> wrote:

> Convert comments that reference mmap_sem to reference mmap_lock instead.

This may not be complete..

From: Andrew Morton <akpm@linux-foundation.org>
Subject: mmap-locking-api-convert-mmap_sem-comments-fix

fix up linux-next leftovers

Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: David Rientjes <rientjes@google.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jerome Glisse <jglisse@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Laurent Dufour <ldufour@linux.ibm.com>
Cc: Liam Howlett <Liam.Howlett@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michel Lespinasse <walken@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Ying Han <yinghan@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/mm/fault.c |    2 +-
 include/linux/pgtable.h |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/powerpc/mm/fault.c~mmap-locking-api-convert-mmap_sem-comments-fix
+++ a/arch/powerpc/mm/fault.c
@@ -138,7 +138,7 @@ static noinline int bad_access_pkey(stru
 	 * 2. T1   : set AMR to deny access to pkey=4, touches, page
 	 * 3. T1   : faults...
 	 * 4.    T2: mprotect_key(foo, PAGE_SIZE, pkey=5);
-	 * 5. T1   : enters fault handler, takes mmap_sem, etc...
+	 * 5. T1   : enters fault handler, takes mmap_lock, etc...
 	 * 6. T1   : reaches here, sees vma_pkey(vma)=5, when we really
 	 *	     faulted on a pte with its pkey=4.
 	 */
--- a/include/linux/pgtable.h~mmap-locking-api-convert-mmap_sem-comments-fix
+++ a/include/linux/pgtable.h
@@ -1101,11 +1101,11 @@ static inline pmd_t pmd_read_atomic(pmd_
 #endif
 /*
  * This function is meant to be used by sites walking pagetables with
- * the mmap_sem hold in read mode to protect against MADV_DONTNEED and
+ * the mmap_lock held in read mode to protect against MADV_DONTNEED and
  * transhuge page faults. MADV_DONTNEED can convert a transhuge pmd
  * into a null pmd and the transhuge page fault can convert a null pmd
  * into an hugepmd or into a regular pmd (if the hugepage allocation
- * fails). While holding the mmap_sem in read mode the pmd becomes
+ * fails). While holding the mmap_lock in read mode the pmd becomes
  * stable and stops changing under us only if it's not null and not a
  * transhuge pmd. When those races occurs and this function makes a
  * difference vs the standard pmd_none_or_clear_bad, the result is
@@ -1115,7 +1115,7 @@ static inline pmd_t pmd_read_atomic(pmd_
  *
  * For 32bit kernels with a 64bit large pmd_t this automatically takes
  * care of reading the pmd atomically to avoid SMP race conditions
- * against pmd_populate() when the mmap_sem is hold for reading by the
+ * against pmd_populate() when the mmap_lock is hold for reading by the
  * caller (a special atomic read not done by "gcc" as in the generic
  * version above, is also needed when THP is disabled because the page
  * fault can populate the pmd from under us).
_

