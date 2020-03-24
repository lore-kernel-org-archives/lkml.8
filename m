Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B6CC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 23:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDE820722
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 23:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ECfvU7LQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgCXXAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 19:00:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58884 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbgCXXAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 19:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lMLZN4KAtuo1ufR/sSTZ/YTJGpv+xv3ZRVB8FGX/yGk=; b=ECfvU7LQJ3/ad+P0qhTKIOpSSi
        tkgUQF/eQ0lskX/01cd8rVtNyqNM07qHca0y8evXPdEFaNgGjpDNJi6qRQGF28eAtM1ykh3eicez6
        W9Sl/Y5Sn4QV5jQJhpXEPR+dP97C943JtE5gRv1WZ3VmCVX2nDDWhgwdWLx8bLucn4lbj4mWBBey6
        jLO35EvVmF1+vHhPK8k4eTvgNjnEe3WysV+GjuCkptI8N0Xes6TgZcn8QYrh9ALoYi2jTHHpisR7R
        y3rnvBzwJfDJMRyTx63SATwbiWAUgUMqKgXj1rascF5kk8cWin2x1Yzx/6mn4581ah5lwkuUlgNAV
        zRyMiRTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGsWq-0000bH-U8; Tue, 24 Mar 2020 23:00:13 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C9A83980EBD; Wed, 25 Mar 2020 00:00:10 +0100 (CET)
Date:   Wed, 25 Mar 2020 00:00:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [PATCH v3 18/26] objtool: Fix !CFI insn_state propagation
Message-ID: <20200324230010.GW2452@worktop.programming.kicks-ass.net>
References: <20200324153113.098167666@infradead.org>
 <20200324160924.987489248@infradead.org>
 <20200324214006.tlanaff5q6gkgk2a@treble>
 <20200324221109.GU2452@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324221109.GU2452@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 11:11:09PM +0100, Peter Zijlstra wrote:
> On Tue, Mar 24, 2020 at 04:40:06PM -0500, Josh Poimboeuf wrote:
> > On Tue, Mar 24, 2020 at 04:31:31PM +0100, Peter Zijlstra wrote:
> 
> > > +		if (!save_insn->visited) {
> > > +			/*
> > > +			 * Oops, no state to copy yet.
> > > +			 * Hopefully we can reach this
> > > +			 * instruction from another branch
> > > +			 * after the save insn has been
> > > +			 * visited.
> > > +			 */
> > > +			if (insn == first)
> > > +				return 0; // XXX
> > 
> > Yeah, moving this code out to apply_insn_hint() seems like a nice idea,
> > but it wouldn't be worth it if it breaks this case.  TBH I don't
> > remember if this check was for a real-world case.  Might be worth
> > looking at...  If this case doesn't exist in reality then we could just
> > remove this check altogether.
> 
> I'll go run a bunch of builds with a print on it, that should tell us I
> suppose.

I can a bunch of builds, including an allmodconfig with the below on top
and it 'works'.

So I suppose we can remove this special case.

---
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2134,11 +2134,13 @@ static int apply_insn_hint(struct objtoo
 			 * after the save insn has been
 			 * visited.
 			 */
-			if (insn == first)
-				return 0; // XXX

 			WARN_FUNC("objtool isn't smart enough to handle this CFI save/restore combo",
 					sec, insn->offset);
+
+			if (insn == first)
+				return -1;
+
 			return 1;
 		}


