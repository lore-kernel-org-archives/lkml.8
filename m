Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BD1C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9313020658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMsPovza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgBTQDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:03:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36534 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728428AbgBTQDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582214582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q5FY/Zzd2u2AdqZ3/YqXWZ85ciAIFYLeZe5XKvNHEBI=;
        b=VMsPovzaISRD9wCO+kDY0A5ajPO5z4kfxdo78c3KRKqEzDoBhUmtK3dHiIP4y9TnlUu1ZK
        v7Pg+n81bd6GlrhWM3/V0DRA5uX6cwQF3cW0ERNNfWiY93G6DW868v0Y5oBUL3C/L26XDb
        sR1JIt4Nz+eab5kaRAaynHsgtCfro9k=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-DRN7CqDQMnO2cDTxRFP9AA-1; Thu, 20 Feb 2020 11:02:59 -0500
X-MC-Unique: DRN7CqDQMnO2cDTxRFP9AA-1
Received: by mail-qk1-f199.google.com with SMTP id b23so3028198qkg.17
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:02:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q5FY/Zzd2u2AdqZ3/YqXWZ85ciAIFYLeZe5XKvNHEBI=;
        b=MbWzRvI0eEUuSu6xWLzo+k0xsGdazPwFjffRcDbsfIktqtiYt1sNxHJwVzjp9kBmSy
         4QafWddqjDLwbChCGwWvCj1Ui+KcWV3SxVTvK9vOSkb8xSXr40q0ZKqK8xznuLmkrXSA
         tQTPlZ9Gg9BkMhwwdP29NZL1OGYXafeDkaeoVX+VMfMOn0suGPoccqMRYy5u3hFT0tAZ
         ufiNzc6P+PDvJmgtLpcbvc12VIzDYbIfQwT6kxGCtBGrNVVQjpp/dgzEZwCwNq+o7azI
         3ZoQYUyqaG23/qat6n+k9PS6MHLh4CEH1TthISBeb+6ASZTKN3KUVaCqB1ivEL1gIJmY
         STWQ==
X-Gm-Message-State: APjAAAXqBE71yoZHtcT6q+FUzu2NKc4w4CL3WbI0HF1MHUd5qncfdv/M
        8h1FptBzaCQLuoZoA5jt80+TLq6gnvmZZcOPHWRsWwDAjDj03QIOc9wgaJUI6gUxJZ8hzd21rEY
        Mbh1QIL+qYoTK+7XAvhoiujcn
X-Received: by 2002:ac8:76d7:: with SMTP id q23mr26733648qtr.198.1582214579291;
        Thu, 20 Feb 2020 08:02:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqwoNuezOvlo55PbKbVDuaGVM6RJ8MihIsmeXUiSVkGz8jhyvlUwzF/7iq9KMKbFy8anvbkKyw==
X-Received: by 2002:ac8:76d7:: with SMTP id q23mr26733627qtr.198.1582214579032;
        Thu, 20 Feb 2020 08:02:59 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id 139sm1821617qkg.79.2020.02.20.08.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:02:58 -0800 (PST)
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
Subject: [PATCH RESEND v6 15/16] mm/gup: Allow to react to fatal signals
Date:   Thu, 20 Feb 2020 11:02:56 -0500
Message-Id: <20200220160256.9887-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220155353.8676-1-peterx@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing gup code does not react to the fatal signals in many code
paths.  For example, in one retry path of gup we're still using
down_read() rather than down_read_killable().  Also, when doing page
faults we don't pass in FAULT_FLAG_KILLABLE as well, which means that
within the faulting process we'll wait in non-killable way as well.
These were spotted by Linus during the code review of some other
patches.

Let's allow the gup code to react to fatal signals to improve the
responsiveness of threads when during gup and being killed.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c     | 12 +++++++++---
 mm/hugetlb.c |  3 ++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index ec2b76f44a01..3f0cb14334ac 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -648,7 +648,7 @@ static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
 	if (*flags & FOLL_REMOTE)
 		fault_flags |= FAULT_FLAG_REMOTE;
 	if (locked)
-		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
+		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 	if (*flags & FOLL_NOWAIT)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_RETRY_NOWAIT;
 	if (*flags & FOLL_TRIED) {
@@ -991,7 +991,7 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 	address = untagged_addr(address);
 
 	if (unlocked)
-		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
+		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
 retry:
 	vma = find_extend_vma(mm, address);
@@ -1113,7 +1113,13 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
 			break;
 
 		*locked = 1;
-		down_read(&mm->mmap_sem);
+		ret = down_read_killable(&mm->mmap_sem);
+		if (ret) {
+			BUG_ON(ret > 0);
+			if (!pages_done)
+				pages_done = ret;
+			break;
+		}
 
 		ret = __get_user_pages(tsk, mm, start, 1, flags | FOLL_TRIED,
 				       pages, NULL, locked);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ac9a28d51674..c342b091a7a4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4338,7 +4338,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			if (flags & FOLL_WRITE)
 				fault_flags |= FAULT_FLAG_WRITE;
 			if (locked)
-				fault_flags |= FAULT_FLAG_ALLOW_RETRY;
+				fault_flags |= FAULT_FLAG_ALLOW_RETRY |
+					FAULT_FLAG_KILLABLE;
 			if (flags & FOLL_NOWAIT)
 				fault_flags |= FAULT_FLAG_ALLOW_RETRY |
 					FAULT_FLAG_RETRY_NOWAIT;
-- 
2.24.1

