Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25271C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03789208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgDQMfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:35:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:33670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbgDQMfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:35:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 15185AC64;
        Fri, 17 Apr 2020 12:35:17 +0000 (UTC)
Date:   Fri, 17 Apr 2020 14:35:16 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        jthierry@redhat.com, alexandre.chartre@oracle.com
Subject: Re: [PATCH v5 02/17] objtool: Better handle IRET
In-Reply-To: <20200417122553.GD20730@hirez.programming.kicks-ass.net>
Message-ID: <alpine.LSU.2.21.2004171434280.7737@pobox.suse.cz>
References: <20200416114706.625340212@infradead.org> <20200416115118.631224674@infradead.org> <alpine.LSU.2.21.2004171326230.7737@pobox.suse.cz> <20200417122553.GD20730@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020, Peter Zijlstra wrote:

> On Fri, Apr 17, 2020 at 01:29:32PM +0200, Miroslav Benes wrote:
> > On Thu, 16 Apr 2020, Peter Zijlstra wrote:
> 
> > > +		case INSN_EXCEPTION_RETURN:
> > > +			if (handle_insn_ops(insn, &state))
> > > +				return 1;
> > > +
> > > +			/*
> > > +			 * This handles x86's sync_core() case, where we use an
> > > +			 * IRET to self. All 'normal' IRET instructions are in
> > > +			 * STT_NOTYPE entry symbols.
> > > +			 */
> > > +			if (func)
> > > +				break;
> > > +
> > > +			return 0;
> > > +
> > >  		case INSN_CONTEXT_SWITCH:
> > >  			if (func && (!next_insn || !next_insn->hint)) {
> > >  				WARN_FUNC("unsupported instruction in callable function",
> > 
> > It looks really simple.
> > 
> > Have you tried Julien's proposal about removing INSN_STACK altogether, 
> > move the x86 to arch/x86/ and call handle_insn_ops() unconditionally, or 
> > have you just postponed it? As I said, I think it could be better in the 
> > long term, but the above looks good for now as well.
> 
> If you look at this other set I send yesterday:
> 
>   https://lkml.kernel.org/r/20200416150752.569029800@infradead.org
> 
> (also, sorry for not adding you to the Cc; also best look at the gitweb
> version, the patches I send out are missing a hunk and lacking some
> back-merges.. clearly I wasn't having a good day yesterday).
> 
> it has this intra_function_calls crud that needs explicit conditional
> handle_insn_ops().

Ah, ok. Thanks for letting me know. There are so many patches for objtool 
flying around now that it is easy to miss something.

Miroslav
