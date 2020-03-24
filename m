Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50064C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EB420789
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wb5HwDO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgCXQLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:11:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50986 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbgCXQLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=U/Z93ID0Ley3uabUn6Av4k+K52bsSIKdSRKwQpkQdic=; b=Wb5HwDO1V86ruJz1gq7Ry7JLZ1
        VcWhGpds5RujG52EdswQmRtNlLpdZSFrxjZDH/AJs/pyC52308uTG4WvxPDeeMDUTrLf0NslGAGyb
        fGhxdQ0VHTA6sd/QHan6Uxw7SA2O/XsWlTQ0WHSBekq/UmklEtJRsSlEyZhs14gW2EIpPQ3x8KWUz
        yldkv81KbTp4loLPUHMLsbYGelr0cXst04rxyOlMN7R6zn5Xfl0ElaUFZvc06zYLivKgVRTN0rNuR
        vBM9PRLgwAbdl7Z6ZTZCzDazIYY/B1H2ixwnoabvqq8iWgzusaKxGecyHJpC6MS7iRC0RqnaQ7jzY
        0eoMMUtw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGm9K-0000BS-9f; Tue, 24 Mar 2020 16:11:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 31477306099;
        Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1FCEB29A490F4; Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Message-Id: <20200324160924.083720147@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 16:31:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v3 03/26] objtool: Rename func_for_each_insn_all()
References: <20200324153113.098167666@infradead.org>
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
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
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
 


