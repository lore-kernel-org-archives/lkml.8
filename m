Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E693FC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC0920714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m1JsAm3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgCZPiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:38:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53996 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbgCZPiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 11:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9IAWjcoP6+ERSckz5iuIrOnb3X08KTh1mZKMyBXeW10=; b=m1JsAm3+bBhUPZBW/rd2/xi5ce
        njdfT0jwvgZDLuW8YI4yzjSSssvV497BLlCJlMq+YDgkA+KNJo375sGUgaMvjM7bnP8At+AWWGx7H
        m8rvr6kdENsSJ4ew71fNBT2TVyhjR8jwHSBgjxcIo2LJc47PwiJNgWNytm0F4+ueVxhze4B7Knr5U
        UiyPDgaB11wa8kCU6Vi6kaXLEEfAYD0XBsuodXKEDRxo44Sdao8tGB9/HUp98Os9UU3MQlNAD1Hfe
        4GEnhZvzSuvIyaNg6Fywi7ujVywEasRvw2ork3zUF2KfStIb+KuuCeyDsa3BCxQbPl+gdPym6mDmk
        xKKdpxOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHUak-0004bT-3w; Thu, 26 Mar 2020 15:38:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 513143010C1;
        Thu, 26 Mar 2020 16:38:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E947B205866AC; Thu, 26 Mar 2020 16:38:41 +0100 (CET)
Date:   Thu, 26 Mar 2020 16:38:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz
Subject: Re: [PATCH v4 01/13] objtool: Remove CFI save/restore special case
Message-ID: <20200326153841.GN20713@hirez.programming.kicks-ass.net>
References: <20200325174525.772641599@infradead.org>
 <20200325174605.369570202@infradead.org>
 <20200326113049.GD20696@hirez.programming.kicks-ass.net>
 <20200326125844.GD20760@hirez.programming.kicks-ass.net>
 <20200326134448.5zci3ikdlf5ar2w5@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326134448.5zci3ikdlf5ar2w5@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 08:44:48AM -0500, Josh Poimboeuf wrote:
> On Thu, Mar 26, 2020 at 01:58:44PM +0100, Peter Zijlstra wrote:
> > So instr_begin() / instr_end() have this exact problem, but worse. Those
> > actually do nest and I've ran into the following situation:
> > 
> > 	if (cond1) {
> > 		instr_begin();
> > 		// code1
> > 		instr_end();
> > 	}
> > 	// code
> > 
> > 	if (cond2) {
> > 		instr_begin();
> > 		// code2
> > 		instr_end();
> > 	}
> > 	// tail
> > 
> > Where objtool then finds the path: !cond1, cond2, which ends up at code2
> > with 0, instead of 1.
> 
> Hm, I don't see the nesting in this example, can you clarify?

Indeed no nesting here, but because they can nest we have that begin as
+1, end as -1 and then we sum it over the code flow.

Then given that, the above, ends up as -1 + 1 in the !cond1,cond2 case,
because that -1 escapes the cond1 block.

> > I've also seen:
> > 
> > 	if (cond) {
> > 		instr_begin();
> > 		// code1
> > 		instr_end();
> > 	}
> > 	instr_begin();
> > 	// code2
> > 	instr_end();
> > 
> > Where instr_end() and instr_begin() merge onto the same instruction of
> > code2 as a 0, and again code2 will issue a false warning.
> > 
> > You can also not make objtool lift the end marker to the previous
> > instruction, because then:
> > 
> > 	if (cond1) {
> > 		instr_begin();
> > 		if (cond2) {
> > 			// code2
> > 		}
> > 		instr_end();
> > 	}
> > 
> > Suffers the reverse problem, instr_end() becomes part of the @cond2
> > block and cond1 grows a path that misses it entirely.
> > 
> > So far I've not had any actual solution except adding a NOP to anchor
> > the annotation on.
> 
> Are you adding the NOP to the instr_end() annotation itself?  Seems like
> that would be the cleanest/easiest.

That actually generates a whole bunch of 'stupid' unreachable warnings.
Also, in the hope of still coming up with something saner, we've been
carrying a minimal set of explicit nop()s.

> Though it is sad that we have to change the code to make objtool happy
> -- would be nice if we could come up with something less intrusive.

Very much yes, but so far that's been eluding me.
