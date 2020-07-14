Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F6DC433F7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7841A229CA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753201;
	bh=a/AvI4JLbcTpd/DhvqdT62V8sjX5jgoH9AEd0SneJ3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uh4I+NWVwH4EOy7ulvNv3IxDtxiIzXui40shIP8hBRCTjDfQDuP8x158oXDyLK3bv
	 ub2lIzVIo/XaVMX3+53SUfirEhfnRorOehlBKunLykqn49eX/aJleby+QVNrrHBYap
	 DPDGr3Jep3iooNHQ6t3A8zEy9eLI2PBjIToO1bBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbgGNS77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:59:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730095AbgGNS7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:59:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC8E322507;
        Tue, 14 Jul 2020 18:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594753191;
        bh=a/AvI4JLbcTpd/DhvqdT62V8sjX5jgoH9AEd0SneJ3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tZJ/iGfDMKgY0Ri2HEMNbHuJbarY3/Cu16blv2M++qyI6uTxwD1ts/L9UkRLP8RHM
         vWAYEkwtzThqSdQuXuNulSjlNld7aGV9rfXZzD8/9CUdAR782P4jy4xFSIvvI68caI
         5LURNb8NvAtAfrH252BTz3+eX3Jj3fRIK2EzRiHY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 5.7 153/166] ARC: entry: fix potential EFA clobber when TIF_SYSCALL_TRACE
Date:   Tue, 14 Jul 2020 20:45:18 +0200
Message-Id: <20200714184123.151075690@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineet Gupta <vgupta@synopsys.com>

commit 00fdec98d9881bf5173af09aebd353ab3b9ac729 upstream.

Trap handler for syscall tracing reads EFA (Exception Fault Address),
in case strace wants PC of trap instruction (EFA is not part of pt_regs
as of current code).

However this EFA read is racy as it happens after dropping to pure
kernel mode (re-enabling interrupts). A taken interrupt could
context-switch, trigger a different task's trap, clobbering EFA for this
execution context.

Fix this by reading EFA early, before re-enabling interrupts. A slight
side benefit is de-duplication of FAKE_RET_FROM_EXCPN in trap handler.
The trap handler is common to both ARCompact and ARCv2 builds too.

This just came out of code rework/review and no real problem was reported
but is clearly a potential problem specially for strace.

Cc: <stable@vger.kernel.org>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arc/kernel/entry.S |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -165,7 +165,6 @@ END(EV_Extension)
 tracesys:
 	; save EFA in case tracer wants the PC of traced task
 	; using ERET won't work since next-PC has already committed
-	lr  r12, [efa]
 	GET_CURR_TASK_FIELD_PTR   TASK_THREAD, r11
 	st  r12, [r11, THREAD_FAULT_ADDR]	; thread.fault_address
 
@@ -208,15 +207,9 @@ tracesys_exit:
 ; Breakpoint TRAP
 ; ---------------------------------------------
 trap_with_param:
-
-	; stop_pc info by gdb needs this info
-	lr  r0, [efa]
+	mov r0, r12	; EFA in case ptracer/gdb wants stop_pc
 	mov r1, sp
 
-	; Now that we have read EFA, it is safe to do "fake" rtie
-	;   and get out of CPU exception mode
-	FAKE_RET_FROM_EXCPN
-
 	; Save callee regs in case gdb wants to have a look
 	; SP will grow up by size of CALLEE Reg-File
 	; NOTE: clobbers r12
@@ -243,6 +236,10 @@ ENTRY(EV_Trap)
 
 	EXCEPTION_PROLOGUE
 
+	lr  r12, [efa]
+
+	FAKE_RET_FROM_EXCPN
+
 	;============ TRAP 1   :breakpoints
 	; Check ECR for trap with arg (PROLOGUE ensures r10 has ECR)
 	bmsk.f 0, r10, 7
@@ -250,9 +247,6 @@ ENTRY(EV_Trap)
 
 	;============ TRAP  (no param): syscall top level
 
-	; First return from Exception to pure K mode (Exception/IRQs renabled)
-	FAKE_RET_FROM_EXCPN
-
 	; If syscall tracing ongoing, invoke pre-post-hooks
 	GET_CURR_THR_INFO_FLAGS   r10
 	btst r10, TIF_SYSCALL_TRACE


