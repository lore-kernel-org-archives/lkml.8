Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9734C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A61A7207D5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbgENSzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:55:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52106 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbgENSzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:55:02 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jZJ0W-00067c-IW; Thu, 14 May 2020 18:55:00 +0000
Date:   Thu, 14 May 2020 20:54:59 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] thread fixes v5.7-rc5
Message-ID: <20200514185459.endb3256h27ukwm2@wittgenstein>
References: <20200514170451.1821723-1-christian.brauner@ubuntu.com>
 <CAHk-=wjpb-h9Z6O6o_7GkqCV1N-qQhagVJxpYZurYQR+eLkuEg@mail.gmail.com>
 <1C5DBE84-3E8F-4478-8188-8A09A527B195@ubuntu.com>
 <CAHk-=wjET6Hu50QbnPA+khx8b7hPsZ2bWXmpgA7Ljc6kg8iO-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjET6Hu50QbnPA+khx8b7hPsZ2bWXmpgA7Ljc6kg8iO-Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 11:35:29AM -0700, Linus Torvalds wrote:
> On Thu, May 14, 2020 at 11:22 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > Seemed weird to me to change something that's been exposed to userspace for that long.
> 
> Well, the internal declarations aren't actually "exposed" to user
> space - it's not like it's the declaration of the system call, that's
> separate.
> 
> And we have done that before: we have had a lot of history of using
> "unsigned long" to basically mean "register", and then ended up
> cleaning up types afterwards.

So this has been on my mind for a bit and the clone() bug here brought
this up again. I think it would be good if we could have a consensus
that all new system calls with flag arguments should default to
unsigned int as long as the flag argument is passed in a register; maybe
we could even change most legacy syscalls to unsigned int if safe. It's
not very transparent to userspace when looking at kernel sources why
system calls use unsigned long, int, or unsigned int and I doubt there's
much reason to it anyway apart from historical. But maybe I'm wrong;
that's not unusual. Or maybe it's not worth it. But I've been mulling
putting that into the extensible syscall design patch Aleksa and
I wrote and sent out a while ago:
https://lore.kernel.org/linux-doc/20191002151437.5367-1-christian.brauner@ubuntu.com/
right after copy_struct_from_user() landed. Maybe it's worth resending.

> 
> In fact, if you look at the macros that do SYSCALL_DEFINE() (hint -
> don't actually do it, you'll go mad) you'll see that magical
> __SC_LONG() thing, which actually declares _all_ arguments as either
> "unsigned long" or "unsigned long long".
> 
> That's the "native" representation of the low-level system call (it's
> also marked "asmlinkage" etc).

Right.

> 
> We then end up casting them to the internal representation with that
> __SC_CAST() macro.
> 
> So the actual types that we get are intentionally "cleaned up"
> versions of the raw registers that were passed in.

Yeah, of course.

> 
> But you really don't want to understand the __SYSCALL_DEFINEx() macro.
> It's clever, but it really is the Cthulhu of macros. Just looking at
> it might drive you mad.

That's very Wizard of Oz: "Pay no attention to the macro behind the
syscall declaration"; which means now I really _want_ to look at it. :)

Christian
