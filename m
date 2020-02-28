Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D231C3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C9B246AC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KzW3r8Gf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbgB1ABU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:01:20 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43042 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730193AbgB1ABS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:01:18 -0500
Received: by mail-pf1-f196.google.com with SMTP id s1so695448pfh.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 16:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/uVx/XBN5lZTmlb4Lyfrp23GlYCSyVwKAYoD5ot60Wo=;
        b=KzW3r8GfkXZ1bxbOEhc8YIPZ2dejZnQCX6q/qZZVFR10jC5HNMQ2rn8d9jZcCf9BVI
         2R1tJWstcf9J0wMi0wHy+fL7hI7CG5ueTsfS0gqeu2FK7W7+cI85U1MQNxuleljfBUMU
         q4LnILWGp4BeehZnd/ns8zcKBGPdUUms3t65g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/uVx/XBN5lZTmlb4Lyfrp23GlYCSyVwKAYoD5ot60Wo=;
        b=lmNjK7Y85UG7DhJHd3qlES40ln5zO/MQEz1QwLeLq68J1rCGP63lfPLtgpAucql2/l
         HwQZARaB5QVdHZfVRMj7O/TkxNiuvQD+XQeLsTzg4tkF1NAZ9Gfjv+25o7tGUklumzfA
         BkAD1rO1hVU8cNOtWn5xVzI1JJa+XDU/9/w1nFHiW7vYt817CbRGeckz/OehFa6COy1Q
         O95lAgz1HoNe9dEYUJmyfZmAsxsK1YzGqurgZ1T/4tkjinrUokkmWpSoXu6fyB0scZIS
         qaa3nU5HCTVBFsXGHmNiu6eaO5QfhMPmZ1cQGKcekifn0H66DmMbTG24vXlC1qlzjqZz
         QrLA==
X-Gm-Message-State: APjAAAV19LrGMpr3+jA3UNgGPsq6FxHEeqTaS+4LkNwRqohlVoRh5WqD
        X3N2Rz3cXkqH+KFPukFJdAJMNQ==
X-Google-Smtp-Source: APXvYqx9fo57gEwEfmT4gKHzsyLQFuNMK/TLuK7SY+45wAhvz5aMLc0Yuj+V+h/0aFrVtq1ep7M1QQ==
X-Received: by 2002:a63:c10d:: with SMTP id w13mr1769506pgf.312.1582848076871;
        Thu, 27 Feb 2020 16:01:16 -0800 (PST)
Received: from thgarnie.kir.corp.google.com ([2620:0:1008:1100:6e62:16fa:a60c:1d24])
        by smtp.gmail.com with ESMTPSA id c18sm7314476pgw.17.2020.02.27.16.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:01:16 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 04/11] x86/entry/64: Adapt assembly for PIE support
Date:   Thu, 27 Feb 2020 16:00:49 -0800
Message-Id: <20200228000105.165012-5-thgarnie@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200228000105.165012-1-thgarnie@chromium.org>
References: <20200228000105.165012-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/entry/entry_64.S | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f2bb91e87877..2c8200d35797 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1329,7 +1329,8 @@ SYM_CODE_START_LOCAL(error_entry)
 	movl	%ecx, %eax			/* zero extend */
 	cmpq	%rax, RIP+8(%rsp)
 	je	.Lbstep_iret
-	cmpq	$.Lgs_change, RIP+8(%rsp)
+	leaq	.Lgs_change(%rip), %rcx
+	cmpq	%rcx, RIP+8(%rsp)
 	jne	.Lerror_entry_done_lfence
 
 	/*
@@ -1529,10 +1530,10 @@ SYM_CODE_START(nmi)
 	 * resume the outer NMI.
 	 */
 
-	movq	$repeat_nmi, %rdx
+	leaq	repeat_nmi(%rip), %rdx
 	cmpq	8(%rsp), %rdx
 	ja	1f
-	movq	$end_repeat_nmi, %rdx
+	leaq	end_repeat_nmi(%rip), %rdx
 	cmpq	8(%rsp), %rdx
 	ja	nested_nmi_out
 1:
@@ -1586,7 +1587,8 @@ nested_nmi:
 	pushq	%rdx
 	pushfq
 	pushq	$__KERNEL_CS
-	pushq	$repeat_nmi
+	leaq	repeat_nmi(%rip), %rdx
+	pushq	%rdx
 
 	/* Put stack back */
 	addq	$(6*8), %rsp
@@ -1625,7 +1627,11 @@ first_nmi:
 	addq	$8, (%rsp)	/* Fix up RSP */
 	pushfq			/* RFLAGS */
 	pushq	$__KERNEL_CS	/* CS */
-	pushq	$1f		/* RIP */
+	pushq	$0		/* Space for RIP */
+	pushq	%rdx		/* Save RDX */
+	leaq	1f(%rip), %rdx	/* Put the address of 1f label into RDX */
+	movq    %rdx, 8(%rsp)   /* Store it in RIP field */
+	popq	%rdx		/* Restore RDX */
 	iretq			/* continues at repeat_nmi below */
 	UNWIND_HINT_IRET_REGS
 1:
-- 
2.25.1.481.gfbce0eb801-goog

