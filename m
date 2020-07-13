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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86485C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 21:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ED80208FE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 21:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRJ0qbYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGMVjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 17:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgGMVjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 17:39:06 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776BFC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 14:39:06 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id q74so15181650iod.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 14:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iq2cIgsTsK4a36l68O3I/cXrAGU91DqNfuss40tsJ6I=;
        b=bRJ0qbYpXO9yAjWYS7iPPH49f4w0kjVvS8XJXYg9oY/XVLRuGqYK8BSRSbNnhLJqMr
         xiH2AQk7xWvGGfpwa2xoIya5jcinTac2EI3aPpihaiN3/8qfljBdmtot7LVrWVmB3yS5
         kTob3BNRuktJhE+rPzg4+A6U3SSqh2CS+WNgHhO1rL+i3+G+8wXTzxpX/0ZJIjBY33HL
         2h5AFSiCrfcSAVw0j1ymrWbHuH8b3g4HcPM5TaMF/a4RJ89WKyaiA1kkRDexvS9hbA6b
         C+Lwe9lkzg6s6hTOGf9QG1R27BJPHSTkm52B1LVHMvfgplpR7EM8fY+CK12eM36dymAP
         37mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iq2cIgsTsK4a36l68O3I/cXrAGU91DqNfuss40tsJ6I=;
        b=cMqJPZakJQLk48n0U+DQCNNlyduA9vDUPw+Rk+T8FX4q2zObJnM4ohXFTMxoNK0U1H
         oj1WWYAaFYVnP5NzwWaGDxL9Yut4Hq9NkdgFeBgTfn7N0EKwLuZ7zkwWOJ1We1Y6uLUQ
         NFFbRYV0UlaqwyfmtHdDTkz8bKDq5d5kvzDzaFQdwZaUscikt6owGagDYlUO+BXqkHqG
         Syc38yN9zFjpNgycesHSrDm9GAUHqVC67VgAci5hb43fT+b9VbusvooO4SwUUI+vCy2w
         45v9gQAgnaUeqyko1WIUx0Lw5yQwI1JlrC5MZ3VY06FePwkUL7h91qBVJbENHVzdSe/S
         55xA==
X-Gm-Message-State: AOAM5337SNei7X3yZjDuIchvBjatHFbffLYrOqsuKyIFS1F0jl8Zcdsr
        mSYeAnP+Bv8pXB458/Cu5fg=
X-Google-Smtp-Source: ABdhPJyrsoOpp6XMtTE8POeoMwbFO10ynLauyWhp85xlFTUq+F8JjkoVpF7Yz6OmJJUktqmWSAMNqw==
X-Received: by 2002:a05:6638:381:: with SMTP id y1mr2390716jap.85.1594676345783;
        Mon, 13 Jul 2020 14:39:05 -0700 (PDT)
Received: from jiancai.svl.corp.google.com ([2620:15c:2ce:0:f693:9fff:fef4:238b])
        by smtp.googlemail.com with ESMTPSA id b2sm9053703ilf.0.2020.07.13.14.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 14:39:05 -0700 (PDT)
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
Date:   Mon, 13 Jul 2020 14:38:01 -0700
Message-Id: <20200713213803.1274795-1-caij2003@gmail.com>
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
 arch/x86/include/asm/idtentry.h | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index f3d70830bf2a..7d22684eafdf 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -469,16 +469,15 @@ __visible noinstr void func(struct pt_regs *regs,			\
 	.align 8
 SYM_CODE_START(irq_entries_start)
     vector=FIRST_EXTERNAL_VECTOR
-    pos = .
     .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
+0 :
 	UNWIND_HINT_IRET_REGS
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
+0 :
 	UNWIND_HINT_IRET_REGS
-	.byte	0x6a, vector
+	.byte	0x6a, FIRST_SYSTEM_VECTOR + i
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

