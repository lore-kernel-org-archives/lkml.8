Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBBCC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D62120738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbgHXJQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730447AbgHXI4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:56:00 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F23C061574;
        Mon, 24 Aug 2020 01:55:59 -0700 (PDT)
Received: from cap.home.8bytes.org (p4ff2bb8d.dip0.t-ipconnect.de [79.242.187.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id D6183BBE;
        Mon, 24 Aug 2020 10:55:56 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>,
        hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v6 20/76] x86/boot/compressed/64: Call set_sev_encryption_mask earlier
Date:   Mon, 24 Aug 2020 10:54:15 +0200
Message-Id: <20200824085511.7553-21-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824085511.7553-1-joro@8bytes.org>
References: <20200824085511.7553-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Call set_sev_encryption_mask() while still on the stage 1 #VC-handler,
because the stage 2 handler needs our own page-tables to be set up, to
which calling set_sev_encryption_mask() is a prerequisite.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20200724160336.5435-20-joro@8bytes.org
---
 arch/x86/boot/compressed/head_64.S      | 8 +++++++-
 arch/x86/boot/compressed/ident_map_64.c | 3 ---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 013b29921836..c7fcf60cbd08 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -533,9 +533,15 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	rep	stosq
 
 /*
- * Load stage2 IDT and switch to our own page-table
+ * If running as an SEV guest, the encryption mask is required in the
+ * page-table setup code below. When the guest also has SEV-ES enabled
+ * set_sev_encryption_mask() will cause #VC exceptions, but the stage2
+ * handler can't map its GHCB because the page-table is not set up yet.
+ * So set up the encryption mask here while still on the stage1 #VC
+ * handler. Then load stage2 IDT and switch to our own page-table.
  */
 	pushq	%rsi
+	call	set_sev_encryption_mask
 	call	load_stage2_idt
 	call	initialize_identity_maps
 	popq	%rsi
diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 62e42c11a336..b4f2a5f503cd 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -105,9 +105,6 @@ static void add_identity_map(unsigned long start, unsigned long end)
 /* Locates and clears a region for a new top level page table. */
 void initialize_identity_maps(void)
 {
-	/* If running as an SEV guest, the encryption mask is required. */
-	set_sev_encryption_mask();
-
 	/* Exclude the encryption mask from __PHYSICAL_MASK */
 	physical_mask &= ~sme_me_mask;
 
-- 
2.28.0

