Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7581DC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 365EC22207
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ae4tquuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgIKQWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgIKQWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:22:33 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B54EC0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 09:22:32 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id r7so14520605ejs.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 09:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=evNZKysAyJVDJFT66khLohp3xUs13A1xSWcEfi9b540=;
        b=Ae4tquukEefgUlPmUmJU0RsPNNyjRmp/EcJwNrsDA4qCmFhdDh9bYbZ7o/pXQ7tnT4
         svI/zhr2xDJ83F4ISMrwM3VLNLJGxaT9vhQrAE/9eDcRATsuHPM5THKfI9WzUCyJGKWC
         hNGME51ilNarXtOPN2bD5Ve9/meaJCLFgBJF/TZwW2ufT/quianqVNX4Gbk47G+RpJZc
         pZwL8/KHBuHRDv8Qujoba+Ef9Jb/LVnmsjpKi8BwAcGrQvalpwjdeyzmyN2udZtQ4Pb3
         i3lHMW7qaKFoCp+cM8dKpFBDGLFeYk5c46WtvzAtz9fa9GiR1M4cfxsbexzvnHOL33yW
         4i+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=evNZKysAyJVDJFT66khLohp3xUs13A1xSWcEfi9b540=;
        b=cJG1ZnT1IbCkPutB3AG9uKszbEXGC96RwJa3/A3WUcW+hSHzTZthFbFfDbain7GW1h
         rYcJ0d7tWMvxSoBI+us/D8fNJNHGxfg0cD4FEllNhk+kGmDkv6kxJqBUwEO2i3Llmxtg
         25N4vblnIxKSAmLt01XHQ2NtANouT5X+aGtDAvnYSN3Gl5rz4rTVJMiCnbrWLJDtzwg2
         Q/BibLvwywxKiEUtX46JV7QEPbFKm2pDWshfdsFm4qn+WDPe4DaDWOYjJQVRo+DF1d2r
         lece2g7qLiPOoTGZQY9UNCxyfsZoG+aIx265j11C/8BeiICjmSZXl2ofRtLYwxEa2FIG
         N36g==
X-Gm-Message-State: AOAM533fhYaj4Vtg7/dNFQm+kAMoYhaRGiEOqqbuXaM7QV7ECaMq5LTD
        ZIYQ+DZO8B1O6tDoERXUjH6fxEVtt7MVMUUagR7smg==
X-Google-Smtp-Source: ABdhPJyqHiecqUtumffmsrD9npH6L2n5M/zdIGPahrdtL0+0os1gIs7YjYfDjXWuBz5n1Y8EJ2sQXjRZ/jbRS55PAlw=
X-Received: by 2002:a17:906:a0c2:: with SMTP id bh2mr2837607ejb.493.1599841351050;
 Fri, 11 Sep 2020 09:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200910134802.3160311-1-lenaptr@google.com> <CAG48ez3x51kkDt19ONXbi8Se+2swMgwfmaj7AFbBqmss=D38Ug@mail.gmail.com>
 <CABvBcwY2FLJxc80Leibv=zZ-e_YbjkE+ZBH2LNoFy8HAeD8m6Q@mail.gmail.com>
In-Reply-To: <CABvBcwY2FLJxc80Leibv=zZ-e_YbjkE+ZBH2LNoFy8HAeD8m6Q@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 11 Sep 2020 18:22:04 +0200
Message-ID: <CAG48ez1cEC1q1o4_--aVjuGmC-G9i9PUQQ2Pumr3aSrox_MZ+A@mail.gmail.com>
Subject: Re: [PATCH] sched.h: drop in_ubsan field when UBSAN is in trap mode
To:     Elena Petrova <lenaptr@google.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 5:15 PM Elena Petrova <lenaptr@google.com> wrote:
> On Thu, 10 Sep 2020 at 20:35, Jann Horn <jannh@google.com> wrote:
> > On Thu, Sep 10, 2020 at 3:48 PM Elena Petrova <lenaptr@google.com> wrote:
> > > in_ubsan field of task_struct is only used in lib/ubsan.c, which in its
> > > turn is used only `ifneq ($(CONFIG_UBSAN_TRAP),y)`.
> > >
> > > Removing unnecessary field from a task_struct will help preserve the
> > > ABI between vanilla and CONFIG_UBSAN_TRAP'ed kernels. In particular,
> > > this will help enabling bounds sanitizer transparently for Android's
> > > GKI.
> >
> > The diff looks reasonable to me, but I'm curious about the
> > justification in the commit message:
> >
> > Is the intent here that you want to be able to build a module without
> > CONFIG_UBSAN and load it into a kernel that is built with
> > CONFIG_UBSAN? Or the inverse?
>
> The former. But more precisely, with GKI Google gives a promise, that
> when certain GKI is released, i.e. at 4.19, its ABI will never ever
> change (or, perhaps only change with <next letter> Android release),

Really? How does that work when a kernel update needs to add elements
to existing structs that are part of that "ABI"? Especially when those
structs have something at the end that's variable-length (like
task_struct) or they're embedded in something else?

Maybe you should've done something like BPF's CORE if you really want
to do something like that, teaching the compiler to generate
relocations for struct offsets...

> so vendor modules could have an independent development lifecycle. And
> this patch, when backported, will help enable boundsan on kernels
> where ABI has already been frozen.
>
> > Does this mean that in the future, gating new exported functions, or
> > new struct fields, on CONFIG_UBSAN (independent of whether
> > CONFIG_UBSAN_TRAP is set) will break Android?
>
> I don't understand what you mean here, sorry.

Let's assume that at a later point, someone wants to track for each
process how many UBSAN errors that process has seen so far. And maybe
at that point, we have error recovery support in trap mode. So that
person sends a patch that, among other things, adds something like
this to task_struct:

    #ifdef CONFIG_UBSAN
    unsigned int ubsan_errors_seen;
    #endif

If that patch lands, ABI compatibility between UBSAN=y&&UBSAN_TRAP=y
and UBSAN=n will break again.


I believe that it should normally be possible to add stuff like

    #ifdef CONFIG_<something>
    <some field declaration>
    #endif

to an existing kernel struct without breaking anything (outside UAPI
headers and such). Your patch assumes that that won't happen for
CONFIG_UBSAN.

> > If you really want to do this, and using alternatives to patch out the
> > ubsan instructions is not an option, I wonder whether it would be more
> > reasonable to at least add a configuration where CONFIG_UBSAN is
> > enabled but the compiler flag is not actually set. Then you could
> > unconditionally build that android kernel and its modules with that
> > config option, and wouldn't have to worry about structure size issues,
> > dependencies on undefined symbols and so on.
>
> Such setup might be confusing for developers.

Yeah, but I think that that's still cleaner than assuming that some
normal kernel flag won't change struct layouts...

Anyway, the diff itself looks reasonable to me (although I dislike the
commit message), but don't be surprised if this "ABI" is broken again
in the future.

> We were considering
> something similar: to keep the in_ubsan field regardless of the
> CONFIG_UBSAN option. But since non-trap mode is unlikely to be used on
> production devices due to size and performance overheads, I think it's
> better to just get rid of an unused field, rather than balloon
> task_struct.
>
> Cheers,
> *lenaptr
