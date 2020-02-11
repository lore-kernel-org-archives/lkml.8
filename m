Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5674C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAF124672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbgBKNz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:55:26 -0500
Received: from 8bytes.org ([81.169.241.247]:52390 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729577AbgBKNx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:53:27 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 75519E91; Tue, 11 Feb 2020 14:53:15 +0100 (CET)
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
Subject: [PATCH 46/62] x86/sev-es: Handle INVD Events
Date:   Tue, 11 Feb 2020 14:52:40 +0100
Message-Id: <20200211135256.24617-47-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211135256.24617-1-joro@8bytes.org>
References: <20200211135256.24617-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

Implement a handler for #VC exceptions caused by INVD instructions.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[ jroedel@suse.de: Adapt to #VC handling infrastructure ]
Co-developed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/sev-es.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index e96332516c2a..485f5a14c3b4 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -308,6 +308,11 @@ static enum es_result handle_rdpmc(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	return ES_OK;
 }
 
+static enum es_result handle_invd(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
+{
+	return ghcb_hv_call(ghcb, ctxt, SVM_EXIT_INVD, 0, 0);
+}
+
 static enum es_result handle_vc_exception(struct es_em_ctxt *ctxt,
 					  struct ghcb *ghcb,
 					  unsigned long exit_code,
@@ -328,6 +333,9 @@ static enum es_result handle_vc_exception(struct es_em_ctxt *ctxt,
 	case SVM_EXIT_RDPMC:
 		result = handle_rdpmc(ghcb, ctxt);
 		break;
+	case SVM_EXIT_INVD:
+		result = handle_invd(ghcb, ctxt);
+		break;
 	case SVM_EXIT_CPUID:
 		result = handle_cpuid(ghcb, ctxt);
 		break;
-- 
2.17.1

