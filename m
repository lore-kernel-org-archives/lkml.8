Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE1BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD54121D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IlmtGOd8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kX0rImp0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbgIJJ1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:27:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38932 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730474AbgIJJYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:24:04 -0400
Date:   Thu, 10 Sep 2020 09:22:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g7Qqx4dE4zh12ve8Ky5Zt1rD0JToonxUriEmpHiwUTk=;
        b=IlmtGOd8H3B+h0QkvMDR8A5MkTR9zevfZHkh0CFOzUfpXoRbY+To99Nh2YKelszMKKYKs1
        tKdyzhIUdJJqtlb1HPzC888jZ6NVrZCv7WDwrmN3hHPMmPZRglif+UpDbMFSQCXnCvux5J
        19GQd0ZhYQq9Kyj1cSbUpS5JI3m3ax0bEl4h7drIu995Cfln13OvhGYHJh4sn461yJUf0N
        kPigaQepWNmO2lW61y+EbHqZwQVJRIxRbuP6RJD2c5ND3IPhNGEAiXgCdKXPm2nX8gQazR
        ey6f+3fdutOcRa0EeI37gjZaO6UjnewbZGZ+zMzSXPGraJXX/IaRVFpiYyCszg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g7Qqx4dE4zh12ve8Ky5Zt1rD0JToonxUriEmpHiwUTk=;
        b=kX0rImp0o3Wf2G9ZfoEBPu2wLw6vXgwaFVLKpJtN6q7INIoMQTITnyKqBMngZdBg4ymHfR
        L6n+WYrIkue4MDCQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] KVM: SVM: Use __packed shorthand
Cc:     Borislav Petkov <bp@alien8.de>, Joerg Roedel <jroedel@suse.de>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-5-joro@8bytes.org>
References: <20200907131613.12703-5-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972975112.20229.14792909728772392256.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     976bc5e2aceedef13e0ba1f0e6e372a22164aa0c
Gitweb:        https://git.kernel.org/tip/976bc5e2aceedef13e0ba1f0e6e372a22164aa0c
Author:        Borislav Petkov <bp@alien8.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:05 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 19:45:24 +02:00

KVM: SVM: Use __packed shorthand

Use the shorthand to make it more readable.

No functional changes.

Signed-off-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-5-joro@8bytes.org
---
 arch/x86/include/asm/svm.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 06e5258..cf13f9e 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -150,14 +150,14 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define SVM_NESTED_CTL_NP_ENABLE	BIT(0)
 #define SVM_NESTED_CTL_SEV_ENABLE	BIT(1)
 
-struct __attribute__ ((__packed__)) vmcb_seg {
+struct vmcb_seg {
 	u16 selector;
 	u16 attrib;
 	u32 limit;
 	u64 base;
-};
+} __packed;
 
-struct __attribute__ ((__packed__)) vmcb_save_area {
+struct vmcb_save_area {
 	struct vmcb_seg es;
 	struct vmcb_seg cs;
 	struct vmcb_seg ss;
@@ -231,7 +231,7 @@ struct __attribute__ ((__packed__)) vmcb_save_area {
 	u64 xcr0;
 	u8 valid_bitmap[16];
 	u64 x87_state_gpa;
-};
+} __packed;
 
 struct ghcb {
 	struct vmcb_save_area save;
@@ -256,11 +256,11 @@ static inline void __unused_size_checks(void)
 	BUILD_BUG_ON(sizeof(struct ghcb)		!= EXPECTED_GHCB_SIZE);
 }
 
-struct __attribute__ ((__packed__)) vmcb {
+struct vmcb {
 	struct vmcb_control_area control;
 	u8 reserved_control[1024 - sizeof(struct vmcb_control_area)];
 	struct vmcb_save_area save;
-};
+} __packed;
 
 #define SVM_CPUID_FUNC 0x8000000a
 
