Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E35C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 23:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A5A420707
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 23:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="YQm8mBng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgEaXeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 19:34:03 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:50890 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgEaXeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 19:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=To:References:Message-Id:
        Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
        Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eXFt9y6Z2WBjRWaJgmza57dN3Egt/onllf0rZRMlIAQ=; b=YQm8mBng3LzrqoRSrXxyXIfgl
        72rE/fI48T/f0Gq1j2tApc+bv1Mog1xrrGKNAF/NwpUg6l8ovnJMNljA0l+nirvXA3P0/i5u0WsMW
        BIlpuvyEDzcqS5CZBHNWGjsH0mRndEK4e5Vt5vcF2OQgXDIM9fazzkT5h+m1+HQX7O11k=;
Received: from cpe-107-184-2-226.socal.res.rr.com ([107.184.2.226] helo=[192.168.2.144])
        by mail.codeweavers.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <bshanks@codeweavers.com>)
        id 1jfXSn-0005yd-4N; Sun, 31 May 2020 18:33:59 -0500
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory
 areas
From:   Brendan Shanks <bshanks@codeweavers.com>
In-Reply-To: <CALCETrV+rYnUnve09=n+Zb8BR8mDBq6txX9LmEw7r8tAA7d+2Q@mail.gmail.com>
Date:   Sun, 31 May 2020 16:33:54 -0700
Cc:     Paul Gofman <gofmanp@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Zebediah Figura <zfigura@codeweavers.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8DF2868F-E756-4B33-A7AE-C61F4AB9ABB9@codeweavers.com>
References: <85367hkl06.fsf@collabora.com>
 <079539BF-F301-47BA-AEAD-AED23275FEA1@amacapital.net>
 <50a9e680-6be1-ff50-5c82-1bf54c7484a9@gmail.com>
 <CALCETrX+CEN7Sq=ROP33MAGn2dTX=w0JHWb6f4KAr-E9FE4YPQ@mail.gmail.com>
 <a14be8b0-a9a2-cf96-939e-cedf7e0e669a@gmail.com>
 <CALCETrV+rYnUnve09=n+Zb8BR8mDBq6txX9LmEw7r8tAA7d+2Q@mail.gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3445.104.14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On May 31, 2020, at 11:57 AM, Andy Lutomirski <luto@kernel.org> wrote:
>=20
> Using SECCOMP_RET_USER_NOTIF is likely to be considerably more
> expensive than my scheme.  On a non-PTI system, my approach will add a
> few tens of ns to each syscall.  On a PTI system, it will be worse.
> But using any kind of notifier for all syscalls will cause a context
> switch to a different user program for each syscall, and that will be
> much slower.

There=E2=80=99s also no way (at least to my understanding) to modify =
register state from SECCOMP_RET_USER_NOTIF, which is how the existing =
-staging SIGSYS handler works:

=
<https://github.com/wine-staging/wine-staging/blob/master/patches/ntdll-Sy=
scall_Emulation/0001-ntdll-Support-x86_64-syscall-emulation.patch#L62>

> I think that the implementation may well want to live in seccomp, but
> doing this as a seccomp filter isn't quite right.  It's not a security
> thing -- it's an emulation thing.  Seccomp is all about making
> inescapable sandboxes, but that's not what you're doing at all, and
> the fact that seccomp filters are preserved across execve() sounds
> like it'll be annoying for you.

Definitely. Regardless of what approach is taken, we don=E2=80=99t want =
it to persist across execve.

> What if there was a special filter type that ran a BPF program on each
> syscall, and the program was allowed to access user memory to make its
> decisions, e.g. to look at some list of memory addresses.  But this
> would explicitly *not* be a security feature -- execve() would remove
> the filter, and the filter's outcome would be one of redirecting
> execution or allowing the syscall.  If the "allow" outcome occurs,
> then regular seccomp filters run.  Obviously the exact semantics here
> would need some care.

Although if that=E2=80=99s running a BPF filter on every syscall, =
wouldn=E2=80=99t it also incur the ~10% overhead that Paul and Gabriel =
have seen with existing seccomp?


Brendan Shanks
CodeWeavers=
