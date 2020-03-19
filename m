Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B33AC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 09:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06B120722
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 09:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgCSJQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 05:16:04 -0400
Received: from 8bytes.org ([81.169.241.247]:53168 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbgCSJOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 05:14:46 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A9D92EC7; Thu, 19 Mar 2020 10:14:27 +0100 (CET)
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
Subject: [PATCH 61/70] x86/paravirt: Allow hypervisor specific VMMCALL handling under SEV-ES
Date:   Thu, 19 Mar 2020 10:13:58 +0100
Message-Id: <20200319091407.1481-62-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319091407.1481-1-joro@8bytes.org>
References: <20200319091407.1481-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Add two new paravirt callbacks to provide hypervisor specific processor
state in the GHCB and to copy state from the hypervisor back to the
processor.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/x86_init.h | 16 +++++++++++++++-
 arch/x86/kernel/sev-es.c        | 12 ++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 96d9cd208610..c4790ec279cc 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -4,8 +4,10 @@
 
 #include <asm/bootparam.h>
 
+struct ghcb;
 struct mpc_bus;
 struct mpc_cpu;
+struct pt_regs;
 struct mpc_table;
 struct cpuinfo_x86;
 
@@ -238,10 +240,22 @@ struct x86_legacy_features {
 /**
  * struct x86_hyper_runtime - x86 hypervisor specific runtime callbacks
  *
- * @pin_vcpu:		pin current vcpu to specified physical cpu (run rarely)
+ * @pin_vcpu:			pin current vcpu to specified physical
+ *				cpu (run rarely)
+ * @sev_es_hcall_prepare:	Load additional hypervisor-specific
+ *				state into the GHCB when doing a VMMCALL under
+ *				SEV-ES. Called from the #VC exception handler.
+ * @sev_es_hcall_finish:	Copies state from the GHCB back into the
+ *				processor (or pt_regs). Also runs checks on the
+ *				state returned from the hypervisor after a
+ *				VMMCALL under SEV-ES.  Needs to return 'false'
+ *				if the checks fail.  Called from the #VC
+ *				exception handler.
  */
 struct x86_hyper_runtime {
 	void (*pin_vcpu)(int cpu);
+	void (*sev_es_hcall_prepare)(struct ghcb *ghcb, struct pt_regs *regs);
+	bool (*sev_es_hcall_finish)(struct ghcb *ghcb, struct pt_regs *regs);
 };
 
 /**
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index bc553aae31d2..635e7fc90d01 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -740,6 +740,9 @@ static enum es_result vc_handle_vmmcall(struct ghcb *ghcb,
 	ghcb_set_rax(ghcb, ctxt->regs->ax);
 	ghcb_set_cpl(ghcb, user_mode(ctxt->regs) ? 3 : 0);
 
+	if (x86_platform.hyper.sev_es_hcall_prepare)
+		x86_platform.hyper.sev_es_hcall_prepare(ghcb, ctxt->regs);
+
 	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_VMMCALL, 0, 0);
 	if (ret != ES_OK)
 		return ret;
@@ -749,6 +752,15 @@ static enum es_result vc_handle_vmmcall(struct ghcb *ghcb,
 
 	ctxt->regs->ax = ghcb->save.rax;
 
+	/*
+	 * Call sev_es_hcall_finish() after regs->ax is already set.
+	 * This allows the hypervisor handler to overwrite it again if
+	 * necessary.
+	 */
+	if (x86_platform.hyper.sev_es_hcall_finish &&
+	    !x86_platform.hyper.sev_es_hcall_finish(ghcb, ctxt->regs))
+		return ES_VMM_ERROR;
+
 	return ES_OK;
 }
 
-- 
2.17.1

