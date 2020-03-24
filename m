Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20494C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD3F208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h9e2cHFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgCXQLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:11:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36970 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbgCXQLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=x6OZZLFjbQQ+j9kuhBoOrCjWSWxd8Ek9Bx02vZNOt9k=; b=h9e2cHFaEil1KlgZJuQmGo+Xov
        yCvSJ4V3ix15iKt7cSShcRxmYoUlEL9pZdTMWE60WcBU00zaQcQLTdJrC2t+evXLdiRiXpH8U33Yp
        kz3AvLOa1GMGXop+3FHEmmBb/4vYNvvC2b41HF6Y7JouR5zyjdXPfIz7/VJHGq4vppICydJmxJxzS
        WjV49zJg3iOAbNdPQ/qU6EE29/vEbCkAqkGzYrvBm+snhXORLPOVGQfMIRW+UWLv4Hl289YrPhU0y
        5sgBObC0JGgB8L0KQLInLumPO6f0FFZnwo0EN/lxtVoFQR1EZ9JLiBScgcDAY2sB79xsFJMTthbvA
        hlYQivIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGm9N-0006c8-43; Tue, 24 Mar 2020 16:11:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8902C30785A;
        Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7B5C229A490F0; Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Message-Id: <20200324160925.410651737@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 16:31:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v3 25/26] objtool: Rearrange validate_section()
References: <20200324153113.098167666@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of further changes, once again break out the loop body.
No functional changes intended.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   51 ++++++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2552,12 +2552,37 @@ static void prepare_insn_rela(struct obj
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
 
@@ -2581,25 +2606,7 @@ static int validate_section(struct objto
 		if (func->type != STT_FUNC)
 			continue;
 
-		if (!func->len) {
-			WARN("%s() is missing an ELF size annotation",
-					func->name);
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


