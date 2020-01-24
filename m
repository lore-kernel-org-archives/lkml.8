Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0316BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DF02075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="lmfX8Jm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgAXJQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:16:50 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:35753 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbgAXJQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:16:49 -0500
X-Greylist: delayed 416 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Jan 2020 04:16:49 EST
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 681DF3F6EE;
        Fri, 24 Jan 2020 10:09:51 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=lmfX8Jm+;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ja-EDtmmEIsb; Fri, 24 Jan 2020 10:09:50 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 524263F5D8;
        Fri, 24 Jan 2020 10:09:48 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id E914F360653;
        Fri, 24 Jan 2020 10:09:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1579856988; bh=3/LLclKt7+aCOVoEUoZ2rgY+/+paTMjeNbg1mLjGtXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lmfX8Jm+eY3Ry7JJWrVaHib0VAmvysHOsKTd9EAgG/hvEs5eV4BZxhxGhZkhc3KUb
         qjticevxCPxJ7uQTZL5bBAT/UuQbgXOtIDKWZyMumrDy3cVT4UDntUaK2AQro++6tB
         l+ZCGTshLQUO4igVhjWCh145hJkc3nYcxQvdNfJY=
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
Subject: [PATCH 3/9] mm: Split huge pages on write-notify or COW
Date:   Fri, 24 Jan 2020 10:09:34 +0100
Message-Id: <20200124090940.26571-4-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200124090940.26571-1-thomas_os@shipmail.org>
References: <20200124090940.26571-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

We currently only do COW and write-notify on the PTE level, so if the
huge_fault() handler returns VM_FAULT_FALLBACK on wp faults,
split the huge pages and page-table entries. Also do this for huge PUDs
if there is no huge_fault() handler and the vma is not anonymous, similar
to how it's done for PMDs.

Note that fs/dax.c does the splitting in the huge_fault() handler, but as
huge_fault() is implemented by modules we need to consider whether to
export the splitting functions for use in the modules or whether to try
to keep calls in the core. Opt for the latter. A follow-up patch can
remove the dax.c split_huge_pmd() if needed.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 mm/memory.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 17aadc751e5c..4c49fe963e5c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3880,11 +3880,14 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf, pmd_t orig_pmd)
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
@@ -3897,12 +3900,20 @@ static inline bool vma_is_accessible(struct vm_area_struct *vma)
 
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
2.21.0

