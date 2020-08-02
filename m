Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B27C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 19:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA1BF20759
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 19:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sHovUWig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgHBTSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 15:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgHBTSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 15:18:39 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ED6C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 12:18:38 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id b2so5866614qvp.9
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 12:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=HdJ+2t0gL5zUBULh0wxTvXD/jJHQMjRu5f/2scMrQFs=;
        b=sHovUWigi9DH0ehaFjjuGyHBmXdsFFLTcVQ4mg1yJa8XdTlENu9heMa9cUZgyVHH+o
         uKZUe44Y7JLsGccne7YggSTfxEF99wHr9fYnjCdsYYRX53w+SL0cjr63sTjQchuFQ5xe
         WbqnyIdd1Gb7nz7ykp21L2j8v82z96hxm42keMtf+6U3u3pW3x2HSxBWi3ZXJ8Z5zSjd
         NHjPQpnqydpPofRIFF2H1kTxNhd6LbjBpohrhwWVyZtAvFa7/0ZClkBufNnAi9kaaeZe
         ttxVNKCUGxkI/CxlC4Uc8TeZMcRvw2Rf2c0kkSEZKnOODOM4fm+SEy5oiiLwqnNwZSM0
         WLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=HdJ+2t0gL5zUBULh0wxTvXD/jJHQMjRu5f/2scMrQFs=;
        b=toHDc6l5Q+jQu9NE9Bpay6J1XCuNwJAv4/i43haZFC5AttSMOqMuFB6mEUrL5Jt6Ro
         0y9VKj11x5fiYlufAHvKeEJhZeU0U/bz6h/Gk+BMJQ6iQEycalI/owrF4BmaU89w74Uq
         vFVt5ecd2VDN7Cb/XDO3YL49M41aeBTpjESP+NLguLqH8zPIbIqqcPx0WDUStrgw2nZE
         3eu838pgqBxVTx0qEfketRPsUgHiOzKK1TrkhWp+0Z9ZO7pDihEsCoVcdT4g9a5VgKhs
         zDyTav8UUAZANxRoUsoxPdHaJI2Y+vlo6vrga1hnOxwItGeFtTlWk1jd01u4Bf0ASTd0
         a1uA==
X-Gm-Message-State: AOAM530w0j0ATnpQRjz1H+hWSboV5DhFSWijb67Fue+3Zz8lxZhBn8Mc
        4SDBIDA0+mVNxN3Ivpx/2WlcRA==
X-Google-Smtp-Source: ABdhPJytAGLtbvuAcLH2Aa3Pi1q3sHVCTmRRcn9PxMRLN7jSxbGSR0Xa0ZwxElE1+5veRXWQCgyQHQ==
X-Received: by 2002:ad4:470f:: with SMTP id k15mr13640963qvz.216.1596395918016;
        Sun, 02 Aug 2020 12:18:38 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t35sm19789974qth.79.2020.08.02.12.18.36
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 02 Aug 2020 12:18:37 -0700 (PDT)
Date:   Sun, 2 Aug 2020 12:18:35 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] khugepaged: khugepaged_test_exit() check
 mmget_still_valid()
In-Reply-To: <alpine.LSU.2.11.2008021204390.27773@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2008021217020.27773@eggly.anvils>
References: <alpine.LSU.2.11.2008021204390.27773@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move collapse_huge_page()'s mmget_still_valid() check into
khugepaged_test_exit() itself.  collapse_huge_page() is used for anon
THP only, and earned its mmget_still_valid() check because it inserts
a huge pmd entry in place of the page table's pmd entry; whereas
collapse_file()'s retract_page_tables() or collapse_pte_mapped_thp()
merely clears the page table's pmd entry.  But core dumping without
mmap lock must have been as open to mistaking a racily cleared pmd
entry for a page table at physical page 0, as exit_mmap() was.  And
we certainly have no interest in mapping as a THP once dumping core.

Fixes: 59ea6d06cfa9 ("coredump: fix race condition between collapse_huge_page() and core dumping")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org # v4.8+
---
Note on stable backporting: the coredump fix was backported as far as
v3.16, but this extension only needed where shmem or file THP supported.

 mm/khugepaged.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- 5.8-rc7/mm/khugepaged.c	2020-07-26 16:58:02.189038680 -0700
+++ linux/mm/khugepaged.c	2020-08-02 10:56:11.105617241 -0700
@@ -431,7 +431,7 @@ static void insert_to_mm_slots_hash(stru
 
 static inline int khugepaged_test_exit(struct mm_struct *mm)
 {
-	return atomic_read(&mm->mm_users) == 0;
+	return atomic_read(&mm->mm_users) == 0 || !mmget_still_valid(mm);
 }
 
 static bool hugepage_vma_check(struct vm_area_struct *vma,
@@ -1100,9 +1100,6 @@ static void collapse_huge_page(struct mm
 	 * handled by the anon_vma lock + PG_lock.
 	 */
 	mmap_write_lock(mm);
-	result = SCAN_ANY_PROCESS;
-	if (!mmget_still_valid(mm))
-		goto out;
 	result = hugepage_vma_revalidate(mm, address, &vma);
 	if (result)
 		goto out;
