Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E00C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60CB22527
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="QinxkUM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgBRPld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 10:41:33 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40087 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgBRPld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 10:41:33 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18so23476009ljo.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 07:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1prNYVi8te7tpWxKFgmK7lDkMWxtco2vgGigTJkyqhk=;
        b=QinxkUM/O6Civ5jQpx/cuVNRO8J5+mvs4duVtsr3xz9OrwvnLc9JOcvO6b31sBwh5m
         HZdxicIZPBgdplsEFqpPqBDAx7PMuK8KJe84FhsQ/nH1OxAC0bzLqimtyli5Gmy9wcGA
         47/hc/xCOk8pTbcfL8fVKVf/M3a4YLzIyhX8Vq+nyG/1Ux0XmTrXwbZkxxiTmZ/1qyUZ
         N7jZqgWGM/FxrBvEEIsy/c9VIELiYV6+KzSNNgMudKPN0zT7rCvqbdk75w77kXu1mG8A
         BN9eGYn7q15twXvI7aLSaKQoZEhJdNplhvwvqpeUudiziyCVyzNvmTHsbenQr4yhWu4g
         X1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1prNYVi8te7tpWxKFgmK7lDkMWxtco2vgGigTJkyqhk=;
        b=MKIxRgdmJ79VQEsqRmCpFKJdQr0YaBLIZmhFcFATbkxsEs2RUkBiL7wGJ6omslgIrR
         JlyZMz25pTgDobh1CLevOoPavota38hayKFlA2mqW5MTby4hz/RldNYkLyRsH5+VQ79K
         Jbm30CD+r9DCs/5l0Q0bKDbIplhRXa1nbr5JZQ5OXg9mXELIQ+hODqqI6SYsCk3yAHy+
         s87goj0eZAPXFVNPCLuNicahDJnVdbaQjI3IyOhI+SyAMMoqaTCvlI830HABKwCovooy
         NQqBLPjcLKPUeOu6t5P19pNlE6wMcUYyKuJsLRoVduSgAmD3Cd6Tc4H3CnTDyWyFYvYU
         bCcw==
X-Gm-Message-State: APjAAAV2gpeQ1ZetYNfSz0m36SYor+FLWKtKpG2oiIq4zQkl7EX/9inc
        8KvbJQq8n4vATGXPTGEgtiJv+gWK3vk=
X-Google-Smtp-Source: APXvYqy02bAtARqs+xW5We+9JpED8EM7JDMzMhWAW6eWMmMGlvg2dNW69eQ4eWi532XnQLXF9CeDTA==
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr12507646ljg.154.1582040489372;
        Tue, 18 Feb 2020 07:41:29 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b1sm2932370ljp.72.2020.02.18.07.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 07:41:28 -0800 (PST)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 5F99E100FA3; Tue, 18 Feb 2020 18:41:56 +0300 (+03)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Justin He <Justin.He@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jeff Moyer <jmoyer@redhat.com>
Subject: [PATCH] mm: Avoid data corruption on CoW fault into PFN-mapped VMA
Date:   Tue, 18 Feb 2020 18:41:51 +0300
Message-Id: <20200218154151.13349-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Moyer has reported that one of xfstests triggers a warning when run
on DAX-enabled filesystem:

	WARNING: CPU: 76 PID: 51024 at mm/memory.c:2317 wp_page_copy+0xc40/0xd50
	...
	wp_page_copy+0x98c/0xd50 (unreliable)
	do_wp_page+0xd8/0xad0
	__handle_mm_fault+0x748/0x1b90
	handle_mm_fault+0x120/0x1f0
	__do_page_fault+0x240/0xd70
	do_page_fault+0x38/0xd0
	handle_page_fault+0x10/0x30

The warning happens on failed __copy_from_user_inatomic() which tries to
copy data into a CoW page.

This happens because of race between MADV_DONTNEED and CoW page fault:

	CPU0					CPU1
 handle_mm_fault()
   do_wp_page()
     wp_page_copy()
       do_wp_page()
					madvise(MADV_DONTNEED)
					  zap_page_range()
					    zap_pte_range()
					      ptep_get_and_clear_full()
					      <TLB flush>
	 __copy_from_user_inatomic()
	 sees empty PTE and fails
	 WARN_ON_ONCE(1)
	 clear_page()

The solution is to re-try __copy_from_user_inatomic() under PTL after
checking that PTE is matches the orig_pte.

The second copy attempt can still fail, like due to non-readable PTE,
but there's nothing reasonable we can do about, except clearing the CoW
page.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-and-tested-by: Jeff Moyer <jmoyer@redhat.com>
---
 mm/memory.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 0bccc622e482..e8bfdf0d9d1d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2257,7 +2257,7 @@ static inline bool cow_user_page(struct page *dst, struct page *src,
 	bool ret;
 	void *kaddr;
 	void __user *uaddr;
-	bool force_mkyoung;
+	bool locked = false;
 	struct vm_area_struct *vma = vmf->vma;
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long addr = vmf->address;
@@ -2282,11 +2282,11 @@ static inline bool cow_user_page(struct page *dst, struct page *src,
 	 * On architectures with software "accessed" bits, we would
 	 * take a double page fault, so mark it accessed here.
 	 */
-	force_mkyoung = arch_faults_on_old_pte() && !pte_young(vmf->orig_pte);
-	if (force_mkyoung) {
+	if (arch_faults_on_old_pte() && !pte_young(vmf->orig_pte)) {
 		pte_t entry;
 
 		vmf->pte = pte_offset_map_lock(mm, vmf->pmd, addr, &vmf->ptl);
+		locked = true;
 		if (!likely(pte_same(*vmf->pte, vmf->orig_pte))) {
 			/*
 			 * Other thread has already handled the fault
@@ -2310,18 +2310,37 @@ static inline bool cow_user_page(struct page *dst, struct page *src,
 	 * zeroes.
 	 */
 	if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE)) {
+		if (locked)
+			goto warn;
+
+		/* Re-validate under PTL if the page is still mapped */
+		vmf->pte = pte_offset_map_lock(mm, vmf->pmd, addr, &vmf->ptl);
+		locked = true;
+		if (!likely(pte_same(*vmf->pte, vmf->orig_pte))) {
+			/* The PTE changed under us. Retry page fault. */
+			ret = false;
+			goto pte_unlock;
+		}
+
 		/*
-		 * Give a warn in case there can be some obscure
-		 * use-case
+		 * The same page can be mapped back since last copy attampt.
+		 * Try to copy again under PTL.
 		 */
-		WARN_ON_ONCE(1);
-		clear_page(kaddr);
+		if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE)) {
+			/*
+			 * Give a warn in case there can be some obscure
+			 * use-case
+			 */
+warn:
+			WARN_ON_ONCE(1);
+			clear_page(kaddr);
+		}
 	}
 
 	ret = true;
 
 pte_unlock:
-	if (force_mkyoung)
+	if (locked)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 	kunmap_atomic(kaddr);
 	flush_dcache_page(dst);
-- 
2.25.1

