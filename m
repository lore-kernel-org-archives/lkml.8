Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0263CC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 21:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBDD8206E2
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 21:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590959043;
	bh=SLulN+aWlozERqwepn37XPPXVtQGVg1dNiexWD7wTdw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=i+QMjMp8qOkPCn1Z8d2xznzLgElCT2lxpFCscgBjc8axVSBKS4cJ+yPautoLfn68u
	 ZEyKeSgZhse8IoBqfzSZrjvlhehAzuM/pyC2CLz4BIvvuL8ZgnAFIHBMHh4+Wu9m0/
	 fcY6pnYgthF4lhP8b/zUT38M/A5W4d2xoKxnKh40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgEaVEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 17:04:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbgEaVEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 17:04:02 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E9A32070A
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 21:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590959041;
        bh=SLulN+aWlozERqwepn37XPPXVtQGVg1dNiexWD7wTdw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cHArp5MH1x1xT1yYBp6jPx09P82zfcOHtyoHPLAlQ0GDBrZwlw4vBfcbLPfNS+AMi
         4aUL2zMk82k5c3KhzkZcyHgrVBdmipaedwP2qs9FHyOcFUsfHOPk85xI/zqiya8jfh
         z/9VoE5LeTuiJNmtCYoOLFSSZDvzmae6uykPpSrk=
Received: by mail-wm1-f51.google.com with SMTP id r9so8876311wmh.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 14:04:01 -0700 (PDT)
X-Gm-Message-State: AOAM532aJOlWhwvW5BNEYrDolUAHjmdN3QnuM7HYHHNV2YdzHLgt3NYG
        BmxuxhBCLMNxr45jxmgkJxVZYVLHwVHJqYgppiv+Rw==
X-Google-Smtp-Source: ABdhPJx52LKrvAzhvylZ66QDOXJGseqtTn9m3YUISFVsp5V3Uiyt2NGce9gfQ7vOrglgz68eqsDcynAzmtbq5SzAzPQ=
X-Received: by 2002:a1c:abc3:: with SMTP id u186mr18469081wme.21.1590959039832;
 Sun, 31 May 2020 14:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <85367hkl06.fsf@collabora.com> <079539BF-F301-47BA-AEAD-AED23275FEA1@amacapital.net>
 <50a9e680-6be1-ff50-5c82-1bf54c7484a9@gmail.com> <CALCETrX+CEN7Sq=ROP33MAGn2dTX=w0JHWb6f4KAr-E9FE4YPQ@mail.gmail.com>
 <a14be8b0-a9a2-cf96-939e-cedf7e0e669a@gmail.com> <CALCETrV+rYnUnve09=n+Zb8BR8mDBq6txX9LmEw7r8tAA7d+2Q@mail.gmail.com>
In-Reply-To: <CALCETrV+rYnUnve09=n+Zb8BR8mDBq6txX9LmEw7r8tAA7d+2Q@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 31 May 2020 14:03:48 -0700
X-Gmail-Original-Message-ID: <CALCETrWr_B-quNckFksTP1W-Ww71uQgCrR-o9QWdQ-Gi8p1r9A@mail.gmail.com>
Message-ID: <CALCETrWr_B-quNckFksTP1W-Ww71uQgCrR-o9QWdQ-Gi8p1r9A@mail.gmail.com>
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory areas
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Paul Gofman <gofmanp@gmail.com>,
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

On Sun, May 31, 2020 at 11:57 AM Andy Lutomirski <luto@kernel.org> wrote:
>
>
> What if there was a special filter type that ran a BPF program on each
> syscall, and the program was allowed to access user memory to make its
> decisions, e.g. to look at some list of memory addresses.  But this
> would explicitly *not* be a security feature -- execve() would remove
> the filter, and the filter's outcome would be one of redirecting
> execution or allowing the syscall.  If the "allow" outcome occurs,
> then regular seccomp filters run.  Obviously the exact semantics here
> would need some care.

Let me try to flesh this out a little.

A task could install a syscall emulation filter (maybe using the
seccomp() syscall, maybe using something else).  There would be at
most one such filter per process.  Upon doing a syscall, the kernel
will first do initial syscall fixups (e.g. SYSENTER/SYSCALL32 magic
argument translation) and would then invoke the filter.  The filter is
an eBPF program (sorry Kees) and, as input, it gets access to the
task's register state and to an indication of which type of syscall
entry this was.  This will inherently be rather architecture specific
-- x86 choices could be int80, int80(translated), and syscall64.  (We
could expose SYSCALL32 separately, I suppose, but SYSENTER is such a
mess that I'm not sure this would be productive.)  The program can
access user memory, and it returns one of two results: allow the
syscall or send SIGSYS.  If the program tries to access user memory
and faults, the result is SIGSYS.

(I would love to do this with cBPF, but I'm not sure how to pull this
off.  Accessing user memory is handy for making the lookup flexible
enough to detect Windows vs Linux.  It would be *really* nice to
finally settle the unprivileged eBPF subset discussion so that we can
figure out how to make eBPF work here.)

execve() clears the filter.  clone() copies the filter.

Does this seem reasonable?  Is the implementation complexity small
enough?  Is the eBPF thing going to be a showstopper?

Using a signal instead of a bespoke thunk simplifies a lot of thorny
details but is also enough slower that catching all syscalls might be
a performance problem.
