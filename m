Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C45C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 474652077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587684145;
	bh=tmA6SZO0NejwyvA4Wa62HYo+fcsKi6wnDq5VNCSEFW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rYvlDutM8ZXq9i2JbFFmzBO+P7e7/5vJHTpkBjKi+xfbbK2kQTwjdBwN5N7cV1HML
	 f/Evxgb0WXdnEUndSRa2y6z8IBhJyvQ0tU2TYQBotxWY4DQv4qKodmgOpsiOIBK6vp
	 P7T1a02mpYhn0APLvGTUefFq27cWOuq3VXkg5KEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgDWXWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:22:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729195AbgDWXWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:22:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09158215A4;
        Thu, 23 Apr 2020 23:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587684138;
        bh=tmA6SZO0NejwyvA4Wa62HYo+fcsKi6wnDq5VNCSEFW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DdGbOAZp3kQFyDNHGdswM9670IF9NQG1NkAheR17iXYDgfN9ZUWVQXbTxmfyxC+/R
         a3ugdSDsBi8H7/9fSN1iU3mAczbkh1iyz41A3R36sDpyLutPi3K89xPvdHJlOV6mbW
         qZCbxkFKlg+++iC1hd74Z09xGJbHEfm/YuNx/T2Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Vegard Nossum <vegard.nossum@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v10 05/18] x86/entry/64: Switch CR3 before SWAPGS in paranoid entry
Date:   Thu, 23 Apr 2020 19:21:54 -0400
Message-Id: <20200423232207.5797-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423232207.5797-1-sashal@kernel.org>
References: <20200423232207.5797-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chang S. Bae" <chang.seok.bae@intel.com>

When FSGSBASE is enabled, the GS base handling in paranoid entry will need
to retrieve the kernel GS base which requires that the kernel page table is
active.

As the CR3 switch to the kernel page tables (PTI is active) does not depend
on kernel GS base, move the CR3 switch in front of the GS base handling.

Comment the EBX content while at it.

No functional change.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/entry/entry_64.S | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3adb3c8e2409b..7f27626f8426f 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1220,15 +1220,7 @@ SYM_CODE_START_LOCAL(paranoid_entry)
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
 
-1:
 	/*
 	 * Always stash CR3 in %r14.  This value will be restored,
 	 * verbatim, at exit.  Needed if paranoid_entry interrupted
@@ -1238,16 +1230,31 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	 * This is also why CS (stashed in the "iret frame" by the
 	 * hardware at entry) can not be used: this may be a return
 	 * to kernel code, but with a user CR3 value.
+	 *
+	 * Switching CR3 does not depend on kernel GS base so it can
+	 * be done before switching to the kernel GS base. This is
+	 * required for FSGSBASE because the kernel GS base has to
+	 * be retrieved from a kernel internal table.
 	 */
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
 
+	/* EBX = 1 -> kernel GSBASE active, no restore required */
+	movl	$1, %ebx
 	/*
-	 * The above SAVE_AND_SWITCH_TO_KERNEL_CR3 macro doesn't do an
-	 * unconditional CR3 write, even in the PTI case.  So do an lfence
-	 * to prevent GS speculation, regardless of whether PTI is enabled.
+	 * The kernel-enforced convention is a negative GS base indicates
+	 * a kernel value. No SWAPGS needed on entry and exit.
 	 */
-	FENCE_SWAPGS_KERNEL_ENTRY
+	movl	$MSR_GS_BASE, %ecx
+	rdmsr
+	testl	%edx, %edx
+	jns	.Lparanoid_entry_swapgs
+	ret
 
+.Lparanoid_entry_swapgs:
+	SWAPGS
+	FENCE_SWAPGS_KERNEL_ENTRY
+	/* EBX = 0 -> SWAPGS required on exit */
+	xorl	%ebx, %ebx
 	ret
 SYM_CODE_END(paranoid_entry)
 
-- 
2.20.1

