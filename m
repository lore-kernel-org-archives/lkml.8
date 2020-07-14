Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00326C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 23:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C70B82065E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 23:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="taP7IgzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgGNXbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 19:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGNXbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 19:31:33 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC035C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 16:31:32 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id l1so265644ioh.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 16:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fsTQrOCCM6yA1JojsplBwI6Qpm1eIbU6tWKRrhNq0L8=;
        b=taP7IgzG4BYus1NgdIBE1yrJBe+KkPGgzDe0onIKQ2TgeCt481cFEDv1cJgiG7ERVb
         klIoHxnj2lTam4rLH7kA4JD9XcRczUsB4mha4gWLCjSx+0crHiS7lO9C4ZzBqERpolNm
         g+Q2HzeJZsX+t1Pr43gUaEvuqduiTnB69mGfa7k/w34eIhf4B/pN9P5Wp0VgVej9nkGF
         mXJETelYvOy+Dy13YX9m5iBytgkVTpXsu58ZhruRbv+RAC4WWmQdh2+DbUErc/rTyL4v
         DocBBcqIO5tpHulD8LRUM8HOFqAoDIRHJlUsUZaLWRY/VaEGOxZYuWrxuV375FidavLL
         j/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fsTQrOCCM6yA1JojsplBwI6Qpm1eIbU6tWKRrhNq0L8=;
        b=WYguMxoAesYZRChq5aZTXam2c7Efwo7Nr7HMAanC0itXjHM8gxO7ADhH0Yfb+YNWDB
         6JBVtkeii2J6+/coXuYHP69stlPQjheAdoGgoHcxv8+u5TWQ5Wv2BrRYv05qOuwUZ0fO
         6XczPbWNXfpq+NXpT+bKebuu4xBJDUdICOzOvSgwZgetGepcuHFSB40zsA37zueZfL1R
         onxsynNA+TuzMqy+3ec8XYuboCHaQT62wx+Bp8tj8CuV9rJX/VZS+Fm3sR1dXn06ufRL
         tXzcb26VO7Nysc0inTbg/QU41+qz3VHGJ4pEmgrBeX1wPQdXaHsKPkrkx7D1D2x8HZrj
         Ulug==
X-Gm-Message-State: AOAM532MLmqyDIMb87ef2CkxGZhXC2F7nR+p7fr96wIMW+6bY6SJC9dh
        J9XxrvfZzY6FyFzaEkuCJUI=
X-Google-Smtp-Source: ABdhPJz7Uig/kJDvPNfnF/fQEe7rMqwS5TfQTty5MsanjiHDEFXDjLB0RkO6jMexWw8c/J82t+dZLA==
X-Received: by 2002:a05:6638:2601:: with SMTP id m1mr7526051jat.141.1594769491880;
        Tue, 14 Jul 2020 16:31:31 -0700 (PDT)
Received: from jiancai.svl.corp.google.com ([2620:15c:2ce:0:f693:9fff:fef4:238b])
        by smtp.googlemail.com with ESMTPSA id l13sm252256iob.28.2020.07.14.16.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 16:31:31 -0700 (PDT)
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
Subject: [PATCH v2] x86/entry: add compatibility with IAS
Date:   Tue, 14 Jul 2020 16:30:21 -0700
Message-Id: <20200714233024.1789985-1-caij2003@gmail.com>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
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
Tested-by: Sedat Dilek <sedat.dilek@gmail.com> #
Compile-/Assemble-tested against Linux v5.8-rc5 with LLVM/Clang
v11.0.0-git
Signed-off-by: Jian Cai <caij2003@gmail.com>
---

Thanks Nick and Sedat for explaining the process of submitting patches.
Include the changelog as follows,

Changes v1 -> v2:
 Update the patch based on Arvind Sankar <nivedita@alum.mit.edu>'s
 comments. Also include addtional information in the Tested-by tag.

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
2.27.0.389.gc38d7665816-goog

