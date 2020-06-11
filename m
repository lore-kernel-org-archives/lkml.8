Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D0DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A71320792
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgFKTi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 15:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFKTi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:38:56 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DB3C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:38:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D19FF2A5183
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Paul Gofman <gofmanp@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Zebediah Figura <zfigura@codeweavers.com>
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory areas
Organization: Collabora
References: <85367hkl06.fsf@collabora.com>
        <079539BF-F301-47BA-AEAD-AED23275FEA1@amacapital.net>
        <50a9e680-6be1-ff50-5c82-1bf54c7484a9@gmail.com>
        <CALCETrX+CEN7Sq=ROP33MAGn2dTX=w0JHWb6f4KAr-E9FE4YPQ@mail.gmail.com>
        <a14be8b0-a9a2-cf96-939e-cedf7e0e669a@gmail.com>
        <CALCETrV+rYnUnve09=n+Zb8BR8mDBq6txX9LmEw7r8tAA7d+2Q@mail.gmail.com>
        <CALCETrWr_B-quNckFksTP1W-Ww71uQgCrR-o9QWdQ-Gi8p1r9A@mail.gmail.com>
Date:   Thu, 11 Jun 2020 15:38:50 -0400
In-Reply-To: <CALCETrWr_B-quNckFksTP1W-Ww71uQgCrR-o9QWdQ-Gi8p1r9A@mail.gmail.com>
        (Andy Lutomirski's message of "Sun, 31 May 2020 14:03:48 -0700")
Message-ID: <87h7vhgzp1.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:

> On Sun, May 31, 2020 at 11:57 AM Andy Lutomirski <luto@kernel.org> wrote:
>>
>>
>> What if there was a special filter type that ran a BPF program on each
>> syscall, and the program was allowed to access user memory to make its
>> decisions, e.g. to look at some list of memory addresses.  But this
>> would explicitly *not* be a security feature -- execve() would remove
>> the filter, and the filter's outcome would be one of redirecting
>> execution or allowing the syscall.  If the "allow" outcome occurs,
>> then regular seccomp filters run.  Obviously the exact semantics here
>> would need some care.
>
> Let me try to flesh this out a little.
>
> A task could install a syscall emulation filter (maybe using the
> seccomp() syscall, maybe using something else).  There would be at
> most one such filter per process.  Upon doing a syscall, the kernel
> will first do initial syscall fixups (e.g. SYSENTER/SYSCALL32 magic
> argument translation) and would then invoke the filter.  The filter is
> an eBPF program (sorry Kees) and, as input, it gets access to the
> task's register state and to an indication of which type of syscall
> entry this was.  This will inherently be rather architecture specific
> -- x86 choices could be int80, int80(translated), and syscall64.  (We
> could expose SYSCALL32 separately, I suppose, but SYSENTER is such a
> mess that I'm not sure this would be productive.)  The program can
> access user memory, and it returns one of two results: allow the
> syscall or send SIGSYS.  If the program tries to access user memory
> and faults, the result is SIGSYS.
>
> (I would love to do this with cBPF, but I'm not sure how to pull this
> off.  Accessing user memory is handy for making the lookup flexible
> enough to detect Windows vs Linux.  It would be *really* nice to
> finally settle the unprivileged eBPF subset discussion so that we can
> figure out how to make eBPF work here.)
>
> execve() clears the filter.  clone() copies the filter.
>
> Does this seem reasonable?  Is the implementation complexity small
> enough?  Is the eBPF thing going to be a showstopper?
>
> Using a signal instead of a bespoke thunk simplifies a lot of thorny
> details but is also enough slower that catching all syscalls might be
> a performance problem.

As far as I understand, the eBPF event emulation filter would be a
future-proof mechanism to simplify a lot of wine operations, so, fwiw it
seems an ideal mechanism for us.

If I understand correctly, though, the thunk idea is orthogonal to the
filter itself.  It could be used by the filter in the future
instead of SIGSYS, or we could support it as a sole mechanism to capture
everything.

As a first step, which would solve the existing Wine problem, would you
be open to the sole thunk support implementation, like you proposed?
This would allow us to move forward with this solution without waiting
for unprotected eBPF, and will still be useful in the future once we
get the entire eBPF filter model.

The interface could look like what you proposed, a prctl:

  prctl(PR_SET_SYSCALL_THUNK, target, address_of_unredirected_syscall, 0, 0, 0, 0);

This would immediately solve our use-case, and a few others. For
instance, I believe libsyscall-intercept could start to use that too.

I can explore a bit more, it could be combined to a personality that
enable/disable the thunk on wine entry points, if we notice that
filtering all syscalls in userspace is bad, but that is a second step
that might be unnecessary.

-- 
Gabriel Krisman Bertazi
