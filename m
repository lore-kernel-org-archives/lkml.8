Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED0EC83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1417021707
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SEyLIiii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgD1TTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728377AbgD1TTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:19:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB6CC03C1AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=nzdDBr3oaZauQiS6KFZixaG0IDQ3jdStMDtJDHE6Yc8=; b=SEyLIiiiLtiLGSmRrErCbUwxh6
        3+n+nqDIMv0D1h8k1zZnviIjzH+HhpqRFvP344NwebN2hR6Zhg8hd+yjuabwumZW4pjrvU7DlRVMD
        U4Q60OhnnAfmo/xa60Sth6lj3m/sh7DskoCNf+IxCkaRIDc79DTdah8XS433jZEMXb7tfFRumWXY0
        EgIa7A4uUu1EYzmWHmNFXWtQcFNvjuNuGG2m/V6NLwrm+ozeNwHafoHHs5dKLXKbBiGx24mSfZcET
        aXpf1O6mJrB02FEKsmxVMRpBbL+vof6YAyUVBqF6eG5HBivEIrwcr6MJJTS+k9Ojv6XX01E3/hGE8
        CABWnBGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTVlQ-0006Vi-5h; Tue, 28 Apr 2020 19:19:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 90A6130753D;
        Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 79DD02392F88F; Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Message-Id: <20200428191659.438842526@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 28 Apr 2020 21:11:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, mbenes@suse.cz,
        peterz@infradead.org
Subject: [PATCH v2 01/14] objtool: Allow branches within the same alternative.
References: <20200428191101.886208539@infradead.org>
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
 tools/objtool/check.c |   26 ++++++++++++++++++++------
 tools/objtool/check.h |    3 ++-
 2 files changed, 22 insertions(+), 7 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -770,7 +770,9 @@ static int handle_group_alt(struct objto
 			    struct instruction *orig_insn,
 			    struct instruction **new_insn)
 {
+	static unsigned int alt_group_next_index = 1;
 	struct instruction *last_orig_insn, *last_new_insn, *insn, *fake_jump = NULL;
+	unsigned int alt_group = alt_group_next_index++;
 	unsigned long dest_off;
 
 	last_orig_insn = NULL;
@@ -779,7 +781,7 @@ static int handle_group_alt(struct objto
 		if (insn->offset >= special_alt->orig_off + special_alt->orig_len)
 			break;
 
-		insn->alt_group = true;
+		insn->alt_group = alt_group;
 		last_orig_insn = insn;
 	}
 
@@ -813,6 +815,7 @@ static int handle_group_alt(struct objto
 	}
 
 	last_new_insn = NULL;
+	alt_group = alt_group_next_index++;
 	insn = *new_insn;
 	sec_for_each_insn_from(file, insn) {
 		if (insn->offset >= special_alt->new_off + special_alt->new_len)
@@ -822,6 +825,7 @@ static int handle_group_alt(struct objto
 
 		insn->ignore = orig_insn->ignore_alts;
 		insn->func = orig_insn->func;
+		insn->alt_group = alt_group;
 
 		/*
 		 * Since alternative replacement code is copy/pasted by the
@@ -2163,6 +2167,15 @@ static int validate_return(struct symbol
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
@@ -2170,6 +2183,7 @@ static int validate_return(struct symbol
  * tools/objtool/Documentation/stack-validation.txt.
  */
 static int validate_branch(struct objtool_file *file, struct symbol *func,
+			   struct instruction *from,
 			   struct instruction *insn, struct insn_state state)
 {
 	struct alternative *alt;
@@ -2180,7 +2194,7 @@ static int validate_branch(struct objtoo
 
 	sec = insn->sec;
 
-	if (insn->alt_group && list_empty(&insn->alts)) {
+	if (is_branch_to_alternative(from, insn)) {
 		WARN_FUNC("don't know how to handle branch to middle of alternative instruction group",
 			  sec, insn->offset);
 		return 1;
@@ -2227,7 +2241,7 @@ static int validate_branch(struct objtoo
 				if (alt->skip_orig)
 					skip_orig = true;
 
-				ret = validate_branch(file, func, alt->insn, state);
+				ret = validate_branch(file, func, NULL, alt->insn, state);
 				if (ret) {
 					if (backtrace)
 						BT_FUNC("(alt)", insn);
@@ -2271,7 +2285,7 @@ static int validate_branch(struct objtoo
 
 			} else if (insn->jump_dest) {
 				ret = validate_branch(file, func,
-						      insn->jump_dest, state);
+						      insn, insn->jump_dest, state);
 				if (ret) {
 					if (backtrace)
 						BT_FUNC("(branch)", insn);
@@ -2402,7 +2416,7 @@ static int validate_unwind_hints(struct
 
 	while (&insn->list != &file->insn_list && (!sec || insn->sec == sec)) {
 		if (insn->hint && !insn->visited) {
-			ret = validate_branch(file, insn->func, insn, state);
+			ret = validate_branch(file, insn->func, NULL, insn, state);
 			if (ret && backtrace)
 				BT_FUNC("<=== (hint)", insn);
 			warnings += ret;
@@ -2543,7 +2557,7 @@ static int validate_symbol(struct objtoo
 
 	state->uaccess = sym->uaccess_safe;
 
-	ret = validate_branch(file, insn->func, insn, *state);
+	ret = validate_branch(file, insn->func, NULL, insn, *state);
 	if (ret && backtrace)
 		BT_FUNC("<=== (sym)", insn);
 	return ret;
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -30,12 +30,13 @@ struct instruction {
 	unsigned int len;
 	enum insn_type type;
 	unsigned long immediate;
-	bool alt_group, dead_end, ignore, ignore_alts;
+	bool dead_end, ignore, ignore_alts;
 	bool hint;
 	bool retpoline_safe;
 	s8 instr;
 	u8 visited;
 	u8 ret_offset;
+	int alt_group;
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
 	struct instruction *first_jump_src;


