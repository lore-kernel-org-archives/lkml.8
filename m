Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB62C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB3B2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="MmR6teA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbgAXKmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:42:43 -0500
Received: from ozlabs.org ([203.11.71.1]:55913 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgAXKmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:42:43 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 483whD6FWGz9s1x;
        Fri, 24 Jan 2020 21:42:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1579862561;
        bh=H4j0Futj5uqyyAbpgglurPALtZHLyOVkkBYQKpFq/88=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MmR6teA231c1fXQY1+vLqi0yz+Vc/SdGtcRyQ5HHkVx+BNa3Psa5ILkQxN57JPZ+l
         QIDQJ6babRxL+JNOJ1Ihqnztvi+zDQ0ClPcWniXnyA9m5CrYol7du1yr6gvZgrSqj9
         Sm2JIYeF0VfZ0LNwzGOk02j//mTV+bi0mJJXC3wPwjd0kXnV/egJmn1DK/vMu2Ze/H
         PEy7abr1N9fN1d18XYZwK4cyAbdcoaYAt+wPy0l8aEU5uIJ2g2Gc0DLfd86fF20aOj
         IDGhhd9mt4ij7rNrL1OTDb6LldjgXtBTveq+DlS/1iY4HEmLNb4b5jrGYiOtxTLgBD
         84Co0BMAqYRew==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2 1/6] fs/readdir: Fix filldir() and filldir64() use of user_access_begin()
In-Reply-To: <CAHk-=whCk8z2_kggSCoAGMne8PNSvcT2T4bBH62ngoFrsTyV6w@mail.gmail.com>
References: <12a4be679e43de1eca6e5e2173163f27e2f25236.1579715466.git.christophe.leroy@c-s.fr> <87muaeidyc.fsf@mpe.ellerman.id.au> <87k15iidrq.fsf@mpe.ellerman.id.au> <CAHk-=whCk8z2_kggSCoAGMne8PNSvcT2T4bBH62ngoFrsTyV6w@mail.gmail.com>
Date:   Fri, 24 Jan 2020 21:42:30 +1100
Message-ID: <878slxi19l.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Thu, Jan 23, 2020 at 4:00 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> So I guess I'll wait and see what happens with patch 1.
>
> I've committed my fixes to filldir[64]() directly - they really were
> fixing me being lazy about the range, and the name length checking
> really is a theoretical "access wrong user space pointer" issue with
> corrupted filesystems regardless (even though I suspect it's entirely
> theoretical - even a corrupt filesystem hopefully won't be passing in
> negative directory entry lengths or something like that).

Great, thanks.

> The "pass in read/write" part I'm not entirely convinced about.
> Honestly, if this is just for ppc32 and nobody else really needs it,
> make the ppc32s thing always just enable both user space reads and
> writes. That's the semantics for x86 and arm as is, I'm not convinced
> that we should complicate this for a legacy platform.

We can use the read/write info on Power9 too. That's a niche platform
but hopefully not legacy status yet :P

But it's entirely optional, as you say we can just enable read/write if
we aren't passed the read/write info from the upper-level API.

I think our priority should be getting objtool going on powerpc to check
our user access regions are well contained. Once we have that working
maybe then we can look at plumbing the direction through
user_access_begin() etc.

cheers
