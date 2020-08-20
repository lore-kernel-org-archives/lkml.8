Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB3FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 640812067C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597927253;
	bh=39Z9j7pSv3zj/6DctPXmCOucfnypwgtF2cull4xZDpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v+pFIGqtxI/rYmidh8SfYMPzQoreWE7EI8x7XoJFTvPOO0FJKkuetUuOE0la+jH2t
	 Qjn+T2RD4ovUGvjPJddrcjbrmUfMBUYLoW5Vd5oDQxwKlIYc9nfFL2gEr8O+Z79xeO
	 vn713O9WqFJFgQaZVDOcZB6I91X9R1k5/Ek+UpTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbgHTMku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:40:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729349AbgHTJqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:46:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E18922078D;
        Thu, 20 Aug 2020 09:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916803;
        bh=39Z9j7pSv3zj/6DctPXmCOucfnypwgtF2cull4xZDpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SfiJZW3Y6iBafs3+M/PrHRVH/qTA6QzBbrAlYysg+OQSnWiF0+DiKath5o208FP9P
         9KkkmlStq6N5fhCYD+t/JJL3WxAJ/h1phfCmuZdrKvHaGBSSxS1K9EcMl3YokW4RUe
         JuQ5CdQpR/R1rbK5FSoclBimnOuv4NQZXlfDTkaQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Song Liu <songliubraving@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.4 052/152] khugepaged: collapse_pte_mapped_thp() flush the right range
Date:   Thu, 20 Aug 2020 11:20:19 +0200
Message-Id: <20200820091556.382934995@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091553.615456912@linuxfoundation.org>
References: <20200820091553.615456912@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugh Dickins <hughd@google.com>

commit 723a80dafed5c95889d48baab9aa433a6ffa0b4e upstream.

pmdp_collapse_flush() should be given the start address at which the huge
page is mapped, haddr: it was given addr, which at that point has been
used as a local variable, incremented to the end address of the extent.

Found by source inspection while chasing a hugepage locking bug, which I
then could not explain by this.  At first I thought this was very bad;
then saw that all of the page translations that were not flushed would
actually still point to the right pages afterwards, so harmless; then
realized that I know nothing of how different architectures and models
cache intermediate paging structures, so maybe it matters after all -
particularly since the page table concerned is immediately freed.

Much easier to fix than to think about.

Fixes: 27e1f8273113 ("khugepaged: enable collapse pmd for pte-mapped THP")
Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: <stable@vger.kernel.org>	[5.4+]
Link: http://lkml.kernel.org/r/alpine.LSU.2.11.2008021204390.27773@eggly.anvils
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/khugepaged.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1384,7 +1384,7 @@ void collapse_pte_mapped_thp(struct mm_s
 
 	/* step 4: collapse pmd */
 	ptl = pmd_lock(vma->vm_mm, pmd);
-	_pmd = pmdp_collapse_flush(vma, addr, pmd);
+	_pmd = pmdp_collapse_flush(vma, haddr, pmd);
 	spin_unlock(ptl);
 	mm_dec_nr_ptes(mm);
 	pte_free(mm, pmd_pgtable(_pmd));


