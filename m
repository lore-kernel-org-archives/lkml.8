Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25897C2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EA920836
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LslK6rOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgCYRrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:47:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47266 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbgCYRrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=elFJ6MP2SsmSQz5ZCasofx0hdffplqLelmi5Polbq9o=; b=LslK6rOY+z8/oQ4YsLDfYv3ZR2
        fpRVzqk9lEPUmLYLK09LBf+zEX8negfJBj/L0JsZLJ0Xrr1avbgMT8E9+drgOv4wAZTyWes1epOCP
        UGwg21H6+mE2Txk4mCV/YXolarUVMrrz80tE3C83m/0i1RPUctP+F5bK0Z6w7LIeB3NKzjB40Ttrc
        ZkJXwHW87FmiszPeFm/AL0qdNcgCqfkiMcgQc1sx568b2KZExqz9jMpCGdjg+vyy5oQXawwOsueIi
        oVyYxTbnaD1RzOoSuHCwREsWMRF3qJb0xnrbn6M7NcojqU6QBk4jrSL4Cg4vgjbxEy18I/J1yQV9U
        z6vsL2Xg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHA81-0008Qy-0a; Wed, 25 Mar 2020 17:47:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BDED43011DE;
        Wed, 25 Mar 2020 18:47:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A4BE929BD8A29; Wed, 25 Mar 2020 18:47:42 +0100 (CET)
Message-Id: <20200325174605.455086309@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 25 Mar 2020 18:45:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz
Subject: [PATCH v4 02/13] objtool: Factor out CFI hints
References: <20200325174525.772641599@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the application of CFI hints into it's own function.
No functional changes intended.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c |   67 ++++++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 29 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2033,6 +2033,41 @@ static int validate_return(struct symbol
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
+	return 0;
+}
+
 /*
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
@@ -2081,35 +2116,9 @@ static int validate_branch(struct objtoo
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
 


