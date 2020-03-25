Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2267C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6829208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lFuzV3Bg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgCYOmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:42:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37396 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgCYOmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kQVyswkIEiQqu0q2j98vbPa2ZQs9K9mLGiYpslDqK7w=; b=lFuzV3BgjEFuhVj0JQ7JS2Nc4e
        TdiIekkSH8C3CNNCJNiS5cnKtN1iHbSHsa9Jg0ICgx6uDkK2hFUpmyrFCLbLptYKd+1JoN71Q8pFQ
        sTvjo8W5IV4DUwXNQWt/XXmm0ELuoG1R6RRZKfxCdmYqz7Itb94xrlHU6D/v1+69q8IroaZ0bHape
        quRZbarvOAshpQeV98eF3ke8Xp03yYb1vcGSSF69n8HdAViBn6DUgk5F0o0d2gsz+47I/ltrUPUS7
        m7MXkMMUuFOZB5j/Oq+MGoCMwlJXRLozXIhWCpT2wGq7pyQTa3pQL2b5oZMLO+tUaU0lJTVwh9WF7
        lgZJT7Wg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH7Ej-00086W-T3; Wed, 25 Mar 2020 14:42:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B4905303D97;
        Wed, 25 Mar 2020 15:42:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A01E029A8F430; Wed, 25 Mar 2020 15:42:28 +0100 (CET)
Date:   Wed, 25 Mar 2020 15:42:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v3.1 18b/26] objtool: Factor out CFI hints
Message-ID: <20200325144228.GW20696@hirez.programming.kicks-ass.net>
References: <20200324153113.098167666@infradead.org>
 <20200324160924.987489248@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324160924.987489248@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: objtool: Factor out CFI hints
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Mar 25 13:08:17 CET 2020

Move the application of CFI hints into it's own function.
No functional changes intended.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   66 ++++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2033,6 +2033,40 @@ static int validate_return(struct symbol
 	return 0;
 }
 
+static int apply_insn_hint(struct objtool_file *file, struct section *sec,
+			   struct symbol *func, struct instruction *insn,
+			   struct insn_state *state)
+{
+	if (insn->restore) {
+		struct instruction *save_insn, *i;
+
+		i = insn;
+		save_insn = NULL;
+		sym_for_each_insn_continue_reverse(file, func, i) {
+			if (i->save) {
+				save_insn = i;
+				break;
+			}
+		}
+
+		if (!save_insn) {
+			WARN_FUNC("no corresponding CFI save for CFI restore",
+				  sec, insn->offset);
+			return 1;
+		}
+
+		if (!save_insn->visited) {
+			WARN_FUNC("objtool isn't smart enough to handle this CFI save/restore combo",
+				  sec, insn->offset);
+			return 1;
+		}
+
+		insn->state = save_insn->state;
+	}
+
+	state = insn->state;
+}
+
 /*
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
@@ -2081,35 +2115,9 @@ static int validate_branch(struct objtoo
 		}
 
 		if (insn->hint) {
-			if (insn->restore) {
-				struct instruction *save_insn, *i;
-
-				i = insn;
-				save_insn = NULL;
-				sym_for_each_insn_continue_reverse(file, func, i) {
-					if (i->save) {
-						save_insn = i;
-						break;
-					}
-				}
-
-				if (!save_insn) {
-					WARN_FUNC("no corresponding CFI save for CFI restore",
-						  sec, insn->offset);
-					return 1;
-				}
-
-				if (!save_insn->visited) {
-					WARN_FUNC("objtool isn't smart enough to handle this CFI save/restore combo",
-						  sec, insn->offset);
-					return 1;
-				}
-
-				insn->state = save_insn->state;
-			}
-
-			state = insn->state;
-
+			ret = apply_insn_hint(file, sec, func, insn, &state);
+			if (ret)
+				return ret;
 		} else
 			insn->state = state;
 
