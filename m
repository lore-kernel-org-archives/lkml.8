Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F25CC34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA34A2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F7wmfQVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgBSC3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:29:24 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38044 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgBSC3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:29:23 -0500
Received: by mail-pj1-f68.google.com with SMTP id j17so1869166pjz.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 18:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=rNnCtkOc/6ohK9oTnWLWMg6U3VCtnXynqbtbc3y7Njc=;
        b=F7wmfQVKR5T8ELIXT4gkRwxg9XiiqP2XHkDlzlNKzdHGDz8960m6sciiKT8sIdaoBw
         DFgBuPbBij1lkPgKB7NZIU1qZzrrV4kv0vWX6qsbXyDwZ9nqZvtB3cuo7aL9uia75Ed/
         91s3f3Dhr+I47j6RPCDTGK5eb8lvq5McvlORHiKHcPdqPl2n3cAtgvSAMCoUsekKMNWo
         HtzyiZ5phTk1niQqv/hTzhmsSr42b6MGVP/5Vpo1CMpck/5byadu//sC78HGBDG905b0
         qpC6wkii0qzfp7gTNV/dNs+3xjA+PTB8vFBe7SkjwfF3UL/PG6zEUIFFyjRs6YR8t4ae
         EcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=rNnCtkOc/6ohK9oTnWLWMg6U3VCtnXynqbtbc3y7Njc=;
        b=o2VOo0GVl17wcxToY39LYBLXRXAJU3QKeEw3miR0zW70xA9WbRUTrPVP2IFwtY7WbO
         5Lf4Eudld9q9Sjsr6OLBln6Ia9pa9QNXZ1P5Y4ODPvHjdPbbKbZceaGDMS82g35RpDvQ
         dDPZDXmrXJL2yrpBj0T1prpSGDaIrtwk8goRJLH2idFEc6PmPIRCUL2Kud+C+GnbTWi3
         DAqjv+7kZqJYGUaLsUZzj65sKCEaXqSmKWCtCKeoALNgSzFbmZlX2IchADW6rb5M4HZ7
         aWAtpgmg2CouKz1nHDx4ixHxnyNFfDE2gESpF1M7NmT8SmXjOZVDHebyN81H7Cb4OfG3
         vSHg==
X-Gm-Message-State: APjAAAXNXjkzWV5KX5eYbpszrhQVxwyUXM/vWtvillVIHhr6gEDqhH08
        iEoi0gWAbUurwLYPZ9uQhmOkvA==
X-Google-Smtp-Source: APXvYqxAgulxkjBPCmHduNnt+n7qNB696wehVmi8XG3+039OMApFT1VNGvJyi7Y2w+L+E764qDw9dA==
X-Received: by 2002:a17:902:d684:: with SMTP id v4mr24796967ply.14.1582079362552;
        Tue, 18 Feb 2020 18:29:22 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id b4sm361786pfd.18.2020.02.18.18.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 18:29:21 -0800 (PST)
Date:   Tue, 18 Feb 2020 18:29:21 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jeremy Cline <jcline@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [patch 2/2] mm, thp: track fallbacks due to failed memcg charges
 separately
In-Reply-To: <alpine.DEB.2.21.2002181828070.108053@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2002181828400.108053@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.2002172139310.152060@chino.kir.corp.google.com> <alpine.DEB.2.21.2002181828070.108053@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thp_fault_fallback stat in /proc/vmstat is incremented if either the
hugepage allocation fails through the page allocator or the hugepage
charge fails through mem cgroup.

This patch leaves this field untouched but adds a new field,
thp_fault_fallback_charge, which is incremented only when the mem cgroup
charge fails.

This distinguishes between faults that want to be backed by hugepages but
fail due to fragmentation (or low memory conditions) and those that fail
due to mem cgroup limits.  That can be used to determine the impact of
fragmentation on the system by excluding faults that failed due to memcg
usage.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 v2:
  - supported for shmem faults as well per Kirill
  - fixed worked in documentation and commit description per Mike

 Documentation/admin-guide/mm/transhuge.rst | 5 +++++
 include/linux/vm_event_item.h              | 1 +
 mm/huge_memory.c                           | 2 ++
 mm/shmem.c                                 | 4 +++-
 mm/vmstat.c                                | 1 +
 5 files changed, 12 insertions(+), 1 deletion(-)

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
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -73,6 +73,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 		THP_FAULT_ALLOC,
 		THP_FAULT_FALLBACK,
+		THP_FAULT_FALLBACK_CHARGE,
 		THP_COLLAPSE_ALLOC,
 		THP_COLLAPSE_ALLOC_FAILED,
 		THP_FILE_ALLOC,
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
@@ -1872,8 +1872,10 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg,
 					    PageTransHuge(page));
 	if (error) {
-		if (vmf && PageTransHuge(page))
+		if (vmf && PageTransHuge(page)) {
 			count_vm_event(THP_FAULT_FALLBACK);
+			count_vm_event(THP_FAULT_FALLBACK_CHARGE);
+		}
 		goto unacct;
 	}
 	error = shmem_add_to_page_cache(page, mapping, hindex,
diff --git a/mm/vmstat.c b/mm/vmstat.c
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1254,6 +1254,7 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	"thp_fault_alloc",
 	"thp_fault_fallback",
+	"thp_fault_fallback_charge",
 	"thp_collapse_alloc",
 	"thp_collapse_alloc_failed",
 	"thp_file_alloc",
