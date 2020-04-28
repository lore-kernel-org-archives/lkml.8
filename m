Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64F6C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 804AF206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gDQqYNte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgD1Ofs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727827AbgD1Ofs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:35:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C911C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 07:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VFa9DkhkgJvi6Art6QlAvOF3Ikcmq9272DrVH/wHMWI=; b=gDQqYNteKWhX8NLR4U2IJV36T9
        yOV8dHeuF6D42w8rR/7/PcmY0VUQvQOExUhcCdL6iL0DMKhUiVQwJAY5p7EBveQpU08HDW8WeHnTV
        s/S+HgSq0lbEnMbyL+FLF0KTon70T5Si722ArCzs8DVsr2vEzMdLz6n/vUt4oPuA3o6GA15qqIRk0
        Ifxdn5ZAMVFr8wzki0PKRtqaf10wMGYXu+sH9833Xg+Ql8z1wQDPO52HgV1buHBdZE5pPFevpOcHA
        R5I04HE4sE47u8pzeWqdk7075YI4TSachf3XaKDwuZIJIeu/rw2xkGMqM4t9RsO9gWMQUiDPK7w/U
        MNepop5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTRKk-000088-LY; Tue, 28 Apr 2020 14:35:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C9A50304C22;
        Tue, 28 Apr 2020 16:35:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B5788203E9E21; Tue, 28 Apr 2020 16:35:36 +0200 (CEST)
Date:   Tue, 28 Apr 2020 16:35:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        alexandre.chartre@oracle.com
Subject: Re: x86 entry perf unwinding failure (missing IRET_REGS annotation
 on stack switch?)
Message-ID: <20200428143536.GC13592@hirez.programming.kicks-ass.net>
References: <CAG48ez1rkN0YU-ieBaUZDKFYG5XFnd7dhDjSDdRmVfWyQzsA5g@mail.gmail.com>
 <20200302151829.brlkedossh7qs47s@treble>
 <20200302155239.7ww7jfeu4yeevpkb@treble>
 <20200428070450.w5l5ey54dtmqy5ph@treble>
 <20200428124627.GC13558@hirez.programming.kicks-ass.net>
 <20200428141457.4il3bgjjhifs47zc@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428141457.4il3bgjjhifs47zc@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 09:14:57AM -0500, Josh Poimboeuf wrote:
> On Tue, Apr 28, 2020 at 02:46:27PM +0200, Peter Zijlstra wrote:
> > > I'm thinking something like this should fix it.  Peter, does this look
> > > ok?
> > 
> > Unfortunate. But also, I fear, insufficient. Specifically consider
> > things like:
> > 
> > 	ALTERNATIVE "jmp 1f",
> > 		"alt...
> > 		"..."
> > 		"...insn", X86_FEAT_foo
> > 	1:
> > 
> > This results in something like:
> > 
> > 
> > 	.text	.altinstr_replacement
> > 	e8 xx	...
> > 	90
> > 	90
> > 	...
> > 	90
> > 
> > Where all our normal single byte nops (0x90) are unreachable with
> > undefined CFI, but the alternative might have CFI, which is never
> > propagated.
> > 
> > We ran into this with the validate_alternative stuff from Alexandre.
> 
> I don't get what you're saying.  We decided not to allow CFI changes in
> alternatives.  And how does this relate to my patch?

Ah, I went with a slightly looser invariant rule that allows CFI but
ensures they're the same for all alternatives, and the above orig text
has a giant unreachable hole (that we don't report because NOP), I'm
allowing the alternative CFI changes in that.

Maybe that's too much leaway, but I'm thinking it ought to work.

> > > @@ -773,12 +772,26 @@ static int handle_group_alt(struct objtool_file *file,
> > >  	struct instruction *last_orig_insn, *last_new_insn, *insn, *fake_jump = NULL;
> > >  	unsigned long dest_off;
> > >  
> > > +	/*
> > > +	 * For uaccess checking, propagate the STAC/CLAC from the alternative
> > > +	 * to the original insn to avoid paths where we see the STAC but then
> > > +	 * take the NOP instead of CLAC (and vice versa).
> > > +	 */
> > > +	if (!orig_insn->ignore_alts && orig_insn->type == INSN_NOP &&
> > > +	    *new_insn &&
> > > +	    ((*new_insn)->type == INSN_STAC ||
> > > +	     (*new_insn)->type == INSN_CLAC))
> > > +		orig_insn->type = (*new_insn)->type;
> > 
> > Also, this generates a mis-match between actual instruction text and
> > type. We now have a single byte instruction (0x90) with the type of a 3
> > byte (SLAC/CLAC). Which currently isn't a problem, but I'm looking at
> > adding infrastructure for having objtool rewrite instructions.
> 
> But it doesn't actually change the original instruction bytes, it just
> changes the decoding.  Is that really going to be a problem?  We do that
> in other places as well, and it helps simplify code flow.

It will probably work just fine, it just feels off to me.

> Also might I ask why you're going to be rewriting instructions?  That
> sounds scary.

Variable length jump label support, I can't make gnu-as (I so hate that
thing) emit the right instruction at compile-time :/

> > So rather than hacking around this issue, should we not make
> > create_orc() smarter?
> 
> Maybe, though I don't see how that logic belongs in create_orc().  It
> might be tricky distinguishing between normal undefined and "undefined
> because of a skip_orig".  Right now create_orc() is blissfully ignorant.

Yeah, you're right. I'll look for a better place to stick it. Perhaps I
can frob it in validate_branch() somewhere.

And you're also right on the unreachable because of skip_orig thing,
I'll thnk about that.

