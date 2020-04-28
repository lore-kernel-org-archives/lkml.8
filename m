Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEBCC83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0274921841
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgD1PVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:21:11 -0400
Received: from 8bytes.org ([81.169.241.247]:38536 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbgD1PSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:18:12 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7BBE9F30; Tue, 28 Apr 2020 17:17:51 +0200 (CEST)
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
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 49/75] x86/sev-es: Handle instruction fetches from user-space
Date:   Tue, 28 Apr 2020 17:16:59 +0200
Message-Id: <20200428151725.31091-50-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200428151725.31091-1-joro@8bytes.org>
References: <20200428151725.31091-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

When a #VC exception is triggered by user-space the instruction decoder
needs to read the instruction bytes from user addresses.  Enhance
vc_decode_insn() to safely fetch kernel and user instructions.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/sev-es.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 85027fb4177e..c2223c2a28c2 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -165,17 +165,30 @@ static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
 	enum es_result ret;
 	int res;
 
-	res = vc_fetch_insn_kernel(ctxt, buffer);
-	if (unlikely(res == -EFAULT)) {
-		ctxt->fi.vector     = X86_TRAP_PF;
-		ctxt->fi.error_code = 0;
-		ctxt->fi.cr2        = ctxt->regs->ip;
-		return ES_EXCEPTION;
+	if (!user_mode(ctxt->regs)) {
+		res = vc_fetch_insn_kernel(ctxt, buffer);
+		if (unlikely(res == -EFAULT)) {
+			ctxt->fi.vector     = X86_TRAP_PF;
+			ctxt->fi.error_code = 0;
+			ctxt->fi.cr2        = ctxt->regs->ip;
+			return ES_EXCEPTION;
+		}
+
+		insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE - res, 1);
+		insn_get_length(&ctxt->insn);
+	} else {
+		res = insn_fetch_from_user(ctxt->regs, buffer);
+		if (res == 0) {
+			ctxt->fi.vector     = X86_TRAP_PF;
+			ctxt->fi.cr2        = ctxt->regs->ip;
+			ctxt->fi.error_code = X86_PF_INSTR | X86_PF_USER;
+			return ES_EXCEPTION;
+		}
+
+		if (!insn_decode(ctxt->regs, &ctxt->insn, buffer, res))
+			return ES_DECODE_FAILED;
 	}
 
-	insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE - res, 1);
-	insn_get_length(&ctxt->insn);
-
 	ret = ctxt->insn.immediate.got ? ES_OK : ES_DECODE_FAILED;
 
 	return ret;
-- 
2.17.1

