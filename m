Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEF0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5165321707
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1y5V5Vg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394426AbgFSQOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:14:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30752 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391406AbgFSQOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592583249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ceY5WUXlxKdkNl2ZPUhmC7i0B7kz37sYu0bxG24wxmk=;
        b=b1y5V5VgO1vFUFbmA3K+Ygs5qphypRvKzv99fzzuomTl+R+/m07Qv/evLPQaKZDtisOcVS
        YCBS0O62cZmyhuutEIoKYP/hrVXY5IRn9qNgKILFTsUYDjsLIawuFVlu8NGReEHx3EH6mY
        4px0QBi8pwTblEpWcPLYg/YYE3aMPY0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-fTEq2RS2OtaHSvMW2fb8qw-1; Fri, 19 Jun 2020 12:14:05 -0400
X-MC-Unique: fTEq2RS2OtaHSvMW2fb8qw-1
Received: by mail-qv1-f70.google.com with SMTP id q5so7066083qvp.23
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ceY5WUXlxKdkNl2ZPUhmC7i0B7kz37sYu0bxG24wxmk=;
        b=GktHuPEHdSXTosI2Ybh03Pl2cFX9G8sL+ZjHVU5C3HHsK3VALTKevS4uGBfjWRiXEo
         9AQeIBHGSpdzV2Jzoryvcs8nqWEk2jtkf1rAenyKU96zmcsYjPigl8n0CitoDVtXdKN6
         sW6JFqjkDOGJSHwQhKg2LC5HPrBJhfxKRlPT/9BCaTkUWGn97rnlatfg2URZBoeBHM0G
         bCzelvIhZ5nw0paH/SCsP5kjJmjW4VnbewVyqckqBy+mqeISH5prbZKVF8aPR/eqJm49
         vaskgn8jDNifX4bmJmvi2Rv0RU5rP+9ZVL7kOfxGO7NqsOQaZCKb2S9yQIqGggltxWgi
         /FbA==
X-Gm-Message-State: AOAM533E2ww8Oq5RPfmbcV41u+QB3eRATHsDExaXyhVRIuthu1E0YKkB
        7YJBKLLJfDRDBQ347umn3I2wjXe4MSTg5FU6IkrwKzjRG8LRHnr2oaPI98ntqw324STs2MSwSaI
        LLtthpgWP/4GfRnBx+ESglu4K
X-Received: by 2002:a0c:ee41:: with SMTP id m1mr9169859qvs.95.1592583245019;
        Fri, 19 Jun 2020 09:14:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0zCecxV9JtXknOOZNLR2+6hLoId0LmwX50hMH84sIFNjeC89K0w8Jv2AYP2pWScsHfroN5Q==
X-Received: by 2002:a0c:ee41:: with SMTP id m1mr9169833qvs.95.1592583244707;
        Fri, 19 Jun 2020 09:14:04 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id s4sm6383847qkh.120.2020.06.19.09.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:14:04 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Peter Xu <peterx@redhat.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 25/26] mm: Clean up the last pieces of page fault accountings
Date:   Fri, 19 Jun 2020 12:14:02 -0400
Message-Id: <20200619161402.10004-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200619160538.8641-1-peterx@redhat.com>
References: <20200619160538.8641-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here're the last pieces of page fault accounting that were still done outside
handle_mm_fault() where we still have regs==NULL when calling handle_mm_fault():

arch/powerpc/mm/copro_fault.c:   copro_handle_mm_fault
arch/sparc/mm/fault_32.c:        force_user_fault
arch/um/kernel/trap.c:           handle_page_fault
mm/gup.c:                        faultin_page
                                 fixup_user_fault
mm/hmm.c:                        hmm_vma_fault
mm/ksm.c:                        break_ksm

Some of them has the issue of duplicated accounting for page fault retries.
Some of them didn't do the accounting at all.

This patch cleans all these up by letting handle_mm_fault() to do per-task page
fault accounting even if regs==NULL (though we'll still skip the perf event
accountings).  With that, we can safely remove all the outliers now.

There's another functional change in that now we account the page faults to the
caller of gup, rather than the task_struct that passed into the gup code.  More
information of this can be found at [1].

After this patch, below things should never be touched again outside
handle_mm_fault():

  - task_struct.[maj|min]_flt
  - PERF_COUNT_SW_PAGE_FAULTS_[MAJ|MIN]

[1] https://lore.kernel.org/lkml/CAHk-=wj_V2Tps2QrMn20_W0OJF9xqNh52XSGA42s-ZJ8Y+GyKw@mail.gmail.com/

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/powerpc/mm/copro_fault.c |  5 -----
 arch/um/kernel/trap.c         |  4 ----
 mm/gup.c                      | 13 -------------
 mm/memory.c                   | 20 ++++++++++++--------
 4 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_fault.c
index c0478bef1f14..2e59be1a9359 100644
--- a/arch/powerpc/mm/copro_fault.c
+++ b/arch/powerpc/mm/copro_fault.c
@@ -76,11 +76,6 @@ int copro_handle_mm_fault(struct mm_struct *mm, unsigned long ea,
 		BUG();
 	}
 
-	if (*flt & VM_FAULT_MAJOR)
-		current->maj_flt++;
-	else
-		current->min_flt++;
-
 out_unlock:
 	up_read(&mm->mmap_sem);
 	return ret;
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 32cc8f59322b..c881831de357 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -92,10 +92,6 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 			BUG();
 		}
 		if (flags & FAULT_FLAG_ALLOW_RETRY) {
-			if (fault & VM_FAULT_MAJOR)
-				current->maj_flt++;
-			else
-				current->min_flt++;
 			if (fault & VM_FAULT_RETRY) {
 				flags |= FAULT_FLAG_TRIED;
 
diff --git a/mm/gup.c b/mm/gup.c
index 1a48c639ea49..17b4d0c45a6b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -885,13 +885,6 @@ static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
 		BUG();
 	}
 
-	if (tsk) {
-		if (ret & VM_FAULT_MAJOR)
-			tsk->maj_flt++;
-		else
-			tsk->min_flt++;
-	}
-
 	if (ret & VM_FAULT_RETRY) {
 		if (locked && !(fault_flags & FAULT_FLAG_RETRY_NOWAIT))
 			*locked = 0;
@@ -1239,12 +1232,6 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 		goto retry;
 	}
 
-	if (tsk) {
-		if (major)
-			tsk->maj_flt++;
-		else
-			tsk->min_flt++;
-	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fixup_user_fault);
diff --git a/mm/memory.c b/mm/memory.c
index 23c738b3756e..59a2989231fa 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4350,6 +4350,8 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 /**
  * mm_account_fault - Do page fault accountings
  * @regs: the pt_regs struct pointer.  When set to NULL, will skip accounting
+ *        of perf event counters, but we'll still do the per-task accounting to
+ *        the task who triggered this page fault.
  * @address: faulted address.
  * @major: whether this is a major fault.
  *
@@ -4365,16 +4367,18 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 static inline void mm_account_fault(struct pt_regs *regs,
 				    unsigned long address, bool major)
 {
+	if (major)
+		current->maj_flt++;
+	else
+		current->min_flt++;
+
 	if (!regs)
 		return;
 
-	if (major) {
-		current->maj_flt++;
+	if (major)
 		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs, address);
-	} else {
-		current->min_flt++;
+	else
 		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);
-	}
 }
 
 /*
@@ -4450,9 +4454,9 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	 *    immediately previously).
 	 *
 	 *  - if the fault is done for GUP, regs wil be NULL and
-	 *    no accounting will be done (but you _could_ pass in
-	 *    your own regs and it would be accounted to the thread
-	 *    doing the fault, not to the target!)
+	 *    we only do the accounting for the per thread fault
+	 *    counters who triggered the fault, and we skip the
+	 *    perf event updates.
 	 */
 	mm_account_fault(regs, address, (ret & VM_FAULT_MAJOR) ||
 			 (flags & FAULT_FLAG_TRIED));
-- 
2.26.2

