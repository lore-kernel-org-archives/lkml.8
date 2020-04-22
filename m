Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41037C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1625F2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a6/PaJZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgDVJpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 05:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725912AbgDVJpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 05:45:20 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA12C03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 02:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=788E1MFAXW1wpQjFhhTXItaX7rDEk1l+jBolHhk7YTE=; b=a6/PaJZT3nHwDrb/j5yyNNRx6l
        O51+kKixeRVqvsg/zh2HRODcE3Z/XwTeEhKtPvKjayNsp872SDrmEoatNl7TDdeRW4XjhcvWOgw88
        mIW5KitD1rvpsEwLjav2cyx/I8upgLanlQ66agf0rDJgWXL5/pnNXHidgdPivlsgamfz5h8cRWtYF
        bnWjXuMHORKwjLabrXNMORaZf1sZKIFI076dwyg+HP2nWJ3YGCdn9CEUVNBiuEApjBS7WT5Yl67oQ
        KIiInFTt7efTUfoZmCe8SN6kYiq4qjuJQambSiVRiEjNO6KKeixU6fSVQfCbM0GD4uG7633H4VZxJ
        k2uSzu8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRBw2-0003m5-QK; Wed, 22 Apr 2020 09:44:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CCEC33011C6;
        Wed, 22 Apr 2020 11:44:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F5AC2012B92C; Wed, 22 Apr 2020 11:44:47 +0200 (CEST)
Date:   Wed, 22 Apr 2020 11:44:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, jthierry@redhat.com, alexandre.chartre@oracle.com
Subject: Re: [PATCH v5 04/17] x86,ftrace: Fix ftrace_regs_caller() unwind
Message-ID: <20200422094446.GY20730@hirez.programming.kicks-ass.net>
References: <20200416114706.625340212@infradead.org>
 <20200416115118.749606694@infradead.org>
 <20200421203345.4e165c4b@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421203345.4e165c4b@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 08:33:45PM -0400, Steven Rostedt wrote:
> Hi Peter,
> 
> After looking at the code, I realized that the only possible way to do
> the "direct call" part, is if the direct function helper is executed
> there. All other ftrace_ops, will not call that path.
> 
> I added a trampoline that points to ftrace_regs_caller to the direct
> ftrace_ops, to force it never to allocate its own trampoline, and thus
> no created trampoline should ever do the jump for a direct caller.
> 
> By doing this, I was able to move the code around to be a bit simpler,
> and not need the double modifications (the double ret).
> 
> Of course, if any created trampoline were to touch the ORIG_RAX, then
> it would crash. We could always nop that compare in the created
> trampoline if that is a concern.
> 
> Anyway, I added the below patch on top of your patches and it appears
> to work. Thoughts?

So can I push out those patches as is? :-) We can do this on top I
suppose.

Firstly; your patch isn't objtool clean:

  arch/x86/kernel/ftrace_64.o: warning: objtool: ftrace_regs_caller()+0x199: sibling call from callable instruction with modified stack frame

So 10 points deduction for that :-). You got the RET_OFFSET hint on the
wrong sibling call.

Secondly, yes, that ORIG_RAX issue for copies, that _might_ crash and
burn, but who knows, you're jumping into uninitialized memory afaict. So
that definitely needs fixing. I'm also not sure of stubbing out the
test, that's actually more work than poking in the 1 extra ret and also
gives unexpected behaviour. If anything we should poke an UD2 at the 1:
location in the copy.

Over all, I'm thinking we should keep it as is. If you want to simplify
the poking we can do something like the below; reading a known retq is
daft.

---
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 867c126ddabe..b334adbacb0e 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -307,8 +307,6 @@ union ftrace_op_code_union {
 	} __attribute__((packed));
 };
 
-#define RET_SIZE		1
-
 static unsigned long
 create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 {
@@ -319,7 +317,6 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	unsigned long offset;
 	unsigned long npages;
 	unsigned long size;
-	unsigned long retq;
 	unsigned long *ptr;
 	void *trampoline;
 	void *ip;
@@ -347,11 +344,11 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	 * the iret , as well as the address of the ftrace_ops this
 	 * trampoline is used for.
 	 */
-	trampoline = alloc_tramp(size + RET_SIZE + sizeof(void *));
+	trampoline = alloc_tramp(size + RET_INSN_SIZE + sizeof(void *));
 	if (!trampoline)
 		return 0;
 
-	*tramp_size = size + RET_SIZE + sizeof(void *);
+	*tramp_size = size + RET_INSN_SIZE + sizeof(void *);
 	npages = DIV_ROUND_UP(*tramp_size, PAGE_SIZE);
 
 	/* Copy ftrace_caller onto the trampoline memory */
@@ -359,19 +356,13 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	if (WARN_ON(ret < 0))
 		goto fail;
 
-	ip = trampoline + size;
-
 	/* The trampoline ends with ret(q) */
-	retq = (unsigned long)ftrace_stub;
-	ret = probe_kernel_read(ip, (void *)retq, RET_SIZE);
-	if (WARN_ON(ret < 0))
-		goto fail;
+	ip = trampoline + size;
+	*(u8 *)ip = RET_INSN_OPCODE;
 
 	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
 		ip = trampoline + (ftrace_regs_caller_ret - ftrace_regs_caller);
-		ret = probe_kernel_read(ip, (void *)retq, RET_SIZE);
-		if (WARN_ON(ret < 0))
-			goto fail;
+		*(u8 *)ip = RET_INSN_OPCODE;
 	}
 
 	/*
@@ -382,7 +373,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	 * the global function_trace_op variable.
 	 */
 
-	ptr = (unsigned long *)(trampoline + size + RET_SIZE);
+	ptr = (unsigned long *)(trampoline + size + RET_INSN_SIZE);
 	*ptr = (unsigned long)ops;
 
 	op_offset -= start_offset;
