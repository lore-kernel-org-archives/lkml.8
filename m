Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6062FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3800B2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXBMtHrk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394267AbgFSQOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:14:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48081 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391398AbgFSQOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592583240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hAWzjcK11ehl6Ry1XWEz8DeKxbF5tzxJ+GAj1+W4u20=;
        b=KXBMtHrkoQ2+b0wCheOQ87VDN6D219bxbZUPtEG+Mo6/rWLZyKkTwXHcaVqVPHepfF19Ze
        s4akrpHmLZYAenUa37UHtAORCyA0Ogs8LJSKzno9gLzfhSAv53pBPkl8BQsIDyCTMIxUpE
        FTdRY3PC+feGi73Yz44aHPKFqGb/jdA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-iqD3pJfMNWiOXMrDWhmXIQ-1; Fri, 19 Jun 2020 12:13:58 -0400
X-MC-Unique: iqD3pJfMNWiOXMrDWhmXIQ-1
Received: by mail-qv1-f72.google.com with SMTP id a8so7108218qvt.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hAWzjcK11ehl6Ry1XWEz8DeKxbF5tzxJ+GAj1+W4u20=;
        b=rEckgtkCxWVzlfVn0rFfBncdZnt56sRnrC7YDFarXefJ7FXF8+k41v0/2fnS3phzj/
         5+u+Kk55xzR7PcR2e2Re5Im1cj0CK8Wjxz3Yza6k+XyAyHm5g8ME+AA3uGnKJyZq3oHR
         g6W5iLD5E0Ea40XNfT27zrWGjzJdShJ5aU8+rtOhVn/DpogwHuPXBVs7m7bAk3laqfLR
         jrbrtmxonaT74uMv9ADMvsj6dRhUJRSfXx7N9njm6S8pOXpVD89LTB8f23TZmQ88+/Ac
         9PWHtWTdv+Kj6aGFF7B/f5K9HmORZYLSgokNPVLCa3Epz6NTRWUnJRNGkEsSuyDyLazH
         dhtQ==
X-Gm-Message-State: AOAM531lMdF4Li6UiLGg3vZtUO4jATtd3St4BYGNnzebLalg5UNYKMHh
        5knCPQhCTeCio1/0jBKlu3kxnZHAAHFR82PwShz0UHKVqDxeZFrcebZW9kwFcWl1ve4NiUrgG/e
        m1pvusjyJjYyqm4wCI+pO2qpV
X-Received: by 2002:a05:620a:16b7:: with SMTP id s23mr4396615qkj.142.1592583237768;
        Fri, 19 Jun 2020 09:13:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvBwhl7EOG8ylIuxoeyJJKEMjZ8bo+nIfzIN7OFxYP9urzZkDH6dVu5uteKX7SDFgvKlBOUw==
X-Received: by 2002:a05:620a:16b7:: with SMTP id s23mr4396588qkj.142.1592583237551;
        Fri, 19 Jun 2020 09:13:57 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id i40sm7809041qte.67.2020.06.19.09.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:13:56 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Peter Xu <peterx@redhat.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 23/26] mm/x86: Use general page fault accounting
Date:   Fri, 19 Jun 2020 12:13:54 -0400
Message-Id: <20200619161354.9907-1-peterx@redhat.com>
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

CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: x86@kernel.org
CC: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/mm/fault.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 3e27ed85af06..4604755a303d 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1309,7 +1309,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	struct vm_area_struct *vma;
 	struct task_struct *tsk;
 	struct mm_struct *mm;
-	vm_fault_t fault, major = 0;
+	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	tsk = current;
@@ -1461,8 +1461,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * userland). The return to userland is identified whenever
 	 * FAULT_FLAG_USER|FAULT_FLAG_KILLABLE are both set in flags.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
-	major |= fault & VM_FAULT_MAJOR;
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
@@ -1489,18 +1488,6 @@ void do_user_addr_fault(struct pt_regs *regs,
 		return;
 	}
 
-	/*
-	 * Major/minor page fault accounting. If any of the events
-	 * returned VM_FAULT_MAJOR, we account it as a major fault.
-	 */
-	if (major) {
-		tsk->maj_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs, address);
-	} else {
-		tsk->min_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);
-	}
-
 	check_v8086_mode(regs, address, tsk);
 }
 NOKPROBE_SYMBOL(do_user_addr_fault);
-- 
2.26.2

