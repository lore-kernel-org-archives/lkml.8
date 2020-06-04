Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B9FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF344206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HSfqxACh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgFDOXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728881AbgFDOXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:23:51 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98240C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 07:23:51 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id h7so4907687otr.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 07:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0yy5MHljbkaYpaeAQHYcaCMNZgb1qOOCz2cvx6JmiYQ=;
        b=HSfqxAChf0V1f77Ft3hLr3vs5os805dKFbsK7rD1pDPMUQ0Hpew3ZFGeV9PurLAR8j
         TW4tdEXYbOb6rUxHNaPilcaDJb9iRw91ogsiZTa6bQ28RmdNGYq9X+Js7feaRn2eJn6/
         5L+9nNoyuLYPE2FD9hDGbwmcS+1YS3WqMCv4fhktKikiT6BE8YgcpUB0SXyRDEBVqMXV
         +s+5l8y2eVM3/iAZCQ2r6MFv8iXkhNVkCJKw5EVmRwuqMev8g9eAuZzjoj4YfOsEbPkY
         HethYLZNONsBGpCZvmDurGpyo5swb5veoaKRFljbSId1jfTeY1YAn6c6MlLwFk0laMWy
         DVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0yy5MHljbkaYpaeAQHYcaCMNZgb1qOOCz2cvx6JmiYQ=;
        b=aNUWH/1sxAPFxD56csal9FG/6pNgM3HrjKLzZqB/O+V+3h7zgH51BvicWtU+CHBGZZ
         5pQvmv+Nvn8wOu27Kjy74qvPdL9xpXeG9Mki2V9EPeHAsxcBWQdcp6qq6NHOsRkleRux
         hcDKLjHvImhs1kBPIun0q3Gsrq7l228QVaGN/lBoMCCVw2pfbzE+yskDn9KUsM6DZtzw
         d8VjOkIrQ+dBEVyLb+VTinsKx/bOkLYjG4rP3LNwZbtHGADugLYsBWPNHb/YyCH1ER0H
         mlDhC8ACQIiR28bIltlgBIDSpd0M0pdYWWxEw9NG7PeyvDv4erkKbvXBolk0sYqt98F+
         sfEA==
X-Gm-Message-State: AOAM530Rgg3nyDhiSXsO1TxrNqhLwXi+DmfHblyRr2GOOI/dpRD8t92Z
        FPY1C3WF8USJJIQf8aOkLiUEbO5gMj8nicnUxi5XOQ==
X-Google-Smtp-Source: ABdhPJxJZ4BbuQgjAR20KqnLGvUsqohMq0tFoznzianKvhbfTDKBnCLQ4GtkXTg8uj2Lc1wNadWuIeYAYYqrxPb24Mc=
X-Received: by 2002:a9d:6958:: with SMTP id p24mr4127585oto.17.1591280630632;
 Thu, 04 Jun 2020 07:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200604095057.259452-1-elver@google.com> <20200604110918.GA2750@hirez.programming.kicks-ass.net>
 <CAAeHK+wRDk7LnpKShdUmXo54ij9T0sN9eG4BZXqbVovvbz5LTQ@mail.gmail.com>
In-Reply-To: <CAAeHK+wRDk7LnpKShdUmXo54ij9T0sN9eG4BZXqbVovvbz5LTQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 4 Jun 2020 16:23:38 +0200
Message-ID: <CANpmjNML7hBNpYGL81M1-=rrYn5PAJPTxFc_Jn0DVhUgwJV8Hg@mail.gmail.com>
Subject: Re: [PATCH -tip] kcov: Make runtime functions noinstr-compatible
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jun 2020 at 16:03, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Thu, Jun 4, 2020 at 1:09 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Jun 04, 2020 at 11:50:57AM +0200, Marco Elver wrote:
> > > The KCOV runtime is very minimal, only updating a field in 'current',
> > > and none of __sanitizer_cov-functions generates reports nor calls any
> > > other external functions.
> >
> > Not quite true; it writes to t->kcov_area, and we need to make
> > absolutely sure that doesn't take faults or triggers anything else
> > untowards.
> >
> > > Therefore we can make the KCOV runtime noinstr-compatible by:
> > >
> > >   1. always-inlining internal functions and marking
> > >      __sanitizer_cov-functions noinstr. The function write_comp_data() is
> > >      now guaranteed to be inlined into __sanitize_cov_trace_*cmp()
> > >      functions, which saves a call in the fast-path and reduces stack
> > >      pressure due to the first argument being a constant.
>
> Maybe we could do CFLAGS_REMOVE_kcov.o = $(CC_FLAGS_FTRACE) the same
> way we do it for KASAN? And drop notrace/noinstr from kcov. Would it
> resolve the issue? I'm not sure which solution is better though.

Sadly no. 'noinstr' implies 'notrace', but also places the function in
the .noinstr.text section for the purpose of objtool checking. But: we
should only mark a function 'noinstr' if it (and its callees)
satisfies the requirements that Peter outlined (are the requirements
documented somewhere?). In particular, we need to worry about vmalloc
faults.

[...]
> > > -static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
> > > +static __always_inline void write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
> > >  {
> > >       struct task_struct *t;
> > >       u64 *area;
> > > @@ -231,59 +231,59 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
> > >       }
> > >  }
> >
> > This thing; that appears to be the meat of it, right?
> >
> > I can't find where t->kcov_area comes from.. is that always
> > kcov_mmap()'s vmalloc_user() ?
> >
> > That whole kcov_remote stuff confuses me.
> >
> > KCOV_ENABLE() has kcov_fault_in_area(), which supposedly takes the
> > vmalloc faults for the current task, but who does it for the remote?
>
> Hm, no one. This might be an issue, thanks for noticing!
>
> > Now, luckily Joerg went and ripped out the vmalloc faults, let me check
> > where those patches are... w00t, they're upstream in this merge window.
>
> Could you point me to those patches?
>
> Even though it might work fine now, we might get issues if we backport
> remote kcov to older kernels.
>
> >
> > So no #PF from writing to t->kcov_area then, under the assumption that
> > the vmalloc_user() is the only allocation site.
> >
> > But then there's hardware watchpoints, if someone goes and sets a data
> > watchpoint in the kcov_area we're screwed. Nothing actively prevents
> > that from happening. Then again, the same is currently true for much of
> > current :/
> >
> > Also, I think you need __always_inline on kaslr_offset()
> >
> >
> > And, unrelated to this patch in specific, I suppose I'm going to have to
> > extend objtool to look for data that is used from noinstr, to make sure
> > we exclude it from inspection and stuff, like that kaslr offset crud for
> > example.
> >
> > Anyway, yes, it appears you're lucky (for having Joerg remove vmalloc
> > faults) and this mostly should work as is.

Now I am a bit worried that, even though we're lucky today, with what
Andrey said about e.g. kcov_remote faults, it'll be hard to ensure we
won't break in future. The exact set of conditions that mean we're
lucky today may change and we have no way of checking this.

I'll try to roll a v2 based on the "if (_RET_IP_ in noinstr section)
return;" and whitelist in objtool approach. Unless you see something
very wrong with that. And I do hope we'll get compiler attributes
eventually.

Thanks,
-- Marco
