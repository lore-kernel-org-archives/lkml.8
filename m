Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D90EC4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 556F820728
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhIHtmGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgD0Sp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgD0Sp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:45:56 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB08CC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 11:45:56 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id h11so7306314plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 11:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IpKTFehUcXhhF7xrkmKw3CHsnpQNIE0K3A4gmdlp3lo=;
        b=nhIHtmGNp4TbRPSohBbfR4qNvzHevCBHhmDAOE6oXYA34uwxjj3e6iS6RUCAGmlqx1
         dB53e+WhJusL7F0AdWDOMXgqOeR0tn+x0OLgoyO96KYO461yZKfGamOTx6h32/Cw3k35
         /tQCb0AwPKrlygPZKWDUs9edQutLDqeobySjenyqh+f66a3ZgN1qaVTpQ3cTZZGVEOI6
         9y6uQTazFOLMpkcw2QvVHQiLaN6FswuAtDbh0nRNs+Ux9u1AT6eoUlwPExRX8MExfoTP
         7Z860jhQDTiI4v1MRRRacnGFZ7ltYnMClnYAAORZkOPs2FgGkZk7B4pJP1iHAwL/n58m
         JS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IpKTFehUcXhhF7xrkmKw3CHsnpQNIE0K3A4gmdlp3lo=;
        b=HfyDaEjPyjV+Xj/30KNVR+1qBj7IdSMkdx6+6OP5MxoTQv0mDWjC92WUAHIbqiO8BG
         VIVuO/ea+Jj65SQPk5o3O6wbMeq5x1R/qV3HRQXIeSaisM/SZZqY/87pIWfOF4XqEm1z
         stf+OSEnWQAHu9G1psiiILkF80RO52c4LtsSBLGKAwjb0ULWkSFruGiwVUdItUcVMWBb
         GqR407lIzajL9MFSlghspirre/vPp6MswASMjlpXCPZyHJrateQXAoUsKOQQ6Loz5LFj
         ZvqPEnZbMlkqvWTttjhTEkvGWVRyliPQA3MBtFM3gHQklfSyd72Cr37SLa/Ypm0v6gZP
         5HPQ==
X-Gm-Message-State: AGi0PuYhpE/6ppzWEF9MrEJaMK90io6voyTCTadsq1xI9okT/YZU8LoV
        VsQX3NY3CjRT28qf/NTwXbL7gaLm
X-Google-Smtp-Source: APiQypLnRO8UgrZnYmoaFdaq5a+njOYxt8xpgk+QSZWThlwsacdjzZGuiPRvHsDWNtIHkq79h3XP4w==
X-Received: by 2002:a17:90a:21ee:: with SMTP id q101mr103413pjc.24.1588013156229;
        Mon, 27 Apr 2020 11:45:56 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.172.252.57])
        by smtp.gmail.com with ESMTPSA id h197sm13541237pfe.208.2020.04.27.11.45.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 11:45:55 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] mm/gup.c: Updating the documentation
Date:   Tue, 28 Apr 2020 00:23:50 +0530
Message-Id: <1588013630-4497-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is an attempt to update the documentation.

* Adding / removing extra * based on type of function
static / global.

* Added description for functions and their input arguments.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 mm/gup.c | 59 ++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 6076df8e..7ce796c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -722,7 +722,7 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 	return follow_pud_mask(vma, address, p4d, flags, ctx);
 }
 
-/**
+/*
  * follow_page_mask - look up a page descriptor from a user-virtual address
  * @vma: vm_area_struct mapping @address
  * @address: virtual address to look up
@@ -1168,7 +1168,7 @@ static bool vma_permits_fault(struct vm_area_struct *vma,
 	return true;
 }
 
-/*
+/**
  * fixup_user_fault() - manually resolve a user page fault
  * @tsk:	the task_struct to use for page fault accounting, or
  *		NULL if faults are not to be recorded.
@@ -1837,7 +1837,7 @@ static long __get_user_pages_remote(struct task_struct *tsk,
 				       gup_flags | FOLL_TOUCH | FOLL_REMOTE);
 }
 
-/*
+/**
  * get_user_pages_remote() - pin user pages in memory
  * @tsk:	the task_struct to use for page fault accounting, or
  *		NULL if faults are not to be recorded.
@@ -1868,13 +1868,13 @@ static long __get_user_pages_remote(struct task_struct *tsk,
  *
  * Must be called with mmap_sem held for read or write.
  *
- * get_user_pages walks a process's page tables and takes a reference to
- * each struct page that each user address corresponds to at a given
+ * get_user_pages_remote walks a process's page tables and takes a reference
+ * to each struct page that each user address corresponds to at a given
  * instant. That is, it takes the page that would be accessed if a user
  * thread accesses the given user virtual address at that instant.
  *
  * This does not guarantee that the page exists in the user mappings when
- * get_user_pages returns, and there may even be a completely different
+ * get_user_pages_remote returns, and there may even be a completely different
  * page there in some cases (eg. if mmapped pagecache has been invalidated
  * and subsequently re faulted). However it does guarantee that the page
  * won't be freed completely. And mostly callers simply care that the page
@@ -1886,17 +1886,17 @@ static long __get_user_pages_remote(struct task_struct *tsk,
  * is written to, set_page_dirty (or set_page_dirty_lock, as appropriate) must
  * be called after the page is finished with, and before put_page is called.
  *
- * get_user_pages is typically used for fewer-copy IO operations, to get a
- * handle on the memory by some means other than accesses via the user virtual
- * addresses. The pages may be submitted for DMA to devices or accessed via
- * their kernel linear mapping (via the kmap APIs). Care should be taken to
- * use the correct cache flushing APIs.
+ * get_user_pages_remote is typically used for fewer-copy IO operations,
+ * to get a handle on the memory by some means other than accesses
+ * via the user virtual addresses. The pages may be submitted for
+ * DMA to devices or accessed via their kernel linear mapping (via the
+ * kmap APIs). Care should be taken to use the correct cache flushing APIs.
  *
  * See also get_user_pages_fast, for performance critical applications.
  *
- * get_user_pages should be phased out in favor of
+ * get_user_pages_remote should be phased out in favor of
  * get_user_pages_locked|unlocked or get_user_pages_fast. Nothing
- * should use get_user_pages because it cannot pass
+ * should use get_user_pages_remote because it cannot pass
  * FAULT_FLAG_ALLOW_RETRY to handle_mm_fault.
  */
 long get_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
@@ -1935,7 +1935,17 @@ static long __get_user_pages_remote(struct task_struct *tsk,
 }
 #endif /* !CONFIG_MMU */
 
-/*
+/**
+ * get_user_pages() - pin user pages in memory
+ * @start:      starting user address
+ * @nr_pages:   number of pages from start to pin
+ * @gup_flags:  flags modifying lookup behaviour
+ * @pages:      array that receives pointers to the pages pinned.
+ *              Should be at least nr_pages long. Or NULL, if caller
+ *              only intends to ensure the pages are faulted in.
+ * @vmas:       array of pointers to vmas corresponding to each page.
+ *              Or NULL if the caller does not require them.
+ *
  * This is the same as get_user_pages_remote(), just with a
  * less-flexible calling convention where we assume that the task
  * and mm being operated on are the current task's and don't allow
@@ -1958,11 +1968,7 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
 }
 EXPORT_SYMBOL(get_user_pages);
 
-/*
- * We can leverage the VM_FAULT_RETRY functionality in the page fault
- * paths better by using either get_user_pages_locked() or
- * get_user_pages_unlocked().
- *
+/**
  * get_user_pages_locked() is suitable to replace the form:
  *
  *      down_read(&mm->mmap_sem);
@@ -1978,6 +1984,21 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
  *      get_user_pages_locked(tsk, mm, ..., pages, &locked);
  *      if (locked)
  *          up_read(&mm->mmap_sem);
+ *
+ * @start:      starting user address
+ * @nr_pages:   number of pages from start to pin
+ * @gup_flags:  flags modifying lookup behaviour
+ * @pages:      array that receives pointers to the pages pinned.
+ *              Should be at least nr_pages long. Or NULL, if caller
+ *              only intends to ensure the pages are faulted in.
+ * @locked:     pointer to lock flag indicating whether lock is held and
+ *              subsequently whether VM_FAULT_RETRY functionality can be
+ *              utilised. Lock must initially be held.
+ *
+ * We can leverage the VM_FAULT_RETRY functionality in the page fault
+ * paths better by using either get_user_pages_locked() or
+ * get_user_pages_unlocked().
+ *
  */
 long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
 			   unsigned int gup_flags, struct page **pages,
-- 
1.9.1

