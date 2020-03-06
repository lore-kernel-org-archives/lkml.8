Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B50C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D124020674
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="euevNUnR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCFWWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:22:35 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37526 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgCFWWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:22:35 -0500
Received: by mail-pl1-f194.google.com with SMTP id b8so1433771plx.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 14:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=yq1LlWXfgFVbN1dN7FhDu/ZG8whSBUXn1voZBs312pU=;
        b=euevNUnR9uilPzjMJkibgbzoltDVJCpY61LgqxaYH6BTonL0HIkck4scTwN9KrPHwB
         U1fQ05HIElb2V/zA8kMiDvQo9vfmGmwUjAJg0zEZKmZy0UyVoWup97a6IzDwSEkYgGVY
         wyJ9dvecckunSCuDgCsXT9izi2FD2kBu0Jhi23Ah+HiO89MCharnA0agkzXJjdAFq+UL
         HkFXFOGz1DciQIlyPlJ7vIumhmq+WHOXi503VG/Os7UB5KQiQJOZrq0MxB/Ca7Q3/X2H
         260nirY0ZACoQhYlL1YEdRT2GWaJTX8yIHCBiVKcTt7Zoe/0JKrrpH2R2c+kPYBzoM0F
         UC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=yq1LlWXfgFVbN1dN7FhDu/ZG8whSBUXn1voZBs312pU=;
        b=fK/FDlP5XYG5lcq/0yQokVWw7eGHNPas/Wu83m6MIkDcTv3STxAh69njepQ+tp/NVw
         gO/KuFiy3t+CrdqjOyRnFmxScSuPIke0RJTmiilFYHN8kSdafjtS3fHAsd2iQCoy+M6S
         lIh0b51C+63fu7FH+4QhpWc1kI0KjUmMQmp224KAUVNUrzGWH8Ft5qnVnaD+BmepxZRq
         TrvbcssFHXiJWOFneLFQY2SFkSocqABOqb0Zw/bKcKL9zFYHEtBByX+buEauplAGvNZ9
         V9wtjKrAnRi0eBTgXZSWcdauzDYMnZDaV6A7ieDLRNc5KPGJmhJIizEy7zSWCKmk2JX1
         dI2A==
X-Gm-Message-State: ANhLgQ2wCN36SA8u3bKUmbMNLL7ZyPulbnYuQNBusE27KZB3bV80sH70
        iNdxhxHK8HxThkQGa4sOkj75JA==
X-Google-Smtp-Source: ADFU+vtl+VdsMHnoS3xzYLEpNEMejM0HbgJXg8kWeEc+p/hRmDM5OVJrSvhDxDtqhAwTsC3mpZscEw==
X-Received: by 2002:a17:902:8f8a:: with SMTP id z10mr5213289plo.169.1583533354024;
        Fri, 06 Mar 2020 14:22:34 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id m70sm10598029pje.45.2020.03.06.14.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 14:22:33 -0800 (PST)
Date:   Fri, 6 Mar 2020 14:22:32 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jeremy Cline <jcline@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: [patch 1/2] mm, shmem: add vmstat for hugepage fallback
Message-ID: <alpine.DEB.2.21.2003061421240.7412@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing thp_fault_fallback indicates when thp attempts to allocate a
hugepage but fails, or if the hugepage cannot be charged to the mem cgroup
hierarchy.

Extend this to shmem as well.  Adds a new thp_file_fallback to complement
thp_file_alloc that gets incremented when a hugepage is attempted to be
allocated but fails, or if it cannot be charged to the mem cgroup
hierarchy.

Additionally, remove the check for CONFIG_TRANSPARENT_HUGE_PAGECACHE from
shmem_alloc_hugepage() since it is only called with this configuration
option.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 Documentation/admin-guide/mm/transhuge.rst |  4 ++++
 include/linux/vm_event_item.h              |  2 ++
 mm/shmem.c                                 | 10 ++++++----
 mm/vmstat.c                                |  1 +
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -319,6 +319,10 @@ thp_file_alloc
 	is incremented every time a file huge page is successfully
 	allocated.
 
+thp_file_fallback
+	is incremented if a file huge page is attempted to be allocated
+	but fails and instead falls back to using small pages.
+
 thp_file_mapped
 	is incremented every time a file huge page is mapped into
 	user address space.
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -76,6 +76,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		THP_COLLAPSE_ALLOC,
 		THP_COLLAPSE_ALLOC_FAILED,
 		THP_FILE_ALLOC,
+		THP_FILE_FALLBACK,
 		THP_FILE_MAPPED,
 		THP_SPLIT_PAGE,
 		THP_SPLIT_PAGE_FAILED,
@@ -115,6 +116,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 
 #ifndef CONFIG_TRANSPARENT_HUGEPAGE
 #define THP_FILE_ALLOC ({ BUILD_BUG(); 0; })
+#define THP_FILE_FALLBACK ({ BUILD_BUG(); 0; })
 #define THP_FILE_MAPPED ({ BUILD_BUG(); 0; })
 #endif
 
diff --git a/mm/shmem.c b/mm/shmem.c
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1472,9 +1472,6 @@ static struct page *shmem_alloc_hugepage(gfp_t gfp,
 	pgoff_t hindex;
 	struct page *page;
 
-	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGE_PAGECACHE))
-		return NULL;
-
 	hindex = round_down(index, HPAGE_PMD_NR);
 	if (xa_find(&mapping->i_pages, &hindex, hindex + HPAGE_PMD_NR - 1,
 								XA_PRESENT))
@@ -1486,6 +1483,8 @@ static struct page *shmem_alloc_hugepage(gfp_t gfp,
 	shmem_pseudo_vma_destroy(&pvma);
 	if (page)
 		prep_transhuge_page(page);
+	else
+		count_vm_event(THP_FILE_FALLBACK);
 	return page;
 }
 
@@ -1871,8 +1870,11 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 
 	error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg,
 					    PageTransHuge(page));
-	if (error)
+	if (error) {
+		if (PageTransHuge(page))
+			count_vm_event(THP_FILE_FALLBACK);
 		goto unacct;
+	}
 	error = shmem_add_to_page_cache(page, mapping, hindex,
 					NULL, gfp & GFP_RECLAIM_MASK);
 	if (error) {
diff --git a/mm/vmstat.c b/mm/vmstat.c
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1257,6 +1257,7 @@ const char * const vmstat_text[] = {
 	"thp_collapse_alloc",
 	"thp_collapse_alloc_failed",
 	"thp_file_alloc",
+	"thp_file_fallback",
 	"thp_file_mapped",
 	"thp_split_page",
 	"thp_split_page_failed",
