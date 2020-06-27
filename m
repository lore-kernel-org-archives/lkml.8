Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4ABC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 16:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74449206A5
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 16:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593275608;
	bh=d9pGLeKX7Mnj2Sis5onHc4rcPHK59+Cn8LDz/l6cVCo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YjMeMdprHqYHF+jeHHp91a+YUfqwRTEOI4H5GnvyRWtrOFLSmMiPaAXo19yO+v3Ji
	 76hVDNkiv08Nfyce11WtUaLYOjyabPKx4WGVGFAJiOesTdeXfQL1OqbEdtUbWHlKAU
	 cgvxi5Vf6+frupcB3ZEnzMBZ7tE63rSBuVXTpgCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgF0Qd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 12:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgF0QdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 12:33:24 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229C6C03E979
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 09:33:24 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n24so13418768lji.10
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 09:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zm7F5E21VOj53dJ+cv9f96G78mr9Hbsprjoym1XE0Kg=;
        b=dFxU7A/dIhFjWtexhRNj28JLQPwpPSTC1IGJO/QY3YkFQYuCZfN6sVlY1GZnZj6nWT
         kQ1zk7vcokCOAN2dBrIDOU7zEwC2lfKje2337ddmXvQK9BmAk8ikcCQhrJv3qQd4ngmg
         VFhgtqA8GhgsJmUd8Y4k5JIGnPtXeVQvq0e0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zm7F5E21VOj53dJ+cv9f96G78mr9Hbsprjoym1XE0Kg=;
        b=fBw3gmDY/7c9aW8RxEGpfu529tcy3hh3IbVGSkfAMJ0dleao8M5aCe2iB4paiZZ/T2
         tn8H7uMYNwuatJgIsOy0qwyyatGGqv5K+ZzfbiL4D/EOibLNBZpMw3LJNHW+VxwCRmJh
         jjN1HSdYWUFx61aCFCUB23xDHzCOA+91m5YBROFk3VRivdsT8cifk0QLQJhMKL5vvgTo
         5QFltExMpbbw3tLOnj6v/p+hOAPTnfmy4Qd6bjJVjrQKWSXXHVlEDSersCsQJYAJ1w84
         zERtzPFzYQ1/uhISGJLRWxikC2gJix0ve+NHi72h5opjDA2crr0mJ9pFwhJwFCiWhUvL
         sD+w==
X-Gm-Message-State: AOAM532MWAea3zk/jbehBVfrF/GGYyP4MdzertowBwHsXa3NtRRl9Pb6
        5z9u6wr8pGAYKx4eHOXeVFSa603BmmY=
X-Google-Smtp-Source: ABdhPJwvTIde7C6ObJWfE/1KGzSrUj5kVCG3uv16rj6Fv7cTv8RV1+E3xXKK/Vb1D4TbZKxvKr7njw==
X-Received: by 2002:a2e:8490:: with SMTP id b16mr4241329ljh.325.1593275601677;
        Sat, 27 Jun 2020 09:33:21 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id n10sm7484022lfb.82.2020.06.27.09.33.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2020 09:33:20 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id i3so13475072ljg.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 09:33:19 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr3996353ljj.102.1593275599478;
 Sat, 27 Jun 2020 09:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200624162901.1814136-1-hch@lst.de> <20200624162901.1814136-4-hch@lst.de>
 <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com>
 <20200624175548.GA25939@lst.de> <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com>
 <f50b9afa5a2742babe0293d9910e6bf4@AcuMS.aculab.com>
In-Reply-To: <f50b9afa5a2742babe0293d9910e6bf4@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 Jun 2020 09:33:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxQczqZ96esvDrH5QZsLg6azXCGDgo+Bmm6r8t2ssasg@mail.gmail.com>
Message-ID: <CAHk-=wjxQczqZ96esvDrH5QZsLg6azXCGDgo+Bmm6r8t2ssasg@mail.gmail.com>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file operations
To:     David Laight <David.Laight@aculab.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 3:49 AM David Laight <David.Laight@aculab.com> wrote:
>
> > Just keep the existing "set_fs()". It's not harmful if it's only used
> > occasionally. We should rename it once it's rare enough, though.
>
> Am I right in thinking that it just sets a flag in 'current' ?

Basically, yes. That's what it has always done.

Well "always" is not true - it used to set the %fs segment register
originally (thus the name), but _conceptually_ it sets a flag for
"should user accesses be kernel accesses instead".

On x86 - and most other architectures where user space and kernel
space are in the same address space and accessed with the same
instructions, that has then been implemented as just a "what is the
limit for an access".

On other architectures - architectures that need different access
methods (or different flags to the load/store instruction) - it's an
actual flag that changes which access method you use.

> Although I don't remember access_ok() doing a suitable check
> (would need to be (address - base) < limit).

So again, on the architectures with a unified address space,
access_ok() is exactly that "address + access_size <= limit", although
often done with some inline asm just to get the overflow case done
efficiently.

On other architectures, there's no limit check, because _all_
addresses are either user space or kernel space addresses, and what
changes isn't the address limit, but the access itself.

So what I was suggesting is literally

 - keep this flag around as a flag

 - but make all _normal_ user accesses ignore it, and always do user
accesses (so on a unified address space architecture like x86 it
always checks the _fixed_ limit, and on something like sparc32 which
has separate kernel and user address spaces, it just always does a
user access with no conditionals at all)

 - then make the really odd and hopefully very rare cases check that
flag explicitly and manually, and do

        if (current->legacy_uptr_is_kernel)
                memcpy(...);
        else
                copy_to/from_user(...);

and my hope is that we'd have only a handful of cases (like the
setsockopt thing: one for each protocol or whatever) that actually
want this.

Note that the legacy behavior would still remain in architectures that
haven't been modified to remove the use of set_fs(), so I would
further suggest that the two approaches live side-by-side for at least
a while. But _generic_ code (and with Christoph's patches at least
x86) would make set_fs() cause a build error.

So we'd have a new

     set_force_kernel_pointers();
     ....
     clear_force_kernel_pointers();

that would set/clear that 'current->legacy_uptr_is_kernel' variable,
and we'd have a handful of places that would check it.

The naming above is all random, and I'm not claiming that any of this
is particularly _clean_. I'm also not claiming that it's really any
better than our current "set_fs()" mess conceptually.

The only thing that makes it better than our current "set_fs()" is

 - there would hopefully be very few cases of this

 - it would *not* affect random incidental user accesses that just
happen to be in the shadow of this thing.

That second point is the important one, I feel. The real problem with
"set_fs()" has been that we've occasionally had bugs where we ended up
running odd paths that we really didn't _intend_ to run with kernel
pointers. The classic example is the SCSI "write as ioctl" example,
where a write to a SCSI generic device would do various odd things and
follow pointers and what-not. Then you get into real trouble when
"splice()" ends up truiong to write a kernel buffer, and because of
"set_fs()" suddenly the sg code started accessing kernel memory
willy-nilly.

So my suggestion was basically a new version of set_fs(), but one that
is just much more targeted, and doesn't affect all random user
accesses, only those very special ones that are then very *explicitly*
aware of the fact that "hey, I might be called in this situation where
I'm going to get a kernel address instead".

> If that is needed (I presume it was added for a purpose) then all
> the socket option code needs to be able to handle kernel buffers.

So that's very much what I'd like to avoid.

The plan would be that all the *normal* stuff would be handled by
either (a) always having the data come from user space, or (b) the
data has a known size (either fixed, or "optlen" or whatever) and then
being copied to a kernel buffer and then always handled as a kernel
field that bpf can then call with kernel data.

I thought there was just one very specific case of "oh, in certain
cases of setsockopt we don't know what size this address is and optlen
is ignored", so we have to just pass the pointer down to the protocol,
which is the point that knows how much of an address it wants..

Was that a misunderstanding on my part?

Because if there are tons and tons of places that want this "either
kernel or user" then we could still have a helper function for it, but
it means that the whole "limit the cases" advantage to some degree
goes away.

It would still fix the 99% of normal "copy/from/to_user()" cases,
though. They'd be fixed and "safe" and coule never ever touch kernel
memory even if there was some confusion about things. So it would be
an improvement, but I was really hoping that the cases where there can
be confusion would be pretty rare.

             Linus
