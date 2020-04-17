Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C1EC38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 23:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56D7C214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 23:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587167682;
	bh=HCzVg03ezNfJiW+a3f3XOrfTSBBCxCngM+8lnNBq6VA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KjoCVXyHcX2rIQC0x4rseIty6SX342Ckjuocc3U7HQI//IM1B0S3brwDgIdrqQx7Y
	 acdsuy/3Gpumr3LUBragJRBfs6JPZ9sVhBuoW8OzfT20S/QgmNPm8R5IIFs9zCu9ts
	 3RDmUWiY6fnTZ2Vol3hLhdi7w6raIiGgztWcidZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgDQXyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 19:54:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgDQXxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 19:53:45 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B280F2223D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 23:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587167625;
        bh=HCzVg03ezNfJiW+a3f3XOrfTSBBCxCngM+8lnNBq6VA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mTuWbjHW3YL24GlxCamLX3PPmACoo9riYOzuPAZcPOOMQJNSumyN46EcA7fpSSehI
         uTeGJOqsJIJOsJ6TqWUgk78buz9Eh1KU4qybmEkasGqG5SOSDrI52ix/uToMbrefH6
         kIeDwc7jFF9pJ4s73+L3wCCu5gRs0snWhkR5Jn58=
Received: by mail-wm1-f48.google.com with SMTP id z6so4732470wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 16:53:44 -0700 (PDT)
X-Gm-Message-State: AGi0Puat6Ul8FAeviu5Aji6kjBh+c3AloyEXii+kj0XvqgNSyB9Xlpma
        bZG6WpGvf4jv46mbKbQoTligPN6S/CCZFVgq6PSSmA==
X-Google-Smtp-Source: APiQypIS7QxD3bx2ErLcQa1gY0k6A9DeUxB6NhiSPoI1iiosTI3B/lKTmQvqf3m7jgtWF738MJHrEX4ZXr2dI2DiWlg=
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr5507982wmk.36.1587167623061;
 Fri, 17 Apr 2020 16:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200416114706.625340212@infradead.org> <20200416115118.631224674@infradead.org>
 <8692ee18-e553-6f90-5291-62d6d57407cd@oracle.com> <20200417182339.GJ20730@hirez.programming.kicks-ass.net>
In-Reply-To: <20200417182339.GJ20730@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 17 Apr 2020 16:53:31 -0700
X-Gmail-Original-Message-ID: <CALCETrU58muwSVDstRJQGEn20aOOHFctzZkxHRGh-yEGR9x1VA@mail.gmail.com>
Message-ID: <CALCETrU58muwSVDstRJQGEn20aOOHFctzZkxHRGh-yEGR9x1VA@mail.gmail.com>
Subject: Re: [PATCH v5 02/17] objtool: Better handle IRET
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, jthierry@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 11:23 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Apr 17, 2020 at 07:37:32PM +0200, Alexandre Chartre wrote:
> > > @@ -2243,6 +2232,20 @@ static int validate_branch(struct objtoo
> > >                     break;
> > > +           case INSN_EXCEPTION_RETURN:
> > > +                   if (handle_insn_ops(insn, &state))
> > > +                           return 1;
> >
> > Do we need to update the stack state for normal IRET? This wasn't done before.
> > So shouldn't this better be:
> >
> >                case INSN_EXCEPTION_RETURN:
> >                         if (!func)
> >                                 return 0;
> >
> >                         if (handle_insn_ops(insn, &state))
> >                                 return 1;
> >
> >                         break;
>
> Well, I was going to do the unconditional handle_insn_ops(), like
> mentioned, but then that intra_function_call thing spoiled it.
>
> It doesn't matter though; STT_NOTYPE doesn't care.
>
> > > +
> > > +                   /*
> > > +                    * This handles x86's sync_core() case, where we use an
> > > +                    * IRET to self. All 'normal' IRET instructions are in
> > > +                    * STT_NOTYPE entry symbols.
> > > +                    */
> > > +                   if (func)
> > > +                           break;
> >
> > Is it worth checking that func->name is effectively "sync_core"?
>
> It's an inline..

I'm wondering if this would be easier if we just moved the guts of
sync_core() into asm.

In the near future, I think we want to rework it a tiny bit.  In
particular, I think we're going to want to make sync_core() do:

if (static_cpu_has(X86_FEATURE_SERIALIZE))
  asm volatile ("serialize");
else
  iret_to_self();

where iret_to_self() is the meat of the IRET hack.  And then we're
going to add a new thingy unmask_nmi() that does iret_to_self() on
everything except SEV-ES.  The near-term motivation is that I think we
have some genuine bugs in a couple of corner cases:

1. On AMD chips, if NMI hits user code with invalid CS or SS, we will
enter on the NMI stack, switch to the normal stack, and return with
IRET, and the IRET will fail.  And then we end up in a nasty state in
which NMIs are masked but the code path we run doesn't expect that.
So we should unmask_nmi() in fixup_bad_iret() or similar.  Intel CPUs
are unaffected because Intel is differently quirky.

2.  do_nmi() does this:

    if (user_mode(regs))
                mds_user_clear_cpu_buffers();

because it can't safely call prepare_exit_to_usermode().  This is a
gross wart and I'd like to fix it.  Fixing it involves teaching the
relevant code paths to unmask_nmis() if they're going to so IRQs-on
exit work.

None of this is really relevant to the current patch, but it wouldn't
be unreasonable to turn the IRET thing from an inline asm into a real
asm function if it makes objtool's life easier.
