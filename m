Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554B8C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 072AC20C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fgB9kTDl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jK5lz1a+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbgIJJey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:34:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38756 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730328AbgIJJW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:58 -0400
Date:   Thu, 10 Sep 2020 09:22:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GPf1Fbc1PBSxebF6JNkUaO6mgNCPzvuIKWsnbOaX/K4=;
        b=fgB9kTDlPJ3e4+yZeNyqeW0Tw23S1Zp61/p+lojnyFEheuwLZirUOqOPuxK+PDBSeGI/Uq
        cLheSgral91aY6eNqWHMWjCPftg6Xl6fclOs/4r1+ebp+Qb46nGpMS10OKTI4A/jVIlxl3
        i9xgKD0oatX79af3b9QewvJdw6BYwjPRE/20MvWyoS2VhNwOJJV9rn73QEpYt4d/HH0ilR
        zJoeVPIYKzgcgF+pqeEpNo5g5lfK4sLkzlpI7882N419BiOwzr4ESUFkKmFRLAlP2B9zoV
        GEFH4Mr/cFPcL76wtK61Sw9hB/Iyf7VBDEVR9trlBo8UrYHy9j1/K3WteTtvQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GPf1Fbc1PBSxebF6JNkUaO6mgNCPzvuIKWsnbOaX/K4=;
        b=jK5lz1a+XiS5vaIA6sLeijcSmIBPCNjMq9fei6gNnYM8AGMn1UwovyKIIHqp7PnGTibCqj
        MTWPVHaC5FrCJMDQ==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/boot/compressed/64: Call
 set_sev_encryption_mask() earlier
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-21-joro@8bytes.org>
References: <20200907131613.12703-21-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972974433.20229.16402957057054683352.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     c2a0304a286f386e45cea3f4b0617f0813de67fd
Gitweb:        https://git.kernel.org/tip/c2a0304a286f386e45cea3f4b0617f0813de67fd
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:21 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 19:45:25 +02:00

x86/boot/compressed/64: Call set_sev_encryption_mask() earlier

Call set_sev_encryption_mask() while still on the stage 1 #VC-handler
because the stage 2 handler needs the kernel's own page tables to be
set up, to which calling set_sev_encryption_mask() is a prerequisite.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-21-joro@8bytes.org
---
 arch/x86/boot/compressed/head_64.S      |  9 ++++++++-
 arch/x86/boot/compressed/ident_map_64.c |  3 ---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index fb6c039..42190c0 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -543,9 +543,16 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	rep	stosq
 
 /*
- * Load stage2 IDT and switch to our own page-table
+ * If running as an SEV guest, the encryption mask is required in the
+ * page-table setup code below. When the guest also has SEV-ES enabled
+ * set_sev_encryption_mask() will cause #VC exceptions, but the stage2
+ * handler can't map its GHCB because the page-table is not set up yet.
+ * So set up the encryption mask here while still on the stage1 #VC
+ * handler. Then load stage2 IDT and switch to the kernel's own
+ * page-table.
  */
 	pushq	%rsi
+	call	set_sev_encryption_mask
 	call	load_stage2_idt
 	call	initialize_identity_maps
 	popq	%rsi
diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 62e42c1..b4f2a5f 100644
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
 
