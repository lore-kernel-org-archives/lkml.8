Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54E2C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714C420838
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xfgkd61A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgCZM6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 08:58:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54408 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgCZM6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 08:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rzshhV1EjDPDvPwuwpPv01RlWStEAGE2W0F482FlNVY=; b=Xfgkd61Ar0SJFQUvCzwNipTe/1
        npsVLFsOZ5TtOuM8xwwGmhdYIX/wx1DNOfPAVNSsFQd5bPJnstIZgoGHRnjOQirgil7nQRJt8uznS
        oPcDm9Mi8x6cQfiVnddUdp9nbEnVOpbgqrnPYiSMPMKHyFtGkmodkH1Oy4ZTeXLBLYxDnwgS3RpPD
        KEBr3J6pbVXLCKyqKsMd16fbVFWTwIHhxn2UTJY/RuXTFY1n5mKn/puROvHX2jRuJbjqsxpbGN6O1
        yw1r50tjMtjw97UCM69l9w6R7RS0ydn8dfvuMqNqt+VAK0DIy3cYBiEdW40LoNirlpWc4dZsUjPhw
        UOJ18Hrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHS5u-0004G2-Sk; Thu, 26 Mar 2020 12:58:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BE1B13010C1;
        Thu, 26 Mar 2020 13:58:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AC9CE29965B27; Thu, 26 Mar 2020 13:58:44 +0100 (CET)
Date:   Thu, 26 Mar 2020 13:58:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz
Subject: Re: [PATCH v4 01/13] objtool: Remove CFI save/restore special case
Message-ID: <20200326125844.GD20760@hirez.programming.kicks-ass.net>
References: <20200325174525.772641599@infradead.org>
 <20200325174605.369570202@infradead.org>
 <20200326113049.GD20696@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326113049.GD20696@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 12:30:50PM +0100, Peter Zijlstra wrote:

> There is a special case in the UNWIND_HINT_RESTORE code. When, upon
> looking for the UNWIND_HINT_SAVE instruction to restore from, it finds
> the instruction hasn't been visited yet, it normally issues a WARN,
> except when this HINT_SAVE instruction is the first instruction of
> this branch.
> 
> The reason for this special case comes apparent when we remove it;
> code like:
> 
> 	if (cond) {
> 		UNWIND_HINT_SAVE
> 		// do stuff
> 		UNWIND_HINT_RESTORE
> 	}
> 	// more stuff
> 
> will now trigger the warning. This is because UNWIND_HINT_RESTORE is
> just a label, and there is nothing keeping it inside the (extended)
> basic block covered by @cond. It will attach itself to the first
> instruction of 'more stuff' and we'll hit it outside of the @cond,
> confusing things.
> 
> I don't much like this special case, it confuses things and will come
> apart horribly if/when the annotation needs to support nesting.
> Instead extend the affected code to at least form an extended basic
> block.
> 
> In particular, of the 2 users of this annotation: ftrace_regs_caller()
> and sync_core(), only the latter suffers this problem. Extend it's
> code sequence with a NOP to make it an extended basic block.
> 
> This isn't ideal either; stuffing code with NOPs just to make
> annotations work is certainly sub-optimal, but given that sync_core()
> is stupid expensive in any case, one extra nop isn't going to be a
> problem here.

So instr_begin() / instr_end() have this exact problem, but worse. Those
actually do nest and I've ran into the following situation:

	if (cond1) {
		instr_begin();
		// code1
		instr_end();
	}
	// code

	if (cond2) {
		instr_begin();
		// code2
		instr_end();
	}
	// tail

Where objtool then finds the path: !cond1, cond2, which ends up at code2
with 0, instead of 1.

I've also seen:

	if (cond) {
		instr_begin();
		// code1
		instr_end();
	}
	instr_begin();
	// code2
	instr_end();

Where instr_end() and instr_begin() merge onto the same instruction of
code2 as a 0, and again code2 will issue a false warning.

You can also not make objtool lift the end marker to the previous
instruction, because then:

	if (cond1) {
		instr_begin();
		if (cond2) {
			// code2
		}
		instr_end();
	}

Suffers the reverse problem, instr_end() becomes part of the @cond2
block and cond1 grows a path that misses it entirely.

So far I've not had any actual solution except adding a NOP to anchor
the annotation on.

