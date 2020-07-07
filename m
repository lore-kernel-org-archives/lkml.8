Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BD9C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EB692075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+SWQiEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgGGWvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:51:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48899 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729752AbgGGWvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594162262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kk36RboWNwg3s7a93FkyA+KGsd0nhQw91NIAXCwhVNw=;
        b=E+SWQiEOqrSWDMuUenqBPZuinnBpEGoJbrN4UD6Bfxc04fl9GEmrqIUo4TQKP6uewSBZc4
        lzMmBUHm11Kw/X+WcBQS1NHHwNUe6W21go3rjcsWwje8CNys9HULxlL9CrQsIeniyKxaeC
        Y8VtH634HCxObNhA2JkbTNo2sdfxhKQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-7lNp3lbnPDigwTmTYr2NOg-1; Tue, 07 Jul 2020 18:51:01 -0400
X-MC-Unique: 7lNp3lbnPDigwTmTYr2NOg-1
Received: by mail-qk1-f197.google.com with SMTP id q6so21047672qke.21
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kk36RboWNwg3s7a93FkyA+KGsd0nhQw91NIAXCwhVNw=;
        b=HxmhVLYfulaO2euDIC3DinWr3oB4rEb2Vur+4Blq9pJhYSEefyFVB0ymREVoNDkqox
         jYhQYhms7AmC9IvfTj3Ao4mM9maKo4azWG+SIaIyhBMkNS3ZqefoyKirAc13D5lRQiI8
         d9AkaJdwOcVXRbUcC1XE8akCFJbJCsdl5xHQS71R7dtjzC8YVnX2lRKIdLyvE8VnWM1G
         CfdzZ/oWeA1kWaAp+CgWBVrrcHsEoqL54ficBLCHkPI4c1ycF1Ypxz7tcDs/UIgKpZPd
         SorjRIS666Tw3oSoq5g9/l8W8AId3LUr5w/eJujcZGfMlH9wHeoDlKFpzAj/OoRVmmrv
         yBsg==
X-Gm-Message-State: AOAM532CV6A3SW6y+8ybw6ktV48Y3xYXYoDsPMZ6Y/v7RUIYBoDC22qS
        IcctC2YZqIWF+atlp6i37XzYDp6CMJ74aaBkVJQOjKuNK0cEZKPDTQ+aD4eN1IJGJmxvO+YLlei
        iShiJ7fI5IwznnhrMpcBNdhFJ
X-Received: by 2002:a37:6190:: with SMTP id v138mr53385956qkb.121.1594162260752;
        Tue, 07 Jul 2020 15:51:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTUthE4moACxwTPkskLMlZ3H+JQN0LXa92kSVZuEtlyr0Utc0VYzJmCu+EUJvBvgJauPP9DA==
X-Received: by 2002:a37:6190:: with SMTP id v138mr53385933qkb.121.1594162260533;
        Tue, 07 Jul 2020 15:51:00 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j16sm26267642qtp.92.2020.07.07.15.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:50:59 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 22/25] mm/x86: Use general page fault accounting
Date:   Tue,  7 Jul 2020 18:50:18 -0400
Message-Id: <20200707225021.200906-23-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707225021.200906-1-peterx@redhat.com>
References: <20200707225021.200906-1-peterx@redhat.com>
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
index 0adbff41adec..471cfd162b30 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1139,7 +1139,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	struct vm_area_struct *vma;
 	struct task_struct *tsk;
 	struct mm_struct *mm;
-	vm_fault_t fault, major = 0;
+	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	tsk = current;
@@ -1291,8 +1291,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * userland). The return to userland is identified whenever
 	 * FAULT_FLAG_USER|FAULT_FLAG_KILLABLE are both set in flags.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
-	major |= fault & VM_FAULT_MAJOR;
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
@@ -1319,18 +1318,6 @@ void do_user_addr_fault(struct pt_regs *regs,
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

