Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3F2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC0DE204EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="g05ihPzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgETDQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 23:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgETDQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 23:16:37 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3EFC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:16:36 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id bs4so1212115edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dsjqUKLAoPyWanOv8aTbF0H7d0vvqgBqr3qnWwKSiI0=;
        b=g05ihPzTKTH8r7WtEFbtcqj2ZeF6/IrsMm7VWloVdmxpAtIdo8jrvJL6YidOeYIqm8
         oHeeA4jnYg9FBq5wzouhF2QhoQztCqZsUb/jsKgdCRUcNw/XZtjjN3Dm64CsmzTEgynY
         HcHxo5tJhOYqyXcw0to1yx8nW7l4mOUjhEFRi07iCFmoEmsUUsyY0quGse4Fw6qRryPc
         qn47AB0+p+emI0YhleZg4zCI907eFQaTkOm7kttzuu9qH6HtrCATsoc9zcC4XdKN5hBH
         5y8OziXyn522+FGLaOz4x7hhj5Y2dvBoyz0fbQq7WZvluJOxWPU04+0vKx3cySI8suR0
         Qh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dsjqUKLAoPyWanOv8aTbF0H7d0vvqgBqr3qnWwKSiI0=;
        b=hGruuoAFnfLvEz6b+72Lbn7GtIUdQImbAG7IAgL0Ag+iWyDGXG2A3y/6GO4UirVjg6
         tbQQVbEQwEqI6Wr396cROps4egdMwXZiR7t810Ka0P/o0p5XTpOQ1gOwj/0svsHyPnAZ
         JT0OGfgx8b9ifK8zVnZOYuZBUblEMNqXyMXSNFeQH62wulupJYfGSVidTNXSOXLvmSzS
         +62nf7Jor8B7XTsCJs48hZZmYz3P+1R5/3dw89SK8Ydqnxx3uTfCQFmyWYw7/uZ5Sn0m
         RobLiDPjfy6zmXuqJncPqGOCnuaXoHIZPx3+tkf/uCZtFlneRorrvT+FZU1LN9FwpIOm
         Sc1g==
X-Gm-Message-State: AOAM533nU2XzWNzBND/g8BQLvFKlzP91mreyRcp0dbjdERawDiTKa461
        k1liwKA3wKRKtnTucQR5hVqeXqAsLXJDwMf4aIi4GA==
X-Google-Smtp-Source: ABdhPJwczEEsrYVStnl/es0QdVO1iUcwsh/VSKLjgES7W8Of/18KvUbEFozlBmONg8BzAuuKFkHFQjZzfeuOHCTEwDQ=
X-Received: by 2002:aa7:cc84:: with SMTP id p4mr1427232edt.157.1589944595021;
 Tue, 19 May 2020 20:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <87y2pn60ob.fsf@nanos.tec.linutronix.de> <360AFD09-27EC-4133-A5E3-149B8C0C4232@lca.pw>
 <20200520024736.GA854786@ubuntu-s3-xlarge-x86>
In-Reply-To: <20200520024736.GA854786@ubuntu-s3-xlarge-x86>
From:   Qian Cai <cai@lca.pw>
Date:   Tue, 19 May 2020 23:16:24 -0400
Message-ID: <CAG=TAF4M5s1kQ98ys_YCgRS9WqjV_9KEbPCFiS71MA_QK8epdA@mail.gmail.com>
Subject: Re: [PATCH] READ_ONCE, WRITE_ONCE, kcsan: Perform checks in __*_ONCE variants
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 10:47 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Tue, May 19, 2020 at 10:28:41PM -0400, Qian Cai wrote:
> >
> >
> > > On May 19, 2020, at 6:05 PM, Thomas Gleixner <tglx@linutronix.de> wro=
te:
> > >
> > > Yes, it's unfortunate, but we have to stop making major concessions j=
ust
> > > because tools are not up to the task.
> > >
> > > We've done that way too much in the past and this particular problem
> > > clearly demonstrates that there are limits.
> > >
> > > Making brand new technology depend on sane tools is not asked too
> > > much. And yes, it's inconvenient, but all of us have to build tools
> > > every now and then to get our job done. It's not the end of the world=
.
> > >
> > > Building clang is trivial enough and pointing the make to the right
> > > compiler is not rocket science either.
> >
> > Yes, it all make sense from that angle. On the other hand, I want to be=
 focus on kernel rather than compilers by using a stable and rocket-solid v=
ersion. Not mentioned the time lost by compiling and properly manage my own=
 toolchain in an automated environment, using such new version of compilers=
 means that I have to inevitably deal with compiler bugs occasionally. Anyw=
ay, it is just some other more bugs I have to deal with, and I don=E2=80=99=
t have a better solution to offer right now.
>
> Hi Qian,
>
> Shameless plug but I have made a Python script to efficiently configure
> then build clang specifically for building the kernel (turn off a lot of
> different things that the kernel does not need).
>
> https://github.com/ClangBuiltLinux/tc-build
>
> I added an option '--use-good-revision', which uses an older master
> version (basically somewhere between clang-10 and current master) that
> has been qualified against the kernel. I currently update it every
> Linux release but I am probably going to start doing it every month as
> I have written a pretty decent framework to ensure that nothing is
> breaking on either the LLVM or kernel side.
>
> $ ./build-llvm.py --use-good-revision
>
> should be all you need to get off the ground and running if you wanted
> to give it a shot. The script is completely self contained by default so
> it won't mess with the rest of your system. Additionally, leaving off
> '--use-good-revision' will just use the master branch, which can
> definitely be broken but not as often as you would think (although I
> totally understand wanting to focus on kernel regressions only).

Great, thanks. I'll try it in a bit.
