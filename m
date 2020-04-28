Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912FEC83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C5F120787
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hdJ4RabN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgD1Mqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 08:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726620AbgD1Mqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:46:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445C1C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 05:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L8JvbmxT37GKwTzqU5jL14/ixMzFMoK2O4sEzKJ6fwA=; b=hdJ4RabNMW8wAaV1Y2dK7WXpLK
        kJnswvHWMJK929DoAy4hSj5e/RMCungqN9cXj//3PO6Mqi73mVQtFRCc4DrDUgZM/AF9AQyfh9xA7
        c5ph5v8nT1FhYLh4NviE4YcavWrQ/nr/wKnsHAI4RPU2In/5kU/kdJIguqwm04Q/4mL8HoOBfDu+k
        78bBdgJ6o0MVeVYdGhEGTp7xwDiMF3UWT6W8pyjE7WgjX6OSjOfGmTmsfuZhQ26BBPLdZzsSSCciM
        KVwYndM7pWppb45znZ/lWQK38TQOai8iF8ykofKbKCO5SxKqB8DFs9s5CRcP7Hit0JrkBmo/KkRYp
        UG0GmpVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTPdA-00009U-Ds; Tue, 28 Apr 2020 12:46:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0C15430477A;
        Tue, 28 Apr 2020 14:46:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6992B286AD5E1; Tue, 28 Apr 2020 14:46:27 +0200 (CEST)
Date:   Tue, 28 Apr 2020 14:46:27 +0200
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
Message-ID: <20200428124627.GC13558@hirez.programming.kicks-ass.net>
References: <CAG48ez1rkN0YU-ieBaUZDKFYG5XFnd7dhDjSDdRmVfWyQzsA5g@mail.gmail.com>
 <20200302151829.brlkedossh7qs47s@treble>
 <20200302155239.7ww7jfeu4yeevpkb@treble>
 <20200428070450.w5l5ey54dtmqy5ph@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428070450.w5l5ey54dtmqy5ph@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 02:04:50AM -0500, Josh Poimboeuf wrote:
> On Mon, Mar 02, 2020 at 09:52:40AM -0600, Josh Poimboeuf wrote:
> > On Mon, Mar 02, 2020 at 09:18:29AM -0600, Josh Poimboeuf wrote:
> > > > So I think on machines without X86_FEATURE_SMAP, trying to unwind from
> > > > the two NOPs at f41 and f42 will cause the unwinder to report an
> > > > error? Looking at unwind_next_frame(), "sp:(und)" without the "end:1"
> > > > marker seems to be reserved for errors.
> > 
> > I think we can blame this one on Peter ;-)
> > 
> >   764eef4b109a ("objtool: Rewrite alt->skip_orig")
> > 
> > With X86_FEATURE_SMAP, alt->skip_orig gets set, which tells objtool to
> > skip validation of the NOPs.  That has the side effect of not
> > propagating the ORC state to the NOPs as well.
> 
> I almost forgot about this one, until I rediscovered it just now...
> Peter, I just realized you weren't CCed on the original email, oops.

Nah, I got them (through x86@); but I too lost track of it :/

> I'm thinking something like this should fix it.  Peter, does this look
> ok?

Unfortunate. But also, I fear, insufficient. Specifically consider
things like:

	ALTERNATIVE "jmp 1f",
		"alt...
		"..."
		"...insn", X86_FEAT_foo
	1:

This results in something like:


	.text	.altinstr_replacement
	e8 xx	...
	90
	90
	...
	90

Where all our normal single byte nops (0x90) are unreachable with
undefined CFI, but the alternative might have CFI, which is never
propagated.

We ran into this with the validate_alternative stuff from Alexandre.

> @@ -773,12 +772,26 @@ static int handle_group_alt(struct objtool_file *file,
>  	struct instruction *last_orig_insn, *last_new_insn, *insn, *fake_jump = NULL;
>  	unsigned long dest_off;
>  
> +	/*
> +	 * For uaccess checking, propagate the STAC/CLAC from the alternative
> +	 * to the original insn to avoid paths where we see the STAC but then
> +	 * take the NOP instead of CLAC (and vice versa).
> +	 */
> +	if (!orig_insn->ignore_alts && orig_insn->type == INSN_NOP &&
> +	    *new_insn &&
> +	    ((*new_insn)->type == INSN_STAC ||
> +	     (*new_insn)->type == INSN_CLAC))
> +		orig_insn->type = (*new_insn)->type;

Also, this generates a mis-match between actual instruction text and
type. We now have a single byte instruction (0x90) with the type of a 3
byte (SLAC/CLAC). Which currently isn't a problem, but I'm looking at
adding infrastructure for having objtool rewrite instructions.

So rather than hacking around this issue, should we not make
create_orc() smarter?

I'm trying to come up with something, but so far I'm just making a mess.
