Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEFAC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CE42073E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mt3m6Rbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgCQRMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:12:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46218 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgCQRMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=piGWWulTk/Ov0pTiMRYfA+U7bMQU7zVTS0znoAEkY9M=; b=mt3m6RbiQvxUGlCFn+RwEC8WY2
        b+a6LPe7fL0kl9q6Z1yJ08ZxKXka3cyfSc98TzP2mToW5NkL6HABS7p/ExMxFSb9p2jZrUqFrh7W/
        /yo3o1OvEmKWa3Ny3AvA5zy8tsOiE3wOE8Y/Oyc/Pz+4h1mKUxk/XcXeHLHE+fWYObAhu+z+tBWjs
        cYEuzO5wEU2C/T9GMllv5rvCDRfMExT+3ciQxrBaFAwVMn6537KTzs+GgP2T++mWJIE6OO+gfKC92
        ZwGoD6HQY99MMap72WkLmyTrBYizd6pHr76DCg4nWwzbq17o7IxkKVUEaHkU21dzxx2F0PDfnKtMa
        x3+IKYMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEFky-0002r1-Lc; Tue, 17 Mar 2020 17:11:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D0514300606;
        Tue, 17 Mar 2020 18:11:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BA9BA20B16493; Tue, 17 Mar 2020 18:11:54 +0100 (CET)
Message-Id: <20200317170909.821700312@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 17 Mar 2020 18:02:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v2 01/19] objtool: Introduce validate_return()
References: <20200317170234.897520633@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial 'cleanup' to save one indentation level and match
validate_call().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   64 ++++++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1935,6 +1935,41 @@ static int validate_sibling_call(struct
 	return validate_call(insn, state);
 }
 
+static int validate_return(struct symbol *func, struct instruction *insn, struct insn_state *state)
+{
+	if (state->uaccess && !func_uaccess_safe(func)) {
+		WARN_FUNC("return with UACCESS enabled",
+			  insn->sec, insn->offset);
+		return 1;
+	}
+
+	if (!state->uaccess && func_uaccess_safe(func)) {
+		WARN_FUNC("return with UACCESS disabled from a UACCESS-safe function",
+			  insn->sec, insn->offset);
+		return 1;
+	}
+
+	if (state->df) {
+		WARN_FUNC("return with DF set",
+			  insn->sec, insn->offset);
+		return 1;
+	}
+
+	if (func && has_modified_stack_frame(state)) {
+		WARN_FUNC("return with modified stack frame",
+			  insn->sec, insn->offset);
+		return 1;
+	}
+
+	if (state->bp_scratch) {
+		WARN("%s uses BP as a scratch register",
+		     func->name);
+		return 1;
+	}
+
+	return 0;
+}
+
 /*
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
@@ -2050,34 +2085,7 @@ static int validate_branch(struct objtoo
 		switch (insn->type) {
 
 		case INSN_RETURN:
-			if (state.uaccess && !func_uaccess_safe(func)) {
-				WARN_FUNC("return with UACCESS enabled", sec, insn->offset);
-				return 1;
-			}
-
-			if (!state.uaccess && func_uaccess_safe(func)) {
-				WARN_FUNC("return with UACCESS disabled from a UACCESS-safe function", sec, insn->offset);
-				return 1;
-			}
-
-			if (state.df) {
-				WARN_FUNC("return with DF set", sec, insn->offset);
-				return 1;
-			}
-
-			if (func && has_modified_stack_frame(&state)) {
-				WARN_FUNC("return with modified stack frame",
-					  sec, insn->offset);
-				return 1;
-			}
-
-			if (state.bp_scratch) {
-				WARN("%s uses BP as a scratch register",
-				     func->name);
-				return 1;
-			}
-
-			return 0;
+			return validate_return(func, insn, &state);
 
 		case INSN_CALL:
 		case INSN_CALL_DYNAMIC:


