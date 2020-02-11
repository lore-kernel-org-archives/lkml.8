Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AF2C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774822086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgBKN4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:56:17 -0500
Received: from 8bytes.org ([81.169.241.247]:52198 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729544AbgBKNxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:53:25 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 09D04E82; Tue, 11 Feb 2020 14:53:13 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 38/62] x86/sev-es: Handle instruction fetches from user-space
Date:   Tue, 11 Feb 2020 14:52:32 +0100
Message-Id: <20200211135256.24617-39-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211135256.24617-1-joro@8bytes.org>
References: <20200211135256.24617-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

When a #VC exception is triggered by user-space the instruction
decoder needs to read the instruction bytes from user addresses.
Enhance es_fetch_insn_byte() to safely fetch kernel and user
instruction bytes.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/sev-es.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 2a801919e7c0..f5bff4219f6f 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -61,13 +61,29 @@ static enum es_result es_fetch_insn_byte(struct es_em_ctxt *ctxt,
 					 unsigned int offset,
 					 char *buffer)
 {
-	char *rip = (char *)ctxt->regs->ip;
-
-	/* More checks are needed when we boot to user-space */
-	if (!check_kernel(ctxt->regs))
-		return ES_UNSUPPORTED;
-
-	buffer[offset] = rip[offset];
+	if (user_mode(ctxt->regs)) {
+		unsigned long addr = ctxt->regs->ip + offset;
+		char __user *rip = (char __user *)addr;
+
+		if (unlikely(addr >= TASK_SIZE_MAX))
+			return ES_UNSUPPORTED;
+
+		if (copy_from_user(buffer + offset, rip, 1)) {
+			ctxt->fi.vector     = X86_TRAP_PF;
+			ctxt->fi.cr2        = addr;
+			ctxt->fi.error_code = X86_PF_INSTR | X86_PF_USER;
+			return ES_EXCEPTION;
+		}
+	} else {
+		char *rip = (char *)ctxt->regs->ip + offset;
+
+		if (probe_kernel_read(buffer + offset, rip, 1) != 0) {
+			ctxt->fi.vector     = X86_TRAP_PF;
+			ctxt->fi.cr2        = (unsigned long)rip;
+			ctxt->fi.error_code = X86_PF_INSTR;
+			return ES_EXCEPTION;
+		}
+	}
 
 	return ES_OK;
 }
-- 
2.17.1

