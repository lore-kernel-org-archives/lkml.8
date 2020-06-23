Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94001C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 645B32078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592933999;
	bh=yjNpRv8q3GfXREcKPByLoH2E7axhZx/JhrTgyTbmn9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kUAlAidjkff+hiagDmUuwZHgdz0k/uVmlAa64ybeveUhQWIe+ZwJ8J3vF8/gEDNrq
	 4nbYadRcq2KCl/WVQqHFKy/K6XLjNTbBUxm4TQRBjLA/V7CQPk7fuaLgXJP5ZF52gw
	 PV0m9gF1FrfKYjyYTJA5PkSOV0/Gfga9BUS9kH6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387691AbgFWRj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:39:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387532AbgFWRgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:36:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 112B220774;
        Tue, 23 Jun 2020 17:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592933776;
        bh=yjNpRv8q3GfXREcKPByLoH2E7axhZx/JhrTgyTbmn9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QWFA8Hqp+0FLPhAG1DBELN+UW2kZcs1FbVJr5OcrQy/g4CRZCQKmQdPGSLVUVytIE
         6pfeUT9oyC1Eny2dhei9JjtXZwvgo7249FPXjsG0/5+j5G7MTKtDcRtu614s6PlxJH
         JfOBjTLrL43nHx+pyzjzSt6ytCUW55G/DO8+dK1c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 14/24] s390/ptrace: pass invalid syscall numbers to tracing
Date:   Tue, 23 Jun 2020 13:35:49 -0400
Message-Id: <20200623173559.1355728-14-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623173559.1355728-1-sashal@kernel.org>
References: <20200623173559.1355728-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Schnelle <svens@linux.ibm.com>

[ Upstream commit 00332c16b1604242a56289ff2b26e283dbad0812 ]

tracing expects to see invalid syscalls, so pass it through.
The syscall path in entry.S checks the syscall number before
looking up the handler, so it is still safe.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/entry.S  | 2 +-
 arch/s390/kernel/ptrace.c | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index bc85987727f09..c544b7a11ebb3 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -368,9 +368,9 @@ ENTRY(system_call)
 	jnz	.Lsysc_nr_ok
 	# svc 0: system call number in %r1
 	llgfr	%r1,%r1				# clear high word in r1
+	sth	%r1,__PT_INT_CODE+2(%r11)
 	cghi	%r1,NR_syscalls
 	jnl	.Lsysc_nr_ok
-	sth	%r1,__PT_INT_CODE+2(%r11)
 	slag	%r8,%r1,3
 .Lsysc_nr_ok:
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index ad71132374f0c..5a2b1501d9983 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -844,11 +844,9 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 	 * call number to gprs[2].
 	 */
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    (tracehook_report_syscall_entry(regs) ||
-	     regs->gprs[2] >= NR_syscalls)) {
+	    tracehook_report_syscall_entry(regs)) {
 		/*
-		 * Tracing decided this syscall should not happen or the
-		 * debugger stored an invalid system call number. Skip
+		 * Tracing decided this syscall should not happen. Skip
 		 * the system call and the system call restart handling.
 		 */
 		clear_pt_regs_flag(regs, PIF_SYSCALL);
-- 
2.25.1

