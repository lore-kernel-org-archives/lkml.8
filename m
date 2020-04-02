Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A50C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62506206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585846850;
	bh=rP4R6ltwyFbIop2qaFd2X7PeOsFsKHTsCehRkWKRkWg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tO5rERvhy6oJyelAVPw/phGC4iJ6uvDOg9sYl9M1cN2ZZ67iwdtR8icwSLBXTkmmZ
	 R0sWulaa1Gq6VlxAZ9s8SsAOsVDetyeKOkr7ZjlRUkdS5UcLiQn1qx6nqzhgrY+LZt
	 czs4NKsfznIrzUvp/gudI/dGX9RVZ3AbrKZQ4rn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389965AbgDBRAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:00:49 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42329 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387700AbgDBRAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:00:49 -0400
Received: by mail-lj1-f194.google.com with SMTP id q19so3975724ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 10:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z6HfP8JeHREg6eazqAmdO8jOM+tUPqEvL6gQdFFuuL0=;
        b=LARJycAL1QnwRNtl0O8DbeTXG347AEmyzgHBnsfSvvt9OkYHcuqi7Q/8iCWECOrjG9
         4OaHaXJeaTYUjpH2umpeMu6BO37kTCr2a/zlUwOl1YPv23rNBvDGt8arpIlmG2TyaPXn
         tJkuXraj5kXgprAlkRwk285/jzeC90vqNpf3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z6HfP8JeHREg6eazqAmdO8jOM+tUPqEvL6gQdFFuuL0=;
        b=TOTKX18yGCp6C8iMN3TGPoJ1f0sPylWFItni8fTBBVuhBal8Cj5Qpq8BAc1ypXo5SC
         bjymOAF0UBAiD2Dm/S54K4oaer2su82nztu553WBPRmQA2IFsbzXkUnr+yLHrnoJdRDN
         AP1QgpSvX7h1rgkq5p/fEUkqAALE7/WKcRGctJtQuPxZQctrkIXy5DP5yGA3Zckk28EM
         BqSlHKPslr0hhaHNdsgtl1dWcgIBMiZpDM3/HV3GdTMvPjiYSO4cFj7PzC6qNLseBoA5
         x2FUYlaOrLpt6o6zM5lGPfPTILxHzqpManlwtaO4CpqN2+FLE/js0AqTxZyzvXDGcmIo
         brcw==
X-Gm-Message-State: AGi0PuYxG9EWJM3av6LnsHdbZgfmI0d+qD1MTcX+rfPNBCG66UkPkrnG
        2LJo2D9c0NKXVZ47WGUkOur3ho+5G0s=
X-Google-Smtp-Source: APiQypK/2wsAQ7JRm+een1kxfyO3FvEjuoMZK3r2wMhSkWq8EFVZ3uUwM/UasyGwD9VlTQcp2LHIOw==
X-Received: by 2002:a2e:b446:: with SMTP id o6mr2576084ljm.80.1585846844516;
        Thu, 02 Apr 2020 10:00:44 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id q30sm4886315lfn.18.2020.04.02.10.00.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 10:00:43 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id z23so3348058lfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 10:00:42 -0700 (PDT)
X-Received: by 2002:a19:6144:: with SMTP id m4mr2667553lfk.192.1585846842546;
 Thu, 02 Apr 2020 10:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200331080111.GA20569@gmail.com> <CAHk-=wjpBohNkBSxyPfC7w8165usbU5TuLohdbPs+D0bUYqJhQ@mail.gmail.com>
 <CAHk-=wijWvUfEkqUZRpvo9FCaJNsioS_qZT+iNWUdqQ6eO8Ozw@mail.gmail.com>
 <87v9mioj5r.fsf@nanos.tec.linutronix.de> <CAHk-=wh3_WTKeR=TTbPpbJYjC8DOPcDPJhhoopTVs3WJimsT=A@mail.gmail.com>
 <20200402134051.GC9352@zn.tnic>
In-Reply-To: <20200402134051.GC9352@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Apr 2020 10:00:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCw-WFbHhq6uYZcXrMEoi4y_FhZk48adf4JePxBzmFsg@mail.gmail.com>
Message-ID: <CAHk-=whCw-WFbHhq6uYZcXrMEoi4y_FhZk48adf4JePxBzmFsg@mail.gmail.com>
Subject: Re: [GIT PULL] x86 cleanups for v5.7
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Matz <matz@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 6:40 AM Borislav Petkov <bp@alien8.de> wrote:
>
> Btw, looking at this:
>
> https://reviews.llvm.org/rG50cac248773
>
> and talking to a gcc guy (CCed), it should be also relatively easy to do
> the fallthrough variant in gcc too so you could open a feature request
> for that in the gcc bugzilla.

I absolutely want to have that in gcc too (I've mentioned it a couple
of times to people like rth), but I wanted to have more than just an
abstract test-case for it.

Sure, I could attach my current patch to the bug report, but honestly,
if I was a compiler guy, I'd care a lot less about a "hey, you have to
apply this patch that won't even _compile_ for you right now to a tree
you don't really care about that much" kind of bug-report than a "hey.
look, upstream Linux already does this, and with clang I get this
code, and with gcc it's much worse".

And to be honest, while I love the asm goto output, it's not *that*
noticeable. Particularly since we don't have a lot. This is the inner
loop of "strncpy_from_user" with the feature (and clang, of course):

  90: mov    (%r15,%r13,1),%rdx
  94: mov    %rdx,(%r12,%r13,1)
  98: mov    %rdx,%rsi
  9b: not    %rsi
  9e: and    %rax,%rsi
  a1: add    %rcx,%rdx
  a4: and    %rsi,%rdx
  a7: jne    ec <strncpy_from_user+0xec>
  a9: add    $0x8,%r13
  ad: add    $0xfffffffffffffff8,%rbx
  b1: cmp    $0x7,%rbx
  b5: ja     90 <strncpy_from_user+0x90>

And all the jumps are just for testing if there was a zero in there
(the jne in the middle) or testing for the length of the remaining
space (that "cmp $7;ja" at the end).

This is the same thing with gcc (and without asm goto, of course):

  91: lea    (%rcx,%rdi,1),%rdx
  95: mov    %rcx,0x0(%r13,%rax,1)
  9a: not    %rcx
  9d: and    %rcx,%rdx
  a0: mov    %rdx,%rcx
  a3: and    %rsi,%rcx
  a6: jne    108 <strncpy_from_user+0x108>
  a8: sub    $0x8,%rbx
  ac: add    $0x8,%rax
  b0: cmp    $0x7,%rbx
  b4: jbe    12d <strncpy_from_user+0x12d>
  b6: mov    %r8d,%edx
  b9: mov    0x0(%rbp,%rax,1),%rcx
  be: test   %edx,%edx
  c0: je     91 <strncpy_from_user+0x91>

and the only real difference in that inner loop from the asm goto is
that the gcc code has three extra instructions (don't ask me why gcc
decided to cache the value 0 in %r8, that just looks stupid):

  b6: mov    %r8d,%edx
...
  be: test   %edx,%edx
  c0: je     91 <strncpy_from_user+0x91>

(Ok, the code sequence looks completely different because the two
compilers also end up generating the function differently: gcc does
the user space load at the end of the loop while clang does it at the
top. That's probably related to the fact that gcc has to generate that
extra jump anyway, and decided to make that the loop finishing jump).

So realistically, it doesn't make a huge difference. It's a bit more
noticeable when you have the "multiple unsafe_get_user()s in a row"
pattern, but we don't really have that (we have lots of "multiple
unsafe_put_user() in a row").

Of course, one reason we don't have that pattern is that it generates
nasty code with gcc (exactly because of the extra test for each
access).

But while I love looking at small things like this, and I'd like to
have all compilers support it, I have to admit that it's not likely to
really _matter_ much.

                Linus
