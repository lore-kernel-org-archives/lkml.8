Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3CAC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79541206D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgCFC32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 21:29:28 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:53664 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgCFC32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 21:29:28 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jA2jk-0062dm-0g; Fri, 06 Mar 2020 02:29:16 +0000
Date:   Fri, 6 Mar 2020 02:29:15 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jann Horn <jannh@google.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>, Todd Kjos <tkjos@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] binder: do not initialize locals passed to
 copy_from_user()
Message-ID: <20200306022915.GW23230@ZenIV.linux.org.uk>
References: <20200302130430.201037-1-glider@google.com>
 <20200302130430.201037-2-glider@google.com>
 <0eaac427354844a4fcfb0d9843cf3024c6af21df.camel@perches.com>
 <CAG_fn=VNnxjD6qdkAW_E0v3faBQPpSsO=c+h8O=yvNxTZowuBQ@mail.gmail.com>
 <4cac10d3e2c03e4f21f1104405a0a62a853efb4e.camel@perches.com>
 <CAG_fn=XOyPGau9m7x8eCLJHy3m-H=nbMODewWVJ1xb2e+BPdFw@mail.gmail.com>
 <CAG48ez3sPSFQjB7K64YiNYfemZ_W9cCcKQW34XAcLP_MkXUjCw@mail.gmail.com>
 <205aa3d8-7d18-1b73-4650-5ef534fe55da@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <205aa3d8-7d18-1b73-4650-5ef534fe55da@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 10:03:25AM +0100, Rasmus Villemoes wrote:

> Does copy_from_user guarantee to zero-initialize the remaining buffer if
> copying fails partway through?

That's guaranteed, short of raw_copy_from_user() being completely broken.
What raw_copy_from_user() implementation must guarantee is that if
raw_copy_from_user(to, from, N) returns N - n, then
	* 0 <= n <= N
	* all attempted reads had been within the range [from .. from + N - 1]
	* all stores had been to the range [to .. to + n - 1] and every byte
within that range had been overwritten
	* for all k in [0 .. n - 1], the value stored at to[k] by the end of
the call is equal to the value that would've been possible to read from
from[k] at some point during the call.  In particular, for all bytes in
range [from .. from + n - 1] there had been a successful read of some
object containing that byte.
	* if everything in [from .. from + N - 1] is readable, the call
will copy the entire range into [to .. to + N - 1] and return 0.

Provided that, copy_from_user() will leave no uninitialized data in
destination object in any case, success or no success.
