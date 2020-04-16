Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBF8C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA1B321D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hbFceX3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395095AbgDPPMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2395053AbgDPPMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:12:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412F9C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=LNXKTw/zTEs+P8C9X4mauLkA1J1HXkddgGUFayNufW8=; b=hbFceX3MJlgsd5aXDNp7dFyclo
        HpI4HI8TGk7Y/OdimcJdDNWQaQim1s1fXSWyEl2y38SABYq0Guuc1krw+0jjje1UgJ1k332ZJz95S
        6kT4ASZG8R/LUrECf/rMunTpV8HdfRDf5L/yb+dxFAIa0lKSyYb++LqTJd3/D052QkDzGePQ0WWRK
        xsAmTli1R9wSb6hWkqsW8zRZ4sbdzjncvF6sF+U1DvUE9j2fWh2uUgFVzSrkqr3FEcHuvZK77nsJz
        ePycpHbOTEWvZvvg/YTHXRk31bBRNnBT5lgE0pRmcbwUiq1VlYKpimbA1gujbdc5YyE2EYuY2ZHmG
        H1f2anvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP6BI-0003Wf-99; Thu, 16 Apr 2020 15:11:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 255243073F0;
        Thu, 16 Apr 2020 17:11:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0960A2B0DE4BE; Thu, 16 Apr 2020 17:11:54 +0200 (CEST)
Message-Id: <20200416151024.885221682@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 16 Apr 2020 17:07:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 3/7] objtool: Allow branches within the same alternative.
References: <20200416150752.569029800@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Chartre <alexandre.chartre@oracle.com>

Currently objtool prevents any branch to an alternative. While preventing
branching from the outside to the middle of an alternative makes perfect
sense, branching within the same alternative should be allowed. To do so,
identify each alternative and check that a branch to an alternative comes
from the same alternative.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200414103618.12657-3-alexandre.chartre@oracle.com
---
 tools/objtool/check.c |   27 +++++++++++++++++++++------
 tools/objtool/check.h |    3 ++-
 2 files changed, 23 insertions(+), 7 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -768,7 +768,9 @@ static int handle_group_alt(struct objto
 			    struct instruction *orig_insn,
 			    struct instruction **new_insn)
 {
+	static unsigned int alt_group_next_index = 1;
 	struct instruction *last_orig_insn, *last_new_insn, *insn, *fake_jump = NULL;
+	unsigned int alt_group = alt_group_next_index++;
 	unsigned long dest_off;
 
 	last_orig_insn = NULL;
@@ -777,7 +779,7 @@ static int handle_group_alt(struct objto
 		if (insn->offset >= special_alt->orig_off + special_alt->orig_len)
 			break;
 
-		insn->alt_group = true;
+		insn->alt_group = alt_group;
 		last_orig_insn = insn;
 	}
 
@@ -811,6 +813,7 @@ static int handle_group_alt(struct objto
 	}
 
 	last_new_insn = NULL;
+	alt_group = alt_group_next_index++;
 	insn = *new_insn;
 	sec_for_each_insn_from(file, insn) {
 		if (insn->offset >= special_alt->new_off + special_alt->new_len)
@@ -820,6 +823,7 @@ static int handle_group_alt(struct objto
 
 		insn->ignore = orig_insn->ignore_alts;
 		insn->func = orig_insn->func;
+		insn->alt_group = alt_group;
 
 		/*
 		 * Since alternative replacement code is copy/pasted by the
@@ -2157,6 +2161,15 @@ static int validate_return(struct symbol
 	return 0;
 }
 
+static bool is_branch_to_alternative(struct instruction *from,
+				     struct instruction *to)
+{
+	if (!from || !to->alt_group || !list_empty(&to->alts))
+		return false;
+
+	return (from->alt_group != to->alt_group);
+}
+
 /*
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
@@ -2164,6 +2177,7 @@ static int validate_return(struct symbol
  * tools/objtool/Documentation/stack-validation.txt.
  */
 static int validate_branch(struct objtool_file *file, struct symbol *func,
+			   struct instruction *from,
 			   struct instruction *insn, struct insn_state state)
 {
 	struct alternative *alt;
@@ -2174,7 +2188,7 @@ static int validate_branch(struct objtoo
 
 	sec = insn->sec;
 
-	if (insn->alt_group && list_empty(&insn->alts)) {
+	if (is_branch_to_alternative(from, insn)) {
 		WARN_FUNC("don't know how to handle branch to middle of alternative instruction group",
 			  sec, insn->offset);
 		return 1;
@@ -2221,7 +2235,8 @@ static int validate_branch(struct objtoo
 				if (alt->skip_orig)
 					skip_orig = true;
 
-				ret = validate_branch(file, func, alt->insn, state);
+				ret = validate_branch(file, func,
+						      NULL, alt->insn, state);
 				if (ret) {
 					if (backtrace)
 						BT_FUNC("(alt)", insn);
@@ -2264,7 +2279,7 @@ static int validate_branch(struct objtoo
 					return ret;
 
 			} else if (insn->jump_dest) {
-				ret = validate_branch(file, func,
+				ret = validate_branch(file, func, insn,
 						      insn->jump_dest, state);
 				if (ret) {
 					if (backtrace)
@@ -2396,7 +2411,7 @@ static int validate_unwind_hints(struct
 
 	while (&insn->list != &file->insn_list && (!sec || insn->sec == sec)) {
 		if (insn->hint && !insn->visited) {
-			ret = validate_branch(file, insn->func, insn, state);
+			ret = validate_branch(file, insn->func, NULL, insn, state);
 			if (ret && backtrace)
 				BT_FUNC("<=== (hint)", insn);
 			warnings += ret;
@@ -2537,7 +2552,7 @@ static int validate_symbol(struct objtoo
 
 	state->uaccess = sym->uaccess_safe;
 
-	ret = validate_branch(file, insn->func, insn, *state);
+	ret = validate_branch(file, insn->func, NULL, insn, *state);
 	if (ret && backtrace)
 		BT_FUNC("<=== (sym)", insn);
 	return ret;
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -30,7 +30,8 @@ struct instruction {
 	unsigned int len;
 	enum insn_type type;
 	unsigned long immediate;
-	bool alt_group, dead_end, ignore, ignore_alts;
+	int alt_group;
+	bool dead_end, ignore, ignore_alts;
 	bool hint;
 	bool retpoline_safe;
 	s8 instr;


