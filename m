Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C96C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C164D2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595999382;
	bh=eYb5MXNDios1YM3ylYsZfmcDeaiH+jiIZ1lgRFwy64s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xt7iwWLWAjM6mnBvEw7LTiZN78k54W0raQXIy298LfTpgqJVYptvrdEVeq73ldsHi
	 m5VtbTMTAG77LBJjRmSycQFB9O9ayluDLROQeIpXUFIbnoKIoHu0+M5L8iAPVO16tR
	 Wxo/aoXrOoihQXWV20pnZjEsxrV04u5wuZvMtoUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgG2FJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 01:09:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgG2FJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 01:09:40 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B677E21744
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 05:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595999380;
        bh=eYb5MXNDios1YM3ylYsZfmcDeaiH+jiIZ1lgRFwy64s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GAwiXcoNz08y7TTbyLlCoUYpO5MeI+RNkj6Z/fJ/FknMkcrDelYDcCyRdSMznPhBk
         1NMp1Qiq0B6/53VJfm2dmBzzTxgiRDJdqtC9dmMNp7Uejt+Y7Y9kF9GbTpSLjFNT8D
         RKD3FO1mRp/u2PP+0LAaMMO+flgn1PDTrIs+qSnk=
Received: by mail-wr1-f48.google.com with SMTP id r12so20250235wrj.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 22:09:39 -0700 (PDT)
X-Gm-Message-State: AOAM532Y0d/O5GsMAK7aRiBHJymSotd0Sg/1zBK2sXw5DJ6360K2kTme
        GKcwsUFOiT6F+8JO3KPwBQZJFVhriCWatMJfkLsl3Q==
X-Google-Smtp-Source: ABdhPJz3aIycVjIWLwxfa+Ybs9B0c7EMDmh+T49YplX2TrmTysv3u0GyE6F8KnCgryujrGj2Iq+HoVPwcHz0agFDKC4=
X-Received: by 2002:a5d:5273:: with SMTP id l19mr27308359wrc.257.1595999378162;
 Tue, 28 Jul 2020 22:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200728202229.1195682-1-krisman@collabora.com>
 <20200728202229.1195682-3-krisman@collabora.com> <CALCETrV_HJCrDLCKLrqNbLiOsoEcC9M7zn-v_hcVMvDgnWW8yw@mail.gmail.com>
 <878sf3j5cl.fsf@collabora.com>
In-Reply-To: <878sf3j5cl.fsf@collabora.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 28 Jul 2020 22:09:26 -0700
X-Gmail-Original-Message-ID: <CALCETrUVQw4EUyEFQ4xdWBrxVKJtNmrZurGccXtn8i9nNAYufg@mail.gmail.com>
Message-ID: <CALCETrUVQw4EUyEFQ4xdWBrxVKJtNmrZurGccXtn8i9nNAYufg@mail.gmail.com>
Subject: Re: [PATCH 2/6] arch: x86: Wrap TIF_IA32 checks
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 9:46 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Andy Lutomirski <luto@kernel.org> writes:
>
> > On Tue, Jul 28, 2020 at 1:22 PM Gabriel Krisman Bertazi
> > <krisman@collabora.com> wrote:
> >>
> >> In preparation to remove TIF_IA32, add wrapper that check the process
> >> has IA32 ABI without using the flag directly.
> >
> > Thank you for doing this, but let's please do it right.  There is,
> > fundamentally, no such thing as a "process with IA32 ABI".
>
> Hi Andy,
>
> Thanks a lot for your review.
>
> As you can see, I'm learning my way here. Can you clarify "there is no
> such a thing as a 'process with IA32 ABI'"?  I'm not sure if I confused
> the terminology or if (more worrisome for me) I got the concepts wrong.
>
> My understanding is that TIF_IA32 marks a thread that is running under
> the 32-bit compat mode, which would be running a 32-bit process (as in
> compiled with -m32, for instance), while TIF_X32 marks a process running
> under the X32 ABI.  Each process would have only one of these
> "personalities". This is what I meant by a process with IA32 ABI (which
> is wrong in any case).  Is there more to it, or is the problem the
> terminology I used?

There's more to it.

On sane architectures like Linux on ARM64, a process can be 32-bit or
64-bit.  If you are a 64-bit ARM process, you run in 64-bit mode,
period.  Anything other than execve() that lets you become 32-bit is a
bug.

Linux on x86 is nutty, though.  (IIRC Sparc is too.)  In particular,
it's entirely legal for a Linux program to switch between 32-bit and
64-bit mode all by itself.  This can be done with LJMP, LRET, IRET, or
a few other hacks.  It can also be done using any of the sigreturn
syscalls.  (SYSENTER comes to mind, but anyone who uses SYSENTER to
switch modes is *nuts*.)  Certain evil people named Andy Lutomirski
write kernel selftests that switch modes using sigreturn just to abuse
the kernel.  But some real programs do this too.  For example, I think
that CRIU restores 32-bit programs by starting out as a 64-bit
program, restoring everything, and then switching to 32-bit mode.
Keep in mind that most of these mode-switching tricks do not enter the
kernel at all.

The upshot is that kernel does not actually know what the running
program's ABI is.  For all the kernel knows, a process uses the
Linux/psABI 64-bit ABI, the ia32 ABI, the x32 ABI, the Windows 32-bit
ABI, the Windows 64-bit ABI, and some gnarly ABI from DOS or OS/2, all
in the same process.

So we really shouldn't be trying to keep track of what we think the
user program should be doing, and instead we should pay attention to
what the user program actually did in its interactions with the
kernel.  If we want to know whether a user task is running in 64-bit
mode right now, we can use user_64bit_mode(regs).  (And keep in mind
that syscalls like rt_sigreturn() and anything that gets ptraced can
*change* the outcome of user_64bit_mode(regs) mid-syscall.)  If we're
delivering a signal, we instead want to know the ABI of the signal's
handler, so we use is_ia32_frame(ksig) and is_x32_frame(ksig).  If we
want to know whether mmap() should return values above 2^32-1, we
currently use some hackery, but we really ought to be looking at
whether the call was 64-bit mmap() or compat mmap().  (I had some
really half-baked patches to fix this at one point, but the core code
was a real mess and I didn't finish it.)  If we still supported MPX in
the kernel, we'd have a real mess, because MPX malfunctions if user
programs switch bitness on us.  Good riddance!

>
> I don't have any comments on the other things you mentioned, except that
> I need to go through them and better understand your suggestions.  Would
> you prefer me to rework this patch series with what you suggested or is
> this something you want to take over and do yourself?  Both ways are
> fine by me.

Please rework it :)  I have seriously limited bandwidth right now.
