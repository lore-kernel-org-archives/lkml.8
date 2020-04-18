Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEAAC352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA07422209
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587243165;
	bh=apE6XqxFG6TG4FN0Ki0Dsv+Sqkeuz7N4O9bXIKSuhwg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=faa5ZiR7a0waHEpzZ6v+4r+Qh2+yVhs/b3GKElrlFMnVMLSIxQBy7XEsOEtamdbVq
	 rvZuPPMVqR8B070HxayxBu6s9qHN9CTbE85NqzZ8P/rD8oQE/bP5S9hUxDTh6YkXfh
	 9qvHJWhU2hF0PBAYbtQ1WZfqTS/oX2BgXsy83b+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgDRUwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgDRUwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:52:36 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9872C061A0F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:52:34 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id m2so4726413lfo.6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s/MCXYluiV/Di6rRKjHU/d4NnQSkJUzqjX8QxIsHmUc=;
        b=IeynsinqAESZ7D5iH0Mw7AG00cif0HeQeEDlNnZHliL9sMslW01AUBwTualDAKcx6x
         vICf3ReOAIMcS25qObUhbwk3qGc/BhprOp/3VHZEytcvQY4Pv2D4bBv88lxtaCvewGqg
         DnGnok45WuhxHNH5EwyksqWHkDHRbvN//rwvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s/MCXYluiV/Di6rRKjHU/d4NnQSkJUzqjX8QxIsHmUc=;
        b=X1dcQJhZr20g18p781T0toQHxmtdlOJfFdjsn/k6C1FcmzeDRJ+wQCgpuF/XBoYuwB
         /ruG8sJDsIlEAxQtYf+DmUKY6DwMKoRCBdDuQ8ZR6G5MgYqD2n3KkFIajfue/Q/WAO/v
         SN9OKUvA2kte+pNgW+rMjc5Na3KByuWdzJpwLFZk0tL+pGZKTCe9TGWgE0MhbV3FewY9
         wyWOfsoQxO4fqpo01Z2T7ul3lI4LGVWMavpMQOWlGtJsSGOUTcS+sWg5QVa/ML+Ao7VV
         jPr4qdFp16Brw/wWom8kErOp6oz2kj3AmSV2BTBowi1hIcdcn9BcamW64m1sl2BfcS7l
         iybQ==
X-Gm-Message-State: AGi0PuYIa+eUFSRONeGQolnIZrMnL8QSNYgF4qyZlx+Hjo0xRZu9CfMV
        x/hyzs24KMHddloRfGXCQzGBbPvDVIQ=
X-Google-Smtp-Source: APiQypIl5tZF2mg24VmOyesBcu+yrQzijwWFKa1E3OkEaddv0Wk1NkP298WxjiwkswWycvnfnrD8Gg==
X-Received: by 2002:ac2:4551:: with SMTP id j17mr5770370lfm.147.1587243152674;
        Sat, 18 Apr 2020 13:52:32 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 64sm19322217ljj.41.2020.04.18.13.52.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 13:52:31 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id m2so4726356lfo.6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:52:31 -0700 (PDT)
X-Received: by 2002:ac2:4466:: with SMTP id y6mr5848677lfl.125.1587243150793;
 Sat, 18 Apr 2020 13:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <67FF611B-D10E-4BAF-92EE-684C83C9107E@amacapital.net>
In-Reply-To: <67FF611B-D10E-4BAF-92EE-684C83C9107E@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Apr 2020 13:52:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjePyyiNZo0oufYSn0s46qMYHoFyyNKhLOm5MXnKtfLcg@mail.gmail.com>
Message-ID: <CAHk-=wjePyyiNZo0oufYSn0s46qMYHoFyyNKhLOm5MXnKtfLcg@mail.gmail.com>
Subject: Re: [PATCH] x86/memcpy: Introduce memcpy_mcsafe_fast
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Erwin Tsaur <erwin.tsaur@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 1:30 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
> Maybe I=E2=80=99m missing something obvious, but what=E2=80=99s the alter=
native?  The _mcsafe variants don=E2=80=99t just avoid the REP mess =E2=80=
=94 they also tell the kernel that this particular access is recoverable vi=
a extable.

.. which they could easily do exactly the same way the user space
accessors do, just with a much simplified model that doesn't even care
about multiple sizes, since unaligned accesses weren't valid anyway.

The thing is, all of the MCS code has been nasty. There's no reason
for it what-so-ever that I can tell. The hardware has been so
incredibly broken that it's basically unusable, and most of the
software around it seems to have been about testing.

So I absolutely abhor that thing. Everything about that code has
screamed "yeah, we completely mis-designed the hardware, we're pushing
the problems into software, and nobody even uses it or can test it so
there's like 5 people who care".

And I'm pushing back on it, because I think that the least the code
can do is to at least be simple.

For example, none of those optimizations should exist. That function
shouldn't have been inline to begin with. And if it really really
matters from a performance angle that it was inline (which I doubt),
it shouldn't have looked like a memory copy, it should have looked
like "get_user()" (except without all the complications of actually
having to test addresses or worry about different sizes).

And it almost certainly shouldn't have been done in low-level asm
either. It could have been a single "read aligned word" interface
using an inline asm, and then everything else could have been done as
C code around it.

But no. The software side is almost as messy as the hardware side is.
I hate it. And since nobody sane can test it, and the broken hardware
is _so_ broken than nobody should ever use it, I have continually
pushed back against this kind of ugly nasty special code.

We know the writes can't fault, since they are buffered. So they
aren't special at all.

We know the acceptable reads for the broken hardware basically boil
down to a single simple word-size aligned read, so you need _one_
special inline asm for that. The rest of the cases can be handled by
masking and shifting if you really really need to - and done better
that way than with byte accesses anyway.

Then you have _one_ C file that implements everything using that
single operation (ok, if people absolutely want to do sizes, I guess
they can if they can just hide it in that one file), and you have one
header file that exposes the interfaces to it, and you're done.

And you strive hard as hell to not impact anything else, because you
know that the hardware is unacceptable until all those special rules
go away. Which they apparently finally have.

                Linus
