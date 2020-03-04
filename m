Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8484FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C7F21775
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="aYDMzrpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387840AbgCDK3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:29:19 -0500
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:45226 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729138AbgCDK2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:28:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 7ECCE3F888;
        Wed,  4 Mar 2020 11:28:52 +0100 (CET)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=aYDMzrpo;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ovLp4pFr5_Wd; Wed,  4 Mar 2020 11:28:50 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 5CC693F885;
        Wed,  4 Mar 2020 11:28:48 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 0E83136042F;
        Wed,  4 Mar 2020 11:28:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1583317728; bh=eArF6ZjbQdomBzBVnzbUQcGFkrLPEvAM1NjLa5asgsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aYDMzrpoD0nNuFdNRG3boslnkJ3rFO1pNqTFdJzDcSDijQcx1cRVU0nVBP0ouv6pf
         qjDLfCcx2elKnNFohIkbfgdg91M67xEBCYHm0kFTqUbhgnHkt+nSBzysBEAeaviqL/
         qsn1A4dTA6TfXugmDW4/HvLd2yNQwBqXVShRK0kY=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v6 3/9] mm: Split huge pages on write-notify or COW
Date:   Wed,  4 Mar 2020 11:28:34 +0100
Message-Id: <20200304102840.2801-4-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200304102840.2801-1-thomas_os@shipmail.org>
References: <20200304102840.2801-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

The functions wp_huge_pmd() and wp_huge_pud() currently relies on the
huge_fault() callback to split huge page table entries if needed.
However for module users that requires export of the split_huge_xxx()
functionality which may be undesired. Instead split pre-existing huge
page-table entries on VM_FAULT_FALLBACK return.

We currently only do COW and write-notify on the PTE level, so if the
huge_fault() handler returns VM_FAULT_FALLBACK on wp faults,
split the huge pages and page-table entries. Also do this for huge PUDs
if there is no huge_fault() handler and the vma is not anonymous, similar
to how it's done for PMDs.

Note that fs/dax.c still does the splitting in the huge_fault() handler, but as
huge_fault() A follow-up patch can remove the dax.c split_huge_pmd() if needed.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 mm/memory.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 0bccc622e482..1e3fc1988790 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3932,11 +3932,14 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf, pmd_t orig_pmd)
 {
 	if (vma_is_anonymous(vmf->vma))
 		return do_huge_pmd_wp_page(vmf, orig_pmd);
-	if (vmf->vma->vm_ops->huge_fault)
-		return vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PMD);
+	if (vmf->vma->vm_ops->huge_fault) {
+		vm_fault_t ret = vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PMD);
 
-	/* COW handled on pte level: split pmd */
-	VM_BUG_ON_VMA(vmf->vma->vm_flags & VM_SHARED, vmf->vma);
+		if (!(ret & VM_FAULT_FALLBACK))
+			return ret;
+	}
+
+	/* COW or write-notify handled on pte level: split pmd. */
 	__split_huge_pmd(vmf->vma, vmf->pmd, vmf->address, false, NULL);
 
 	return VM_FAULT_FALLBACK;
@@ -3949,12 +3952,20 @@ static inline bool vma_is_accessible(struct vm_area_struct *vma)
 
 static vm_fault_t create_huge_pud(struct vm_fault *vmf)
 {
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&			\
+	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 	/* No support for anonymous transparent PUD pages yet */
 	if (vma_is_anonymous(vmf->vma))
-		return VM_FAULT_FALLBACK;
-	if (vmf->vma->vm_ops->huge_fault)
-		return vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
+		goto split;
+	if (vmf->vma->vm_ops->huge_fault) {
+		vm_fault_t ret = vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
+
+		if (!(ret & VM_FAULT_FALLBACK))
+			return ret;
+	}
+split:
+	/* COW or write-notify not handled on PUD level: split pud.*/
+	__split_huge_pud(vmf->vma, vmf->pud, vmf->address);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 	return VM_FAULT_FALLBACK;
 }
-- 
2.21.1

