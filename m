Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39A9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 01:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0419206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 01:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNvRaDkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgGMBZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 21:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgGMBZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 21:25:40 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC39AC061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 18:25:39 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id v8so11794087iox.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 18:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u7Jop7cZN8wbIaggddxP3/Gu6w2p7TP7pCxcVgLAycg=;
        b=TNvRaDkf2mNdHTgEYOeus2qvzdfiLqm+VbESKIBr7EBw/IZ/sqvI+1191+eFf+7EiC
         rVj8pcEsB1QN+q7vqP9nYhS4rgOb0P3DlV/pRSe9A1bRkO8OIaf9hVrC2tzI25uD2BcJ
         N1Ph5vZoiX+NdsqPosOwqaYhTbs5XOUaJOIdNt7sJ74cTcOoNGk25++mg8KrhxRT43j3
         2scUjHA6RABc8hZ5KHpr01pNjkuL7REhHIvG0eZb5CCCwZcDEEhVoOrmHWC6tFYdZMtr
         6gv/VglbfbwMJSCIZ/ZuLcyi5jKHxeOKtDB15RXZSDHYy/61gVndW1OKZSmGIyFCDLsf
         2MCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u7Jop7cZN8wbIaggddxP3/Gu6w2p7TP7pCxcVgLAycg=;
        b=nXAwUDTQCnC0ab1/dFFT/AKaQJARZNPkbqbnnvJbr/eF88uujnkrGbnfifg88tjbqC
         RS5v4Y7fzWyc5tWdUAm4xFzYSQC1x1o4cEJuuHycTqNRzm2XS2AC1yAZ/eh3aFq8bwrp
         NbNBTDfwsm+c0QZf+nc8znHhIVetXHQRzcOAIWd6mV7EbI/SONJJUOEvxEsK24FJpx3O
         SB5FJHcVDmhFZRwIGP1QUdN7nl/lRCbQfmGJm3lX0/BkedTb8l2S31LRWUzXvuxrqyrd
         ZxDQwiVoJaLPDF4xI/uGSTd/RvkalsKEDKhcPcBsiBgmLlVLXpO/zZLz5emkCrpkl0zm
         4Eug==
X-Gm-Message-State: AOAM530HoHGzQrWMgLu2qPqS+nsQu5H9xQE4czegqWFlaFuoleyPOaTY
        VfPgctvt5QbRcWUvwv2Txug=
X-Google-Smtp-Source: ABdhPJx/Zyg7LupxAresBF+Q+aCyViNFsox+I9rjXxZ4tvJlel8knMGPudomsLg3Leck8IJbCNfLEQ==
X-Received: by 2002:a05:6638:d05:: with SMTP id q5mr87613435jaj.2.1594603538565;
        Sun, 12 Jul 2020 18:25:38 -0700 (PDT)
Received: from jiancai.svl.corp.google.com ([2620:15c:2ce:0:f693:9fff:fef4:238b])
        by smtp.googlemail.com with ESMTPSA id k3sm7436436ils.8.2020.07.12.18.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 18:25:38 -0700 (PDT)
From:   Jian Cai <caij2003@gmail.com>
Cc:     caij2003@gmail.com, jiancai@google.com, ndesaulniers@google.com,
        manojgupta@google.com, sedat.dilek@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] x86/entry: add compatibility with IAS
Date:   Sun, 12 Jul 2020 18:24:22 -0700
Message-Id: <20200713012428.1039487-1-caij2003@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
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
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Jian Cai <caij2003@gmail.com>
---
 arch/x86/include/asm/idtentry.h | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index f3d70830bf2a..77beed2cd6d9 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -468,34 +468,32 @@ __visible noinstr void func(struct pt_regs *regs,			\
  */
 	.align 8
 SYM_CODE_START(irq_entries_start)
-    vector=FIRST_EXTERNAL_VECTOR
-    pos = .
+    i = 1
+    pos1 = .
     .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
 	UNWIND_HINT_IRET_REGS
-	.byte	0x6a, vector
+	.byte	0x6a, FIRST_EXTERNAL_VECTOR + i - 1
 	jmp	asm_common_interrupt
 	nop
 	/* Ensure that the above is 8 bytes max */
-	. = pos + 8
-    pos=pos+8
-    vector=vector+1
+	. = pos1 + 8 * i
+	i = i + 1
     .endr
 SYM_CODE_END(irq_entries_start)
 
 #ifdef CONFIG_X86_LOCAL_APIC
 	.align 8
 SYM_CODE_START(spurious_entries_start)
-    vector=FIRST_SYSTEM_VECTOR
-    pos = .
+    i = 1
+    pos2 = .
     .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
 	UNWIND_HINT_IRET_REGS
-	.byte	0x6a, vector
+	.byte	0x6a, FIRST_SYSTEM_VECTOR + i - 1
 	jmp	asm_spurious_interrupt
 	nop
 	/* Ensure that the above is 8 bytes max */
-	. = pos + 8
-    pos=pos+8
-    vector=vector+1
+	. = pos2 + 8 * i
+	i = i + 1
     .endr
 SYM_CODE_END(spurious_entries_start)
 #endif
-- 
2.27.0.383.g050319c2ae-goog

