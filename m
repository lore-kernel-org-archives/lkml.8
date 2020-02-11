Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D0DC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB2E2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgBKNzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:55:02 -0500
Received: from 8bytes.org ([81.169.241.247]:52278 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729592AbgBKNx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:53:28 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 871A0E9C; Tue, 11 Feb 2020 14:53:16 +0100 (CET)
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
Subject: [PATCH 52/62] x86/sev-es: Handle #DB Events
Date:   Tue, 11 Feb 2020 14:52:46 +0100
Message-Id: <20200211135256.24617-53-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211135256.24617-1-joro@8bytes.org>
References: <20200211135256.24617-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Handle #VC exceptions caused by #DB exceptions in the guest. Do not
forward them to the hypervisor and handle them with do_debug() instead.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/sev-es.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 1b873d00e38f..700f75fc13e7 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -361,6 +361,15 @@ static enum es_result handle_vmmcall(struct ghcb *ghcb,
 	return ES_OK;
 }
 
+static enum es_result handle_db_exception(struct ghcb *ghcb,
+					  struct es_em_ctxt *ctxt)
+{
+	do_debug(ctxt->regs, 0);
+
+	/* Exception event, do not advance RIP */
+	return ES_RETRY;
+}
+
 static enum es_result handle_vc_exception(struct es_em_ctxt *ctxt,
 					  struct ghcb *ghcb,
 					  unsigned long exit_code,
@@ -375,6 +384,9 @@ static enum es_result handle_vc_exception(struct es_em_ctxt *ctxt,
 	case SVM_EXIT_WRITE_DR7:
 		result = handle_dr7_write(ghcb, ctxt, early);
 		break;
+	case SVM_EXIT_EXCP_BASE + X86_TRAP_DB:
+		result = handle_db_exception(ghcb, ctxt);
+		break;
 	case SVM_EXIT_EXCP_BASE + X86_TRAP_AC:
 		do_alignment_check(ctxt->regs, 0);
 		result = ES_RETRY;
-- 
2.17.1

