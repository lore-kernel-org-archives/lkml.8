Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50165C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 344AB206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbgFASHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729750AbgFASGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:06:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBE7C05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 11:06:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 3AFDB2A2AF4
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
Date:   Mon, 01 Jun 2020 14:06:30 -0400
In-Reply-To: <CALCETrWr_B-quNckFksTP1W-Ww71uQgCrR-o9QWdQ-Gi8p1r9A@mail.gmail.com>
        (Andy Lutomirski's message of "Sun, 31 May 2020 14:03:48 -0700")
Message-ID: <85y2p664pl.fsf@collabora.com>
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

If we can have something close to the numbers you shared, it seems to be
good for us.  Using the thunk instead of a signal seems very interesting
for performance.

Though, I'm not convinced about this not being part of seccomp just
because it is not security.  The suggestion from Kees to convert
seccomp to eBPF filters and stack them would provide similar semantics
and reuse the infrastructure.

Finnaly, as you said, I'm afraid that eBPF will be a show stopper,
unless unpriviledged eBPF becomes a thing. Wine cannot count on
CAP_SYS_ADMIN.

-- 
Gabriel Krisman Bertazi
