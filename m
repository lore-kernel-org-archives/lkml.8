Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A74C54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8776D208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hGeKhiQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgCYOnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:43:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgCYOnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B6/EgTBmcxNOYlRTwE7Wey9MaN6nSic+eYAPKYmBAVI=; b=hGeKhiQKnC5hgLlmKId/RJgDg1
        Nhlf++GdvHq/joC7x6FRSaGlfnGHP5PMgQWzKPg5K/ANtkp6GjAQs5YfkSpOJPGUTBTqDF/0K/HBb
        ngYtsPqdukuYJI5/ywOSSlQKIklvur0x5/HItw8aFW1TwjpEL2YKERk4NXlyRXoTScm1mViPt4kWo
        jH2bU++9/8WUfDbk581Dwq47He7KpORbGW2QwBE6KVDeuxONzgS3n4+MwElF9fSIk93fABxjjraF4
        3gU+XCl85roGSr2HYsEKmZ6CBkcjGx0OWbtikcWgZ5mS3d++9JrCzZfJydAFbEn+aqkFR6MXz5f2Y
        RnMcQZXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH7FQ-0002F3-S1; Wed, 25 Mar 2020 14:43:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 081103007F2;
        Wed, 25 Mar 2020 15:43:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE92829A8F430; Wed, 25 Mar 2020 15:43:10 +0100 (CET)
Date:   Wed, 25 Mar 2020 15:43:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v3.1 18c/26] objtool: Rename struct cfi_state
Message-ID: <20200325144310.GX20696@hirez.programming.kicks-ass.net>
References: <20200324153113.098167666@infradead.org>
 <20200324160924.987489248@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324160924.987489248@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: objtool: Rename struct cfi_state
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Mar 25 15:34:50 CET 2020

There's going to be a new struct cfi_state, rename this one to make
place.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch.h            |    2 +-
 tools/objtool/arch/x86/decode.c |    2 +-
 tools/objtool/cfi.h             |    2 +-
 tools/objtool/check.c           |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -66,7 +66,7 @@ struct stack_op {
 	struct op_src src;
 };
 
-void arch_initial_func_cfi_state(struct cfi_state *state);
+void arch_initial_func_cfi_state(struct cfi_init_state *state);
 
 int arch_decode_instruction(struct elf *elf, struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -480,7 +480,7 @@ int arch_decode_instruction(struct elf *
 	return 0;
 }
 
-void arch_initial_func_cfi_state(struct cfi_state *state)
+void arch_initial_func_cfi_state(struct cfi_init_state *state)
 {
 	int i;
 
--- a/tools/objtool/cfi.h
+++ b/tools/objtool/cfi.h
@@ -35,7 +35,7 @@ struct cfi_reg {
 	int offset;
 };
 
-struct cfi_state {
+struct cfi_init_state {
 	struct cfi_reg cfa;
 	struct cfi_reg regs[CFI_NUM_REGS];
 };
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -27,7 +27,7 @@ struct alternative {
 };
 
 const char *objname;
-struct cfi_state initial_func_cfi;
+struct cfi_init_state initial_func_cfi;
 
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset)
