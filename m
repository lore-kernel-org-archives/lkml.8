Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA10BC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D1421D7F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q75fEJxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506742AbgDPLxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506708AbgDPLwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:52:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37897C03C1A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=k/3+spoNimAYc6iAjh77mhVTzVz8FbGn1YtCEp5dCes=; b=q75fEJxBphUQl4Urs42UV6nKCU
        zq8lLbFUJnfcDNwvSRM4acekc1lBB/m43INQWlXuSwU4SS3Iek3BCDzBJVlA8A7xwv/BySep+dfr6
        SzSaCfWn+tmgAa2j6FEej84bq8PgoDhnymxLdOYIs+fwKRLN/RE9z/k96E5OanaSlRZ4Q/6t85tNx
        FnLl1oObE414NI20g8fEOQdlpEXSAazSBYwrbZVwD9uZ9qwk3xbWDD24ODZ2ZrCScSVLOGMNyjwn3
        KZoZB2Nv+DOO8m6J7bhoLhkVJtVic1sIpmRCgctK20MXBPrEYVlJP5NtE2EIcYW2Jc4GvqgxzfwCj
        4R7C6+TQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP34H-0004sj-E7; Thu, 16 Apr 2020 11:52:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 72813307893;
        Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6474D2B0DE4C1; Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Message-Id: <20200416115119.525037514@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 16 Apr 2020 13:47:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, jthierry@redhat.com,
        alexandre.chartre@oracle.com
Subject: [PATCH v5 17/17] objtool: Also consider .entry.text as noinstr
References: <20200416114706.625340212@infradead.org>
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


