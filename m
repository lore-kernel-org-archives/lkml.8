Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDECC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 11:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3957F207D3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 11:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JRQAvggw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgFDL2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 07:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgFDL2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 07:28:36 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B652DC03E96D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 04:28:36 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id k4so3205688oik.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 04:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Wd046SRnNXPmZWQmANFyPx5YHXn43TLrkGNrhSkVE8=;
        b=JRQAvggwV7UK6Wmv4DmQ7rzLvxk57dmHOgqKdYcFw2opwBGdjNtGFjTBgn5xGnyiqP
         LSNiAQI+VjyIQ4T6T5ZWWuF+JcY9y97ONqr/2Z6rw8cHOgpSGqOudKTME+I2pePJ8RcZ
         HV0+2V40T9QKfppMa2YnFGZ1f1XQkshE/lQyT9bD0OrD8aNanwlsHnvIG102Fk7cx/06
         kav3V9A1YAEAAmkO1z+/HNY2PkcC+7gQ2a2LAKVZ5wBFn889iBwcan71GS3AlVwj6C8P
         zyLrRK7De6QD7KbRfFQImnFEwqCVNj7wwvYD0uVRlNZqEAPIiUKQLcrwWXqN4gfS98Lk
         nxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Wd046SRnNXPmZWQmANFyPx5YHXn43TLrkGNrhSkVE8=;
        b=A+Doj21cLsfZs+yrTj8itrRzJnoMCyDjh2ToZlB6ApRYQ1IIjT7WjX3hiDq5TH89K9
         ib3e/MurYKOE1X2yFF/4iWqKdr0gjtygISuLZ+EKjwY28aX2Z7pOuLJYPGm6EocpCrRH
         +nz9liKtK6EIrMoLsPW1HjR5+Uw7MaDrbA/rHl6aWwB1xWp6JrFkUFERtDiskGdX4AWO
         Y+0vZi7w8713HYi/gKWS1mKBJVLpYVy1KcsPVr8ciM6faSwt6xeU7XiJ/zdNTZWkngYs
         LhkVx7PaoiNeKg/BF1lJbxtzMw+177afUN+LWxvSIm1lKujzOlYKjmwbhwcrCkqS6HB2
         AdpA==
X-Gm-Message-State: AOAM53292s09u6DVbfu5tJVH2aqxNpZpd5lJ8Be49U1754CiLP9d+hDk
        tv9ccDQjuGuPVHR9uezh4+9yknFV2qRHtm4aPGUMow==
X-Google-Smtp-Source: ABdhPJyuy8+hU7ZIqj63O2jWh3VmSyv222QPXEwL6/Td7CfrbAbiw5bj4q1XgzUuWKC0KDSQmL6FoGQxSkIx2+y4kP0=
X-Received: by 2002:a05:6808:3ac:: with SMTP id n12mr2720496oie.172.1591270115850;
 Thu, 04 Jun 2020 04:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200604095057.259452-1-elver@google.com> <20200604110918.GA2750@hirez.programming.kicks-ass.net>
In-Reply-To: <20200604110918.GA2750@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Thu, 4 Jun 2020 13:28:24 +0200
Message-ID: <CANpmjNPgqjZaz9R9dq_4xiRShcFTX0APyqfsX1JhBZo9ON-kCg@mail.gmail.com>
Subject: Re: [PATCH -tip] kcov: Make runtime functions noinstr-compatible
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jun 2020 at 13:09, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jun 04, 2020 at 11:50:57AM +0200, Marco Elver wrote:
> > The KCOV runtime is very minimal, only updating a field in 'current',
> > and none of __sanitizer_cov-functions generates reports nor calls any
> > other external functions.
>
> Not quite true; it writes to t->kcov_area, and we need to make
> absolutely sure that doesn't take faults or triggers anything else
> untowards.

Ah, right.

> > Therefore we can make the KCOV runtime noinstr-compatible by:
> >
> >   1. always-inlining internal functions and marking
> >      __sanitizer_cov-functions noinstr. The function write_comp_data() is
> >      now guaranteed to be inlined into __sanitize_cov_trace_*cmp()
> >      functions, which saves a call in the fast-path and reduces stack
> >      pressure due to the first argument being a constant.
> >
> >   2. For Clang, correctly pass -fno-stack-protector via a separate
> >      cc-option, as -fno-conserve-stack does not exist on Clang.
> >
> > The major benefit compared to adding another attribute to 'noinstr' to
> > not collect coverage information, is that we retain coverage visibility
> > in noinstr functions. We also currently lack such an attribute in both
> > GCC and Clang.
> >
>
> > -static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
> > +static __always_inline void write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
> >  {
> >       struct task_struct *t;
> >       u64 *area;
> > @@ -231,59 +231,59 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
> >       }
> >  }
>
> This thing; that appears to be the meat of it, right?
>
> I can't find where t->kcov_area comes from.. is that always
> kcov_mmap()'s vmalloc_user() ?

Yeah, looks like it.

> That whole kcov_remote stuff confuses me.
>
> KCOV_ENABLE() has kcov_fault_in_area(), which supposedly takes the
> vmalloc faults for the current task, but who does it for the remote?
>
> Now, luckily Joerg went and ripped out the vmalloc faults, let me check
> where those patches are... w00t, they're upstream in this merge window.
>
> So no #PF from writing to t->kcov_area then, under the assumption that
> the vmalloc_user() is the only allocation site.
>
> But then there's hardware watchpoints, if someone goes and sets a data
> watchpoint in the kcov_area we're screwed. Nothing actively prevents
> that from happening. Then again, the same is currently true for much of
> current :/
>
> Also, I think you need __always_inline on kaslr_offset()
>
>
> And, unrelated to this patch in specific, I suppose I'm going to have to
> extend objtool to look for data that is used from noinstr, to make sure
> we exclude it from inspection and stuff, like that kaslr offset crud for
> example.
>
> Anyway, yes, it appears you're lucky (for having Joerg remove vmalloc
> faults) and this mostly should work as is.

Hmm, looks like this doesn't generally work then. :-/

An alternative would be to check if '__noinstr_text_start <= _RET_IP_
< __noinstr_text_end' in __sanitizer_cov-functions and return if
that's the case. This could be #ifdef'd when we get a compiler that
can do __no_sanitize_coverage. At least that way we get working KCOV
for now.

Would that work?

Thanks,
-- Marco
