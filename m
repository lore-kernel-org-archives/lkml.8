Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C17C433ED
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0432620663
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8Zir56V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbgF3UqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:46:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45494 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730290AbgF3Upv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=C2j+0prlu3q0Pnx3SiAUON88ocaozCL3GS+ha/ScH8o=;
        b=L8Zir56V1tV/fGwlgwaOpJCsqDItyzXLm8cpDUaMDAqGG1LmwE5LkdG/zTyZWZFrzvSwL8
        ZT0VAuoIakuiwhauqBHNtSNapcOZFlRXrIv9+SWsUlbWygan2qu27YsQfY89wPcpgYJlx7
        z/bKoE4qTNyLFE23bNqkEzFKs3nl86E=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-B-tMB9XmMl6ahiRuPBTN4A-1; Tue, 30 Jun 2020 16:45:41 -0400
X-MC-Unique: B-tMB9XmMl6ahiRuPBTN4A-1
Received: by mail-qk1-f197.google.com with SMTP id q192so5231837qka.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C2j+0prlu3q0Pnx3SiAUON88ocaozCL3GS+ha/ScH8o=;
        b=OgGmjpgG3/TjYci3TJ29nzsVZx9YRUzwnBToY52iahb04eNRgY2u39fVsg/OojSmR8
         gXHz5ANCW9DTEhbok8qtk30Si50k4HDk2uKuI9ldjzZkZUb4zzYTitis+ChBpHwN9bur
         lXXV9dvSbVo98rRiijqsz+VGu/IDS3OEXMjZDjH6xyxVr5kR42Wt/DsCwhfd9/U83sds
         mVEv5Tu5NonK1GHYqlKB4POUUDyZtqbUxsj2XuBU9iAIMzggOdwSFlM+T1vBlQrgDfar
         bz7Q1Nm1OFxAgxz5LSgxY4qDHWh37QL5+Z+oPCx+DtWLUch0zjbySVqoNR28dn2OKVro
         DwuA==
X-Gm-Message-State: AOAM531utX6RMHUQcaMc6Rz6cWMrZlzFE+dJNg7WoRWkBr0XOpOQrLzI
        P0UYiYJ85CjK8HgxMEgBD934Q1VizpxGJ8k0V2bpvYNlO/htDLf0byaS/DJni0tah4X0BtuDpCs
        UWcTGFijLVobABizg14s/FyUs
X-Received: by 2002:a37:af82:: with SMTP id y124mr21944083qke.254.1593549940753;
        Tue, 30 Jun 2020 13:45:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/HYIsMAbxeYN3zSZX+wIPNCjUoMjnq6Rwg1C2jh93RywEtUABz6jJyXvLDQO0NcHZL2Cmkg==
X-Received: by 2002:a37:af82:: with SMTP id y124mr21944054qke.254.1593549940427;
        Tue, 30 Jun 2020 13:45:40 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id 142sm3880877qki.35.2020.06.30.13.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:45:39 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org
Subject: [PATCH v4 14/26] mm/openrisc: Use general page fault accounting
Date:   Tue, 30 Jun 2020 16:45:38 -0400
Message-Id: <20200630204538.39149-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().
It naturally solve the issue of multiple page fault accounting when page fault
retry happened.

Add the missing PERF_COUNT_SW_PAGE_FAULTS perf events too.  Note, the other two
perf events (PERF_COUNT_SW_PAGE_FAULTS_[MAJ|MIN]) were done in handle_mm_fault().

CC: Jonas Bonn <jonas@southpole.se>
CC: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
CC: Stafford Horne <shorne@gmail.com>
CC: openrisc@lists.librecores.org
Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/openrisc/mm/fault.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index 3daa491d1edb..ca97d9baab51 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/extable.h>
 #include <linux/sched/signal.h>
+#include <linux/perf_event.h>
 
 #include <linux/uaccess.h>
 #include <asm/siginfo.h>
@@ -103,6 +104,8 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (in_interrupt() || !mm)
 		goto no_context;
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
+
 retry:
 	mmap_read_lock(mm);
 	vma = find_vma(mm, address);
@@ -159,7 +162,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * the fault.
 	 */
 
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -176,10 +179,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
 		/*RGD modeled on Cris */
-		if (fault & VM_FAULT_MAJOR)
-			tsk->maj_flt++;
-		else
-			tsk->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2

