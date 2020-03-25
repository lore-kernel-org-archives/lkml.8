Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7ECC2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90E02080C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ztoLJ0nu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgCYRsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:48:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58434 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgCYRru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Kqw2eANcr/NXrVf+g4UsmSnBMu4St2jvCKmskXKN8nA=; b=ztoLJ0nu4vzJkgIPrzMaGq1UbT
        fv2ZM7z8HXKPVgze9SaZlUrnAvlcVSg0tj4WZFag4BFiS5rtZKKM17N2LZzOJAnz8NOTpmap/xC8P
        N08Wrl6HBzl4gF6mckSWHhmMjq2Zjl1Z/Xa4okCzX1nXroxdOZtzZVseC2WF8PZYoBKQH2RPKw10L
        jv/FmuygQu/D4U2v63YWfnRruIwCoo/TOrMcPTvYl/JIRB6ZkpGg0KMzgYASKNkhJmrL69aSV5Nyt
        N8TZnw87LWCVh/UKSHmGB13JaW9wAJE9XEb0PWuDFnV9yTYI4/Fyjv1oNJxcvaSQmqVyTTygM8F7f
        htSyrRAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHA82-0003oi-Hw; Wed, 25 Mar 2020 17:47:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B32C43010CF;
        Wed, 25 Mar 2020 18:47:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A2E92286C1385; Wed, 25 Mar 2020 18:47:42 +0100 (CET)
Message-Id: <20200325174605.369570202@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 25 Mar 2020 18:45:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz
Subject: [PATCH v4 01/13] objtool: Remove CFI save/restore special case
References: <20200325174525.772641599@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a special case in the UNWIND_HINT_RESTORE code. When, upon
looking for the UNWIND_HINT_SAVE instruction to restore from, it finds
the instruction hasn't been visited yet, it normally issues a WARN,
except when this HINT_SAVE instruction is the first instruction of
this branch.

This special case is of dubious correctness and is certainly unused
(verified with an allmodconfig build), the two sites that employ
UNWIND_HINT_SAVE/RESTORE (sync_core() and ftrace_regs_caller()) have
the SAVE on unconditional instructions at the start of the function.
It is therefore impossible for the save_insn not to have been visited
when we do hit the RESTORE.

Remove this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2040,15 +2040,14 @@ static int validate_return(struct symbol
  * tools/objtool/Documentation/stack-validation.txt.
  */
 static int validate_branch(struct objtool_file *file, struct symbol *func,
-			   struct instruction *first, struct insn_state state)
+			   struct instruction *insn, struct insn_state state)
 {
+	struct instruction *next_insn;
 	struct alternative *alt;
-	struct instruction *insn, *next_insn;
 	struct section *sec;
 	u8 visited;
 	int ret;
 
-	insn = first;
 	sec = insn->sec;
 
 	if (insn->alt_group && list_empty(&insn->alts)) {
@@ -2101,16 +2100,6 @@ static int validate_branch(struct objtoo
 				}
 
 				if (!save_insn->visited) {
-					/*
-					 * Oops, no state to copy yet.
-					 * Hopefully we can reach this
-					 * instruction from another branch
-					 * after the save insn has been
-					 * visited.
-					 */
-					if (insn == first)
-						return 0;
-
 					WARN_FUNC("objtool isn't smart enough to handle this CFI save/restore combo",
 						  sec, insn->offset);
 					return 1;


