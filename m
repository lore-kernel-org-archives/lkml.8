Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22187C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F15E620899
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9kfI48Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgGMWkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGMWko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 18:40:44 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDA4C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:40:43 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id e18so12626605ilr.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FQ7NMKo03W54NhNsLDg4XkthULZUgCOASFezEvTt0gQ=;
        b=r9kfI48QueoI2xnPKErUlFJe4TFAsoH/tgaYcs5PDdJNxT8sIIbsvppbdKtlNIlZ53
         J3ZupCPqsJmvcmW4h3uCEq8he6qaks+5cWuq780V9Fk5TbioU6F8rgWCw4UxpT8Dl6l/
         U31Fgto5J1dCJa7v6kN8xnTLvY1A8FdjGFJNiPD6eCA7MkHMQB9CY78Qobpr04rkjMCM
         WJQrjmgK6L3LqQEntQVd/j9Q2CPdLPaTuiY12ENiVERS1c0151T3xV91y0idhQsS840+
         tkXAHNFF2AvC5/4dp5F7p2tJnCz0GBbY5KbhP1q/0uMmBjnqZjyGX5HSTL/Sskozrnuj
         w5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FQ7NMKo03W54NhNsLDg4XkthULZUgCOASFezEvTt0gQ=;
        b=AXpTL0hNp5Hj0QZZlvKPTn+8lKrZM+56mKw0qroAfFPaRkmmJd623ROfK4irjm1/45
         YIHdpSezNPZyfPfpOUUKC8NNj82meWFLJPEMGC6bPsnEpVZe/ecyCtA/HCJL+YLxtFZa
         NNoSAZLvAi18gbH5RZAuAIvoo3hyAHF22PpaGAyl7Kh3wOKLNZPRbbtFlttKW4jnX1q4
         0WCqAfnly5k1F2LBeMYlB/4KT4FKcB62WQDMNZOpZJv8hXO+LfxvhcRek/2a+DwWi31H
         1UHzJsHkKXW7fuHGOgCKWte/fAL8FWNMy2FjaPuI2+nggLU3liFeGb31FBUBb4VWC5Vc
         nh9w==
X-Gm-Message-State: AOAM5323JXqj9UoxyQPwqnWc5uITUrLvIhSw36kqCJIEIPClLl8e36Kp
        DluEsRYRISPNF64FuACE1jQ=
X-Google-Smtp-Source: ABdhPJxlxbx2b5wcxcKQ9JmOKqbhQV9nDIdjv1nR+bkTkzgItTS42Z794b/2/sqsCAtmgwuR3XOKRw==
X-Received: by 2002:a92:3311:: with SMTP id a17mr2059950ilf.210.1594680043340;
        Mon, 13 Jul 2020 15:40:43 -0700 (PDT)
Received: from jiancai.svl.corp.google.com ([2620:15c:2ce:0:f693:9fff:fef4:238b])
        by smtp.googlemail.com with ESMTPSA id i6sm9123152ilj.61.2020.07.13.15.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 15:40:42 -0700 (PDT)
From:   Jian Cai <caij2003@gmail.com>
Cc:     caij2003@gmail.com, jiancai@google.com, ndesaulniers@google.com,
        manojgupta@google.com, sedat.dilek@gmail.com,
        Brian Gerst <brgerst@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] x86/entry: add compatibility with IAS
Date:   Mon, 13 Jul 2020 15:40:18 -0700
Message-Id: <20200713224020.1297154-1-caij2003@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200713012428.1039487-1-caij2003@gmail.com>
References: <20200713012428.1039487-1-caij2003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang's integrated assembler does not allow symbols with non-absolute
values to be reassigned. This patch allows the affected code to be
compatible with IAS.

Link: https://github.com/ClangBuiltLinux/linux/issues/1043
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Brian Gerst <brgerst@gmail.com>
Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Jian Cai <caij2003@gmail.com>
---
 arch/x86/include/asm/idtentry.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index f3d70830bf2a..5efaaed34eda 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -469,16 +469,15 @@ __visible noinstr void func(struct pt_regs *regs,			\
 	.align 8
 SYM_CODE_START(irq_entries_start)
     vector=FIRST_EXTERNAL_VECTOR
-    pos = .
     .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
 	UNWIND_HINT_IRET_REGS
+0 :
 	.byte	0x6a, vector
 	jmp	asm_common_interrupt
 	nop
 	/* Ensure that the above is 8 bytes max */
-	. = pos + 8
-    pos=pos+8
-    vector=vector+1
+	. = 0b + 8
+	vector = vector+1
     .endr
 SYM_CODE_END(irq_entries_start)
 
@@ -486,16 +485,15 @@ SYM_CODE_END(irq_entries_start)
 	.align 8
 SYM_CODE_START(spurious_entries_start)
     vector=FIRST_SYSTEM_VECTOR
-    pos = .
     .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
 	UNWIND_HINT_IRET_REGS
+0 :
 	.byte	0x6a, vector
 	jmp	asm_spurious_interrupt
 	nop
 	/* Ensure that the above is 8 bytes max */
-	. = pos + 8
-    pos=pos+8
-    vector=vector+1
+	. = 0b + 8
+	vector = vector+1
     .endr
 SYM_CODE_END(spurious_entries_start)
 #endif
-- 
2.27.0.383.g050319c2ae-goog

