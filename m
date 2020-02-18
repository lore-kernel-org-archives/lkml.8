Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD3FC34034
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 05:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A4820836
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 05:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RtOguG0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgBRFlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 00:41:44 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41956 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgBRFln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 00:41:43 -0500
Received: by mail-pf1-f195.google.com with SMTP id j9so10048556pfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 21:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=esjIwXMBf/hgdFfGBIjggPZwNclD7vRz+/fGr5r+Z2E=;
        b=RtOguG0sNrSmHKOP6ewO8LT+ei2pgaBCnqI0Sa3rNdfs8HCP6LII4+OueoQw83a3VK
         j40L1T/Pf5byRFDukW/msBNJ+loNhBNgVRAMHc3bLny4aOd/MWF+PxHyusUToa0F210C
         NZ3HGDQeFT33d96fHhZqPTmIlr7x+grAu/9sZNSdEQwAUP53vz+LKKfk6+3vR4yr6KZ/
         2A2lFsrM1NyeatXa/yRCULqvBVuK0wY9uDfHsC3JhtTyGKhE4oYXuuib7mPH81oADaTD
         zss65SrCuaScvuvCmZzFmouw79wZi9eMDB741ilsfMj1E8jc+XsfESiUDOA8U7/VXxTQ
         tk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=esjIwXMBf/hgdFfGBIjggPZwNclD7vRz+/fGr5r+Z2E=;
        b=R6rUZHriP3Etn1iVAgZB3tiPsdG1tEp6U+D6QuRFGJ/1TXm52JbbfuF261RBLuvu1e
         jmCbyq4tLb+g7kpslB9SiOgabmgr1DPB2OgY9oCOyIS7bnY9tqiaKhtM0SESSV9ITQ2g
         eQPaLvpchGKiGDahBNHyhP7FX1ALsglXA/Hi0pWHztI+Jxj5p2+9jJwKVCj2jEvH9knS
         LsYUaytcnEETMzndcDqZ5mcZxH0g8dMWOW179T9N1RonFTAivz22ghE5SqsiezfT/ZuH
         DUBC26na+QjFReAlAByLB8LMcTnfWx4TdctNtN+AfQDoPNk4eRKov2wGh9CWcidL3pRQ
         3vIw==
X-Gm-Message-State: APjAAAWUHXpPIDLAP7byVpY239pRmNOxD+P5rVkasQG8vFZZdRitxRfT
        NV1mmM4vHxUH4dQt9K6FrwQHYQ==
X-Google-Smtp-Source: APXvYqzs308xRKAwyAmQ7Qew/TEy0TtQ8KfvWXBSdmvdvthEHpFolOD3XpfjaX7qYllV6Lt78Mk+iw==
X-Received: by 2002:a63:ed49:: with SMTP id m9mr20824593pgk.304.1582004501721;
        Mon, 17 Feb 2020 21:41:41 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id f3sm2731827pga.38.2020.02.17.21.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 21:41:41 -0800 (PST)
Date:   Mon, 17 Feb 2020 21:41:40 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jeremy Cline <jcline@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [patch] mm, thp: track fallbacks due to failed memcg charges
 separately
Message-ID: <alpine.DEB.2.21.2002172139310.152060@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thp_fault_fallback stat in either /proc/vmstat is incremented if 
either the hugepage allocation fails through the page allocator or the 
hugepage charge fails through mem cgroup.

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
 Documentation/admin-guide/mm/transhuge.rst | 5 +++++
 include/linux/vm_event_item.h              | 1 +
 mm/huge_memory.c                           | 2 ++
 mm/vmstat.c                                | 1 +
 4 files changed, 9 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -310,6 +310,11 @@ thp_fault_fallback
 	is incremented if a page fault fails to allocate
 	a huge page and instead falls back to using small pages.
 
+thp_fault_fallback_charge
+	is incremented if a page fault fails to charge a huge page and
+	instead falls back to using small pages even through the
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
