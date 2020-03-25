Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AA8C2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7166C2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JzuficHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgCYRrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:47:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47290 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgCYRrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=k/3+spoNimAYc6iAjh77mhVTzVz8FbGn1YtCEp5dCes=; b=JzuficHXVp4WDfYJelHbvcXaEE
        Fff79ugx0SmcuQuZG1V5yq/6leTeAHsjeRvm5xyshXtKtVxX1St/pSyG79npHFA8gw7oagFOmLqUK
        sVIaHwKMnmXdkJvefptbbUWIjraOafEIpM+o3Aa6Q9x8A0REWJGmEQKG659RPzWXJN8S5yzTcZgOt
        L7F0co/1rZ6Ktz7GvNJRm62xNC5SoNompzb5NEWEZj3o6NbU/+yx2ixPWq/6ocNtF9pe3pVx4Ahk8
        Y+W9ew9jbMEm6IXMp7WmO9oalNMOSKWSRhcPw1mFyuRBJWff9S0aUFcoE1pPhIWLmB+z1KhzMnDxh
        4NzuKJew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHA82-0008RJ-OJ; Wed, 25 Mar 2020 17:47:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E2CEF307276;
        Wed, 25 Mar 2020 18:47:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D53CA29BD8A2A; Wed, 25 Mar 2020 18:47:42 +0100 (CET)
Message-Id: <20200325174606.363061813@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 25 Mar 2020 18:45:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz
Subject: [PATCH v4 13/13] objtool: Also consider .entry.text as noinstr
References: <20200325174525.772641599@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Consider all of .entry.text as noinstr. This gets us coverage across
the PTI boundary. While we could add everything .noinstr.text into
.entry.text that would bloat the amount of code in the user mapping.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -285,7 +285,8 @@ static int decode_instructions(struct ob
 		    strncmp(sec->name, ".discard.", 9))
 			sec->text = true;
 
-		if (!strcmp(sec->name, ".noinstr.text"))
+		if (!strcmp(sec->name, ".noinstr.text") ||
+		    !strcmp(sec->name, ".entry.text"))
 			sec->noinstr = true;
 
 		for (offset = 0; offset < sec->len; offset += insn->len) {
@@ -2065,7 +2066,7 @@ static inline const char *call_dest_name
 static int validate_call(struct instruction *insn, struct insn_state *state)
 {
 	if (state->noinstr && state->instr <= 0 &&
-	    (!insn->call_dest || insn->call_dest->sec != insn->sec)) {
+	    (!insn->call_dest || !insn->call_dest->sec->noinstr)) {
 		WARN_FUNC("call to %s() leaves .noinstr.text section",
 				insn->sec, insn->offset, call_dest_name(insn));
 		return 1;
@@ -2636,11 +2637,16 @@ static int validate_vmlinux_functions(st
 	int warnings = 0;
 
 	sec = find_section_by_name(file->elf, ".noinstr.text");
-	if (!sec)
-		return 0;
+	if (sec) {
+		warnings += validate_section(file, sec);
+		warnings += validate_unwind_hints(file, sec);
+	}
 
-	warnings += validate_section(file, sec);
-	warnings += validate_unwind_hints(file, sec);
+	sec = find_section_by_name(file->elf, ".entry.text");
+	if (sec) {
+		warnings += validate_section(file, sec);
+		warnings += validate_unwind_hints(file, sec);
+	}
 
 	return warnings;
 }


