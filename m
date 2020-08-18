Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DB1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F07D0207DE
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RrbIW/x2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgHROOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgHROMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:12:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C5EC06134D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=7Xriqb3TNa3O6LDuCV5RJhwMY0rpFT6Cvp/v2JiOvkM=; b=RrbIW/x28zSRMvpchaP+AcSnAN
        kCkrUNSVB6wfnJSSeeQBt8zkS3IJs+gu7aPAhm2xZuJZ5SAIUE+fbzU885rOI4CAzX89HDdlGie1z
        nnmJxMJmsWz9NPsMkILpcmhU5GQz/UPLeDh2yu30/0xbOxtsuUmNQU1p8wYQsJe1Aqlk+AfkI7yFZ
        EtrFRZuw9hdkeBVHVyC75O1YMfkDgqxTTup6NsfJacKSTwAvBCmDrEPezF++pHW6WtE+bTBv7jcW9
        UpU9k8krgajHCfgis/yR+TyaPsFd1AFA5U8CncWytlycWDK2AXSU88D6GzZXdxEwRjkrPGaUlz1+0
        DJKvhlmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k82LL-0006VN-Jt; Tue, 18 Aug 2020 14:12:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B11D330797D;
        Tue, 18 Aug 2020 16:12:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DD19E23D42C0F; Tue, 18 Aug 2020 16:11:59 +0200 (CEST)
Message-ID: <20200818135805.161974981@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 18 Aug 2020 15:57:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk
Subject: [PATCH v7 15/18] static_call: Add some validation
References: <20200818135735.948368560@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Verify the text we're about to change is as we expect it to be.

Requested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/static_call.c |   28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -41,6 +41,26 @@ static void __static_call_transform(void
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
@@ -60,11 +80,15 @@ void arch_static_call_transform(void *si
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


