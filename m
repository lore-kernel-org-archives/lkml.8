Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76D8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B99F520739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIKWOR94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgFOWQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:16:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24894 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726397AbgFOWQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=36ZF/biwj/VA+UsNPBUNfyG0Dq51HOZlNRabEgtvraE=;
        b=IIKWOR94zCvAQBp1+TE1r7l4nR+bvXnfucIl0CPRw41DRNzN+PgFPEVOjWa4+0RnDmY9EQ
        v9kchydzbtdNm9sI1wrn0AMjm/vwDZiyMTiF4V4CzaG35FedLjTdIxp2phV7+L1FvgO1fr
        M82yEVcdjs15SoTSwJaZsBlrB8aO4RE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-aNGpdwOrM5WYHemcRXhAhA-1; Mon, 15 Jun 2020 18:16:42 -0400
X-MC-Unique: aNGpdwOrM5WYHemcRXhAhA-1
Received: by mail-qt1-f197.google.com with SMTP id k23so15219069qtb.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=36ZF/biwj/VA+UsNPBUNfyG0Dq51HOZlNRabEgtvraE=;
        b=UsTOrf+5EzZHKj/aw2H0VzYKkBpeGGSh667oglh2AtXgk4WaODE1WLpN2m1jD+lK7Y
         p+w1xoPHPpKXHYM+5eXFGl2ud/CbYXdtFgQaoxbgPAKFkKsjiJ4S8YVNL8Br9r8PJSqM
         S8DWiFXa0x1nctWYAyMz5q3CVxWMEFA1wtL9NixQritD7TtQyVibzpcO2s1KbhL02RHp
         dM8Wlt193VOuV0JSlovF+RqO5OPmFF4R12M6x5S99Om34fuvhXkDJ10zQmSnqZ5C2B2P
         CwxKyhIYX8xfDPgxqrig8TJVNyaT+h0rc0GruhP5jLXJJ++PFCYP8d0p27bjQc6jMPNr
         v+uA==
X-Gm-Message-State: AOAM533NpT9mjsVcon+JTLrZkX338HskIub2ceFwlJm+mDHULuoCGoCX
        0p64U8MXp3puV6BWZjNerLudrnJJ8DV/Ezb75qv3p2lMQG6esn2PTmqrQWg0iL1V/V3hAqfrtmV
        RaY3lyps03jGsn1glNXKQGkMm
X-Received: by 2002:a37:a0d0:: with SMTP id j199mr16970953qke.300.1592259400690;
        Mon, 15 Jun 2020 15:16:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9KGEANrrpBThsrhroFN+hSsX9BivaeMbkhMP7hiObGEAGG+ZmPX4mroIaSO0uiyEEJzhS4Q==
X-Received: by 2002:a37:a0d0:: with SMTP id j199mr16970930qke.300.1592259400461;
        Mon, 15 Jun 2020 15:16:40 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w13sm12351509qkb.91.2020.06.15.15.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:16:39 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH 18/25] mm/riscv: Use mm_fault_accounting()
Date:   Mon, 15 Jun 2020 18:16:00 -0400
Message-Id: <20200615221607.7764-19-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615221607.7764-1-peterx@redhat.com>
References: <20200615221607.7764-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new mm_fault_accounting() helper for page fault accounting.

Avoid doing page fault accounting multiple times if the page fault is retried.

CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Albert Ou <aou@eecs.berkeley.edu>
CC: linux-riscv@lists.infradead.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/riscv/mm/fault.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index be84e32adc4c..9262338614d1 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -30,7 +30,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 	unsigned long addr, cause;
-	unsigned int flags = FAULT_FLAG_DEFAULT;
+	unsigned int flags = FAULT_FLAG_DEFAULT, major = 0;
 	int code = SEGV_MAPERR;
 	vm_fault_t fault;
 
@@ -65,9 +65,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
-
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
-
 retry:
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, addr);
@@ -111,6 +108,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	 * the fault.
 	 */
 	fault = handle_mm_fault(vma, addr, flags);
+	major |= fault & VM_FAULT_MAJOR;
 
 	/*
 	 * If we need to retry but a fatal signal is pending, handle the
@@ -128,21 +126,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 		BUG();
 	}
 
-	/*
-	 * Major/minor page fault accounting is only done on the
-	 * initial attempt. If we go through a retry, it is extremely
-	 * likely that the page will be found in page cache at that point.
-	 */
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR) {
-			tsk->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ,
-				      1, regs, addr);
-		} else {
-			tsk->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN,
-				      1, regs, addr);
-		}
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
@@ -156,6 +140,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	}
 
 	up_read(&mm->mmap_sem);
+	mm_fault_accounting(tsk, regs, addr, major);
 	return;
 
 	/*
-- 
2.26.2

