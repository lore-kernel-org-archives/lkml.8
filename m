Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60547C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 23:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F648207D5
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 23:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591053523;
	bh=vG7dpOcajSi/mt4/We78ONhQ6W10E0sko1pNjj1dhKo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=m42V7d+EJbaNdTZsXsneceKJHEHfTsLCInRCs01gmeZwM2uHlzBUjMldTmTyKcDA3
	 gGw4Ij3mN1xWvsAWeSKQAnGs++s2R79DgRKE+vIDvzbUwl2bCbY4qlXvKkH3iNxR2U
	 qhCMO3opAGn4IDjnLMpRJ52rEW6qBLM0jnPquM90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgFAXSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 19:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgFAXSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 19:18:42 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBB55207BB
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 23:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591053521;
        bh=vG7dpOcajSi/mt4/We78ONhQ6W10E0sko1pNjj1dhKo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L3qZgGCD1KwPW+AzHVpCLxbtFMIbF8YoDBXINYIN9StTf6HaAHbtZYUevfjha89GT
         P4SXM5QubUZ7cE7/FYz9/lp6VGJohG7ThZqriBrgsA5x6aZQ7dmbKCmUMCL7/mTr2i
         gwuBMglfxUU18LuGxEbZ0DAhZL3Wc7Y2BHOtUXKw=
Received: by mail-wr1-f45.google.com with SMTP id h5so1467735wrc.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 16:18:40 -0700 (PDT)
X-Gm-Message-State: AOAM5327qk8uENiABX3Wxx5KvkWSfGeRTvk4GwkXaIDa/TYi8ldrU4Cd
        T2y0FRQtwJu2oh+IlYC79kjB+DB9j5F/CU1hzSSmYw==
X-Google-Smtp-Source: ABdhPJwcrV44K9KnQPiete8Q8IGAa4fv5gTnd/zkm7UMyds9Aoe3lJR00gDthiHYjn5UnatttJZS0INS+BA4D1pJlvY=
X-Received: by 2002:adf:ea11:: with SMTP id q17mr23050302wrm.75.1591053519479;
 Mon, 01 Jun 2020 16:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <85367hkl06.fsf@collabora.com> <079539BF-F301-47BA-AEAD-AED23275FEA1@amacapital.net>
 <50a9e680-6be1-ff50-5c82-1bf54c7484a9@gmail.com> <CALCETrX+CEN7Sq=ROP33MAGn2dTX=w0JHWb6f4KAr-E9FE4YPQ@mail.gmail.com>
 <a14be8b0-a9a2-cf96-939e-cedf7e0e669a@gmail.com> <CALCETrV+rYnUnve09=n+Zb8BR8mDBq6txX9LmEw7r8tAA7d+2Q@mail.gmail.com>
 <CALCETrWr_B-quNckFksTP1W-Ww71uQgCrR-o9QWdQ-Gi8p1r9A@mail.gmail.com> <202006011306.2E31FDED@keescook>
In-Reply-To: <202006011306.2E31FDED@keescook>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 1 Jun 2020 16:18:27 -0700
X-Gmail-Original-Message-ID: <CALCETrW9R7YyxkervbsH2NZDUtYzag23ewD=--poeH54nc-yiQ@mail.gmail.com>
Message-ID: <CALCETrW9R7YyxkervbsH2NZDUtYzag23ewD=--poeH54nc-yiQ@mail.gmail.com>
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory areas
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Paul Gofman <gofmanp@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Drewry <wad@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Zebediah Figura <zfigura@codeweavers.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 1:08 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Sun, May 31, 2020 at 02:03:48PM -0700, Andy Lutomirski wrote:
> > On Sun, May 31, 2020 at 11:57 AM Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > >
> > > What if there was a special filter type that ran a BPF program on each
> > > syscall, and the program was allowed to access user memory to make its
> > > decisions, e.g. to look at some list of memory addresses.  But this
> > > would explicitly *not* be a security feature -- execve() would remove
> > > the filter, and the filter's outcome would be one of redirecting
> > > execution or allowing the syscall.  If the "allow" outcome occurs,
> > > then regular seccomp filters run.  Obviously the exact semantics here
> > > would need some care.
> >
> > Let me try to flesh this out a little.
> >
> > A task could install a syscall emulation filter (maybe using the
> > seccomp() syscall, maybe using something else).  There would be at
> > most one such filter per process.  Upon doing a syscall, the kernel
> > will first do initial syscall fixups (e.g. SYSENTER/SYSCALL32 magic
> > argument translation) and would then invoke the filter.  The filter is
> > an eBPF program (sorry Kees) and, as input, it gets access to the
>
> FWIW, I agree: something like this needs to use eBPF -- this isn't
> being designed as a security boundary. It's more like eBPF ptrace.

On a bit more consideration, I think that I have the model a bit
wrong.  We shouldn't think of this as a *syscall* filter but as a
filter for architectural privilege transitions in general.  After all,
there is no particular guarantee that any given emulated program has a
syscall ABI that is even remotely compatible with Linux.  So maybe the
filter is fed events like SYSCALL64, SYSCALL32, SYSENTER, #GP, #PF
(the bad kind that would otherwise get a signal), #UD, etc.  And the
filter can examine process state and take some reasonable action.
Think if it as a personality scheme that's programmable by user code.
I imagine that even schemes like NaCl could make some use of this.

This allows all kinds of interesting things.  For example, it should
give Wine a much nicer emulation of Windows SEH and vectored signals.
And maybe it could finally allow Linux userspace to have some sensible
equivalent of those Windows features -- being able to write library
code that could sanely handle, say, math errors would be quite handy.

This could be mocked up with cBPF, but I think a cBPF version will
struggle to be a performant solution for Wine because it will have a
hard time distinguishing between Windows and Linux syscalls.

--Andy
