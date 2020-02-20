Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC51C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FD1208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLzTcpTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgBTTyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:54:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49865 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728556AbgBTTyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582228442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fez1YLYoRTejKdl3XovFZRqHL8yeL2JwUep3jNimnQM=;
        b=WLzTcpTU2VGcnTgHsUzdEjIub5u2+7yDAgL+UD16gT09lNzslx1xOEySgq2VV0xRu81c+l
        uwZZYwi9bTWbmf2qApbo6xlbsmQigyQhhJIDb5FRPCIK+UNKYcB9KjUT9sAWle88PT9+VC
        ubuiovkClXAykm67izuPw5nWX+OJaYE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-Ar63fx_ePSS9Hvsku2YrUQ-1; Thu, 20 Feb 2020 14:54:00 -0500
X-MC-Unique: Ar63fx_ePSS9Hvsku2YrUQ-1
Received: by mail-qt1-f199.google.com with SMTP id r30so3373174qtb.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 11:54:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fez1YLYoRTejKdl3XovFZRqHL8yeL2JwUep3jNimnQM=;
        b=Db+NET4UXZ3i9Ya0tN5mVBrstQ4hFGW4FkHCL9gWu61FkOurCtmeQY2LaH4zEOZOYg
         pn/cZO4KMjIBS/Idgbi85LrcOrXJRL8zoGqu8lC9Ew/goPyhoiVmcrnRtP7rZxtX9vQb
         Sa+PsdnAKhNWOQK34Ri8XQcWpEyoJElIxpk8X1HLu4coKBdPSejaCWiZV35jIKqveqQJ
         QXyvM/U19Du/OhCd05AJzBGAg5Iy3eSbsgkN41HbQ4nCFLtKktyqErTnNpPOKEoI3zyl
         CG7V9awYnLX2qWFp5AdrpOODNu3odO4vHX9KsLSK+Dz5iep6ZHfufH4VMZHfep96FYic
         7MZg==
X-Gm-Message-State: APjAAAXD1bKmqJhDmp7VkXCiyXQzkrR1P5lHXKHIvsd6taDaFZ6juneY
        M/s6o10G44Wzxo/7q+IyaFAb9an3Ain9h7zDW4FlIZZOTugRyW4jh4y0Hmz/ZaUtP9GX1V+sd61
        T6qEWbwGjduT+Hex7C6TwmYiu
X-Received: by 2002:a05:6214:1750:: with SMTP id dc16mr27322419qvb.47.1582228439903;
        Thu, 20 Feb 2020 11:53:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqwEIhUPaSeXK2C2o3Bv58EPeWBkwTGMcKqMaRd3x8T+f6afhWOfRCq+hk0nYhl6E3hyCskSsQ==
X-Received: by 2002:a05:6214:1750:: with SMTP id dc16mr27322394qvb.47.1582228439636;
        Thu, 20 Feb 2020 11:53:59 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id a192sm332776qkb.53.2020.02.20.11.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 11:53:59 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>, Martin Cracauer <cracauer@cons.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Brian Geffon <bgeffon@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        David Hildenbrand <david@redhat.com>,
        Bobby Powers <bobbypowers@gmail.com>,
        Mel Gorman <mgorman@suse.de>
Subject: [PATCH RESEND v6 14/16] mm/gup: Allow VM_FAULT_RETRY for multiple times
Date:   Thu, 20 Feb 2020 14:53:57 -0500
Message-Id: <20200220195357.16371-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220155353.8676-1-peterx@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the gup counterpart of the change that allows the
VM_FAULT_RETRY to happen for more than once.  One thing to mention is
that we must check the fatal signal here before retry because the GUP
can be interrupted by that, otherwise we can loop forever.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c     | 27 +++++++++++++++++++++------
 mm/hugetlb.c |  6 ++++--
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 76cb420c0fb7..ec2b76f44a01 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -652,7 +652,10 @@ static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
 	if (*flags & FOLL_NOWAIT)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_RETRY_NOWAIT;
 	if (*flags & FOLL_TRIED) {
-		VM_WARN_ON_ONCE(fault_flags & FAULT_FLAG_ALLOW_RETRY);
+		/*
+		 * Note: FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_TRIED
+		 * can co-exist
+		 */
 		fault_flags |= FAULT_FLAG_TRIED;
 	}
 
@@ -1012,7 +1015,6 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 		down_read(&mm->mmap_sem);
 		if (!(fault_flags & FAULT_FLAG_TRIED)) {
 			*unlocked = true;
-			fault_flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			fault_flags |= FAULT_FLAG_TRIED;
 			goto retry;
 		}
@@ -1096,17 +1098,30 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
 		if (likely(pages))
 			pages += ret;
 		start += ret << PAGE_SHIFT;
+		lock_dropped = true;
 
+retry:
 		/*
 		 * Repeat on the address that fired VM_FAULT_RETRY
-		 * without FAULT_FLAG_ALLOW_RETRY but with
-		 * FAULT_FLAG_TRIED.
+		 * with both FAULT_FLAG_ALLOW_RETRY and
+		 * FAULT_FLAG_TRIED.  Note that GUP can be interrupted
+		 * by fatal signals, so we need to check it before we
+		 * start trying again otherwise it can loop forever.
 		 */
+
+		if (fatal_signal_pending(current))
+			break;
+
 		*locked = 1;
-		lock_dropped = true;
 		down_read(&mm->mmap_sem);
+
 		ret = __get_user_pages(tsk, mm, start, 1, flags | FOLL_TRIED,
-				       pages, NULL, NULL);
+				       pages, NULL, locked);
+		if (!*locked) {
+			/* Continue to retry until we succeeded */
+			BUG_ON(ret != 0);
+			goto retry;
+		}
 		if (ret != 1) {
 			BUG_ON(ret > 1);
 			if (!pages_done)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c84f721db020..ac9a28d51674 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4343,8 +4343,10 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 				fault_flags |= FAULT_FLAG_ALLOW_RETRY |
 					FAULT_FLAG_RETRY_NOWAIT;
 			if (flags & FOLL_TRIED) {
-				VM_WARN_ON_ONCE(fault_flags &
-						FAULT_FLAG_ALLOW_RETRY);
+				/*
+				 * Note: FAULT_FLAG_ALLOW_RETRY and
+				 * FAULT_FLAG_TRIED can co-exist
+				 */
 				fault_flags |= FAULT_FLAG_TRIED;
 			}
 			ret = hugetlb_fault(mm, vma, vaddr, fault_flags);
-- 
2.24.1

