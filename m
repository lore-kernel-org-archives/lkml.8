Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEC2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BF58207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wsk9SH3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405554AbgFSQGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:06:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58624 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391903AbgFSQFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592582748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZrEBS+6D6tr7sKM8RKvuVARuC8ujPdG5Fi1hrXsWHAc=;
        b=Wsk9SH3lTAZhf1AAiciCwfzq9Ifqv/x6qS0Hmpqxv9MEnBcUfUnkblY/QXGU0VvSArdxne
        emnlTEreEdMNFCKYVOCbQTQ0LdKl14iJgi9Nydu6UHH8OIDd7uMtpO5iWEWfIJABIO4VyQ
        fpIUNuYihcQbOwo1YrLhPWptkj8s3jI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-sV7FoGMFPOCz0Riql3RVMQ-1; Fri, 19 Jun 2020 12:05:46 -0400
X-MC-Unique: sV7FoGMFPOCz0Riql3RVMQ-1
Received: by mail-qk1-f200.google.com with SMTP id 140so7421026qko.23
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZrEBS+6D6tr7sKM8RKvuVARuC8ujPdG5Fi1hrXsWHAc=;
        b=LV3qxd1E7TW0Ll1uQidMto9+xPAe6/jXV0wsMhk3RNqJZDs5/4gEJ3xXQwg4UJIe36
         oICKTqS2c0WRwAE/amm/vqIbE1SnLmi+1hJNin4FOWyI+sllwI1mVxlGJfTpt//EAomS
         uf3HubOcJh/etDilxhbS3yxSjKYnXMKn+mvyeJe79+r7I6WyOrA+9sYiW0Y+rMhlkJP3
         K/lvhGyP4NKW7dnp7h6AeiaGxRFYbMSAr5gixCCrbaV9u1fCAvanw/rvG/V4oYpv9zOC
         tcGvO2B1yBk+QStO+B72eZxQf5RPLc/2mluRNUpeEaeNZgPhKdHohu8q4d6gSA84ZxD7
         JyYw==
X-Gm-Message-State: AOAM530D0r9VSHptjlP9serZ/Df57DCyq4vOG5FHZc34LKvm0tNat5Ml
        3igjz5SthZUSM4OnTSTZrK4Z7IxQbf+DuHvSWINnuovpWjbCSEe6vuCqXbyqnLP9y5oz5twCdSL
        MdYdLduN1QPryZun05SyJeoxC
X-Received: by 2002:a37:6d4:: with SMTP id 203mr1558331qkg.62.1592582745378;
        Fri, 19 Jun 2020 09:05:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1Ah5qSbhiFYhHGzi97I57hEEaVVSsMBbZi7Nga0UAUiVp9Ck6HGvQPSjZ83MKPB5TgG3lyw==
X-Received: by 2002:a37:6d4:: with SMTP id 203mr1558310qkg.62.1592582745151;
        Fri, 19 Jun 2020 09:05:45 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id g11sm6412604qkk.123.2020.06.19.09.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:05:44 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH 03/26] mm/arc: Use general page fault accounting
Date:   Fri, 19 Jun 2020 12:05:15 -0400
Message-Id: <20200619160538.8641-4-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200619160538.8641-1-peterx@redhat.com>
References: <20200619160538.8641-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().
It naturally solve the issue of multiple page fault accounting when page fault
retry happened.

Fix PERF_COUNT_SW_PAGE_FAULTS perf event manually for page fault retries, by
moving it before taking mmap_sem.

CC: Vineet Gupta <vgupta@synopsys.com>
CC: linux-snps-arc@lists.infradead.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arc/mm/fault.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 34380139e7a2..68e6849cf086 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -106,6 +106,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	if (write)
 		flags |= FAULT_FLAG_WRITE;
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
 	down_read(&mm->mmap_sem);
 
@@ -131,7 +132,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 		goto bad_area;
 	}
 
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
@@ -156,22 +157,9 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	 * Major/minor page fault accounting
 	 * (in case of retry we only land here once)
 	 */
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
-
-	if (likely(!(fault & VM_FAULT_ERROR))) {
-		if (fault & VM_FAULT_MAJOR) {
-			tsk->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
-				      regs, address);
-		} else {
-			tsk->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
-				      regs, address);
-		}
-
+	if (likely(!(fault & VM_FAULT_ERROR)))
 		/* Normal return path: fault Handled Gracefully */
 		return;
-	}
 
 	if (!user_mode(regs))
 		goto no_context;
-- 
2.26.2

