Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34036C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93F7207EA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="trCYcFbz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5U9bKwlG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbgIJJbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:31:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38970 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730401AbgIJJYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:24:35 -0400
Date:   Thu, 10 Sep 2020 09:22:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729752;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1uwb+6C4Y109KlNB2Aw0X0SoRhS6c6ZFvINH5OGcDx4=;
        b=trCYcFbzgtRHPPaPOwSEk8vno5QLY2+EcXN6RlyphWFboSIUevMSSRTysyzS+nt0itsG5C
        RV55OwcEItLKnOJMW2K6Lw2MtKDYCYjAniQOXALqiv2r23oKU27rbmPaDFKcX700unMvv6
        FchYq8oYXtwD9focxC6V1TCfnU17F1d+HJYkgcM53bt1J5BrdL3B8QxLMV7b1bVB9rb6oP
        SWe7BXYcIKD0ioJrpc5BXzCp/JgAtTxg869N4NjU2QFB8lZTpfPo5ILIx66r71K5nsFzNz
        ME+dKcu2hmyzaHeVUaXdPAbyhSEIKKKer41tDwRmGUDbKgck6NT+/M6GlvWbOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729752;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1uwb+6C4Y109KlNB2Aw0X0SoRhS6c6ZFvINH5OGcDx4=;
        b=5U9bKwlGQ+arvVnxbIbGthljUopjwENTkWQOcZVOjh0xbCmm9q2rfImjjTI9pxQZIjraX0
        3bmLSfpO+gqo7DBw==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] KVM: SVM: Add GHCB definitions
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-3-joro@8bytes.org>
References: <20200907131613.12703-3-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972975196.20229.1038177390621739891.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     d07f46f9f51afc7fc9f021eae19eba3c2e7870ac
Gitweb:        https://git.kernel.org/tip/d07f46f9f51afc7fc9f021eae19eba3c2e7870ac
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 07 Sep 2020 15:15:03 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 19:45:24 +02:00

KVM: SVM: Add GHCB definitions

Extend the vmcb_safe_area with SEV-ES fields and add a new
'struct ghcb' which will be used for guest-hypervisor communication.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-3-joro@8bytes.org
---
 arch/x86/include/asm/svm.h | 51 +++++++++++++++++++++++++++++++++++--
 arch/x86/kvm/svm/svm.c     |  2 +-
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 8a1f538..acac55d 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -200,13 +200,60 @@ struct __attribute__ ((__packed__)) vmcb_save_area {
 	u64 br_to;
 	u64 last_excp_from;
 	u64 last_excp_to;
+
+	/*
+	 * The following part of the save area is valid only for
+	 * SEV-ES guests when referenced through the GHCB.
+	 */
+	u8 reserved_7[104];
+	u64 reserved_8;		/* rax already available at 0x01f8 */
+	u64 rcx;
+	u64 rdx;
+	u64 rbx;
+	u64 reserved_9;		/* rsp already available at 0x01d8 */
+	u64 rbp;
+	u64 rsi;
+	u64 rdi;
+	u64 r8;
+	u64 r9;
+	u64 r10;
+	u64 r11;
+	u64 r12;
+	u64 r13;
+	u64 r14;
+	u64 r15;
+	u8 reserved_10[16];
+	u64 sw_exit_code;
+	u64 sw_exit_info_1;
+	u64 sw_exit_info_2;
+	u64 sw_scratch;
+	u8 reserved_11[56];
+	u64 xcr0;
+	u8 valid_bitmap[16];
+	u64 x87_state_gpa;
 };
 
+struct ghcb {
+	struct vmcb_save_area save;
+	u8 reserved_save[2048 - sizeof(struct vmcb_save_area)];
+
+	u8 shared_buffer[2032];
+
+	u8 reserved_1[10];
+	u16 protocol_version;	/* negotiated SEV-ES/GHCB protocol version */
+	u32 ghcb_usage;
+} __packed;
+
+
+#define EXPECTED_VMCB_SAVE_AREA_SIZE		1032
+#define EXPECTED_VMCB_CONTROL_AREA_SIZE		256
+#define EXPECTED_GHCB_SIZE			PAGE_SIZE
 
 static inline void __unused_size_checks(void)
 {
-	BUILD_BUG_ON(sizeof(struct vmcb_save_area) != 0x298);
-	BUILD_BUG_ON(sizeof(struct vmcb_control_area) != 256);
+	BUILD_BUG_ON(sizeof(struct vmcb_save_area)	!= EXPECTED_VMCB_SAVE_AREA_SIZE);
+	BUILD_BUG_ON(sizeof(struct vmcb_control_area)	!= EXPECTED_VMCB_CONTROL_AREA_SIZE);
+	BUILD_BUG_ON(sizeof(struct ghcb)		!= EXPECTED_GHCB_SIZE);
 }
 
 struct __attribute__ ((__packed__)) vmcb {
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0194336..1db4fdc 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4164,6 +4164,8 @@ static struct kvm_x86_init_ops svm_init_ops __initdata = {
 
 static int __init svm_init(void)
 {
+	__unused_size_checks();
+
 	return kvm_init(&svm_init_ops, sizeof(struct vcpu_svm),
 			__alignof__(struct vcpu_svm), THIS_MODULE);
 }
