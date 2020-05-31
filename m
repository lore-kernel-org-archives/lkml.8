Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B59C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 18:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A2E020810
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 18:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590951438;
	bh=lWjRJ6TmC63MtaoV2GDVh+SjpgJni5oloXOqPMTiCTM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CWJO6yB20jMuwIzeovazhTa1MvaWvGSlkcFQEm0rLw9fY6SpCR0G3VosEHwaj3WIg
	 SPOyCjnwxw8fLHFXcOpvGq+pvhmjDr29jNHTYqLy/kjQ2Q2ChSmKTIOONUMsjTOtqu
	 hV0BRQKvPL+QkqRtk2e+kdvPnImUvXP04wOy9Cdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgEaS5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 14:57:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728296AbgEaS5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 14:57:16 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC586207D5
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 18:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590951436;
        bh=lWjRJ6TmC63MtaoV2GDVh+SjpgJni5oloXOqPMTiCTM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZujAwms3y4kucEwEZ1nuKxm3b82kGZqYvCC+TAJLn2E48hG3tUni4luPyqb2jz4XQ
         mxX+61zbU4ATW45Q05e6SQPuHi4xxDXjSXtpRbjXJB3JxfbMmkI4d8O7F7dHQFnU8Y
         ipOtM8e0nERV1WFmuRUiTAVa2oxNPYWotcq1cJ0s=
Received: by mail-wm1-f43.google.com with SMTP id r9so8708045wmh.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 11:57:14 -0700 (PDT)
X-Gm-Message-State: AOAM531FX+/WzX6P+ygAAe8YhhpBpJlb2rNkgC3EfHbG+q4q/0DB9QMy
        mAxaHkcTM/dTMf7JxFQ4bfmrxQj7EXC5HCCpsXBnKw==
X-Google-Smtp-Source: ABdhPJyFfciPGCD0rEun0QTBX6ia4qRJhBtnixXTPoOLtfpeWX//2K8XUbDFqxB2Dfyy3eZDH5rD1Rl6irSGixSa4RQ=
X-Received: by 2002:a1c:7f96:: with SMTP id a144mr18038816wmd.176.1590951433390;
 Sun, 31 May 2020 11:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <85367hkl06.fsf@collabora.com> <079539BF-F301-47BA-AEAD-AED23275FEA1@amacapital.net>
 <50a9e680-6be1-ff50-5c82-1bf54c7484a9@gmail.com> <CALCETrX+CEN7Sq=ROP33MAGn2dTX=w0JHWb6f4KAr-E9FE4YPQ@mail.gmail.com>
 <a14be8b0-a9a2-cf96-939e-cedf7e0e669a@gmail.com>
In-Reply-To: <a14be8b0-a9a2-cf96-939e-cedf7e0e669a@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 31 May 2020 11:57:02 -0700
X-Gmail-Original-Message-ID: <CALCETrV+rYnUnve09=n+Zb8BR8mDBq6txX9LmEw7r8tAA7d+2Q@mail.gmail.com>
Message-ID: <CALCETrV+rYnUnve09=n+Zb8BR8mDBq6txX9LmEw7r8tAA7d+2Q@mail.gmail.com>
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory areas
To:     Paul Gofman <gofmanp@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Zebediah Figura <zfigura@codeweavers.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 11:36 AM Paul Gofman <gofmanp@gmail.com> wrote:
>
> On 5/31/20 21:10, Andy Lutomirski wrote:
> >
> > That's not what I meant.  I meant that you would set the kernel up to
> > redirect *all* syscalls from the thread with the sole exception of one
> > syscall instruction in the thunk.  This would catch Windows syscalls
> > and Linux syscalls.  The thunk would determine whether the original
> > syscall was Linux or Windows and handle it accordingly.
> >
> > This may interact poorly with the DRM scheme.  The redzone might need
> > to be respected, or stack switching might be needed.
>
> Oh yeah, I see now, thanks. Sure, we could trap every syscall and have a
> Seccomp-allowed trampoline for executing native ones with the existing
> Seccomp implementation. But this is going to have prohibitive
> performance impact. Our present use case specifics is that vast majority
> of syscalls do not need to be emulated, they are native. And just a few
> go from the Windows application which we need to trap and route to our
> handler to let the program continue, while we do not care too much about
> the overhead for those few. So the hope was that the kernel can route
> that majority of Linux native syscalls inside with the minor overhead.
> I've read the suggestion to use SECCOMP_RET_USER_NOTIF instead of
> SECCOMP_RET_TRAP, is handling the trap this way supposed to be much
> quicker than handling the sigsys from SECCOMP_RET_TRAP? More
> specifically, would not SECCOMP_RET_USER_NOTIF effectively serialize all
> the syscalls waiting in a single queue for processing, while
> SECCOMP_RET_TRAP can be processed without exclusive locking?
>
>

Using SECCOMP_RET_USER_NOTIF is likely to be considerably more
expensive than my scheme.  On a non-PTI system, my approach will add a
few tens of ns to each syscall.  On a PTI system, it will be worse.
But using any kind of notifier for all syscalls will cause a context
switch to a different user program for each syscall, and that will be
much slower.

I think that the implementation may well want to live in seccomp, but
doing this as a seccomp filter isn't quite right.  It's not a security
thing -- it's an emulation thing.  Seccomp is all about making
inescapable sandboxes, but that's not what you're doing at all, and
the fact that seccomp filters are preserved across execve() sounds
like it'll be annoying for you.

What if there was a special filter type that ran a BPF program on each
syscall, and the program was allowed to access user memory to make its
decisions, e.g. to look at some list of memory addresses.  But this
would explicitly *not* be a security feature -- execve() would remove
the filter, and the filter's outcome would be one of redirecting
execution or allowing the syscall.  If the "allow" outcome occurs,
then regular seccomp filters run.  Obviously the exact semantics here
would need some care.
