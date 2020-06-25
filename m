Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D92C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A28DA2072E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgFYXtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:49:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42328 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgFYXtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 19:49:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 714492A4797
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Robert O'Callahan" <robert@ocallahan.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Gofman <gofmanp@gmail.com>
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory areas
Organization: Collabora
References: <20200530055953.817666-1-krisman@collabora.com>
        <AF65147C-15DB-4BA4-A08B-55676B489BA5@amacapital.net>
        <85367hkl06.fsf@collabora.com>
        <CAOp6jLazKdQ4U8Zyuqf3Zj8DgBnq0QGCbpk3f46dnyLDr69upg@mail.gmail.com>
Date:   Thu, 25 Jun 2020 19:48:58 -0400
In-Reply-To: <CAOp6jLazKdQ4U8Zyuqf3Zj8DgBnq0QGCbpk3f46dnyLDr69upg@mail.gmail.com>
        (Robert O'Callahan's message of "Fri, 26 Jun 2020 11:14:56 +1200")
Message-ID: <877dvuemfp.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert O'Callahan" <robert@ocallahan.org> writes:

> rr (https://rr-project.org, https://arxiv.org/abs/1705.05937) grapples
> with a similar problem. We need to intercept commonly-executed system
> calls and wrap them with our own processing, with minimal overhead. I
> think our basic approach might work for Wine without kernel changes.
>
> We use SECCOMP_SET_MODE_FILTER with a simple filter that returns
> SECCOMP_RET_TRAP on all syscalls except for those called from a single
> specific trampoline page (which get SECCOMP_RET_ALLOW). rr ptraces its
> children. So, when user-space makes a syscall, the seccomp filter
> triggers a ptrace trap. The ptracer looks at the code around the
> syscall and if it matches certain common patterns, the ptracer patches
> the code with a jump to a stub that does extra work and issues a real
> syscall via the trampoline. Thus, each library syscall instruction is
> slow the first time and fast every subsequent time. "Weird" syscalls
> that the ptracer chooses not to patch do incur the context-switch
> penalty every time so their overhead does increase a lot ... but it
> sounds like that might be OK in Wine's case?
>
> A more efficient variant of this approach which would work in some
> cases (but maybe not Wine?) would be to avoid using a ptracer and give
> the process a SIGSYS handler which does the patching.

We couldn't patch Windows code because of the aforementioned DRM and
anti-cheat mechanisms, but I suppose this limitation doesn't apply to
Wine/native code, and if this assumption is correct, this approach could
work.

One complexity might be the consistent model for the syscall live
patching.  I don't know how much of the problem is diminished from the
original userspace live-patching problem, but I believe at least part of
it applies.  And fencing every thread to patch would kill performance.
Also, we cannot just patch everything at the beginning.  How does rr
handle that?

Another problem is that we will want to support i386 and other
architectures.  For int 0x80, it is trickier to encode a branch to
another region, given the limited instruction space, and the patching
might not be possible in hot paths.  I did port libsyscall-intercept to
x86-32 once and I could correctly patch glibc, but it's not guaranteed
that an updated libc or something else won't break it.

I'm not sure the benefit of not needing enhanced kernel support
justifies the complexity and performance cost required to make this work
reliably, in particular since the semantics for a kernel implementation
that we are discussing doesn't seem overly intrusive and might have
other applications like in the generic filter Andy mentioned.

-- 
Gabriel Krisman Bertazi
