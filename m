Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93D2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E4F22B4B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597915709;
	bh=7a11vyjkFBvgDh5rGkcLcXiUPLhdNhbeJ8aUbN/3XCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L4/QIRXQJZZ6qNSQUfXlTsnuv/3NSKENA2uQx+RzQUv+tpBpYD6UbLClbfgnn7yeS
	 7szQ1RsW3wtiiQVuGBRicMXhCCI3/IXzjnziaLYUb7n63fKLihqsWJj5s7Zx3XMTMY
	 2Ga9TVBs0QliWwfH11tLGzMWpXPLi0X8Od+Ef4Ng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgHTJ22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:28:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbgHTJ1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:27:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E153222D02;
        Thu, 20 Aug 2020 09:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915621;
        bh=7a11vyjkFBvgDh5rGkcLcXiUPLhdNhbeJ8aUbN/3XCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vj9xj3iA0bRK6mUk9bDb27WJ3F3eWmlsFKvhEktXO2yXraB0gGeQpEgtzIYOek72c
         nZujJmsmGwyMxzArtocCyTB818rDxoi0qQyUhXKo9edIRpUNA/gO1+SB+NS/Uv5Lxk
         j7ggkhKt+WOnpVRD5xm6LmLyrRidH3GWxyCT4luY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.8 078/232] mm/hugetlb: fix calculation of adjust_range_if_pmd_sharing_possible
Date:   Thu, 20 Aug 2020 11:18:49 +0200
Message-Id: <20200820091616.590598104@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/hugetlb.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5313,25 +5313,21 @@ static bool vma_shareable(struct vm_area
 void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 				unsigned long *start, unsigned long *end)
 {
-	unsigned long check_addr;
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


