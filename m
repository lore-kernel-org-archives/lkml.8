Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5A0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57C62074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RZbZjQG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgFAMkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFAMkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:40:43 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43329C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 05:40:43 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id x17so1374939oog.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 05:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xqANHaGznl5Aocto0IQ3gq922jkx9zcNPs6wxjCx7c=;
        b=RZbZjQG6H1T25hcnE+y6/y5IN6IfGfJ3yRCWbk3fOF0Byu6FZDtlpLMaQRXA5n/wdY
         jM/Nbn0qrGaumoLUJtOQH36v8/lrTiv0K3Jgz9VtCU2F+vRq3zCYvrgzTIgIibEFRu3f
         H12LfpVUyGTLvJR72Yla1iPZaTX7S0i1yJC96p9FkZBIZ3OwtPA9dgkYwK6B96sbP0lr
         FFpXuNjkXXkzyCt5Qz6KcBGgc0Qdab8OAHnOJWPA/PzdmIqOo78fScBbKhSKoVtDK/oD
         078PLLoYkRxcxYnQttjE9UWRuA6TgemEhRUUOCOjRlm1K2pT7eFaJ5DZbscDeCZsHWq5
         vMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xqANHaGznl5Aocto0IQ3gq922jkx9zcNPs6wxjCx7c=;
        b=RJnF5pK/53ZNSu3c2q/wp2pjKDl86N5TjQiVdli9AEc/V8gyP8H5WXtxrko6DEc3CF
         WUrMq0bb8eFRF7LMqVaYc0i3NBrt3VfGbTG3BVMAGgPTStJO7p/nEDN7LWQIzFToAaTE
         12j1ROTwb+hpzlpmT9bIHrKCPLu57Gk/r67fJxFSfyilkxas4Zd7scUWuk7ppKQPukSZ
         xAo2fWLRpccIh80L+4poQ5Qityjhb5XJrGM5h9GUZHEJgIo7TjfOFFb6tCgCnD1nmJoT
         8CA+Fq9YC+qATlTndPDKvmXT48qrLw2Gsz//vZeHJly61gYx48NaldJOwJXb074vEqSZ
         cr+Q==
X-Gm-Message-State: AOAM532pAWhgwdJCsdU0b3lgNw55Ar6Pn2UbZL+8xXlRKNojDsQhI+wi
        RDvP9JPHc//ZMuo2N0u23CajYnBA9uJZ2V+ybCQUmA==
X-Google-Smtp-Source: ABdhPJxkPjkmsDUgZ0ZkPxBbQBKhFxnIKE3UDDowD/5ISyfJ5ok07p+tB06+OqK5ARJCrUNrcZGXbvkQKWhxt53+x/4=
X-Received: by 2002:a4a:b54b:: with SMTP id s11mr11444003ooo.14.1591015242422;
 Mon, 01 Jun 2020 05:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d2474c05a6c938fe@google.com> <CACT4Y+ajjB8RmG3_H_9r-kaRAZ05ejW02-Py47o7wkkBjwup3Q@mail.gmail.com>
 <87o8q6n38p.fsf@nanos.tec.linutronix.de> <20200529160711.GC706460@hirez.programming.kicks-ass.net>
 <20200529171104.GD706518@hirez.programming.kicks-ass.net> <CACT4Y+YB=J0+w7+SHBC3KpKOzxh1Xaarj1cXOPOLKPKQwAW6nQ@mail.gmail.com>
In-Reply-To: <CACT4Y+YB=J0+w7+SHBC3KpKOzxh1Xaarj1cXOPOLKPKQwAW6nQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 1 Jun 2020 14:40:31 +0200
Message-ID: <CANpmjNP7mKDaXE1=5k+uPK15TDAX+PsV03F=iOR77Pnczkueyg@mail.gmail.com>
Subject: Re: PANIC: double fault in fixup_bad_iret
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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

On Sun, 31 May 2020 at 11:32, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, May 29, 2020 at 7:11 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > Like with KCSAN, we should blanket kill KASAN/UBSAN and friends (at the
> > > very least in arch/x86/) until they get that function attribute stuff
> > > sorted.
> >
> > Something like so.
> >
> > ---
> > diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> > index 00e378de8bc0..a90d32b87d7e 100644
> > --- a/arch/x86/Makefile
> > +++ b/arch/x86/Makefile
> > @@ -1,6 +1,14 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  # Unified Makefile for i386 and x86_64
> >
> > +#
> > +# Until such a time that __no_kasan and __no_ubsan work as expected (and are
> > +# made part of noinstr), don't sanitize anything.
> > +#
> > +KASAN_SANITIZE := n
> > +UBSAN_SANITIZE := n
> > +KCOV_INSTRUMENT := n
> > +
> >  # select defconfig based on actual architecture
> >  ifeq ($(ARCH),x86)
> >    ifeq ($(shell uname -m),x86_64)
>
> +kasan-dev
> +Marco, please send a fix for this

I think Peter wanted to send a patch to add __no_kcsan to noinstr:
https://lkml.kernel.org/r/20200529170755.GN706495@hirez.programming.kicks-ass.net

In the same patch we can add __no_sanitize_address to noinstr. But:

- We're missing a definition for __no_sanitize_undefined and
__no_sanitize_coverage.

- Could optionally add __no_{kasan,ubsan,kcov}, to be consistent with
__no_kcsan, although I'd just keep __no_sanitize for the unambiguous
names (__no_kcsan is special because __no_sanitize_thread and TSAN
instrumentation is just an implementation detail of KCSAN, which !=
KTSAN).

- We still need the above blanket no-instrument for x86 because of
GCC. We could guard it with "ifdef CONFIG_CC_IS_GCC".

Not sure what the best strategy is to minimize patch conflicts. For
now I could send just the patches to add missing definitions. If you'd
like me to send all patches (including modifying 'noinstr'), let me
know.

Thanks,
-- Marco
