Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A69EC433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 367AF2065E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259916;
	bh=JS8ZQOSUM4qWSeqJVCG/LhsLW7f6uNGnyC/H3yHP2+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fU1APIf/5Qs9+EnieMsr3/mv4UVmFsHCXAUVhy10ONhgZhId8JNpVtlFf5rIhK1Or
	 nG8nOfd7f/S89Ybrh/t+dBFRT3xhTJDkBWU+NHdEFKD1ddN4j5Gni5NSpDKrQpomMf
	 ZEoTj9DGWOaAH2XTIjaynnKArTjzmZLHZ1Tr6i3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgGTPpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730487AbgGTPpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:45:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0CD42176B;
        Mon, 20 Jul 2020 15:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259911;
        bh=JS8ZQOSUM4qWSeqJVCG/LhsLW7f6uNGnyC/H3yHP2+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SqGCzk3NTkgosQqampq2aykbx36sxTsGB0pek1TMB8kVrccVRe7BDbzTTHehXG/nC
         nD9RIMrN3GPcWw/IDW7yR/+/GYbxG3htx04taW+epcLdB/qkqJXl64fFezoDFyKF92
         h7hiplTThK0V86l8/zkv8w5NJ8VNrtx45+1WAHY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.14 038/125] ARC: entry: fix potential EFA clobber when TIF_SYSCALL_TRACE
Date:   Mon, 20 Jul 2020 17:36:17 +0200
Message-Id: <20200720152804.840483594@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152802.929969555@linuxfoundation.org>
References: <20200720152802.929969555@linuxfoundation.org>
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
@@ -156,7 +156,6 @@ END(EV_Extension)
 tracesys:
 	; save EFA in case tracer wants the PC of traced task
 	; using ERET won't work since next-PC has already committed
-	lr  r12, [efa]
 	GET_CURR_TASK_FIELD_PTR   TASK_THREAD, r11
 	st  r12, [r11, THREAD_FAULT_ADDR]	; thread.fault_address
 
@@ -199,15 +198,9 @@ tracesys_exit:
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
@@ -234,6 +227,10 @@ ENTRY(EV_Trap)
 
 	EXCEPTION_PROLOGUE
 
+	lr  r12, [efa]
+
+	FAKE_RET_FROM_EXCPN
+
 	;============ TRAP 1   :breakpoints
 	; Check ECR for trap with arg (PROLOGUE ensures r9 has ECR)
 	bmsk.f 0, r9, 7
@@ -241,9 +238,6 @@ ENTRY(EV_Trap)
 
 	;============ TRAP  (no param): syscall top level
 
-	; First return from Exception to pure K mode (Exception/IRQs renabled)
-	FAKE_RET_FROM_EXCPN
-
 	; If syscall tracing ongoing, invoke pre-post-hooks
 	GET_CURR_THR_INFO_FLAGS   r10
 	btst r10, TIF_SYSCALL_TRACE


