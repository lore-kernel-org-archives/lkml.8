Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3372C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3FF24650
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgBKNxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:53:39 -0500
Received: from 8bytes.org ([81.169.241.247]:52410 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729565AbgBKNx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:53:27 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 20CAFE8E; Tue, 11 Feb 2020 14:53:15 +0100 (CET)
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
Subject: [PATCH 44/62] x86/sev-es: Handle RDTSC Events
Date:   Tue, 11 Feb 2020 14:52:38 +0100
Message-Id: <20200211135256.24617-45-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211135256.24617-1-joro@8bytes.org>
References: <20200211135256.24617-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

Implement a handler for #VC exceptions caused by RDTSC instructions.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[ jroedel@suse.de: Adapt to #VC handling infrastructure ]
Co-developed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/sev-es.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 491537b770fd..061557515f75 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -272,6 +272,23 @@ static enum es_result handle_wbinvd(struct ghcb *ghcb,
 	return ghcb_hv_call(ghcb, ctxt, SVM_EXIT_WBINVD, 0, 0);
 }
 
+static enum es_result handle_rdtsc(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
+{
+	enum es_result ret;
+
+	ret = ghcb_hv_call(ghcb, ctxt, SVM_EXIT_RDTSC, 0, 0);
+	if (ret != ES_OK)
+		return ret;
+
+	if (!(ghcb_is_valid_rax(ghcb) && ghcb_is_valid_rdx(ghcb)))
+		return ES_VMM_ERROR;
+
+	ctxt->regs->ax = ghcb->save.rax;
+	ctxt->regs->dx = ghcb->save.rdx;
+
+	return ES_OK;
+}
+
 static enum es_result handle_vc_exception(struct es_em_ctxt *ctxt,
 					  struct ghcb *ghcb,
 					  unsigned long exit_code,
@@ -286,6 +303,9 @@ static enum es_result handle_vc_exception(struct es_em_ctxt *ctxt,
 	case SVM_EXIT_WRITE_DR7:
 		result = handle_dr7_write(ghcb, ctxt, early);
 		break;
+	case SVM_EXIT_RDTSC:
+		result = handle_rdtsc(ghcb, ctxt);
+		break;
 	case SVM_EXIT_CPUID:
 		result = handle_cpuid(ghcb, ctxt);
 		break;
-- 
2.17.1

