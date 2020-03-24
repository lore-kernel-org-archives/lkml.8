Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5AAC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645902137B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fx7Dkrtk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgCXQNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:13:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51012 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbgCXQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=o7RVv3CUxPNg2jYu+UyuSePNLr3TfhvVjvW78jQ2xdI=; b=fx7Dkrtkrtnc7RuojEKOo7tzgE
        4LigaAKR02Gnj76ssof/X42oEltOQNRfk6lac2xWgu0x3qa6yFKyXygFDiPYG8Q3j01I7AcSml+j7
        QbhEjxrj3cXacjQjI5R/OnW3HbhZQhTm6td/Uzl7dS6g3DcaeOY91E8pQ/xVMwwsDY1nRFAPjGaFv
        Ywy/3DDwb9JPJaB3ujE4dd1wH3qma4W7VJ36rru3E7I86MzMLyLV5xNMuCguXuHNCj/fsNFtsqY74
        X7vv+lgGr8sAexPzylNRT9bGv6vTXciu+u7ib20e5bjhTsbfMrntRFEcSBbdlJrjmhJ70SPGkC65f
        AHBbKRDg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGm9M-0000Bv-1v; Tue, 24 Mar 2020 16:11:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5FE5B3073F6;
        Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 52C9D29A490F6; Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Message-Id: <20200324160924.924304616@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 16:31:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v3 17/26] objtool: Re-arrange validate_functions()
References: <20200324153113.098167666@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to adding a vmlinux.o specific pass, rearrange some
code. No functional changes intended.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   60 ++++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2413,9 +2413,8 @@ static bool ignore_unreachable_insn(stru
 	return false;
 }
 
-static int validate_functions(struct objtool_file *file)
+static int validate_section(struct objtool_file *file, struct section *sec)
 {
-	struct section *sec;
 	struct symbol *func;
 	struct instruction *insn;
 	struct insn_state state;
@@ -2428,35 +2427,44 @@ static int validate_functions(struct obj
 	       CFI_NUM_REGS * sizeof(struct cfi_reg));
 	state.stack_size = initial_func_cfi.cfa.offset;
 
-	for_each_sec(file, sec) {
-		list_for_each_entry(func, &sec->symbol_list, list) {
-			if (func->type != STT_FUNC)
-				continue;
-
-			if (!func->len) {
-				WARN("%s() is missing an ELF size annotation",
-				     func->name);
-				warnings++;
-			}
-
-			if (func->pfunc != func || func->alias != func)
-				continue;
-
-			insn = find_insn(file, sec, func->offset);
-			if (!insn || insn->ignore || insn->visited)
-				continue;
-
-			state.uaccess = func->uaccess_safe;
-
-			ret = validate_branch(file, func, insn, state);
-			if (ret && backtrace)
-				BT_FUNC("<=== (func)", insn);
-			warnings += ret;
+	list_for_each_entry(func, &sec->symbol_list, list) {
+		if (func->type != STT_FUNC)
+			continue;
+
+		if (!func->len) {
+			WARN("%s() is missing an ELF size annotation",
+					func->name);
+			warnings++;
 		}
+
+		if (func->pfunc != func || func->alias != func)
+			continue;
+
+		insn = find_insn(file, sec, func->offset);
+		if (!insn || insn->ignore || insn->visited)
+			continue;
+
+		state.uaccess = func->uaccess_safe;
+
+		ret = validate_branch(file, func, insn, state);
+		if (ret && backtrace)
+			BT_FUNC("<=== (func)", insn);
+		warnings += ret;
 	}
 
 	return warnings;
 }
+
+static int validate_functions(struct objtool_file *file)
+{
+	struct section *sec;
+	int warnings = 0;
+
+	for_each_sec(file, sec)
+		warnings += validate_section(file, sec);
+
+	return warnings;
+}
 
 static int validate_reachable_instructions(struct objtool_file *file)
 {


