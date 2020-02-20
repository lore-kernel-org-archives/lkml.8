Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2675C11D0F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FF42467A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NS+hDbRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgBTQc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:32:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38791 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728910AbgBTQbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582216295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9p8DfFh4LDgRTv+VZI0mGqV/kjyY8x0K2QPT4Z6z4hI=;
        b=NS+hDbRyj0cJ7ViSkQDA3Ihi4yg0bFWrlncmI/ErHC4nygPeCEKf2+HSKtiNsu+k2x1Fp4
        O/a3xYZ/DYZwsJ34U9VCNWIFw6GW19XuBqN1rFNMZMwVaL0Bue34jZpWb70NjIyC14EcIC
        DIf+3xXLfZLWVgaYUx7GdiZjp5aF+mY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-hOJLXRkhPmS6KMSEN8BF0w-1; Thu, 20 Feb 2020 11:31:30 -0500
X-MC-Unique: hOJLXRkhPmS6KMSEN8BF0w-1
Received: by mail-qk1-f197.google.com with SMTP id w126so3082186qkb.23
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:31:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9p8DfFh4LDgRTv+VZI0mGqV/kjyY8x0K2QPT4Z6z4hI=;
        b=Ygvl8J3HUR3MLLLWPf2/gg5h8nNCpT6EjmoaTEI1G+6peLxZ3gB5UAoT2wl5YlHGge
         Qhvvwqnz9w4mjbFvB8EzezB9bNgoe0B9CFVcF8n/d+dp2WrLvnXE0a5TsMLrJhlnw+lb
         r5gTJfKaoFk9jseo0Tg6Vx0CJBBpQrDzWXIAEXiuEVJSRXbs7a9BQD6OLjjF1Al/34C/
         8u7kwq3jFQTaGoPqwhsvNcLlF3hSM8gWHMkcH6t+8B5ui9YS65wOtgH/RvvcFHnsPtXZ
         IuKWS6qMsmB6TEy0PCMl11HuDuBQ+584Oz3DLr/RXeuuHIjRrdotXiSa3b8wqjmkjR+A
         3QkA==
X-Gm-Message-State: APjAAAVRY/ZKtopIqUrjlhP5ghCqWTWkkMbHdNKi5up4b/opFwKXLF/L
        E2vgeY4MBCdbWwAcfY87XsN0dmza1VO/uLmRzkwlNVlqZwnXUD+EGw88SAcmc/TW2O8O/VLQHH6
        ORrU+1naqkKqxVOnwWvXYY0Au
X-Received: by 2002:ac8:6f09:: with SMTP id g9mr27612446qtv.275.1582216290038;
        Thu, 20 Feb 2020 08:31:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqwsnOU5LWdon8Q11QY9e4+1W5bENddKTz44hj+9UCZ2Yyh27gd4WB1LUA2w5xbsoq6RUPQx5Q==
X-Received: by 2002:ac8:6f09:: with SMTP id g9mr27612422qtv.275.1582216289803;
        Thu, 20 Feb 2020 08:31:29 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id l19sm42366qkl.3.2020.02.20.08.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:31:28 -0800 (PST)
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
Subject: [PATCH v6 08/19] userfaultfd: wp: drop _PAGE_UFFD_WP properly when fork
Date:   Thu, 20 Feb 2020 11:31:01 -0500
Message-Id: <20200220163112.11409-9-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220163112.11409-1-peterx@redhat.com>
References: <20200220163112.11409-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UFFD_EVENT_FORK support for uffd-wp should be already there, except
that we should clean the uffd-wp bit if uffd fork event is not
enabled.  Detect that to avoid _PAGE_UFFD_WP being set even if the VMA
is not being tracked by VM_UFFD_WP.  Do this for both small PTEs and
huge PMDs.

Reviewed-by: Jerome Glisse <jglisse@redhat.com>
Reviewed-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/huge_memory.c | 8 ++++++++
 mm/memory.c      | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c56a83e0a184..134bef68a1de 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1011,6 +1011,14 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	ret = -EAGAIN;
 	pmd = *src_pmd;
 
+	/*
+	 * Make sure the _PAGE_UFFD_WP bit is cleared if the new VMA
+	 * does not have the VM_UFFD_WP, which means that the uffd
+	 * fork event is not enabled.
+	 */
+	if (!(vma->vm_flags & VM_UFFD_WP))
+		pmd = pmd_clear_uffd_wp(pmd);
+
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 	if (unlikely(is_swap_pmd(pmd))) {
 		swp_entry_t entry = pmd_to_swp_entry(pmd);
diff --git a/mm/memory.c b/mm/memory.c
index 21cd818dfede..557837ec29c3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -785,6 +785,14 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pte = pte_mkclean(pte);
 	pte = pte_mkold(pte);
 
+	/*
+	 * Make sure the _PAGE_UFFD_WP bit is cleared if the new VMA
+	 * does not have the VM_UFFD_WP, which means that the uffd
+	 * fork event is not enabled.
+	 */
+	if (!(vm_flags & VM_UFFD_WP))
+		pte = pte_clear_uffd_wp(pte);
+
 	page = vm_normal_page(vma, addr, pte);
 	if (page) {
 		get_page(page);
-- 
2.24.1

