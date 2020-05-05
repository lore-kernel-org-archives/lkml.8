Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D34C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BF1E206CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OYaFBo53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgEES2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 14:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgEES2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 14:28:04 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473ABC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 11:28:04 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a5so1580578pjh.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 11:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+I2ZEpd9rMStG/cH8oLpZvbJxOrhOe7FbrS6Jy7iRQ=;
        b=OYaFBo53N41YL0p8SCOnpHV1R+tw5a4LhMXnIwzP8D//GJ5+IEOk9hpoI6oCV2xFQH
         aySgt3bd5dneynZzlv+x3i3O5HGCf0fnX+A5gDKvwsONyESp2jWCZVNylHzWQ7A+mzK+
         379MgLp8isot6kDWV4cqr0awdFFGm8nUN+Bze4Xf9FR85rM3jPva3qXM/t82rEj+jGwn
         KMmZOnanmFr2mArpfXKAFriAPjKGFAFMmA2N4zrLVfhFASq/xwn/d0E1V43tula3k7uD
         nYZ9m13pOTx7k/xuGFyBDaFrb5++habxqRx/12ky4kRH2P4/VgrWHvJFMlP5fM8HxHsR
         LsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+I2ZEpd9rMStG/cH8oLpZvbJxOrhOe7FbrS6Jy7iRQ=;
        b=eeNfFv//Z4AWEi9lhR197q0InvKNx+3QBQJp403S5FQN38JINBTu1COW8sQcAbw/eH
         LTnAobxPr9SePEiJKUZ9AqXU6tjbRU16msv4XZzqAqBklYGjWP6sf1MbTKKOar3+YG65
         stWoSg5RDQt64NiwerlE5xF3aAHqBJdxsZHYYQmKsK+tiP7sngogpn3r+jHLw5dcaD5t
         d1/T6az4jbddFeRYoU/js7XDWCjBHYxeUGYP1kJsxAldQbDfBoa4072H4TIlcuNWYrhQ
         vHif5NCCAYhYI3p0E3DLgkGjJPUYdO/IA6zda9E/gnI5FZhapcIraqUMS5gjGISpdkBh
         07lA==
X-Gm-Message-State: AGi0PuaNQ08nERmmLEVuofu5DpKJh0vYcG/2Rc3Ii4QE3gH8aHLlpFIE
        BUq9wiNNkB+SWafjr9P6NjFmTa88dpLH44Ea2/USKLvmAQ4=
X-Google-Smtp-Source: APiQypJ1QRZvnJwUKVMgH23rMrsqRdLI0q8UpwJckYydGWF5qT3qY2bI4VT9AXj4jo67L249SkRBVnWOFutezq1TZXM=
X-Received: by 2002:a17:90a:6488:: with SMTP id h8mr4710233pjj.51.1588703283513;
 Tue, 05 May 2020 11:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200501202849.647891881@infradead.org> <20200501202944.593400184@infradead.org>
 <1238787e-d97d-f09b-d76d-2df2dc273f4b@rasmusvillemoes.dk> <20200503125813.GL3762@hirez.programming.kicks-ass.net>
 <a53369f3-665a-af0e-efad-09ae456af847@rasmusvillemoes.dk> <20200504201445.GQ3762@hirez.programming.kicks-ass.net>
 <20200505093625.GE5298@hirez.programming.kicks-ass.net> <CAKwvOd=cP8UCX0+5pZ3AqzvOM8LKzLJJ_heDhrghqJdOnHoGMg@mail.gmail.com>
In-Reply-To: <CAKwvOd=cP8UCX0+5pZ3AqzvOM8LKzLJJ_heDhrghqJdOnHoGMg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 May 2020 11:27:53 -0700
Message-ID: <CAKwvOdkL+2Gvn2mkZ8cdHN=1F5cHQHii57ocD0RFeLJxEt=TUQ@mail.gmail.com>
Subject: Re: [PATCH v4 14/18] static_call: Add static_cond_call()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, bristot@redhat.com,
        Jason Baron <jbaron@akamai.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 11:13 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, May 5, 2020 at 2:36 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> >
> > HJ, Nick,
> >
> > Any chance any of you can see a way to make your respective compilers
> > not emit utter junk for this?
> >
> > On Mon, May 04, 2020 at 10:14:45PM +0200, Peter Zijlstra wrote:
> >
> > > https://godbolt.org/z/SDRG2q
>
> Woah, a godbolt link! Now we're speaking the same language.  What were
> you expecting? Us to remove the conditional check that a volatile read
> wasn't NULL? (Not using READ_ONCE, produces the direct tail call I
> suspect you're looking for, but am unsure if that's what you meant,
> and understand that's not a solution).  I am simultaneously impressed
> and disgusted by this btw, cool stuff.
>
> i.e.
> void *func = &name.func; \
> rather than
> void *func = READ_ONCE(name.func); \

Changing
void *func = READ_ONCE(name.func); \
to
void *func = &READ_ONCE(name.func); \
produces the tail call.  Not sure if that's relevant/what you were
looking for/even correct (haven't thought to hard about the
implications of that change; juggling other stuff ATM)

> (I'm surprised that `&name.func;` and `name.func;` also produce
> different results).
>
> > >
> > > ---
> > > #include <stddef.h>
> > >
> > >
> > > #define READ_ONCE(var)                (*((volatile typeof(var) *)&(var)))
> > > #define WRITE_ONCE(var, val)  (*((volatile typeof(var) *)&(var)) = (val))
> > >
> > > struct static_call_key {
> > >       void *func;
> > > };
> > >
> > > #define DECLARE_STATIC_CALL(name, func)       \
> > >       extern struct static_call_key name; \
> > >       extern typeof(func) __SCT__##name;
> > >
> > > #define DEFINE_STATIC_COND_CALL(name, _func) \
> > >       DECLARE_STATIC_CALL(name, _func) \
> > >       struct static_call_key name = { \
> > >               .func = NULL, \
> > >       }
> > >
> > > static void __static_call_nop(void)
> > > {
> > > }
> > >
> > > #define __static_cond_call(name) \
> > > ({ \
> > >       void *func = READ_ONCE(name.func); \
> > >       if (!func) \
> > >               func = &__static_call_nop; \
> > >       (typeof(__SCT__##name)*)func; \
> > > })
> > >
> > > #define static_cond_call(name) (void)__static_cond_call(name)
> > >
> > > static void inline static_call_update(struct static_call_key *call, void *func)
> > > {
> > >       WRITE_ONCE(call->func, func);
> > > }
> > >
> > > volatile int _x;
> > >
> > > void bar(int x)
> > > {
> > >       _x = x;
> > > }
> > >
> > > DEFINE_STATIC_COND_CALL(foo, bar);
> > >
> > > void ponies(int x)
> > > {
> > >       static_cond_call(foo)(x);
> > > }
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
