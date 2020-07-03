Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675D5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 395CB21556
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593795786;
	bh=VtVahXR24bIQ7uZKPTBuNdjH+qDT1E7QMPYElGUQZMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sx6XJrn5brbH/WpOBtQnvDCIT4rNXKrgRm2Ba5iQYHp7QUk89whJ9BWU+8zl1RhsI
	 GVOXMMoacfxvz8n9sdDoa4ly8FJhdb15nv9BX+6idN15mQFKMUJydQMR/KgUz8EW6g
	 cckm2OX2xxJ3s1Kqice03QLLw/6WybIGPsQd3GJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgGCRDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:03:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgGCRDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:03:02 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E6E9208E4;
        Fri,  3 Jul 2020 17:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593795782;
        bh=VtVahXR24bIQ7uZKPTBuNdjH+qDT1E7QMPYElGUQZMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jkXxwqjFMdCLzXd+2SYBs7TngFpP2CmsJ0N15TpRaVpAXyx37y36pzLGo/NlHUhtV
         A/6SzgfAbFnAiv/hMjayfwaw7RwPjeMoptxhu0gjp1z0RKRi7E1TEn9veXi6ppILQ2
         19Rmaj3jrboNkq+yyWqpEL+Pd51Cl+4MSIssZMRE=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH entry v2 1/6] x86/entry/compat: Clear RAX high bits on Xen PV SYSENTER
Date:   Fri,  3 Jul 2020 10:02:53 -0700
Message-Id: <9d33b3f3216dcab008070f1c28b6091ae7199969.1593795633.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1593795633.git.luto@kernel.org>
References: <cover.1593795633.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the cleari the high bits of RAX after Xen PV joins the SYSENTER
path so that Xen PV doesn't skip it.

Arguably we should delete this code instead, but that would belong
in the merge window.

Fixes: ffae641f5747 ("x86/entry/64/compat: Fix Xen PV SYSENTER frame setup")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/entry_64_compat.S | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 381a6de7de9c..541fdaf64045 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -57,15 +57,6 @@ SYM_CODE_START(entry_SYSENTER_compat)
 
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
-	/*
-	 * User tracing code (ptrace or signal handlers) might assume that
-	 * the saved RAX contains a 32-bit number when we're invoking a 32-bit
-	 * syscall.  Just in case the high bits are nonzero, zero-extend
-	 * the syscall number.  (This could almost certainly be deleted
-	 * with no ill effects.)
-	 */
-	movl	%eax, %eax
-
 	/* Construct struct pt_regs on stack */
 	pushq	$__USER32_DS		/* pt_regs->ss */
 	pushq	$0			/* pt_regs->sp = 0 (placeholder) */
@@ -80,6 +71,16 @@ SYM_CODE_START(entry_SYSENTER_compat)
 	pushq	$__USER32_CS		/* pt_regs->cs */
 	pushq	$0			/* pt_regs->ip = 0 (placeholder) */
 SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
+
+	/*
+	 * User tracing code (ptrace or signal handlers) might assume that
+	 * the saved RAX contains a 32-bit number when we're invoking a 32-bit
+	 * syscall.  Just in case the high bits are nonzero, zero-extend
+	 * the syscall number.  (This could almost certainly be deleted
+	 * with no ill effects.)
+	 */
+	movl	%eax, %eax
+
 	pushq	%rax			/* pt_regs->orig_ax */
 	pushq	%rdi			/* pt_regs->di */
 	pushq	%rsi			/* pt_regs->si */
-- 
2.25.4

