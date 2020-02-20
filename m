Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD7DC11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F45420722
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZ1gWsSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgBTQbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:31:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30823 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728919AbgBTQbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:31:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582216297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r0sDJodwNgyoOwbHrwVGLbL90Ddr5lTCsGS0o/0PgMM=;
        b=iZ1gWsSq86tmDlPpEm6FwtXLKN81sGnlxCNHaGwqikw4ilrzKxy9CEGIP9TzfvgEdmireP
        c5f9Z+oF15Swv/6xPGdWcv04NFot1ZTkpn7Cr69pPr/mL49LO0zW6Xd1s+lN2GoEYS4HXV
        nhKu4hLwnFXaJhd+YxHLOMLfcY8pcNs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409--AcYs81LNii2-ZMwAd7fiw-1; Thu, 20 Feb 2020 11:31:36 -0500
X-MC-Unique: -AcYs81LNii2-ZMwAd7fiw-1
Received: by mail-qt1-f198.google.com with SMTP id t4so2978665qtd.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:31:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r0sDJodwNgyoOwbHrwVGLbL90Ddr5lTCsGS0o/0PgMM=;
        b=NfzzN0+5F7d5tQEfjpoHqhJ0TJ8Zlu0M9RND76SOVTsQ8F+xhyh6Dz2nou+y1czRm4
         zsjf8JIhrzi2fEDRma9A0aJA9nUSWGjvk5mDMm9JJluTw8qWVvBFJhoAa1i9bJY4pT43
         lX9tjdZYl0xnrqLfm5QcfgCsDD+xnfVee1MNa25tughOBy8F850tkqJuy5ktfVfy/u5w
         iqaVa+sB49zylsx7W3qAwoHFkldKyNHwuxVljRWTg27eIPyOSXyYVtvXHKTgm/ClPheS
         htFWZ/0X8oXS7moKL7YhmRnN3cEsnOj9R9KRJBUYDpzrL359S+JrDbfUjYkl9rCKOfb+
         ObeA==
X-Gm-Message-State: APjAAAXxCpaVl80Ru8eQGb5aBGt/XwhT6t1NSvOI2zuPd8Hge7PBuzUU
        deoAWCNVsXsieBN8TTCDQuElLPMXCkBlYy45+lNjnmk4GxFR7VVPLBYn9mmGtAwHR4WIdYCnSMW
        nJhCqBSbSpeNxF2KwBFQhw+ma
X-Received: by 2002:ad4:518b:: with SMTP id b11mr26734762qvp.195.1582216295514;
        Thu, 20 Feb 2020 08:31:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqzMBpmXyr/u1LNt9PUL6pwnIZzwSdaDP3RIPkOsS6PRT517wakgQUFK3sPZeVT/zL3xK1gWJA==
X-Received: by 2002:ad4:518b:: with SMTP id b11mr26734653qvp.195.1582216294337;
        Thu, 20 Feb 2020 08:31:34 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id l19sm42366qkl.3.2020.02.20.08.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:31:33 -0800 (PST)
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
        Jerome Glisse <jglisse@redhat.com>
Subject: [PATCH v6 10/19] userfaultfd: wp: support swap and page migration
Date:   Thu, 20 Feb 2020 11:31:03 -0500
Message-Id: <20200220163112.11409-11-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220163112.11409-1-peterx@redhat.com>
References: <20200220163112.11409-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For either swap and page migration, we all use the bit 2 of the entry to
identify whether this entry is uffd write-protected.  It plays a similar
role as the existing soft dirty bit in swap entries but only for keeping
the uffd-wp tracking for a specific PTE/PMD.

Something special here is that when we want to recover the uffd-wp bit
from a swap/migration entry to the PTE bit we'll also need to take care
of the _PAGE_RW bit and make sure it's cleared, otherwise even with the
_PAGE_UFFD_WP bit we can't trap it at all.

In change_pte_range() we do nothing for uffd if the PTE is a swap
entry.  That can lead to data mismatch if the page that we are going
to write protect is swapped out when sending the UFFDIO_WRITEPROTECT.
This patch also applies/removes the uffd-wp bit even for the swap
entries.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/swapops.h |  2 ++
 mm/huge_memory.c        |  3 +++
 mm/memory.c             |  8 ++++++++
 mm/migrate.c            |  6 ++++++
 mm/mprotect.c           | 28 +++++++++++++++++-----------
 mm/rmap.c               |  6 ++++++
 6 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 877fd239b6ff..9a6f06de183b 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -68,6 +68,8 @@ static inline swp_entry_t pte_to_swp_entry(pte_t pte)
 
 	if (pte_swp_soft_dirty(pte))
 		pte = pte_swp_clear_soft_dirty(pte);
+	if (pte_swp_uffd_wp(pte))
+		pte = pte_swp_clear_uffd_wp(pte);
 	arch_entry = __pte_to_swp_entry(pte);
 	return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 134bef68a1de..ef18ad16b7ed 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2252,6 +2252,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		write = is_write_migration_entry(entry);
 		young = false;
 		soft_dirty = pmd_swp_soft_dirty(old_pmd);
+		uffd_wp = pmd_swp_uffd_wp(old_pmd);
 	} else {
 		page = pmd_page(old_pmd);
 		if (pmd_dirty(old_pmd))
@@ -2284,6 +2285,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			entry = swp_entry_to_pte(swp_entry);
 			if (soft_dirty)
 				entry = pte_swp_mksoft_dirty(entry);
+			if (uffd_wp)
+				entry = pte_swp_mkuffd_wp(entry);
 		} else {
 			entry = mk_pte(page + i, READ_ONCE(vma->vm_page_prot));
 			entry = maybe_mkwrite(entry, vma);
diff --git a/mm/memory.c b/mm/memory.c
index 557837ec29c3..103c1cf9b794 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -733,6 +733,8 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 				pte = swp_entry_to_pte(entry);
 				if (pte_swp_soft_dirty(*src_pte))
 					pte = pte_swp_mksoft_dirty(pte);
+				if (pte_swp_uffd_wp(*src_pte))
+					pte = pte_swp_mkuffd_wp(pte);
 				set_pte_at(src_mm, addr, src_pte, pte);
 			}
 		} else if (is_device_private_entry(entry)) {
@@ -762,6 +764,8 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			    is_cow_mapping(vm_flags)) {
 				make_device_private_entry_read(&entry);
 				pte = swp_entry_to_pte(entry);
+				if (pte_swp_uffd_wp(*src_pte))
+					pte = pte_swp_mkuffd_wp(pte);
 				set_pte_at(src_mm, addr, src_pte, pte);
 			}
 		}
@@ -3079,6 +3083,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	flush_icache_page(vma, page);
 	if (pte_swp_soft_dirty(vmf->orig_pte))
 		pte = pte_mksoft_dirty(pte);
+	if (pte_swp_uffd_wp(vmf->orig_pte)) {
+		pte = pte_mkuffd_wp(pte);
+		pte = pte_wrprotect(pte);
+	}
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
 	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
 	vmf->orig_pte = pte;
diff --git a/mm/migrate.c b/mm/migrate.c
index b1092876e537..73cbdbf69fc5 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -243,11 +243,15 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 		entry = pte_to_swp_entry(*pvmw.pte);
 		if (is_write_migration_entry(entry))
 			pte = maybe_mkwrite(pte, vma);
+		else if (pte_swp_uffd_wp(*pvmw.pte))
+			pte = pte_mkuffd_wp(pte);
 
 		if (unlikely(is_zone_device_page(new))) {
 			if (is_device_private_page(new)) {
 				entry = make_device_private_entry(new, pte_write(pte));
 				pte = swp_entry_to_pte(entry);
+				if (pte_swp_uffd_wp(*pvmw.pte))
+					pte = pte_mkuffd_wp(pte);
 			}
 		}
 
@@ -2318,6 +2322,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			swp_pte = swp_entry_to_pte(entry);
 			if (pte_soft_dirty(pte))
 				swp_pte = pte_swp_mksoft_dirty(swp_pte);
+			if (pte_uffd_wp(pte))
+				swp_pte = pte_swp_mkuffd_wp(swp_pte);
 			set_pte_at(mm, addr, ptep, swp_pte);
 
 			/*
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 22a1c78e3f51..104ac88163d4 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -139,11 +139,11 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			}
 			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
 			pages++;
-		} else if (IS_ENABLED(CONFIG_MIGRATION)) {
+		} else if (is_swap_pte(oldpte)) {
 			swp_entry_t entry = pte_to_swp_entry(oldpte);
+			pte_t newpte;
 
 			if (is_write_migration_entry(entry)) {
-				pte_t newpte;
 				/*
 				 * A protection check is difficult so
 				 * just be safe and disable write
@@ -152,22 +152,28 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				newpte = swp_entry_to_pte(entry);
 				if (pte_swp_soft_dirty(oldpte))
 					newpte = pte_swp_mksoft_dirty(newpte);
-				set_pte_at(vma->vm_mm, addr, pte, newpte);
-
-				pages++;
-			}
-
-			if (is_write_device_private_entry(entry)) {
-				pte_t newpte;
-
+				if (pte_swp_uffd_wp(oldpte))
+					newpte = pte_swp_mkuffd_wp(newpte);
+			} else if (is_write_device_private_entry(entry)) {
 				/*
 				 * We do not preserve soft-dirtiness. See
 				 * copy_one_pte() for explanation.
 				 */
 				make_device_private_entry_read(&entry);
 				newpte = swp_entry_to_pte(entry);
-				set_pte_at(vma->vm_mm, addr, pte, newpte);
+				if (pte_swp_uffd_wp(oldpte))
+					newpte = pte_swp_mkuffd_wp(newpte);
+			} else {
+				newpte = oldpte;
+			}
 
+			if (uffd_wp)
+				newpte = pte_swp_mkuffd_wp(newpte);
+			else if (uffd_wp_resolve)
+				newpte = pte_swp_clear_uffd_wp(newpte);
+
+			if (!pte_same(oldpte, newpte)) {
+				set_pte_at(vma->vm_mm, addr, pte, newpte);
 				pages++;
 			}
 		}
diff --git a/mm/rmap.c b/mm/rmap.c
index b3e381919835..ce935d0ddf75 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1497,6 +1497,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 			swp_pte = swp_entry_to_pte(entry);
 			if (pte_soft_dirty(pteval))
 				swp_pte = pte_swp_mksoft_dirty(swp_pte);
+			if (pte_uffd_wp(pteval))
+				swp_pte = pte_swp_mkuffd_wp(swp_pte);
 			set_pte_at(mm, pvmw.address, pvmw.pte, swp_pte);
 			/*
 			 * No need to invalidate here it will synchronize on
@@ -1596,6 +1598,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 			swp_pte = swp_entry_to_pte(entry);
 			if (pte_soft_dirty(pteval))
 				swp_pte = pte_swp_mksoft_dirty(swp_pte);
+			if (pte_uffd_wp(pteval))
+				swp_pte = pte_swp_mkuffd_wp(swp_pte);
 			set_pte_at(mm, address, pvmw.pte, swp_pte);
 			/*
 			 * No need to invalidate here it will synchronize on
@@ -1662,6 +1666,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 			swp_pte = swp_entry_to_pte(entry);
 			if (pte_soft_dirty(pteval))
 				swp_pte = pte_swp_mksoft_dirty(swp_pte);
+			if (pte_uffd_wp(pteval))
+				swp_pte = pte_swp_mkuffd_wp(swp_pte);
 			set_pte_at(mm, address, pvmw.pte, swp_pte);
 			/* Invalidate as we cleared the pte */
 			mmu_notifier_invalidate_range(mm, address,
-- 
2.24.1

