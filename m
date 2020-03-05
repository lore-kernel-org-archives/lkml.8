Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0720C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7807120848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nbjJ+edo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgCEMqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:46:13 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44536 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgCEMqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 07:46:12 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so5781917oia.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 04:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EBJiQx/MPyQ2hugQ5S0diNZxP8ij3c3rvZpbZvxi3j0=;
        b=nbjJ+edob4wcEAnoswnNyP+pLHYUqojVTVp7wAaZTxnr3fi5TcwEr0MXNa/oZHh7xh
         YywP+f0wo1k9fzezVsgVONxhuga2FzGKv6C9dPwH9nDS3dkZBqynk8RCmPoF85tbirBt
         3m5RdwT7gU0M91d4vA7T30cRea9uA8cV1XPZYX1SYQ4Tc8iWWSUv7iCJGUyst68xulMo
         FFTlWebAxu/wdRjpF/Jwr7UtMtKWCNcyPuwyVXAHcIeKBUHsfOG8580m7GkS8spotS5h
         B8rclHh70hiN++lVZLl04OxZ/lJOEP7GttWhyVMN+0PzxuYgUa0RJCKBX5szy1nniwlv
         hSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EBJiQx/MPyQ2hugQ5S0diNZxP8ij3c3rvZpbZvxi3j0=;
        b=rigkO46RBV43EnjzVP1omGTZZTE1srYX5zc8SMKIMhte6X8JrJJrt/5J3X6Lvarw+m
         /NRCmz1Tw4QrAV0FE6leiqgO0Uz8UK3fEaabRCQHeJhIp3c/XMqq9Wr4LnXrlR1qJR4t
         fuSnwSPrUWSo9XUjoG0hGJgoYogdLKIHgHDnBqOpkidqc2JHu0AxrArDYhAz6K+8VOmw
         6Aqviqy8JhmlsNJuVXonCTVzpu6oMKoDREcfdDaQIiixzHtXDv+tWFKGCmgqhuHWZ6zs
         osyKRJ3fHt7UfwgjAK0zChgeK8n2oMNk+ujsnFv+YcjekJWh5DEg6szqFptvxvHZ2iw+
         zs1A==
X-Gm-Message-State: ANhLgQ3mTd9h0/90G0SIDE2PTmb66v3kz4uKs4oR7LiLnteuVuYwzBz+
        bdVAw//LJsyQUj3hbx8XKUxLOxUOSuI3LPImZoqpWQ==
X-Google-Smtp-Source: ADFU+vso1w9mhfeUd+ur1ReAf47AM2hyb8bzzNFTdwBLB0Sbp0EkstxtFY56uOcWw4/dmeQ6pS9n5ARaJ8lPS979twY=
X-Received: by 2002:a05:6808:8d0:: with SMTP id k16mr5503025oij.68.1583412371104;
 Thu, 05 Mar 2020 04:46:11 -0800 (PST)
MIME-Version: 1.0
References: <20200302130430.201037-1-glider@google.com> <20200302130430.201037-2-glider@google.com>
 <0eaac427354844a4fcfb0d9843cf3024c6af21df.camel@perches.com>
 <CAG_fn=VNnxjD6qdkAW_E0v3faBQPpSsO=c+h8O=yvNxTZowuBQ@mail.gmail.com>
 <4cac10d3e2c03e4f21f1104405a0a62a853efb4e.camel@perches.com>
 <CAG_fn=XOyPGau9m7x8eCLJHy3m-H=nbMODewWVJ1xb2e+BPdFw@mail.gmail.com>
 <CAG48ez3sPSFQjB7K64YiNYfemZ_W9cCcKQW34XAcLP_MkXUjCw@mail.gmail.com> <205aa3d8-7d18-1b73-4650-5ef534fe55da@rasmusvillemoes.dk>
In-Reply-To: <205aa3d8-7d18-1b73-4650-5ef534fe55da@rasmusvillemoes.dk>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 5 Mar 2020 13:45:44 +0100
Message-ID: <CAG48ez014nW8pie91cnrn_7N1zyziAN+9xrT9xN0iLecCoRwfA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] binder: do not initialize locals passed to copy_from_user()
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>, Todd Kjos <tkjos@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 10:03 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> On 02/03/2020 19.31, Jann Horn wrote:
> > On Mon, Mar 2, 2020 at 7:17 PM Alexander Potapenko <glider@google.com> wrote:
> >> On Mon, Mar 2, 2020 at 3:00 PM Joe Perches <joe@perches.com> wrote:
> >>>
> >>> So?  CONFIG_INIT_STACK_ALL by design slows down code.
> >> Correct.
> >>
> >>> This marking would likely need to be done for nearly all
> >>> 3000+ copy_from_user entries.
> >> Unfortunately, yes. I was just hoping to do so for a handful of hot
> >> cases that we encounter, but in the long-term a compiler solution must
> >> supersede them.
> >>
> >>> Why not try to get something done on the compiler side
> >>> to mark the function itself rather than the uses?
> >> This is being worked on in the meantime as well (see
> >> http://lists.llvm.org/pipermail/cfe-dev/2020-February/064633.html)
> >> Do you have any particular requisitions about how this should look on
> >> the source level?
> >
> > Just thinking out loud: Should this be a function attribute, or should
> > it be a builtin - something like __builtin_assume_initialized(ptr,
> > len)? That would make it also work for macros,
>
> But with macros (and static inlines), the compiler sees all the
> initialization being done, no?

Depends on how the macro writes to the buffer, whether it's a normal
write or happens through another function call or whatever.

> and it might simplify
> > the handling of inlining in the compiler. And you wouldn't need such a
> > complicated attribute that refers to function arguments by index and
> > such.
>
> Does copy_from_user guarantee to zero-initialize the remaining buffer if
> copying fails partway through?

Basically yes. From include/linux/uaccess.h:

static __always_inline unsigned long __must_check
copy_from_user(void *to, const void __user *from, unsigned long n)
{
  if (likely(check_copy_size(to, n, false)))
    n = _copy_from_user(to, from, n);
  return n;
}

check_copy_size() should be optimized out entirely for straightforward
use of stack objects; it will only return false if the specified
address range crosses beyond an allocation boundary.
_copy_from_user() is defined as follows (there are two possible
definitions, both of them have the same method body, but they differ
in whether the function is inline - which one is used depends on the
architecture):

static inline __must_check unsigned long
_copy_from_user(void *to, const void __user *from, unsigned long n)
{
  unsigned long res = n;
  might_fault();
  if (likely(access_ok(from, n))) {
    kasan_check_write(to, n);
    res = raw_copy_from_user(to, from, n);
  }
  if (unlikely(res))
    memset(to + (n - res), 0, res);
  return res;
}

So annotating _copy_from_user(), or calling a magic
fake-initialization builtin directly before calling _copy_from_user(),
should be safe. As long as the compiler can eliminate the call to
check_copy_size(), that should then make that propagate up to the
caller of copy_from_user(). (You could also try to annotate
copy_from_user() directly, but I'm not sure whether doing it before
the bounds check might confuse the compiler somehow.)
