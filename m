Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54161C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28317206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQGCGDfi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgBTQbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:31:48 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47742 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728788AbgBTQbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:31:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582216305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pNbMD8h94PEyk7ZB2quMRa+mQt+SyNS5feRUb7MU+eY=;
        b=YQGCGDfiz84f1F/Rwoh/8gM/0jTW6kutNj1gQROeKH0E6TmzSxTwZWHrDkJNqp408MMB9J
        pXI3s3NcuXE2UFuGLI/UCuAnbbHh00eimE+9SjPK4m48ayDRn5P1zP8+uPcI6juwl+hNlO
        kN0gbRn+QeJD4uMvRvoFfucgciSBPHo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-F5OHVlcxPcqs-fV-8sDe8w-1; Thu, 20 Feb 2020 11:31:43 -0500
X-MC-Unique: F5OHVlcxPcqs-fV-8sDe8w-1
Received: by mail-qt1-f197.google.com with SMTP id m8so2951079qta.20
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:31:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pNbMD8h94PEyk7ZB2quMRa+mQt+SyNS5feRUb7MU+eY=;
        b=bu4Dbdndd4TLi0/QxfJgN1Qu+8Sv2+ereBVn3RAEUoazUq6YeH4iIFPo3Cdi3MqZwV
         vM7c2cfTcMSLfBxvwtqLSaWVl3b7WKTPztXL+FZntx0sPLncZOwJ5KEML0ukJYU6O7ey
         oVEWsVCHhIXdOdXs+xlw9UqN2hR4rsU6Opq7X+VaRgMMOvDOms62kJ0DloPwfTr/0J9T
         no6QN0WR9SNvUBK0+FwP2WueGkznrMbrraFv4fyOrrEY8dEgs0/BBVnqciFLnM/SBuMD
         QBNc6k2WFzFUZPIQfXMHwJQkHD7Us246NTNYgPfQ4KoD+yA9q7cdjCvozqdhc71zzMga
         iZoQ==
X-Gm-Message-State: APjAAAUnudLC1l6OP+sdMVvzze2dXprNHFXLa7I0qWv8y5+gFrZxkh2C
        3txtpnYLj67Y54UDWWjnO+63Qjmgm0Z1hvFPUM1aNIZa9lc167OmFBqHNdaq6KdWVe3SZdPI/mD
        0t86I4ebt0prHeKM3AhD40os6
X-Received: by 2002:a0c:f412:: with SMTP id h18mr26792907qvl.124.1582216302765;
        Thu, 20 Feb 2020 08:31:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqyzpD7dCbZe5R9YUkLsh6bUSiBnhC9LIv4j2aOfGaXadHL8Np9pCBbqpRrmVNzc8iZ2PzkM8Q==
X-Received: by 2002:a0c:f412:: with SMTP id h18mr26792469qvl.124.1582216297889;
        Thu, 20 Feb 2020 08:31:37 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id l19sm42366qkl.3.2020.02.20.08.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:31:37 -0800 (PST)
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
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>,
        Rik van Riel <riel@redhat.com>
Subject: [PATCH v6 12/19] userfaultfd: wp: support write protection for userfault vma range
Date:   Thu, 20 Feb 2020 11:31:05 -0500
Message-Id: <20200220163112.11409-13-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220163112.11409-1-peterx@redhat.com>
References: <20200220163112.11409-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaohua Li <shli@fb.com>

Add API to enable/disable writeprotect a vma range. Unlike mprotect,
this doesn't split/merge vmas.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
[peterx:
 - use the helper to find VMA;
 - return -ENOENT if not found to match mcopy case;
 - use the new MM_CP_UFFD_WP* flags for change_protection
 - check against mmap_changing for failures
 - replace find_dst_vma with vma_find_uffd]
Reviewed-by: Jerome Glisse <jglisse@redhat.com>
Reviewed-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/userfaultfd_k.h |  3 ++
 mm/userfaultfd.c              | 54 +++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index dcd33172b728..a8e5f3ea9bb2 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -41,6 +41,9 @@ extern ssize_t mfill_zeropage(struct mm_struct *dst_mm,
 			      unsigned long dst_start,
 			      unsigned long len,
 			      bool *mmap_changing);
+extern int mwriteprotect_range(struct mm_struct *dst_mm,
+			       unsigned long start, unsigned long len,
+			       bool enable_wp, bool *mmap_changing);
 
 /* mm helpers */
 static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 4a06613525ee..cf1217e6f956 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -631,3 +631,57 @@ ssize_t mfill_zeropage(struct mm_struct *dst_mm, unsigned long start,
 {
 	return __mcopy_atomic(dst_mm, start, 0, len, true, mmap_changing, 0);
 }
+
+int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
+			unsigned long len, bool enable_wp, bool *mmap_changing)
+{
+	struct vm_area_struct *dst_vma;
+	pgprot_t newprot;
+	int err;
+
+	/*
+	 * Sanitize the command parameters:
+	 */
+	BUG_ON(start & ~PAGE_MASK);
+	BUG_ON(len & ~PAGE_MASK);
+
+	/* Does the address range wrap, or is the span zero-sized? */
+	BUG_ON(start + len <= start);
+
+	down_read(&dst_mm->mmap_sem);
+
+	/*
+	 * If memory mappings are changing because of non-cooperative
+	 * operation (e.g. mremap) running in parallel, bail out and
+	 * request the user to retry later
+	 */
+	err = -EAGAIN;
+	if (mmap_changing && READ_ONCE(*mmap_changing))
+		goto out_unlock;
+
+	err = -ENOENT;
+	dst_vma = find_dst_vma(dst_mm, start, len);
+	/*
+	 * Make sure the vma is not shared, that the dst range is
+	 * both valid and fully within a single existing vma.
+	 */
+	if (!dst_vma || (dst_vma->vm_flags & VM_SHARED))
+		goto out_unlock;
+	if (!userfaultfd_wp(dst_vma))
+		goto out_unlock;
+	if (!vma_is_anonymous(dst_vma))
+		goto out_unlock;
+
+	if (enable_wp)
+		newprot = vm_get_page_prot(dst_vma->vm_flags & ~(VM_WRITE));
+	else
+		newprot = vm_get_page_prot(dst_vma->vm_flags);
+
+	change_protection(dst_vma, start, start + len, newprot,
+			  enable_wp ? MM_CP_UFFD_WP : MM_CP_UFFD_WP_RESOLVE);
+
+	err = 0;
+out_unlock:
+	up_read(&dst_mm->mmap_sem);
+	return err;
+}
-- 
2.24.1

