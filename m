Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6664C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ED7A21D7F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W2deN1OU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634058AbgDPLxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506707AbgDPLwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:52:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7F1C03C1A6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=+/Xl9QZxuCUp81LzYaZ7P1/ZN4KYWh4fZr7Ht4W81L4=; b=W2deN1OUs+OKjS4F/w/VFS9Za2
        RZjIUtGQjKxjZhL7a+CbdH4fn0jttN+rkzHGhRZqR3oMDgNnWa4OQwf1DLz4HCG/6f3YZv2K+nwZj
        KBJRvu9ioEe09xEhpeTR1YLupkDUlCeaMfJNeMy9MZigy7YfzykeB59sQ8cwbbR0gGyT+a5iOnSpg
        nA5utnBj7GJObaf4Xm1OJdiP/6kz2BI22p55d4maYBUvPtkFc4WoJd19/ggBKBLb3cv95I9IgTOwv
        lM+ki2tVBb9zsxO9vfWDUeYP2y1U6V+rA1bz24F1QtgIq2wIakRAFrE6sNm89DZb/n8ZX0godwbJJ
        ExCecrog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP34F-0004sD-NQ; Thu, 16 Apr 2020 11:52:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 590F2307479;
        Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 39F0D2B0DE4C8; Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Message-Id: <20200416115118.986441913@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 16 Apr 2020 13:47:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, jthierry@redhat.com,
        alexandre.chartre@oracle.com
Subject: [PATCH v5 08/17] objtool: Rename struct cfi_state
References: <20200416114706.625340212@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's going to be a new struct cfi_state, rename this one to make
place.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/arch.h            |    2 +-
 tools/objtool/arch/x86/decode.c |    2 +-
 tools/objtool/cfi.h             |    2 +-
 tools/objtool/check.c           |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -68,7 +68,7 @@ struct stack_op {
 	struct list_head list;
 };
 
-void arch_initial_func_cfi_state(struct cfi_state *state);
+void arch_initial_func_cfi_state(struct cfi_init_state *state);
 
 int arch_decode_instruction(struct elf *elf, struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -501,7 +501,7 @@ int arch_decode_instruction(struct elf *
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


