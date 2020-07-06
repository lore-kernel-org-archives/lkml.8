Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB36C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4491D2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Blw8NTT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgGFOee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbgGFOed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:34:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64642C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 07:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yTfkro5cHzke17V5815BcwuPcfPkV4tReADrZoIyi9k=; b=Blw8NTT7z/NtSn5D4AGCXycPHM
        Qnm9jbS0ORUe2v92VLKPzIVL2s5JMzkFJB2IlRkma/XNiR395F+SHmzQeas3dKSTAP2lcXElYZi3P
        5dcIW/LOfXWxLnwrDErsl9uP5gfkc4/vlMBKpg5rxwOIwgeeY1iJtHhi7x+CmyjuQfT6e6ePKDLS0
        LPIFndGQBgI+IUF3ecLbuglDX3tgkTh4e2+/o+9arN6feQ94LlQy+lk3sj7fpcZdgT0kwRiYx6tC/
        xRJbOf0//zqFKda42clz6pcUqfAER/qONh+vxy1V+T+SgSEZtGamLVVJSfA5Abo4xhJnYqNxY7ce8
        nxAwqa0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsSCQ-0004wY-Dq; Mon, 06 Jul 2020 14:34:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CB005304E03;
        Mon,  6 Jul 2020 16:34:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A41E2213C65B2; Mon,  6 Jul 2020 16:34:25 +0200 (CEST)
Date:   Mon, 6 Jul 2020 16:34:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH] x86/entry: Mark check_user_regs() noinstr
Message-ID: <20200706143425.GG4800@hirez.programming.kicks-ass.net>
References: <cover.1593191971.git.luto@kernel.org>
 <52059e42bb0ab8551153d012d68f7be18d72ff8e.1593191971.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52059e42bb0ab8551153d012d68f7be18d72ff8e.1593191971.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 10:21:11AM -0700, Andy Lutomirski wrote:

> +static void check_user_regs(struct pt_regs *regs)

---
Subject: x86/entry: Mark check_user_regs() noinstr

vmlinux.o: warning: objtool: do_syscall_64()+0xb: call to check_user_regs() leaves .noinstr.text section
vmlinux.o: warning: objtool: do_int80_syscall_32()+0x4: call to check_user_regs() leaves .noinstr.text section
vmlinux.o: warning: objtool: do_fast_syscall_32()+0x25: call to check_user_regs() leaves .noinstr.text section
vmlinux.o: warning: objtool: idtentry_enter_cond_rcu()+0x3d: call to check_user_regs() leaves .noinstr.text section
vmlinux.o: warning: objtool: idtentry_enter_user()+0x0: call to check_user_regs() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index e83b3f14897c..ea7b515e3bc2 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -46,7 +46,7 @@
 #include <trace/events/syscalls.h>
 
 /* Check that the stack and regs on entry from user mode are sane. */
-static void check_user_regs(struct pt_regs *regs)
+static noinstr void check_user_regs(struct pt_regs *regs)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_ENTRY)) {
 		/*
