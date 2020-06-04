Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C1AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35B4D207DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wK7E14tk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgFDODI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgFDODH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:03:07 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95911C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 07:03:06 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y17so2214151plb.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 07:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImRfD2cqJ0tQ89Ygd7DHH9ExVVNMqaoCZMhHXpLzooU=;
        b=wK7E14tkPXobd7wDQL7W8LDVbrDwK7tITVXSLRkBIJdEYvo3HtCPYNTUV67NicHiyj
         9AWMuN3o/OCp+XDPOyVJ4OD+zKHZhzvB8phTAhL2BJKc+dCHU/C4r9FrBiSo0lAAV3zF
         /+TX7AQJSWs4CfyqHdFGIQmXqaBGBSbT3Ij+yk2atYIdyrFpLiXaOPYyYGKO3mK2Pr3H
         08eNplDAwz4UYU/RZPegMsv/4aKNxGvubjCgs8lENLh7IR346BBMADPg8DSesz7AMTmh
         pDz1FCdbw8eIu7sHR/LUVKGggNgaJ3/9sRr3n1KYCTdXms2GBXMCQt0Wrna+r97AAGpc
         Df2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImRfD2cqJ0tQ89Ygd7DHH9ExVVNMqaoCZMhHXpLzooU=;
        b=kpQ4Rf3hw6NlP8btAoafcdvlNmgC1fJ6YLzH57o9X/onClSa8eHmbvMruwGu0+etbN
         6U3IfClNhYWLyo+rVzFi9KatD+Ow43vbLS1aB5RyILI23UWkzpmHBfAbvW9gQpscT/8z
         qHXtVg4jN9yNcIDhFhNGz8zGPqlsrj9fmbjx3mAZsN36q3d9yTcq1I7tzMDTBSuzy5jh
         KxOoSTkgvfbaHcT8ReUGT7KSSR7+58bbBbAywFYvtofgPyhS3C6XqFFXgkVQM3IN2wBc
         Vtptiu6fIJ5z/bLol7iw3vRR17Ph11kUMwmw8RBYDk2XldhKFJoSjc4zVqhL7BGcK3kx
         hU1A==
X-Gm-Message-State: AOAM532NcT1NEOb4LDO59NHqjhzcXNrdgUlIc//zqRgd1PxVFEduvFYc
        YeTfmXHGRgPVmruTmloPFLpNTZXi427xBmLSc+GFaw==
X-Google-Smtp-Source: ABdhPJxF6w0guK8bIziJwSer4vYqYL9hM8mQ+nxlzjZzeCVI7qPY7HlVwnjRxTnlb0CIYKAmin4YVVJZlev8RU7hBeo=
X-Received: by 2002:a17:90b:1244:: with SMTP id gx4mr6178570pjb.136.1591279385737;
 Thu, 04 Jun 2020 07:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200604095057.259452-1-elver@google.com> <20200604110918.GA2750@hirez.programming.kicks-ass.net>
In-Reply-To: <20200604110918.GA2750@hirez.programming.kicks-ass.net>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 4 Jun 2020 16:02:54 +0200
Message-ID: <CAAeHK+wRDk7LnpKShdUmXo54ij9T0sN9eG4BZXqbVovvbz5LTQ@mail.gmail.com>
Subject: Re: [PATCH -tip] kcov: Make runtime functions noinstr-compatible
To:     Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
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

On Thu, Jun 4, 2020 at 1:09 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jun 04, 2020 at 11:50:57AM +0200, Marco Elver wrote:
> > The KCOV runtime is very minimal, only updating a field in 'current',
> > and none of __sanitizer_cov-functions generates reports nor calls any
> > other external functions.
>
> Not quite true; it writes to t->kcov_area, and we need to make
> absolutely sure that doesn't take faults or triggers anything else
> untowards.
>
> > Therefore we can make the KCOV runtime noinstr-compatible by:
> >
> >   1. always-inlining internal functions and marking
> >      __sanitizer_cov-functions noinstr. The function write_comp_data() is
> >      now guaranteed to be inlined into __sanitize_cov_trace_*cmp()
> >      functions, which saves a call in the fast-path and reduces stack
> >      pressure due to the first argument being a constant.

Maybe we could do CFLAGS_REMOVE_kcov.o = $(CC_FLAGS_FTRACE) the same
way we do it for KASAN? And drop notrace/noinstr from kcov. Would it
resolve the issue? I'm not sure which solution is better though.

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
>
> That whole kcov_remote stuff confuses me.
>
> KCOV_ENABLE() has kcov_fault_in_area(), which supposedly takes the
> vmalloc faults for the current task, but who does it for the remote?

Hm, no one. This might be an issue, thanks for noticing!

> Now, luckily Joerg went and ripped out the vmalloc faults, let me check
> where those patches are... w00t, they're upstream in this merge window.

Could you point me to those patches?

Even though it might work fine now, we might get issues if we backport
remote kcov to older kernels.

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
