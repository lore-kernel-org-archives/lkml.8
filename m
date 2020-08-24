Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05BCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 976A62072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598259174;
	bh=dOuvFQoLG2+iBcwFTac/uZ5LdgTProqLm/wMU2a01nU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qaDA+5PuiCCZdI3fnIetrFOsAAfO4s0oph9AFhd3shJaTbwTSdKpNo/3nlSzGCA/J
	 u3Rv3u1gWROCHb3eeS72w0LnASRwzCJBtC4Sk8mWzcyQOA/+3BNX4ahRSLcZ7NbgBY
	 HQMx6gMtwEWaqN6v5F76MltiQKVCefUaMCcume4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgHXIwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:52:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729534AbgHXIw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:52:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EB7A208E4;
        Mon, 24 Aug 2020 08:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259147;
        bh=dOuvFQoLG2+iBcwFTac/uZ5LdgTProqLm/wMU2a01nU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FK/PFkNbuL10Y6kUK4LCJ/4IwGeG7BlfjKY6vW6pZU24NeEidE6eTAWYGRC3Rmcij
         kUlCSCYJMtOkYIJ5Cc2e3fpMQ9Ii5mePo9K8s7xhXfZrnUQJw+8A9bBHw7yvx8/c3S
         jPcnMz4K0rcgybiisseLRwOdzqZ6d4ugcKEsDbHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 38/39] mm/hugetlb: fix calculation of adjust_range_if_pmd_sharing_possible
Date:   Mon, 24 Aug 2020 10:31:37 +0200
Message-Id: <20200824082350.486010746@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082348.445866152@linuxfoundation.org>
References: <20200824082348.445866152@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Xu <peterx@redhat.com>

commit 75802ca66354a39ab8e35822747cd08b3384a99a upstream.

This is found by code observation only.

Firstly, the worst case scenario should assume the whole range was covered
by pmd sharing.  The old algorithm might not work as expected for ranges
like (1g-2m, 1g+2m), where the adjusted range should be (0, 1g+2m) but the
expected range should be (0, 2g).

Since at it, remove the loop since it should not be required.  With that,
the new code should be faster too when the invalidating range is huge.

Mike said:

: With range (1g-2m, 1g+2m) within a vma (0, 2g) the existing code will only
: adjust to (0, 1g+2m) which is incorrect.
:
: We should cc stable.  The original reason for adjusting the range was to
: prevent data corruption (getting wrong page).  Since the range is not
: always adjusted correctly, the potential for corruption still exists.
:
: However, I am fairly confident that adjust_range_if_pmd_sharing_possible
: is only gong to be called in two cases:
:
: 1) for a single page
: 2) for range == entire vma
:
: In those cases, the current code should produce the correct results.
:
: To be safe, let's just cc stable.

Fixes: 017b1660df89 ("mm: migration: fix migration of huge PMD shared pages")
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/20200730201636.74778-1-peterx@redhat.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/hugetlb.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4380,25 +4380,21 @@ static bool vma_shareable(struct vm_area
 void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 				unsigned long *start, unsigned long *end)
 {
-	unsigned long check_addr = *start;
+	unsigned long a_start, a_end;
 
 	if (!(vma->vm_flags & VM_MAYSHARE))
 		return;
 
-	for (check_addr = *start; check_addr < *end; check_addr += PUD_SIZE) {
-		unsigned long a_start = check_addr & PUD_MASK;
-		unsigned long a_end = a_start + PUD_SIZE;
+	/* Extend the range to be PUD aligned for a worst case scenario */
+	a_start = ALIGN_DOWN(*start, PUD_SIZE);
+	a_end = ALIGN(*end, PUD_SIZE);
 
-		/*
-		 * If sharing is possible, adjust start/end if necessary.
-		 */
-		if (range_in_vma(vma, a_start, a_end)) {
-			if (a_start < *start)
-				*start = a_start;
-			if (a_end > *end)
-				*end = a_end;
-		}
-	}
+	/*
+	 * Intersect the range with the vma range, since pmd sharing won't be
+	 * across vma after all
+	 */
+	*start = max(vma->vm_start, a_start);
+	*end = min(vma->vm_end, a_end);
 }
 
 /*


