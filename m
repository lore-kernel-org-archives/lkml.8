Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F1EC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3DD62063A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qODyZfuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgD1Qoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbgD1Qoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:44:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8720CC03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 09:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zrBJOFJiwcDTCQAO667u2UEYXqKj7UZ+ML/V6hT9SZE=; b=qODyZfuYPNciYuIAExBt+yszNt
        /qTblkFt5A+ze8gHNpOGKp3qZhj1A6ZdhSE5MlzfpozwCBF58Zi6PvNH/Onyf48X7t3ZKLMLqNZm4
        NqgfflNCj5+XPYzyb41F4jqhY1NLAKFNyES+3R+AzmE+yr+AGx0lEUTNXUMvUsOTc9/egYPpspG6X
        l9R3m5e1sob6hNnA4h93YgpULrTZCcZyXntgXnVh/ureEzsEbW7uerktjvgvsKho/0+zc6ihPWfJM
        //INgvPLw2qZiCnYcYFiDtgcyED92l6OHO2V52kK+wz6iZHZGYXb8VR/sCOnJwTEMOAZNeQGv69nJ
        Qal/Auwg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTTLi-0004nV-1L; Tue, 28 Apr 2020 16:44:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6D1CC30066E;
        Tue, 28 Apr 2020 18:44:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 58B9C201F9F0A; Tue, 28 Apr 2020 18:44:44 +0200 (CEST)
Date:   Tue, 28 Apr 2020 18:44:44 +0200
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
Message-ID: <20200428164444.GD16910@hirez.programming.kicks-ass.net>
References: <CAG48ez1rkN0YU-ieBaUZDKFYG5XFnd7dhDjSDdRmVfWyQzsA5g@mail.gmail.com>
 <20200302151829.brlkedossh7qs47s@treble>
 <20200302155239.7ww7jfeu4yeevpkb@treble>
 <20200428070450.w5l5ey54dtmqy5ph@treble>
 <20200428124627.GC13558@hirez.programming.kicks-ass.net>
 <20200428141614.GA13616@hirez.programming.kicks-ass.net>
 <20200428143157.nxxrgfpo3leia2kr@treble>
 <20200428152552.GD13592@hirez.programming.kicks-ass.net>
 <20200428154909.4cjwetyyb2zhnq5i@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428154909.4cjwetyyb2zhnq5i@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 10:49:09AM -0500, Josh Poimboeuf wrote:
> > @@ -2439,12 +2445,6 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
> >  
> >  	sec = insn->sec;
> >  
> > -	if (insn->alt_group && list_empty(&insn->alts)) {
> > -		WARN_FUNC("don't know how to handle branch to middle of alternative instruction group",
> > -			  sec, insn->offset);
> > -		return 1;
> > -	}
> > -
> 
> ACK (separate patch)
> 
> >  	while (1) {
> >  		next_insn = next_insn_same_sec(file, insn);
> >  

Yeah, there is one from Julien that does this:

  20200327152847.15294-6-jthierry@redhat.com

> > @@ -2494,8 +2494,16 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
> >  				}
> >  			}
> >  
> > -			if (skip_orig)
> > +			if (skip_orig) {
> > +				struct instruction *prev_insn = insn;
> > +				sec_for_each_insn_continue(file, insn) {
> > +					if (!insn->alt_group)
> > +						break;
> > +					if (!insn->visited)
> > +						insn->cfi = prev_insn->cfi;
> > +				}
> >  				return 0;
> > +			}
> 
> NACK :-)
> 
> What happens if you have two alternatives adjacent to each other (which
> can definitely happen in this scenario)?

Alexandre's alt_group would help:

  20200414103618.12657-3-alexandre.chartre@oracle.com

Then we can do something like:

static void fill_alternative(struct instruction *insn)
{
	struct instruction *first_insn = insn;
	int alt_group = insn->alt_group;

	sec_for_each_insn_continue(file, insn) {
		if (insn->alt_group != alt_group)
			break;
		if (!insn->visited)
			insn->cfi = first_insn->cfi;
	}
}

> I still like my patch, at least the hack is done before the validate
> code, so validate_branch() itself is simpler.

But it doesn't handle the case where the alternatives themselves have
unreachable holes in them, if that happens we'll generate spurious ORC
entries for them.

