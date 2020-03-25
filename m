Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E25C2D0E6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF96207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NIQlO5rg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgCYRsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:48:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47286 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgCYRru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=S5YBOI/hzl74GxKLOG1SFL3+rFVI5u7H+0CGlPgUL48=; b=NIQlO5rg33Q9X87rxcWwEaYQpu
        0ZEh5rPn1Fmh5/rl0XNHKyl9WKMo5uDsJhvh7pKObyJmBqQLMi3+QjehsZQJXWtzJZRCJzc33tv0P
        e3guvbIvf1/BdQmlTnb0Y4v1W8Yl+pLIRFTezeZWAH5hgFQJS+HT5qnYP1HLZxMPg7YWZfWMxfOoY
        dgwCBn3yx8xblmJj19VbaqG1VnLHdQQaAxA04CyS/Tt9zqHjbRZiNwFQYacVsOVr9Z1JMuzlgoeEq
        M1mE8uYK9qyXBAC/EGmCLJD2YGDOcfsXcqoiUir6ge+3eU17XgvsRMT7/kqtYgxUmISZGnxqCzF4F
        b/qBJvAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHA82-0008RD-51; Wed, 25 Mar 2020 17:47:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD142306DBB;
        Wed, 25 Mar 2020 18:47:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CD42029BD8A2B; Wed, 25 Mar 2020 18:47:42 +0100 (CET)
Message-Id: <20200325174606.207274148@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 25 Mar 2020 18:45:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz
Subject: [PATCH v4 11/13] objtool: Rearrange validate_section()
References: <20200325174525.772641599@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of further changes, once again break out the loop body.
No functional changes intended.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c |   51 ++++++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2559,12 +2559,37 @@ static void prepare_insn_rela(struct obj
 	}
 }
 
-static int validate_section(struct objtool_file *file, struct section *sec)
+static int validate_symbol(struct objtool_file *file, struct section *sec,
+			   struct symbol *sym, struct insn_state *state)
 {
-	struct symbol *func;
 	struct instruction *insn;
+	int ret;
+
+	if (!sym->len) {
+		WARN("%s() is missing an ELF size annotation", sym->name);
+		return 1;
+	}
+
+	if (sym->pfunc != sym || sym->alias != sym)
+		return 0;
+
+	insn = find_insn(file, sec, sym->offset);
+	if (!insn || insn->ignore || insn->visited)
+		return 0;
+
+	state->uaccess = sym->uaccess_safe;
+
+	ret = validate_branch(file, insn->func, insn, *state);
+	if (ret && backtrace)
+		BT_FUNC("<=== (sym)", insn);
+	return ret;
+}
+
+static int validate_section(struct objtool_file *file, struct section *sec)
+{
 	struct insn_state state;
-	int ret, warnings = 0;
+	struct symbol *func;
+	int warnings = 0;
 
 	clear_insn_state(&state);
 
@@ -2588,25 +2613,7 @@ static int validate_section(struct objto
 		if (func->type != STT_FUNC)
 			continue;
 
-		if (!func->len) {
-			WARN("%s() is missing an ELF size annotation",
-			     func->name);
-			warnings++;
-		}
-
-		if (func->pfunc != func || func->alias != func)
-			continue;
-
-		insn = find_insn(file, sec, func->offset);
-		if (!insn || insn->ignore || insn->visited)
-			continue;
-
-		state.uaccess = func->uaccess_safe;
-
-		ret = validate_branch(file, func, insn, state);
-		if (ret && backtrace)
-			BT_FUNC("<=== (func)", insn);
-		warnings += ret;
+		warnings += validate_symbol(file, sec, func, &state);
 	}
 
 	return warnings;


