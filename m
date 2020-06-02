Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369D4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103642074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YoqpL1g4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgFBRvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgFBRvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:51:54 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F402C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 10:51:54 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k15so8161838otp.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 10:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2z7vnRyBy5ncoXlkW8cnatBQyrXfqejt94sDIEUP2j4=;
        b=YoqpL1g4uSpW54raEZFP7I5fg43ub0VRMXONqJe6PWBdBfZTspk0CdPFnw57k8Z9Ir
         hTj8iR+QeasPEgK+GKUcHpXzxbNfRF9Vq6xIXiK7KV778JVQK+CmAsjTdNG3PUAsz3ph
         sPkjnRGu6INh8W9wgVIyRwUyN33+dHs9YEKbMt+eHFOBDMKja8gsv44X/Angdgd26Lnx
         IzP6ldkFky1kEhl61JkdHXNThGyNGBwlYUZjaXfifAGqD76aECwb7V+JjmdzjQeCozMF
         NzR76A2GFTaSyHSoSg3NRB4QS4loLkcV4sroaw/2YYtd4JtTDy1mlKfJbq46HubDmaY8
         9oMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2z7vnRyBy5ncoXlkW8cnatBQyrXfqejt94sDIEUP2j4=;
        b=jcQDs+G1sRP5lys9VrwM+Sc1fEuO+gWVCuu5u4WsgTeswrRyzSTbKO0OCcsHEGTO5v
         gHZnKZEJ+hhfXxXVtzN/BY7k3gfSMxX994nlmUhc/BggxuI9AN3T/qHgS/0TI3xUZfIC
         d2heXFcUXJ5nc5GElh8wEgYt7jaQxTJlFYXXWCJjVVLLxCdk9ANnXjO4/UtrZmMPbxYL
         471kbGap7GpZ0UQFuCSnIXx3108jrFvk5ObSJlWnHjIFarrndRxmqSIgwMJzI+Txv3u2
         KE55kASyzbidEC8CwHqP/+y3xAsZnqZlD7LDDeGgSHNMacukQmoSY6ZYQkr6dobHVoQH
         3NDA==
X-Gm-Message-State: AOAM532+GU3k46N4dtl6ORM5u5kZVsq//pWAtXnVnseMPo17kKRUn/sL
        KSLUZrlRRzQTLqYgPjgWWEKTagSEeM5UDFz4TubdEw==
X-Google-Smtp-Source: ABdhPJzzSVx3Frnbh0Gmg5ImQUlqTVPQN5MFalLoeJD/gp7lyfBrkdwYsks1G8P7kajZTYyLJRZiISO6lqkq6mCcWWU=
X-Received: by 2002:a9d:27a3:: with SMTP id c32mr330184otb.233.1591120313403;
 Tue, 02 Jun 2020 10:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d2474c05a6c938fe@google.com> <CACT4Y+ajjB8RmG3_H_9r-kaRAZ05ejW02-Py47o7wkkBjwup3Q@mail.gmail.com>
 <87o8q6n38p.fsf@nanos.tec.linutronix.de> <20200529160711.GC706460@hirez.programming.kicks-ass.net>
 <20200529171104.GD706518@hirez.programming.kicks-ass.net> <CACT4Y+YB=J0+w7+SHBC3KpKOzxh1Xaarj1cXOPOLKPKQwAW6nQ@mail.gmail.com>
 <CANpmjNP7mKDaXE1=5k+uPK15TDAX+PsV03F=iOR77Pnczkueyg@mail.gmail.com> <20200602094141.GR706495@hirez.programming.kicks-ass.net>
In-Reply-To: <20200602094141.GR706495@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Tue, 2 Jun 2020 19:51:40 +0200
Message-ID: <CANpmjNOqSQ38DZxunagMLdBi8gjRN=14+FFXPhc+9SsUk+FiXQ@mail.gmail.com>
Subject: Re: PANIC: double fault in fixup_bad_iret
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+dc1fa714cb070b184db5@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You were a bit faster with the other patches ;-) I was still
experimenting the the patches, but let me briefly respond here.

On Tue, 2 Jun 2020 at 11:41, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jun 01, 2020 at 02:40:31PM +0200, Marco Elver wrote:
> > I think Peter wanted to send a patch to add __no_kcsan to noinstr:
> > https://lkml.kernel.org/r/20200529170755.GN706495@hirez.programming.kicks-ass.net
> >
> > In the same patch we can add __no_sanitize_address to noinstr. But:
> >
> > - We're missing a definition for __no_sanitize_undefined and
> > __no_sanitize_coverage.
>
> Do those function attributes actually work? Because the last time I
> played with some of that I didn't.

__no_sanitize_coverage won't work, because neither compiler has an
attribute to disable coverage instrumentation. I'll try and add this
to compilers, but KCOV_INSTRUMENT := n is in the right places right
now it seems. More on that in the patch adding this.

> Specifically: unmarked __always_inline functions must not generate
> instrumentation when they're inlined into a __no_*san function.
>
> (and that fails to build on some GCC versions, and I think fails to
> actually work on the rest of them, but I'd have to double check)

We'll probably need to bump the required compiler version if anybody
still attempts to use these old compilers with sanitizers. The precise
versions of compilers and what mixes with what is a bit of a
nightmare. For now I'd just say, let's add the attributes, and see
where that gets us. Surely it won't be more broken than before. ;-)

> > - We still need the above blanket no-instrument for x86 because of
> > GCC. We could guard it with "ifdef CONFIG_CC_IS_GCC".
>
> Right; so all of GCC is broken vs that function attribute stuff? Any
> plans of getting that fixed? Do we have GCC that care?
>
> Does the GCC plugin approach sound like a viable alternative
> implementation of all this?

I don't think it's realistic to maintain a GCC plugin like that
indefinitely. We can investigate, but it's not a quick fix.

> Anyway, we can make it:
>
> KASAN := SANITIZER_HAS_FUNCTION_ATTRIBUTES
>
> or something, and only make that 'y' when the compiler is sane.

We have all attributes except __no_sanitize_coverage. GCC <= 7 has
problems with __always_inline, so we may just have to bump the
required compiler or emit a warning.

> > Not sure what the best strategy is to minimize patch conflicts. For
> > now I could send just the patches to add missing definitions. If you'd
> > like me to send all patches (including modifying 'noinstr'), let me
> > know.
>
> If you're going to do patches anyway, might as well do that :-)

I was stuck on trying to find ways to emulate __no_sanitize_coverage
(with no success), and then agonizing which patches to send in which
sequence. ;-) You made that decision by sending the KCSAN noinstr
series first, so let me respond to that with what I think we can add
for KASAN and UBSAN at least.

Thanks,
-- Marco
