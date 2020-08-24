Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9E7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 23:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C6A920702
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 23:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598310437;
	bh=90BfEjdiMrtlDa4DBW3PBXhuytcYEiPRAbpvhXIqae4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2eB/KVMqZE0neNuHmVVXWztr9vWrTojSVkzusZEDzCCqCRyoBhWaERb2BiiG1evhl
	 l4BKFV2akzFAffy/q4Nej9E5ZauRZ31wUw+Nzy8C0jaaJTDQ+1y9/dUMW2t6Kblywt
	 fuB0dV4dJH5loj8kMzkRAg/JsoyIPr9hViB0N7H0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgHXXHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 19:07:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbgHXXHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 19:07:15 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F4AC20FC3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 23:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598310434;
        bh=90BfEjdiMrtlDa4DBW3PBXhuytcYEiPRAbpvhXIqae4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iAjMnS8GokQTjLc7DbFIaf9eYpT5w2r0qI14B19MeCyC5D27Njr0yyPhUHKALj4P2
         n/BZKqvbAqrfWuAcdFRW8ul7Le4u3SSXJhVkgRouOiNVO0sQcx6YmpByBJTWMJLyE4
         s7/gzQeknzFWvQ2LYRo0INoJJUFXSp6HEpvb4Bjw=
Received: by mail-wr1-f51.google.com with SMTP id c15so10734527wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 16:07:14 -0700 (PDT)
X-Gm-Message-State: AOAM531OSz+p1XDYfhrtAcmqw2Fht7yk+J3HE51N6DZ5QWvIxNpn+dsZ
        kmGd7SuZrZtRVVIXzv0DGP1AlvC3+4n4rZT0PHD/zQ==
X-Google-Smtp-Source: ABdhPJwwYaE+TsvY/c3hAWoRzy3wtBeWWELu9cTnTPA8gCjM79Q/8FfH7T0sAZ+exG8z6Dmfky4KBJBnVahbZmLrJA8=
X-Received: by 2002:adf:9283:: with SMTP id 3mr7662694wrn.70.1598310433154;
 Mon, 24 Aug 2020 16:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200821093912.815135402@infradead.org> <20200821102053.034965283@infradead.org>
 <CALCETrVBB3YNCqCQ6bFBrSM10OTe354zyh=WbPFaEBxK1_Sa7g@mail.gmail.com>
 <20200824110501.GT1362448@hirez.programming.kicks-ass.net> <b5ff8a44-1039-645c-de3e-d5f085cbc3f0@citrix.com>
In-Reply-To: <b5ff8a44-1039-645c-de3e-d5f085cbc3f0@citrix.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 24 Aug 2020 16:07:00 -0700
X-Gmail-Original-Message-ID: <CALCETrU3ZaymEiCPZWE8fcWOWoWPW_ZyigiHnBZL559pJiWmEQ@mail.gmail.com>
Message-ID: <CALCETrU3ZaymEiCPZWE8fcWOWoWPW_ZyigiHnBZL559pJiWmEQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] x86/debug: Simplify #DB signal code
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 4:26 AM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>
> On 24/08/2020 12:05, peterz@infradead.org wrote:
> > On Sun, Aug 23, 2020 at 04:09:42PM -0700, Andy Lutomirski wrote:
> >> On Fri, Aug 21, 2020 at 3:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >>> Get rid of the two variables, avoid computing si_code when not needed
> >>> and be consistent about which dr6 value is used.
> >>>
> >>> -       if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
> >>> -               send_sigtrap(regs, 0, si_code);
> >>> +       /*
> >>> +        * If dr6 has no reason to give us about the origin of this trap,
> >>> +        * then it's very likely the result of an icebp/int01 trap.
> >>> +        * User wants a sigtrap for that.
> >>> +        */
> >>> +       if (dr6 & (DR_STEP | DR_TRAP_BITS) || !dr6)
> >>> +               send_sigtrap(regs, 0, get_si_code(dr6));
> >> The old condition was ... || (actual DR6 value) and the new condition
> >> was ... || (stupid notifier-modified DR6 value).  I think the old code
> >> was more correct.
> > Hurmph.. /me goes re-read the SDM.
> >
> > INT1 is a trap,
> > instruction breakpoint is a fault
> >
> > So if you have:
> >
> >       INT1
> > 1:    some-instr
> >
> > and set an X breakpoint on 1, we'll loose the INT1, right?
>
> You should get two.  First with a dr6 of 0 (ICEBP, RIP pointing at 1:),
> and a second with dr6 indicating the X breakpoint (again, RIP pointing
> at 1:).
>
> SDM Vol3 6.9 PRIORITY AMONG SIMULTANEOUS EXCEPTIONS AND INTERRUPTS
>
> Traps on previous instructions are at priority 4, because they still
> "part" of the previous instruction.  X breakpoints are priority 7.
>
> The two #DB's shouldn't merge because nothing inhibits delivery[1] of
> the trap at priority 4, and on return from the handler, RF isn't set so
> the instruction breakpoint will trigger.
>

I think that the whole "priority among simultaneous exceptions and
interrupts" section is largely BS.  An instruction that traps will
deliver the exception when it finishes executing unless some other
event prevents the instruction from retiring or unless some other trap
preempts it.  This will happen before the following instruction is
decoded, let alone before any possible faults from its execution will
occur.


Correct me if I'm wrong, but I don't think I am.
