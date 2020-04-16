Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3091C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0C60206A2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G9XHhxQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634302AbgDPLyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506728AbgDPLxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:53:01 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B02DC0610D6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=oFzyaVj88aaR8oiosflQFJrDai8cGo3W9Px0LYEjy9U=; b=G9XHhxQicCODdXBelf5cWXb0tx
        VISTe9cqz6tIyEoGt2zKSJHnlvzRX9Ib6ErlEOZ9uC+vyXWW/bfLSeIzsLVznP646AVF/9PJzYVpj
        ou33hiNV0yN5JX18MeOE4l7HjGnNrlvklV5/8c2fTt4FK5JLm64gWfWUebH5AGShv8ad6oYJAvJzc
        utBEOQ9Wz6i5IvDEWS8upNm2IkzOZz0hawmtl2gHZIlMVJBD9LtyeZyLLmdBNqqi8b6tXBv8iMEhs
        94JtCt2SOA3jGX6LUEwKRyFv3tmUBiC0/D7vjwl3UCscxFoPPCOhnRs/q4FZtcDN5KM+qaV3QQ7zB
        tAOoMrmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP34G-0006ja-Kl; Thu, 16 Apr 2020 11:52:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 590DB30746C;
        Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2FA252B0DE4C6; Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Message-Id: <20200416115118.808485515@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 16 Apr 2020 13:47:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, jthierry@redhat.com,
        alexandre.chartre@oracle.com
Subject: [PATCH v5 05/17] x86,ftrace: Use SIZEOF_PTREGS
References: <20200416114706.625340212@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a convenient macro for 'SS+8' called FRAME_SIZE. Use it to
clarify things.

(entry/calling.h calls this SIZEOF_PTREGS but we're using
asm/ptrace-abi.h)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/ftrace_64.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -23,7 +23,7 @@
 #endif /* CONFIG_FRAME_POINTER */
 
 /* Size of stack used to save mcount regs in save_mcount_regs */
-#define MCOUNT_REG_SIZE		(SS+8 + MCOUNT_FRAME_SIZE)
+#define MCOUNT_REG_SIZE		(FRAME_SIZE + MCOUNT_FRAME_SIZE)
 
 /*
  * gcc -pg option adds a call to 'mcount' in most functions.
@@ -77,7 +77,7 @@
 	/*
 	 * We add enough stack to save all regs.
 	 */
-	subq $(MCOUNT_REG_SIZE - MCOUNT_FRAME_SIZE), %rsp
+	subq $(FRAME_SIZE), %rsp
 	movq %rax, RAX(%rsp)
 	movq %rcx, RCX(%rsp)
 	movq %rdx, RDX(%rsp)


