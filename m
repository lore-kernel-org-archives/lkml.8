Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2A3C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 740E82072A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EeqclIcM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgD1OPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:15:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56143 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727899AbgD1OPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588083307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NFbXtHTyHEyaaSu7Ifnn6u756qhZlAY5OEZBR4sIRJw=;
        b=EeqclIcMQMolv/Py2Q7cG8qb9Dv6b9J50LVt+33G6raSuuJg/ZE/kzYZhFfjlya2PFBuTo
        2f3JD5OmBVVvUX/cdaUofhb8OrDp5BzCIGtVZeNiRWFLwAz6CSzOlb195Pntu9W+vMXziD
        K6cXBx6PmGJ+fU0EqJt6wKOcfcZ1feA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-_TfdQzz5NlG6mmdrW38tEg-1; Tue, 28 Apr 2020 10:15:03 -0400
X-MC-Unique: _TfdQzz5NlG6mmdrW38tEg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB15B83DE6C;
        Tue, 28 Apr 2020 14:15:01 +0000 (UTC)
Received: from treble (ovpn-112-209.rdu2.redhat.com [10.10.112.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 56A0E611A9;
        Tue, 28 Apr 2020 14:14:59 +0000 (UTC)
Date:   Tue, 28 Apr 2020 09:14:57 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        alexandre.chartre@oracle.com
Subject: Re: x86 entry perf unwinding failure (missing IRET_REGS annotation
 on stack switch?)
Message-ID: <20200428141457.4il3bgjjhifs47zc@treble>
References: <CAG48ez1rkN0YU-ieBaUZDKFYG5XFnd7dhDjSDdRmVfWyQzsA5g@mail.gmail.com>
 <20200302151829.brlkedossh7qs47s@treble>
 <20200302155239.7ww7jfeu4yeevpkb@treble>
 <20200428070450.w5l5ey54dtmqy5ph@treble>
 <20200428124627.GC13558@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200428124627.GC13558@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 02:46:27PM +0200, Peter Zijlstra wrote:
> > I'm thinking something like this should fix it.  Peter, does this look
> > ok?
> 
> Unfortunate. But also, I fear, insufficient. Specifically consider
> things like:
> 
> 	ALTERNATIVE "jmp 1f",
> 		"alt...
> 		"..."
> 		"...insn", X86_FEAT_foo
> 	1:
> 
> This results in something like:
> 
> 
> 	.text	.altinstr_replacement
> 	e8 xx	...
> 	90
> 	90
> 	...
> 	90
> 
> Where all our normal single byte nops (0x90) are unreachable with
> undefined CFI, but the alternative might have CFI, which is never
> propagated.
> 
> We ran into this with the validate_alternative stuff from Alexandre.

I don't get what you're saying.  We decided not to allow CFI changes in
alternatives.  And how does this relate to my patch?

> > @@ -773,12 +772,26 @@ static int handle_group_alt(struct objtool_file *file,
> >  	struct instruction *last_orig_insn, *last_new_insn, *insn, *fake_jump = NULL;
> >  	unsigned long dest_off;
> >  
> > +	/*
> > +	 * For uaccess checking, propagate the STAC/CLAC from the alternative
> > +	 * to the original insn to avoid paths where we see the STAC but then
> > +	 * take the NOP instead of CLAC (and vice versa).
> > +	 */
> > +	if (!orig_insn->ignore_alts && orig_insn->type == INSN_NOP &&
> > +	    *new_insn &&
> > +	    ((*new_insn)->type == INSN_STAC ||
> > +	     (*new_insn)->type == INSN_CLAC))
> > +		orig_insn->type = (*new_insn)->type;
> 
> Also, this generates a mis-match between actual instruction text and
> type. We now have a single byte instruction (0x90) with the type of a 3
> byte (SLAC/CLAC). Which currently isn't a problem, but I'm looking at
> adding infrastructure for having objtool rewrite instructions.

But it doesn't actually change the original instruction bytes, it just
changes the decoding.  Is that really going to be a problem?  We do that
in other places as well, and it helps simplify code flow.

Also might I ask why you're going to be rewriting instructions?  That
sounds scary.

> So rather than hacking around this issue, should we not make
> create_orc() smarter?

Maybe, though I don't see how that logic belongs in create_orc().  It
might be tricky distinguishing between normal undefined and "undefined
because of a skip_orig".  Right now create_orc() is blissfully ignorant.

-- 
Josh

