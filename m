Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780FBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5375C20C09
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDHQ0Oud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgFZWgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:36:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22634 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726386AbgFZWgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593211004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hAWzjcK11ehl6Ry1XWEz8DeKxbF5tzxJ+GAj1+W4u20=;
        b=CDHQ0OudVGD3BG97eSE4rC8Wlr0U/7j+xe1nGhGpd7t6/ST5xWnqnkLXXIbGNxh6vBRzkL
        QlNAQ/uLb96CRxAz63EtW+zetYuJ8HT73+spMXPYfrYy+LJFzJQZA870CDoDz1u2F1brA+
        01eGD/7J0GxvNEXUiEm1Xei2Qp1cOXc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185--RzZDpn2POilGoRFJMn3hg-1; Fri, 26 Jun 2020 18:36:43 -0400
X-MC-Unique: -RzZDpn2POilGoRFJMn3hg-1
Received: by mail-qt1-f198.google.com with SMTP id u48so7520812qth.17
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hAWzjcK11ehl6Ry1XWEz8DeKxbF5tzxJ+GAj1+W4u20=;
        b=jC1KG+zHoIxHWlXtGjTyfTDGKc5Q/7+7w5ObVTCGVFXto5oSwY36WA2BiQcbTHutCl
         vvEiwek/SGxCjizsez3Pqkj7XzN8xejxHpii+obiB5lOFMP2tVb0iBal9l3DcFzlyAxb
         XYGYqWmb30LXN8fpetIxejf1ZqrwaBu0e83xHa1/9281z38p7d7sMPdR2jJNIUN00zF8
         3vkStqPL8d2VJYyHZTYAx7TQMMQNS0c6HPfXXY3apZQOs4jj1sXkIve0Uo/NV0vufKeo
         pyj41yXT0FiP+PgOztE2RdqkHI/rWKH4lVl1Que+lddh17w33PMcdTpF4Dj6Gat3jW9r
         waHA==
X-Gm-Message-State: AOAM53125YUdfECW8HcEmOo4s41mHw/wL8CdJA9wI2RedAxUbbL40ULx
        iVHwFGBRZMEgldkO2yA02SVBBxbfVum2ss4pScNLx9RthweftPnoVltbCI0EobeslW44Z8P8ZwT
        A7ne7MFRh2p1jTj4CD1G+yrcs
X-Received: by 2002:a37:dcc3:: with SMTP id v186mr4840584qki.393.1593211003021;
        Fri, 26 Jun 2020 15:36:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzPttymKb4wHJ717OK3QOtEVouZFuStnCrFtZdjLOL+RyVuNvJm1WtcwNW6WKTIt4lHH+smg==
X-Received: by 2002:a37:dcc3:: with SMTP id v186mr4840562qki.393.1593211002808;
        Fri, 26 Jun 2020 15:36:42 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id k2sm9143410qkf.127.2020.06.26.15.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:36:42 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 23/26] mm/x86: Use general page fault accounting
Date:   Fri, 26 Jun 2020 18:36:40 -0400
Message-Id: <20200626223640.200102-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626223130.199227-1-peterx@redhat.com>
References: <20200626223130.199227-1-peterx@redhat.com>
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

