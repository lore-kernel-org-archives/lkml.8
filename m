Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD5EC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C3920770
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JgNymQ/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgCQRMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:12:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46206 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgCQRMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=QbGeewWMk2FA2MtPNB/0FNd9UAqrQnwyvbemtby3IGo=; b=JgNymQ/OmZk3THOR0cipvReSxM
        MCRaq6JlDNJOv+vIddKYyCwajHZLCqKpdNwyrG45ylO1JR6SwJntRWm4VIfzO3ipf7ySQqEb6a9da
        xBg9ceg5iVNr8etd7t8YQq2BfjHcPx+Hciz4/GmT2KDBl2k5MZUUPXfizyJMqxEe7LPBbyQ0N9DRI
        qZVuvrAr1D2tcaMNn9nBu6kM2zJ5/NcJia/lmkKGXld56POC4umiebYk6A9PUgQDRq2bRIRsjhtTT
        BAxANhRN5DUkoR+MG+7p6+Sc9Ko8zO89tExgz2l94YuUkGnq+N2fwLMx51/mv2osnij71KpmsDGab
        FJOUb2Og==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEFky-0002r2-Lv; Tue, 17 Mar 2020 17:11:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D95F4304D2C;
        Tue, 17 Mar 2020 18:11:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C391C264FDB16; Tue, 17 Mar 2020 18:11:54 +0100 (CET)
Message-Id: <20200317170909.940068434@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 17 Mar 2020 18:02:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v2 03/19] objtool: Rename func_for_each_insn_all()
References: <20200317170234.897520633@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that func_for_each_insn() is available, rename
func_for_each_insn_all(). This gets us:

  sym_for_each_insn()  - iterate on symbol offset/len
  func_for_each_insn() - iterate on insn->func

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -72,7 +72,7 @@ static struct instruction *next_insn_sam
 	return find_insn(file, func->cfunc->sec, func->cfunc->offset);
 }
 
-#define func_for_each_insn_all(file, func, insn)			\
+#define func_for_each_insn(file, func, insn)				\
 	for (insn = find_insn(file, func->sec, func->offset);		\
 	     insn;							\
 	     insn = next_insn_same_func(file, insn))
@@ -165,7 +165,7 @@ static bool __dead_end_function(struct o
 	if (!insn->func)
 		return false;
 
-	func_for_each_insn_all(file, func, insn) {
+	func_for_each_insn(file, func, insn) {
 		empty = false;
 
 		if (insn->type == INSN_RETURN)
@@ -180,7 +180,7 @@ static bool __dead_end_function(struct o
 	 * case, the function's dead-end status depends on whether the target
 	 * of the sibling call returns.
 	 */
-	func_for_each_insn_all(file, func, insn) {
+	func_for_each_insn(file, func, insn) {
 		if (is_sibling_call(insn)) {
 			struct instruction *dest = insn->jump_dest;
 
@@ -425,7 +425,7 @@ static void add_ignores(struct objtool_f
 			continue;
 		}
 
-		func_for_each_insn_all(file, func, insn)
+		func_for_each_insn(file, func, insn)
 			insn->ignore = true;
 	}
 }
@@ -1082,7 +1082,7 @@ static void mark_func_jump_tables(struct
 	struct instruction *insn, *last = NULL;
 	struct rela *rela;
 
-	func_for_each_insn_all(file, func, insn) {
+	func_for_each_insn(file, func, insn) {
 		if (!last)
 			last = insn;
 
@@ -1117,7 +1117,7 @@ static int add_func_jump_tables(struct o
 	struct instruction *insn;
 	int ret;
 
-	func_for_each_insn_all(file, func, insn) {
+	func_for_each_insn(file, func, insn) {
 		if (!insn->jump_table)
 			continue;
 


