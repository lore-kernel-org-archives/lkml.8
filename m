Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B514FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F7BD2076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dadYrfXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgFHH5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 03:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgFHH5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 03:57:53 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EB9C08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 00:57:52 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c14so16350032qka.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 00:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UXDknJ6zk2gEs3+RNn5uknA1R62+oU40etEr62atLbs=;
        b=dadYrfXctdZXXvapuXj+z3cinY1S6ogyDHMW5SaDpeBjD0VqWPKYsmgdpfs8zLeHeO
         lnkuNSlOdDAhUxDCTpcQ5k+ACVeRqSy1JtxCzECiVTlWLGu6Fy4YrpEXoujkXEPAghZ4
         aHF84C72mxodftflHvuTgkfPwWpkVHtFAE2lQgOkKNOZXkOO6++uFYBGDNkkP30c+IMG
         MvKbIF3qqHF+Hi8qZTi1Cx60OxQbwMTpKKj6WM7KqwWNbwAUU/4RiwD6z+ypp4pVGGEO
         KXTJIr4zr/048nVh/eavcAjWk2wd2NiKPtmyKjFEdX+nR5bJg2OJJ+xD60bpWtbLxaPQ
         u0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UXDknJ6zk2gEs3+RNn5uknA1R62+oU40etEr62atLbs=;
        b=qraJfz0e3sf9rzIuWYm/eir/IPl20FcBWTiKKuzdSZ1G0wYbac6ztontkXeSYgO3G1
         0ZkxP0FuGSchcsBGMYI0cyhIgcHgI9EGWo46itc6MkVihu//IPNHjdtfBfCOq2Ub8Mx0
         Gz5J1fz5e4E8FFY0Xijg7kzz5EWaMo+1+b+zY7A/GCLHLUqOZI0ng1qyrBrOg620Uo0T
         TUsnYEY9KhZ1lo8nsn554CTnSxymNjTJwQyONt4AisSRnKydMrreN0Uclgg0lCrhMrHX
         syGFWt9371nlqV+uB601KeUAuXq3CIG8y1UGD1/pEMukXgSlzJYGNgCwN7ImDsbBIvXs
         aJhA==
X-Gm-Message-State: AOAM533G50HtSvlMwxClMmwPImJ0RMbKlwPakiLPRgIUZsmuqAg5paK6
        vYa70d8qhXmFjvGNAdFaf6NpSM4nkH7pS+xWmQKupw==
X-Google-Smtp-Source: ABdhPJzTNtUplFsE8XuXiikib5kVZHA4XkODk3NSMC0UShJtsRJZdgEpM2GFEF/iVR7rJS26c84d7wg4HZL6Zi3uvz0=
X-Received: by 2002:a37:a304:: with SMTP id m4mr21920419qke.8.1591603070800;
 Mon, 08 Jun 2020 00:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200605082839.226418-1-elver@google.com> <CACT4Y+ZqdZD0YsPHf8UFJT94yq5KGgbDOXSiJYS0+pjgYDsx+A@mail.gmail.com>
 <20200605120352.GJ3976@hirez.programming.kicks-ass.net> <CAAeHK+zErjaB64bTRqjH3qHyo9QstDSHWiMxqvmNYwfPDWSuXQ@mail.gmail.com>
 <CACT4Y+Zwm47qs8yco0nNoD_hFzHccoGyPznLHkBjAeg9REZ3gA@mail.gmail.com> <CANpmjNPNa2f=kAF6c199oYVJ0iSyirQRGxeOBLxa9PmakSXRbA@mail.gmail.com>
In-Reply-To: <CANpmjNPNa2f=kAF6c199oYVJ0iSyirQRGxeOBLxa9PmakSXRbA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 8 Jun 2020 09:57:39 +0200
Message-ID: <CACT4Y+Z+FFHFGSgEJGkd+zCBgUOck_odOf9_=5YQLNJQVMGNdw@mail.gmail.com>
Subject: Re: [PATCH -tip v3 1/2] kcov: Make runtime functions noinstr-compatible
To:     Marco Elver <elver@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 9:49 AM Marco Elver <elver@google.com> wrote:
> > On Fri, Jun 5, 2020 at 3:25 PM 'Andrey Konovalov' via kasan-dev
> > <kasan-dev@googlegroups.com> wrote:
> > > > On Fri, Jun 05, 2020 at 12:57:15PM +0200, Dmitry Vyukov wrote:
> > > > > On Fri, Jun 5, 2020 at 10:28 AM Marco Elver <elver@google.com> wrote:
> > > > > >
> > > > > > While we lack a compiler attribute to add to noinstr that would disable
> > > > > > KCOV, make the KCOV runtime functions return if the caller is in a
> > > > > > noinstr section, and mark them noinstr.
> > > > > >
> > > > > > Declare write_comp_data() as __always_inline to ensure it is inlined,
> > > > > > which also reduces stack usage and removes one extra call from the
> > > > > > fast-path.
> > > > > >
> > > > > > In future, our compilers may provide an attribute to implement
> > > > > > __no_sanitize_coverage, which can then be added to noinstr, and the
> > > > > > checks added in this patch can be guarded by an #ifdef checking if the
> > > > > > compiler has such an attribute or not.
> > > > >
> > > > > Adding noinstr attribute to instrumentation callbacks looks fine to me.
> > > > >
> > > > > But I don't understand the within_noinstr_section part.
> > > > > As the cover letter mentions, kcov callbacks don't do much and we
> > > > > already have it inserted and called. What is the benefit of bailing
> > > > > out a bit earlier rather than letting it run to completion?
> > > > > Is the only reason for potential faults on access to the vmalloc-ed
> > > > > region?
> > > >
> > > > Vmalloc faults (on x86, the only arch that had them IIRC) are gone, per
> > > > this merge window.
> > > >
> > > > The reason I mentioned them is because it is important that they are
> > > > gone, and that this hard relies on them being gone, and the patch didn't
> > > > call that out.
> > > >
> > > > There is one additional issue though; you can set hardware breakpoint on
> > > > vmalloc space, and that would trigger #DB and then we'd be dead when we
> > > > were already in #DB (IST recursion FTW).
> > > >
> > > > And that is not something you can trivially fix, because you can set the
> > > > breakpoint before the allocation (or perhaps on a previous allocation).
> > > >
> > > > That said; we already have this problem with task_struct (and
> > > > task_stack). IIRC Andy wants to fix the task_stack issue by making all
> > > > of noinstr run on the entry stack, but we're not there yet.
> > > >
> > > > There are no good proposals for random allocations like task_struct or
> > > > in your case kcov_area.
> > > >
> > > > > Andrey, Mark, do you know if it's possible to pre-fault these areas?
> > > >
> > > > Under the assumption that vmalloc faults are still a thing:
> > > >
> > > > You cannot pre-fault the remote area thing, kernel threads use the mm of
> > > > the previous user task, and there is no guarantee that mm will have had
> > > > the vmalloc fault.
> > >
> > > To clarify this part AFAIU it, even if we try to prefault the whole
> > > remote area each time kcov_remote_start() is called, then (let alone
> > > the performance impact) the kernel thread can be rescheduled between
> > > kcov_remote_start() and kcov_remote_stop(), and then it might be
> > > running with a different mm than the one that was used when
> > > kcov_remote_start() happened.
> >
> > Ugh, this is nasty. But this has also gone, which I am happy about :)
> >
> > Why I am looking at this is because with coverage instrumentation
> > __sanitizer_cov_trace_pc is the hottest function in the kernel and we
> > are adding additional branches to it.
> >
> > Can we touch at least some per-cpu data within noinstr code?
> > If yes, we could try to affect the existing
> > in_task()/in_serving_softirq() check.
> > If not, it would be useful to have a comment clarifying that
> > within_noinstr_section check must happen before we touch anything
> > else.
>
> I don't think this will get us anywhere. If anything this will require
> introducing code outside KCOV, and I think that makes the whole
> situation even worse. My guess is also we can't even read per-CPU
> data, but Peter would have to comment on this.
>
> > I assume objtool can now also detect all violations. How bad is it now
> > without within_noinstr_section check? I am assuming we marking noinstr
> > functions to not be instrumented, but we are getting some stray
> > instrumentation from inlined functions or something, right? How many
> > are there? Is it fixable/unfixable? Marco, do you know the list, or
> > could you please collect the list of violations?
>
> It's everywhere. We cannot mark noinstr functions to not be
> instrumented by KCOV/-fsanitize-coverage, because no compiler provides
> an attribute to do so. GCC doesn't have
> __attribute__((no_sanitize_coverage)) and Clang doesn't have
> __attribute__((no_sanitize("coverage")), and therefore we can't have
> __no_sanitize_coverage.
>
> My plan would be to now go and implement the attributes, at the very
> least in Clang. Then what we can do is make wihin_noinstr_section a
> noop (just return false) if we have CONFIG_CC_HAS_NOSANITIZE_COVERAGE
> or something.
>
> Unfortunately, without this patch, we won't have a reliable kernel
> with KCOV until we get compiler support.
>
> The thing is that this slowdown is temporary if we add the attributes
> to the compiler.

As a crazy idea: is it possible to employ objtool (linker script?) to
rewrite all coverage calls to nops in the noinstr section? Or relocate
to nop function?
What we are trying to do is very static, it _should_ have been done
during build. We don't have means in existing _compilers_ to do this,
but maybe we could do it elsewhere during build?...


> > Is there any config that disables #DB? We could well disable it on
> > syzbot, I think we already disable some production hardening/debugging
> > confings, which are not too useful for testing setup.
> > E.g. we support RANDOMIZE_BASE, no problem, but if one disables it
> > (which we do), that becomes no-op:
> >
> > #ifdef CONFIG_RANDOMIZE_BASE
> >     ip -= kaslr_offset();
> > #endif
> >     return ip;
