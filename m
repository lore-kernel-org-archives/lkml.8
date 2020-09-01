Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A319C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01E3221D6C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nqooTdcp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YQOcAe3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbgIAOtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:49:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39636 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbgIALs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:48:28 -0400
Date:   Tue, 01 Sep 2020 11:48:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5aGYOHRifoJZFNp/O/ZmUynNyAjOKW6Um5BGi2nxFP0=;
        b=nqooTdcp87WwRWfVcAPXN/wFEFEZJuhx0lAd75WzCjCguliO8gNTAEbZ5CPhOhlk1NzBMo
        RQc316ivUVNucuZGx1rJNlwVbw9RPI9y5nrL1V1IVLO36RTWP/7jNWJbJGxc5AuZRxMj+g
        HhC4tnPBMEKoC62FTpilxv8LgsjJzgYfIqcVX3HWUFDC6jtB98nGzhj35uBUH+1tk4FQ1V
        B0lI//dRxF/05uH2opVhoLWvkIi6Kk4CF/QSovZJVR+fIrE9a78cjOmP2XUTekl5aX+ssU
        8rK+E0uMvEAxCavZPF1O/ntacnwd+4n2ks0V02FTvORIpO27bugtqu4v01qphg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5aGYOHRifoJZFNp/O/ZmUynNyAjOKW6Um5BGi2nxFP0=;
        b=YQOcAe3svXPZidaT94VkdPCVe4waEV6cJEH58ygn6Fj2zrdBaipGSwupqHJfb8oCP55HJ7
        QcnBERM5vhmJjfBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/static_call] static_call: Add some validation
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200818135805.161974981@infradead.org>
References: <20200818135805.161974981@infradead.org>
MIME-Version: 1.0
Message-ID: <159896088327.20229.3930725558389959830.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/static_call branch of tip:

Commit-ID:     6c3fce794e9d2a5ce3a948962d0808a459c40a84
Gitweb:        https://git.kernel.org/tip/6c3fce794e9d2a5ce3a948962d0808a459c40a84
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 18 Aug 2020 15:57:50 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:58:06 +02:00

static_call: Add some validation

Verify the text we're about to change is as we expect it to be.

Requested-by: Steven Rostedt <rostedt@goodmis.org>

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200818135805.161974981@infradead.org
---
 arch/x86/kernel/static_call.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 60a325c..55140d8 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -41,6 +41,26 @@ static void __static_call_transform(void *insn, enum insn_type type, void *func)
 	text_poke_bp(insn, code, size, NULL);
 }
 
+static void __static_call_validate(void *insn, bool tail)
+{
+	u8 opcode = *(u8 *)insn;
+
+	if (tail) {
+		if (opcode == JMP32_INSN_OPCODE ||
+		    opcode == RET_INSN_OPCODE)
+			return;
+	} else {
+		if (opcode == CALL_INSN_OPCODE ||
+		    !memcmp(insn, ideal_nops[NOP_ATOMIC5], 5))
+			return;
+	}
+
+	/*
+	 * If we ever trigger this, our text is corrupt, we'll probably not live long.
+	 */
+	WARN_ONCE(1, "unexpected static_call insn opcode 0x%x at %pS\n", opcode, insn);
+}
+
 static inline enum insn_type __sc_insn(bool null, bool tail)
 {
 	/*
@@ -60,11 +80,15 @@ void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
 {
 	mutex_lock(&text_mutex);
 
-	if (tramp)
+	if (tramp) {
+		__static_call_validate(tramp, true);
 		__static_call_transform(tramp, __sc_insn(!func, true), func);
+	}
 
-	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site)
+	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site) {
+		__static_call_validate(site, tail);
 		__static_call_transform(site, __sc_insn(!func, tail), func);
+	}
 
 	mutex_unlock(&text_mutex);
 }
