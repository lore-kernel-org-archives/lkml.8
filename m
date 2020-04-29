Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0BBC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF3A20787
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgD2Qlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:41:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:53460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbgD2Qli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:41:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 361E1AC69;
        Wed, 29 Apr 2020 16:41:36 +0000 (UTC)
Date:   Wed, 29 Apr 2020 18:41:36 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     jpoimboe@redhat.com, alexandre.chartre@oracle.com,
        linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 02/14] objtool: Fix ORC vs alternatives
In-Reply-To: <20200429155109.GN13592@hirez.programming.kicks-ass.net>
Message-ID: <alpine.LSU.2.21.2004291840340.3662@pobox.suse.cz>
References: <20200428191101.886208539@infradead.org> <20200428191659.499074346@infradead.org> <alpine.LSU.2.21.2004291622160.28992@pobox.suse.cz> <20200429155109.GN13592@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020, Peter Zijlstra wrote:

> On Wed, Apr 29, 2020 at 04:33:31PM +0200, Miroslav Benes wrote:
> > On Tue, 28 Apr 2020, Peter Zijlstra wrote:
> > >  /*
> > > + * Alternatives should not contain any ORC entries, this in turn means they
> > > + * should not contain any CFI ops, which implies all instructions should have
> > > + * the same same CFI state.
> > > + *
> > > + * It is possible to constuct alternatives that have unreachable holes that go
> > > + * unreported (because they're NOPs), such holes would result in CFI_UNDEFINED
> > > + * states which then results in ORC entries, which we just said we didn't want.
> > > + *
> > > + * Avoid them by copying the CFI entry of the first instruction into the whole
> > > + * alternative.
> > > + */
> > > +static void fill_alternative_cfi(struct objtool_file *file, struct instruction *insn)
> > > +{
> > > +	struct instruction *first_insn = insn;
> > > +	int alt_group = insn->alt_group;
> > > +
> > > +	sec_for_each_insn_continue(file, insn) {
> > > +		if (insn->alt_group != alt_group)
> > > +			break;
> > > +		insn->cfi = first_insn->cfi;
> > > +	}
> > > +}
> > 
> > If I am reading this and previous patch correctly...
> > 
> > The function would copy cfi only to "orig" alternative (its insn->alts is 
> > non-empty, orig_insn->alt_group differs from new_insn->alt_group), right? 
> 
> Yes.
> 
> > Would it make sense to do the same for "new" alternative, because of the 
> > invariant? It seems to me it is not processed anywhere that way.
> 
> No.
> 
> > Am I missing something? Whenever I try to read all this alternatives 
> > handling in objtool, I get lost pretty soon.
> 
> We only care about the ORC covering the original range, because that is
> the range we execute code from. The memory where we store the
> alternative instructions (.altinstruction section) is never executed,
> that is, RIP should never point there, so we don't need ORC data covering
> it.

Aha, that's what I didn't realize (again). Note to myself (for the 
hundredth time): alternatives are not branches.

Thanks
Miroslav
