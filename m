Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26472C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71D72072F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C1/I6q/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgCLNvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:51:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46822 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbgCLNvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=piGWWulTk/Ov0pTiMRYfA+U7bMQU7zVTS0znoAEkY9M=; b=C1/I6q/ODL3KWeoyiZrHLkX910
        7A+NHYoWvcKw9S/CPZE/6oIs/HdMoTraUzZIx7ZT+zgrnSHzQ/abV+zajN1QegBH1XDtBAHf/td25
        83a7I7nQqKT9FSIyEDDqDMd7MEhtg3X2+4Ax+ja3g8QIMDUw489do8TKLaJ03YRv8BIvNiLvSlxl2
        2rL+GTcxz99KpbYtYWw6JQfFuaW87Cz7pX2+LZxd2F0yrh8++bXo8/TzeEeWGHTLC7a+r1TDMBLbE
        AoUsY+V6faDIqErhJ21aMkxg/siDaxXpVL+gj5kYV9SuLFCYScOPqVr0WswafM/bQP30byIcQv6Y+
        NhAErP+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCOFM-0003AP-O1; Thu, 12 Mar 2020 13:51:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3182F305C92;
        Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 08EB72B7403A7; Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Message-Id: <20200312135041.465550716@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 12 Mar 2020 14:41:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 01/16] objtool: Introduce validate_return()
References: <20200312134107.700205216@infradead.org>
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


