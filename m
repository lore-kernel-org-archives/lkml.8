Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A507C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 01:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D96D20674
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 01:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwLTw4Fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGYBBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 21:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgGYBBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 21:01:01 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4117C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 18:01:01 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l63so6327268pge.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 18:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RqfdT0iZfHl2g0qn8q8pqEPbfkgN0EeoAjSG+bhJsWM=;
        b=BwLTw4FbxSU927pXuNBAIQ/zdNnVr8ABcb1hYugeTjvBRQz75GA7I12kXAzqrx8DDg
         YV7VNEd9io8i6PLH0KBF5AjFHN9AF8CYiQkX8vqyzKOSB6SYStkcHZRyFsz0Ym5v2NDf
         MfS2FY+2zodBlmo5gkKdN+eVW91sjboR7QsX7qTOgQGRWQLeUuo1Osi9cCng/Bm9xIXb
         M8Cd7/C6Q/N7+6JIEmVKxCcTTxYeUgy8HD972pTpM2q9rfc1H/b1DMs0RXhpkeBzvem3
         xk4z3AykPin0qIvAT/DiyMNqkrwOT8gB8uOyoPPHZqmvITfeJl7Zd3Kh02qiNglUi36l
         zW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RqfdT0iZfHl2g0qn8q8pqEPbfkgN0EeoAjSG+bhJsWM=;
        b=s5MonDxBhMdIjvGLWOWnE9JXb/w/nKLZDSK6haC/HhWLjVqD4MQSfy/86dEc9WJTeX
         LoMcJm3lc0FI5LZ1gNlaV3stoxoZC8g2lLsBW9aVl/LZ5GLD6kfqA/M3qkfYeAOTJZwx
         r37hh4AtqWGNqW0oh0NhUh3GAqXuKUa49FBva4fj8/7f4acTOfhQAGX6vlv0iAKpkgkW
         HGu388rz6pVYR5g0YuGN32lvxI+8tl7S/Q6cK668VeBdQYjruuDssrK7Mkxm4db4wphJ
         N8tH6iGYWyVyBHDal/UXH7RpMxyb0FCUyGA9mFNjtczgwsfdMA2UpmlHO8GTeC8ZcL9Y
         rkxg==
X-Gm-Message-State: AOAM533uku9DCaeiEmkTRaQGS+AVhkS0Wyvff0+OZDnn2XJy8A+piRhW
        N9jCDmOKRpIYGQowIklLXNG4PYyRwgs=
X-Google-Smtp-Source: ABdhPJwIwSYwgF8/I5anvvdT5qNxsbMhiZWLMtmNB4W8VdwUCEpFISwzCSU0iSFsPoJarZHCBisOzQ==
X-Received: by 2002:aa7:860f:: with SMTP id p15mr11315893pfn.59.1595638860753;
        Fri, 24 Jul 2020 18:01:00 -0700 (PDT)
Received: from localhost (g155.222-224-148.ppp.wakwak.ne.jp. [222.224.148.155])
        by smtp.gmail.com with ESMTPSA id kx3sm6886397pjb.32.2020.07.24.18.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 18:01:00 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org
Subject: [PATCH] openrisc: Implement proper SMP tlb flushing
Date:   Sat, 25 Jul 2020 10:00:47 +0900
Message-Id: <20200725010049.693421-1-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Up until now when flushing pages from the TLB on SMP OpenRISC was always
resorting to flush the entire TLB on all CPUs.  This patch adds the
mechanics for flushing specific ranges and pages based on the usage.

The function switch_mm is updated to account for cpu usage by updating
mm_struct's cpumask.  This is used in the SMP flush routines.

This mostly follows the riscv implementation.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/smp.c | 85 ++++++++++++++++++++++++++++++++++----
 arch/openrisc/mm/tlb.c     | 17 +++++---
 2 files changed, 89 insertions(+), 13 deletions(-)

diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index bd1e660bbc89..29c82ef2e207 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -219,30 +219,99 @@ static inline void ipi_flush_tlb_all(void *ignored)
 	local_flush_tlb_all();
 }
 
+static inline void ipi_flush_tlb_mm(void *info)
+{
+	struct mm_struct *mm = (struct mm_struct *)info;
+
+	local_flush_tlb_mm(mm);
+}
+
+static void smp_flush_tlb_mm(struct cpumask *cmask, struct mm_struct *mm)
+{
+	unsigned int cpuid;
+
+	if (cpumask_empty(cmask))
+		return;
+
+	cpuid = get_cpu();
+
+	if (cpumask_any_but(cmask, cpuid) >= nr_cpu_ids) {
+		/* local cpu is the only cpu present in cpumask */
+		local_flush_tlb_mm(mm);
+	} else {
+		on_each_cpu_mask(cmask, ipi_flush_tlb_mm, mm, 1);
+	}
+	put_cpu();
+}
+
+struct flush_tlb_data {
+	unsigned long addr1;
+	unsigned long addr2;
+};
+
+static inline void ipi_flush_tlb_page(void *info)
+{
+	struct flush_tlb_data *fd = (struct flush_tlb_data *)info;
+
+	local_flush_tlb_page(NULL, fd->addr1);
+}
+
+static inline void ipi_flush_tlb_range(void *info)
+{
+	struct flush_tlb_data *fd = (struct flush_tlb_data *)info;
+
+	local_flush_tlb_range(NULL, fd->addr1, fd->addr2);
+}
+
+static void smp_flush_tlb_range(struct cpumask *cmask, unsigned long start,
+				unsigned long end)
+{
+	unsigned int cpuid;
+
+	if (cpumask_empty(cmask))
+		return;
+
+	cpuid = get_cpu();
+
+	if (cpumask_any_but(cmask, cpuid) >= nr_cpu_ids) {
+		/* local cpu is the only cpu present in cpumask */
+		if ((end - start) <= PAGE_SIZE)
+			local_flush_tlb_page(NULL, start);
+		else
+			local_flush_tlb_range(NULL, start, end);
+	} else {
+		struct flush_tlb_data fd;
+
+		fd.addr1 = start;
+		fd.addr2 = end;
+
+		if ((end - start) <= PAGE_SIZE)
+			on_each_cpu_mask(cmask, ipi_flush_tlb_page, &fd, 1);
+		else
+			on_each_cpu_mask(cmask, ipi_flush_tlb_range, &fd, 1);
+	}
+	put_cpu();
+}
+
 void flush_tlb_all(void)
 {
 	on_each_cpu(ipi_flush_tlb_all, NULL, 1);
 }
 
-/*
- * FIXME: implement proper functionality instead of flush_tlb_all.
- * *But*, as things currently stands, the local_tlb_flush_* functions will
- * all boil down to local_tlb_flush_all anyway.
- */
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	on_each_cpu(ipi_flush_tlb_all, NULL, 1);
+	smp_flush_tlb_mm(mm_cpumask(mm), mm);
 }
 
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 {
-	on_each_cpu(ipi_flush_tlb_all, NULL, 1);
+	smp_flush_tlb_range(mm_cpumask(vma->vm_mm), uaddr, uaddr + PAGE_SIZE);
 }
 
 void flush_tlb_range(struct vm_area_struct *vma,
 		     unsigned long start, unsigned long end)
 {
-	on_each_cpu(ipi_flush_tlb_all, NULL, 1);
+	smp_flush_tlb_range(mm_cpumask(vma->vm_mm), start, end);
 }
 
 /* Instruction cache invalidate - performed on each cpu */
diff --git a/arch/openrisc/mm/tlb.c b/arch/openrisc/mm/tlb.c
index 4b680aed8f5f..2b6feabf6381 100644
--- a/arch/openrisc/mm/tlb.c
+++ b/arch/openrisc/mm/tlb.c
@@ -137,21 +137,28 @@ void local_flush_tlb_mm(struct mm_struct *mm)
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	       struct task_struct *next_tsk)
 {
+	unsigned int cpu;
+
+	if (unlikely(prev == next))
+		return;
+
+	cpu = smp_processor_id();
+
+	cpumask_clear_cpu(cpu, mm_cpumask(prev));
+	cpumask_set_cpu(cpu, mm_cpumask(next));
+
 	/* remember the pgd for the fault handlers
 	 * this is similar to the pgd register in some other CPU's.
 	 * we need our own copy of it because current and active_mm
 	 * might be invalid at points where we still need to derefer
 	 * the pgd.
 	 */
-	current_pgd[smp_processor_id()] = next->pgd;
+	current_pgd[cpu] = next->pgd;
 
 	/* We don't have context support implemented, so flush all
 	 * entries belonging to previous map
 	 */
-
-	if (prev != next)
-		local_flush_tlb_mm(prev);
-
+	local_flush_tlb_mm(prev);
 }
 
 /*
-- 
2.26.2

