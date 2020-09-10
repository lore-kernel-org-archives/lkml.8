Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7ABC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 298822223E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K4W1p+TA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AhXQmcFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbgIJJWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:22:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38612 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgIJJWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:07 -0400
Date:   Thu, 10 Sep 2020 09:22:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8F8RsEAnqXhYOjc6K9L2LBThuNep3ImEcdQps4cvtS8=;
        b=K4W1p+TAKxLnz/hiE6T6VokLZbcqEw6y/taNp7ItoCa43XBbbwBILXNjmPIFyvClVS+NZV
        Yx4EpOy33xEbN2m3Z+fGTMvonz+aI+ZcPaMv0h0pQpyJCvZtudQiiF4/tuulj3iaXmSeld
        0r61ic9eMgGk8x8mVuM8fepVPuidHUsZWlDjhkdk5gCN10UfYMLPysEvFjTREBBtGipB4a
        ASvciOr78v1qqcb/LYikg7jKe9a91K6drKhVAfnaKRHie3kUNQb/tPDet5sDTYqeuPcx5/
        kzFA2dOzRu2g3pdxNvPs7NtBN1f18ebDEVhSLFaJsRAhijCpvAtV6lCcP5Xbdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8F8RsEAnqXhYOjc6K9L2LBThuNep3ImEcdQps4cvtS8=;
        b=AhXQmcFJktdHJ0AIekXMwGTJLpaUaqo8U75ba5Agmbbch1WeqnQJFoGw53Tj9iwJfuanxb
        o3M+Fzdu6Q8JszAw==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/head/64: Don't call verify_cpu() on starting APs
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-69-joro@8bytes.org>
References: <20200907131613.12703-69-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972972396.20229.10379511221993111999.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     3ecacdbd23956a549d93023f86adc87b4a9d6520
Gitweb:        https://git.kernel.org/tip/3ecacdbd23956a549d93023f86adc87b4a9d6520
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:16:09 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:33:20 +02:00

x86/head/64: Don't call verify_cpu() on starting APs

The APs are not ready to handle exceptions when verify_cpu() is called
in secondary_startup_64().

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200907131613.12703-69-joro@8bytes.org
---
 arch/x86/include/asm/realmode.h |  1 +
 arch/x86/kernel/head_64.S       | 12 ++++++++++++
 arch/x86/realmode/init.c        |  6 ++++++
 3 files changed, 19 insertions(+)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 4d4d853..5db5d08 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -72,6 +72,7 @@ extern unsigned char startup_32_smp[];
 extern unsigned char boot_gdt[];
 #else
 extern unsigned char secondary_startup_64[];
+extern unsigned char secondary_startup_64_no_verify[];
 #endif
 
 static inline size_t real_mode_size_needed(void)
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 1a71d0d..7eb2a1c 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -126,6 +126,18 @@ SYM_CODE_START(secondary_startup_64)
 	call verify_cpu
 
 	/*
+	 * The secondary_startup_64_no_verify entry point is only used by
+	 * SEV-ES guests. In those guests the call to verify_cpu() would cause
+	 * #VC exceptions which can not be handled at this stage of secondary
+	 * CPU bringup.
+	 *
+	 * All non SEV-ES systems, especially Intel systems, need to execute
+	 * verify_cpu() above to make sure NX is enabled.
+	 */
+SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
+	UNWIND_HINT_EMPTY
+
+	/*
 	 * Retrieve the modifier (SME encryption mask if SME is active) to be
 	 * added to the initial pgdir entry that will be programmed into CR3.
 	 */
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 3fb9b60..22fda7d 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -46,6 +46,12 @@ static void sme_sev_setup_real_mode(struct trampoline_header *th)
 		th->flags |= TH_FLAGS_SME_ACTIVE;
 
 	if (sev_es_active()) {
+		/*
+		 * Skip the call to verify_cpu() in secondary_startup_64 as it
+		 * will cause #VC exceptions when the AP can't handle them yet.
+		 */
+		th->start = (u64) secondary_startup_64_no_verify;
+
 		if (sev_es_setup_ap_jump_table(real_mode_header))
 			panic("Failed to get/update SEV-ES AP Jump Table");
 	}
