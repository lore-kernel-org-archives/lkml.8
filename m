Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91FAC1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6ED20767
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yafMHcE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgCQRMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:12:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45074 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgCQRMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=PEhndil3er1ZtOevkvDBqMICAFGbV7d9pcozQBA1K+c=; b=yafMHcE4HKXWfwZepqepb3C/L4
        CYg89Jfd5OrWfPmo9yZkBjLScyT7VSUHwL/G6UHAPolVh4evI3SuhI7U79tD64HR2IqUzZ3RKJmtf
        HPbsaVRMpy2BHryyysiZJsIbnIpQ/UPl72OOAL9oG1UZfO+Mf19IqyK0U0YqQd6GWZUVLOt++CPBN
        o9Lf58ucbbeLuO7Qa6qbFU1OoZ8B/sP9d2zcB+nXiZ1JrH7J+VeCboLVbs2QXO7Mf93L9ZSS3tA24
        w1bnCZFW2dbvohEf2sUFTTJtrMyLrOqIP3ERwPlV1TsgeJJZyMQ2BC4oiqnMFmBF1JwLG3esul+sY
        DyPEPfUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEFky-0003ie-3K; Tue, 17 Mar 2020 17:11:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC5FA306099;
        Tue, 17 Mar 2020 18:11:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C8224264FDB17; Tue, 17 Mar 2020 18:11:54 +0100 (CET)
Message-Id: <20200317170909.999544119@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 17 Mar 2020 18:02:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v2 04/19] x86/kexec: Use RIP relative addressing
References: <20200317170234.897520633@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally identity_mapped is not visible to objtool, due to:

  arch/x86/kernel/Makefile:OBJECT_FILES_NON_STANDARD_relocate_kernel_$(BITS).o := y

However, when we want to run objtool on vmlinux.o there is no hiding
it:

  vmlinux.o: warning: objtool: .text+0x4c0f1: unsupported intra-function call

Replace the (i386 inspired) pattern:

	call 1f
  1:	popq %r8
	subq $(1b - relocate_kernel), %r8

With a x86_64 RIP-relative LEA:

	leaq relocate_kernel(%rip), %r8

Suggested-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/relocate_kernel_64.S |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -196,10 +196,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_ma
 
 	/* get the re-entry point of the peer system */
 	movq	0(%rsp), %rbp
-	call	1f
-1:
-	popq	%r8
-	subq	$(1b - relocate_kernel), %r8
+	leaq	relocate_kernel(%rip), %r8
 	movq	CP_PA_SWAP_PAGE(%r8), %r10
 	movq	CP_PA_BACKUP_PAGES_MAP(%r8), %rdi
 	movq	CP_PA_TABLE_PAGE(%r8), %rax


