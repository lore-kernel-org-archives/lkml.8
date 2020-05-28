Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4710C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FD29207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590696903;
	bh=ZkQfUCoSLhk8TJGYpu7rAbr5u4cB5xvk2DG9dyqI42M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dee+LDM3ZKrLbsARAPZ+gVcXXgaVR/u2b04Nlg7K5XbKTLy7fri3COlu0QNZLIRr+
	 GKUmpta8GNxKF761ifDMeACuJ5vObf7Fd+VekmLyZHYA6+Q4KkdkrW1azy07XyB2z2
	 DhZOk0Zz9ss7OYssm0aup0Du0lYKRQQ++pq/4L34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406899AbgE1UPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:15:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407030AbgE1UOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:14:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02AAB21531;
        Thu, 28 May 2020 20:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590696869;
        bh=ZkQfUCoSLhk8TJGYpu7rAbr5u4cB5xvk2DG9dyqI42M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N02hPfEKJWZAz7IhR29+6v50ljmyMrPCOpMsc0mJhrAks34MY8OjHAjpmYcilWqBC
         wKb3eXgoKI8xfriZByf1AxLU0ReaoAX5l24ts+6ciLqPVuhnjR2DdoIu9glstQpNo4
         WPJg0rjAICwS1kB1NlIXwbSy92/tdBSfzn6nzcws=
From:   Sasha Levin <sashal@kernel.org>
To:     tglx@linutronix.de, luto@kernel.org, ak@linux.intel.com
Cc:     corbet@lwn.net, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        shuah@kernel.org, gregkh@linuxfoundation.org, tony.luck@intel.com,
        chang.seok.bae@intel.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v13 09/16] x86/entry/64: Switch CR3 before SWAPGS in paranoid entry
Date:   Thu, 28 May 2020 16:13:55 -0400
Message-Id: <20200528201402.1708239-10-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528201402.1708239-1-sashal@kernel.org>
References: <20200528201402.1708239-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chang S. Bae" <chang.seok.bae@intel.com>

When FSGSBASE is enabled, the GSBASE handling in paranoid entry will need
to retrieve the kernel GSBASE which requires that the kernel page table is
active.

As the CR3 switch to the kernel page tables (PTI is active) does not depend
on kernel GSBASE, move the CR3 switch in front of the GSBASE handling.

Comment the EBX content while at it.

No functional change.

[ tglx: Rewrote changelog and comments ]

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lkml.kernel.org/r/1557309753-24073-11-git-send-email-chang.seok.bae@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/entry/entry_64.S | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3063aa9090f9..3b9ccba6c4b4 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1220,13 +1220,6 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	cld
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
-	movl	$1, %ebx
-	movl	$MSR_GS_BASE, %ecx
-	rdmsr
-	testl	%edx, %edx
-	js	1f				/* negative -> in kernel */
-	SWAPGS
-	xorl	%ebx, %ebx
 
 1:
 	/*
@@ -1238,9 +1231,29 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	 * This is also why CS (stashed in the "iret frame" by the
 	 * hardware at entry) can not be used: this may be a return
 	 * to kernel code, but with a user CR3 value.
+	 *
+	 * Switching CR3 does not depend on kernel GSBASE so it can
+	 * be done before switching to the kernel GSBASE. This is
+	 * required for FSGSBASE because the kernel GSBASE has to
+	 * be retrieved from a kernel internal table.
 	 */
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
 
+	/* EBX = 1 -> kernel GSBASE active, no restore required */
+	movl	$1, %ebx
+	/*
+	 * The kernel-enforced convention is a negative GSBASE indicates
+	 * a kernel value. No SWAPGS needed on entry and exit.
+	 */
+	movl	$MSR_GS_BASE, %ecx
+	rdmsr
+	testl	%edx, %edx
+	jns	.Lparanoid_entry_swapgs
+	ret
+
+.Lparanoid_entry_swapgs:
+	SWAPGS
+
 	/*
 	 * The above SAVE_AND_SWITCH_TO_KERNEL_CR3 macro doesn't do an
 	 * unconditional CR3 write, even in the PTI case.  So do an lfence
@@ -1248,6 +1261,8 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	 */
 	FENCE_SWAPGS_KERNEL_ENTRY
 
+	/* EBX = 0 -> SWAPGS required on exit */
+	xorl	%ebx, %ebx
 	ret
 SYM_CODE_END(paranoid_entry)
 
@@ -1267,7 +1282,8 @@ SYM_CODE_START_LOCAL(paranoid_exit)
 	UNWIND_HINT_REGS
 	DISABLE_INTERRUPTS(CLBR_ANY)
 	TRACE_IRQS_OFF_DEBUG
-	testl	%ebx, %ebx			/* swapgs needed? */
+	/* If EBX is 0, SWAPGS is required */
+	testl	%ebx, %ebx
 	jnz	.Lparanoid_exit_no_swapgs
 	TRACE_IRQS_IRETQ
 	/* Always restore stashed CR3 value (see paranoid_entry) */
-- 
2.25.1

