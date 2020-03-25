Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32171C2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCFA207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mwooyu8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgCYRs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:48:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58416 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgCYRru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=x77cU5fJpsRb5o/kwDXCBU26CDTVfdtKnpNItb3C9yU=; b=Mwooyu8kmVmOkpL6VM8/oCODuC
        6IPgPc22xEEcwt5+ltZLgRQ+7t5/jQOOKpRlDkRTBEsDmM2NoQPx8zm06PygWWnqfyIPPtleFKk4y
        iCnoADOCTPrbQMnovESdXBZH0DOqEQxYKy3fEpPgZ3ROu/J4SqWZoYzJRvXFSaKW6raG6wwV1Okrz
        3a7KCgCn31TF6VQ0ZMXbTuhIgCKugkm0qqXU7yAXGECTQm5fdxsOrmrEdKoy5yD0AArNJBDD8RhZg
        I+YgQe0xBRq3xVvHZtHp21tfPxpQTuyazZWtMoquLo6GBucIE6wRS7myPA3rJOCHDJP6UC7JTiLdS
        j3pIZ6VA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHA80-0003oV-80; Wed, 25 Mar 2020 17:47:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C1F6030152B;
        Wed, 25 Mar 2020 18:47:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id ABA7229BD8A2B; Wed, 25 Mar 2020 18:47:42 +0100 (CET)
Message-Id: <20200325174605.540097964@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 25 Mar 2020 18:45:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz
Subject: [PATCH v4 03/13] objtool: Rename struct cfi_state
References: <20200325174525.772641599@infradead.org>
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


