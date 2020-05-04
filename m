Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C28C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995CA20658
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbgEDSaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729937AbgEDSaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:30:19 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FABDC061A0E;
        Mon,  4 May 2020 11:30:19 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jVfr6-0005N9-DG; Mon, 04 May 2020 20:30:16 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D90DD1C0084;
        Mon,  4 May 2020 20:30:15 +0200 (CEST)
Date:   Mon, 04 May 2020 18:30:15 -0000
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed/64: Switch to __KERNEL_CS after
 GDT is loaded
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200428151725.31091-13-joro@8bytes.org>
References: <20200428151725.31091-13-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <158861701576.8414.8257104010943662350.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     34bb49229f19399a5b45c323afb5749f31f7876c
Gitweb:        https://git.kernel.org/tip/34bb49229f19399a5b45c323afb5749f31f7876c
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Tue, 28 Apr 2020 17:16:22 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 May 2020 19:53:08 +02:00

x86/boot/compressed/64: Switch to __KERNEL_CS after GDT is loaded

When the pre-decompression code loads its first GDT in startup_64(), it
is still running on the CS value of the previous GDT. In the case of
SEV-ES, this is the EFI GDT but it can be anything depending on what has
loaded the kernel (boot loader, container runtime, etc.)

To make exception handling work (especially IRET) the CPU needs to
switch to a CS value in the current GDT, so jump to __KERNEL_CS after
the first GDT is loaded. This is prudent also as a general sanitization
of CS to a known good value.

 [ bp: Massage commit message. ]

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200428151725.31091-13-joro@8bytes.org
---
 arch/x86/boot/compressed/head_64.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 4f7e6b8..6b11060 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -393,6 +393,14 @@ SYM_CODE_START(startup_64)
 	addq	%rax, 2(%rax)
 	lgdt	(%rax)
 
+	/* Reload CS so IRET returns to a CS actually in the GDT */
+	pushq	$__KERNEL_CS
+	leaq	.Lon_kernel_cs(%rip), %rax
+	pushq	%rax
+	lretq
+
+.Lon_kernel_cs:
+
 	/*
 	 * paging_prepare() sets up the trampoline and checks if we need to
 	 * enable 5-level paging.
