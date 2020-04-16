Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20865C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC48206A2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1Am1+ihi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634205AbgDPLyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506727AbgDPLxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:53:01 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB178C03C1A6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=KnsPft4aimU+BAX6201lb5yvbjDdXTMlrvOSCCobppQ=; b=1Am1+ihiqeM0kBe+3rgiKh1KLg
        95cLsKyZPib2GnuhXSCDyqB4yZ4DjDkNZ2VMBMszf79X9IpGPrGA8UReqiyHP2GBE8yiZn5QhstRE
        cIb/vzqicDvoJ4sTPIMaXnU3CGdZ+woaPZmXzQqP+hcbimMXm5ESvB3BHV1FbP9koM7qaal2S7y0T
        FqW1WhcIANzL6GVbeCDFRlxq+tKkBJ1i74QTqq7T/MZCN7uLCzyExUTaeavwf02ikMFEsVcuZLKUQ
        L3kTYgeARC2MoaIIScIDdrH2GO+NMJZRu5lNMG0NHZeeydZWZX//oyU36CC83iQOIDhANRiV0cZSS
        zb6m7j2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP34G-0006jc-Lt; Thu, 16 Apr 2020 11:52:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6E861307886;
        Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 59AA52B0DE4C0; Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Message-Id: <20200416115119.405863817@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 16 Apr 2020 13:47:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, jthierry@redhat.com,
        alexandre.chartre@oracle.com
Subject: [PATCH v5 15/17] objtool: Rearrange validate_section()
References: <20200416114706.625340212@infradead.org>
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
@@ -2447,12 +2447,37 @@ static bool ignore_unreachable_insn(stru
 	return false;
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
 
@@ -2473,25 +2498,7 @@ static int validate_section(struct objto
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


