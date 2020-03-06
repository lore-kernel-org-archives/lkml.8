Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF84C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83BD8206CC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g/DXRsUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCFWWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:22:40 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40676 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgCFWWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:22:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id l184so1774154pfl.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 14:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=u5iQagkAL956X3yAdHAN3Ifbi9AEjrmYTtohHs4VyfI=;
        b=g/DXRsUpnPVv6Ya8NHenBrLz2IUQ4G4Sat8Og//O03Wd8aU2aHn9mt6lfgnz6ERSCX
         hSnkjMcl7Zy2wOyT7dwIF93oQcdUVfCdTTvw+QVhDPmlBGTHdK2sxUAkkXAR6gCIbzT7
         xJc0W7dMjIRoLtxn8UaK2/igdNrqyiCMIMZPOQcykdDAVW5xTMiCB1mKY7Ui4gJl4cAA
         L/M32dbJ022bCltBq8p/2urg0SYTI2cVKeT/Bl6Ojz5Dut9wD1mDM6jqUkEu2st5oc2U
         YAIjFSuh9D3nFe4NLL/Jcaodr+36L3zxBcsGJavDzgKPMCE2I0YDT3ytV19vdtTAL9Br
         FS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=u5iQagkAL956X3yAdHAN3Ifbi9AEjrmYTtohHs4VyfI=;
        b=OsrmeapB9mK1tCgzvybZLU4Zs4EeD9jd9TFV/zlXoDC6aTYqDq8zZZ3NHbfwnn7jwl
         1ocwwMbXw1sMj7g2MwAxjGfV0kBcn6gZGsX6s0OZC4GBQmnRA4z+sLA0fMNSSWmI7skV
         Bhq1yjvLNHlrSljsFsqJOL3LPgMzuyjuFVAYPxVMLLn8lIxikJZ6hVUVIaHlXBEAISBG
         8SzmZsRQybuWCOzzZZMcUpkD13SzQgj7LSDEm9i2Ao/GHKptk2eQFAJETvsEts/E8XnZ
         R/iQ8rHRoc9Gs/mdyRzxg/Vz/wDYUb7Mp9333hsRiA1X3RsQmOfX8wo3U+YKQ/VTpP8h
         uyug==
X-Gm-Message-State: ANhLgQ3GlH91I5S5+WRGeQuMAZsceRIN0uDqqweRlVOPujOSsf9L2ggb
        y/oDZ1fL+pG8GLnJDsfQVjwrGQ==
X-Google-Smtp-Source: ADFU+vv+K2fDyFW749TFSttaWCLjv+bSISZN1YZ8ATK0SwDRzX9iEudV9PVKTAUzPDXtahm6UTPFuQ==
X-Received: by 2002:a05:6a00:2d4:: with SMTP id b20mr5935555pft.143.1583533356476;
        Fri, 06 Mar 2020 14:22:36 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id fa19sm10310152pjb.47.2020.03.06.14.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 14:22:35 -0800 (PST)
Date:   Fri, 6 Mar 2020 14:22:35 -0800 (PST)
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
Subject: [patch 2/2] mm, thp: track fallbacks due to failed memcg charges
 separately
In-Reply-To: <alpine.DEB.2.21.2003061421240.7412@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2003061422070.7412@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.2003061421240.7412@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thp_fault_fallback and thp_file_fallback vmstats are incremented if
either the hugepage allocation fails through the page allocator or the
hugepage charge fails through mem cgroup.

This patch leaves this field untouched but adds two new fields,
thp_{fault,file}_fallback_charge, which is incremented only when the mem
cgroup charge fails.

This distinguishes between attempted hugepage allocations that fail due to
fragmentation (or low memory conditions) and those that fail due to mem
cgroup limits.  That can be used to determine the impact of fragmentation
on the system by excluding faults that failed due to memcg usage.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 10 ++++++++++
 include/linux/vm_event_item.h              |  3 +++
 mm/huge_memory.c                           |  2 ++
 mm/shmem.c                                 |  4 +++-
 mm/vmstat.c                                |  2 ++
 5 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -310,6 +310,11 @@ thp_fault_fallback
 	is incremented if a page fault fails to allocate
 	a huge page and instead falls back to using small pages.
 
+thp_fault_fallback_charge
+	is incremented if a page fault fails to charge a huge page and
+	instead falls back to using small pages even though the
+	allocation was successful.
+
 thp_collapse_alloc_failed
 	is incremented if khugepaged found a range
 	of pages that should be collapsed into one huge page but failed
@@ -323,6 +328,11 @@ thp_file_fallback
 	is incremented if a file huge page is attempted to be allocated
 	but fails and instead falls back to using small pages.
 
+thp_file_fallback_charge
+	is incremented if a file huge page cannot be charged and instead
+	falls back to using small pages even though the allocation was
+	successful.
+
 thp_file_mapped
 	is incremented every time a file huge page is mapped into
 	user address space.
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -73,10 +73,12 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 		THP_FAULT_ALLOC,
 		THP_FAULT_FALLBACK,
+		THP_FAULT_FALLBACK_CHARGE,
 		THP_COLLAPSE_ALLOC,
 		THP_COLLAPSE_ALLOC_FAILED,
 		THP_FILE_ALLOC,
 		THP_FILE_FALLBACK,
+		THP_FILE_FALLBACK_CHARGE,
 		THP_FILE_MAPPED,
 		THP_SPLIT_PAGE,
 		THP_SPLIT_PAGE_FAILED,
@@ -117,6 +119,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifndef CONFIG_TRANSPARENT_HUGEPAGE
 #define THP_FILE_ALLOC ({ BUILD_BUG(); 0; })
 #define THP_FILE_FALLBACK ({ BUILD_BUG(); 0; })
+#define THP_FILE_FALLBACK_CHARGE ({ BUILD_BUG(); 0; })
 #define THP_FILE_MAPPED ({ BUILD_BUG(); 0; })
 #endif
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -597,6 +597,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, gfp, &memcg, true)) {
 		put_page(page);
 		count_vm_event(THP_FAULT_FALLBACK);
+		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
 		return VM_FAULT_FALLBACK;
 	}
 
@@ -1406,6 +1407,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 			put_page(page);
 		ret |= VM_FAULT_FALLBACK;
 		count_vm_event(THP_FAULT_FALLBACK);
+		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
 		goto out;
 	}
 
diff --git a/mm/shmem.c b/mm/shmem.c
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1871,8 +1871,10 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg,
 					    PageTransHuge(page));
 	if (error) {
-		if (PageTransHuge(page))
+		if (PageTransHuge(page)) {
 			count_vm_event(THP_FILE_FALLBACK);
+			count_vm_event(THP_FILE_FALLBACK_CHARGE);
+		}
 		goto unacct;
 	}
 	error = shmem_add_to_page_cache(page, mapping, hindex,
diff --git a/mm/vmstat.c b/mm/vmstat.c
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1254,10 +1254,12 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	"thp_fault_alloc",
 	"thp_fault_fallback",
+	"thp_fault_fallback_charge",
 	"thp_collapse_alloc",
 	"thp_collapse_alloc_failed",
 	"thp_file_alloc",
 	"thp_file_fallback",
+	"thp_file_fallback_charge",
 	"thp_file_mapped",
 	"thp_split_page",
 	"thp_split_page_failed",
