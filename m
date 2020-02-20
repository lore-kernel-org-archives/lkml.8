Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D025C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25ADC206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQK2lEIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgBTQbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:31:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45462 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727868AbgBTQbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582216281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CHUFDqjtneZv80jBBtiyIEM9rxGSYmYj1xgCDRa8zzo=;
        b=cQK2lEIxqT/gmOPMLfTUeweFVYMj7D786Z/CwiXOuog8UF+6Wd4xGZW2WNk4+DvU6aSiwp
        1YLnBEdFdjuaorYmbqdFUjFtam3Z9OOIvqPAs+VcYuWfWJFISQpCCOjwXQgVmcTbWBlUOF
        mSgG/u/RndbsGn1tVQdZiDbQSaTztF0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-r-_C-lArN1SMLZxPWjFOWA-1; Thu, 20 Feb 2020 11:31:19 -0500
X-MC-Unique: r-_C-lArN1SMLZxPWjFOWA-1
Received: by mail-qt1-f197.google.com with SMTP id l25so2980710qtu.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:31:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CHUFDqjtneZv80jBBtiyIEM9rxGSYmYj1xgCDRa8zzo=;
        b=qP1dm/7vep40l2akdqEuws6m9Trp63JnntoqIJg/BqoFGKjVdwWTjrtnfdTTRXKDDn
         VhBBCYc7GYam9aO6+Pv1HnMS8F6HBfkPHbBVToztdCCLUxMH6tUwTp0Ei5kq7ODDxgsk
         bWJ+OtKxtpZ2SLQsZoG3yqmpEcEaINqT/zZvikfywuPtU6toQ9XC8KtQQY49f5L0H0fJ
         GWukEuFQecxNmovPuhYh+I0t/7zCuqkQkRmbPs7fXum7fnsiDvTYujAcuN2x3a7eyZdb
         PH/WCEG9K1Ke91Syp1gPttiAhRZJiWchkq/yf2lqchAyXEnwuea636EwvRPoYpur51/i
         vt9A==
X-Gm-Message-State: APjAAAV6iHknhf92jRh0WWbxj+vAbECPXJDqxSMtfxHpLlr/Bjgxs90+
        ZcmdI2P+mnkZii3ypkWToVHWoIrweZ6XrIMQpmCtciphkLw7xOb0OCWmZbZaiqiweNMxNHYOY2W
        SwN03apedgoGLUviqhDVVUi0H
X-Received: by 2002:a37:9c10:: with SMTP id f16mr29744441qke.275.1582216278843;
        Thu, 20 Feb 2020 08:31:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqx4qYyI240EJ4iaY8NxDR5Afaf1dkjtOJEaaFOxolIwXiqPaZSbmCZWqp6IyApgQc2eCSyiFA==
X-Received: by 2002:a37:9c10:: with SMTP id f16mr29744392qke.275.1582216278582;
        Thu, 20 Feb 2020 08:31:18 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id l19sm42366qkl.3.2020.02.20.08.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:31:17 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Brian Geffon <bgeffon@google.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Bobby Powers <bobbypowers@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>
Subject: [PATCH v6 02/19] userfaultfd: wp: hook userfault handler to write protection fault
Date:   Thu, 20 Feb 2020 11:30:55 -0500
Message-Id: <20200220163112.11409-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220163112.11409-1-peterx@redhat.com>
References: <20200220163112.11409-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Arcangeli <aarcange@redhat.com>

There are several cases write protection fault happens. It could be a
write to zero page, swaped page or userfault write protected
page. When the fault happens, there is no way to know if userfault
write protect the page before. Here we just blindly issue a userfault
notification for vma with VM_UFFD_WP regardless if app write protects
it yet. Application should be ready to handle such wp fault.

v1: From: Shaohua Li <shli@fb.com>

v2: Handle the userfault in the common do_wp_page. If we get there a
pagetable is present and readonly so no need to do further processing
until we solve the userfault.

In the swapin case, always swapin as readonly. This will cause false
positive userfaults. We need to decide later if to eliminate them with
a flag like soft-dirty in the swap entry (see _PAGE_SWP_SOFT_DIRTY).

hugetlbfs wouldn't need to worry about swapouts but and tmpfs would
be handled by a swap entry bit like anonymous memory.

The main problem with no easy solution to eliminate the false
positives, will be if/when userfaultfd is extended to real filesystem
pagecache. When the pagecache is freed by reclaim we can't leave the
radix tree pinned if the inode and in turn the radix tree is reclaimed
as well.

The estimation is that full accuracy and lack of false positives could
be easily provided only to anonymous memory (as long as there's no
fork or as long as MADV_DONTFORK is used on the userfaultfd anonymous
range) tmpfs and hugetlbfs, it's most certainly worth to achieve it
but in a later incremental patch.

v3: Add hooking point for THP wrprotect faults.

CC: Shaohua Li <shli@fb.com>
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
[peterx: don't conditionally drop FAULT_FLAG_WRITE in do_swap_page]
Reviewed-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Reviewed-by: Jerome Glisse <jglisse@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 0bccc622e482..3d8c7e8652e9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2733,6 +2733,11 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 
+	if (userfaultfd_wp(vma)) {
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		return handle_userfault(vmf, VM_UFFD_WP);
+	}
+
 	vmf->page = vm_normal_page(vma, vmf->address, vmf->orig_pte);
 	if (!vmf->page) {
 		/*
@@ -3930,8 +3935,11 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 /* `inline' is required to avoid gcc 4.1.2 build error */
 static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf, pmd_t orig_pmd)
 {
-	if (vma_is_anonymous(vmf->vma))
+	if (vma_is_anonymous(vmf->vma)) {
+		if (userfaultfd_wp(vmf->vma))
+			return handle_userfault(vmf, VM_UFFD_WP);
 		return do_huge_pmd_wp_page(vmf, orig_pmd);
+	}
 	if (vmf->vma->vm_ops->huge_fault)
 		return vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PMD);
 
-- 
2.24.1

