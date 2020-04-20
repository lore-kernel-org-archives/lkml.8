Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390CCC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1371F20782
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587417409;
	bh=r8TA6uD9fYsvYMYu3IZvy0milhQfcC2SrjN4L+PfHLk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pyrz5QhwKqMMAZLQxucxa0GuXnIbDsRYvEbQAgXABMuAc69ZGg1cpIcdhwLr5WrrU
	 gk/cKjBkjFNgeAXFqbYHjPZeR7HJ6mxUWgSUIMKPDqSdxXY5uywwEOJqEUL35g5CUo
	 EInbXUe65LwVeWtS6zi5siBgjdICWvnVrkxotRi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgDTVQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726123AbgDTVQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:16:47 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127E0C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:16:46 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q19so11649295ljp.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2jN6r5vrIi0padwgEOntdkWRPVKTeqU1oUMQLiCc9u8=;
        b=RVMGvgq4dRxVUT5c5yRM7AhK9ONOictyu7KmC/oVUe3820d9C3IZ+Cl66v1+icCDF2
         QgktcgmK+enRUmEsD4pcjlFOgbs2CCGzmQZ3a/E9nbtEQg0f5RbB2c6ns7l8HoIvYshY
         AzHkoLW3JYQL1BBA+DEehjxgRjaVjJWqfueOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2jN6r5vrIi0padwgEOntdkWRPVKTeqU1oUMQLiCc9u8=;
        b=l5AwXGnONWcov8Xho+EBjlYmjv4jTd+Wr3507UCMrqYxSAjp4PbwJVtYjHMaA+Mm8W
         oX1wXUFax8qutzpeQkBJK9dVQjdgnMTrFfyzPBss371kKd28TsWev60lCxhwIS/WOyW3
         EfWJ/fLFcKSn/K79Y+qvPCr91Kw1W/AxWyjrd7M00SIayBvbP9BOSbykgjogWO/9QqiG
         n3k7fyQCDRNZhA/1FWJBdWyKlZp1PCrsVZePdbpUEqiRSKo9oCLq1/7XMQrxThhGC0wZ
         5v634CETatUvMCkB0zzUR1BQ760A9PSXFx1HMqkGGmH4BGhukifBmIU+0A8tyWEDICMZ
         HfEA==
X-Gm-Message-State: AGi0Pua1T8zOf/Nv40YgDZie/f1BmMKFnxSp37mWH+vvC5aFxFuMNUsm
        WV50JvyLqFzYALQ9LNTVLBgB7br2j7k=
X-Google-Smtp-Source: APiQypJCuF0bKJ+yLO9uO7pgGmt02vkWgBlG9sux+faIXS1XekjMMuKX5eOa6+QEthSWZ9yrcP3qQg==
X-Received: by 2002:a2e:8944:: with SMTP id b4mr11486184ljk.84.1587417403210;
        Mon, 20 Apr 2020 14:16:43 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id s8sm413056lfd.61.2020.04.20.14.16.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 14:16:41 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id u15so11702632ljd.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:16:41 -0700 (PDT)
X-Received: by 2002:a2e:7c1a:: with SMTP id x26mr10530724ljc.209.1587417401085;
 Mon, 20 Apr 2020 14:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <67FF611B-D10E-4BAF-92EE-684C83C9107E@amacapital.net>
 <CAHk-=wjePyyiNZo0oufYSn0s46qMYHoFyyNKhLOm5MXnKtfLcg@mail.gmail.com>
 <CAPcyv4jQ3s_ZVRvw6jAmm3vcebc-Ucf7FHYP3_nTybwdfQeG8Q@mail.gmail.com>
 <CAHk-=wjSqtXAqfUJxFtWNwmguFASTgB0dz1dT3V-78Quiezqbg@mail.gmail.com>
 <CAPcyv4hrfZsg48Gw_s7xTLLhjLTk_U+PV0MsLnG+xh3652xFCQ@mail.gmail.com>
 <CAHk-=wgcc=5kiph7o+aBZoWBCbu=9nQDQtD41DvuRRrqixohUA@mail.gmail.com>
 <CAPcyv4iTaBNPMwqUwas+J4rxd867QL7JnQBYB8NKnYaTA-R_Tw@mail.gmail.com>
 <CAHk-=wgOUOveRe8=iFWw0S1LSDEjSfQ-4bM64eiXdGj4n7Omng@mail.gmail.com>
 <CAPcyv4hKcAvQEo+peg3MRT3j+u8UdOHVNUWCZhi0aHaiLbe8gw@mail.gmail.com>
 <CAHk-=wj0yVRjD9KgsnOD39k7FzPqhG794reYT4J7HsL0P89oQg@mail.gmail.com> <3908561D78D1C84285E8C5FCA982C28F7F5FB29E@ORSMSX115.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F5FB29E@ORSMSX115.amr.corp.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Apr 2020 14:16:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjcwJd6+HVQNYdssNONWUx1=orzRKkVyr7+t2x9Ydcwsw@mail.gmail.com>
Message-ID: <CAHk-=wjcwJd6+HVQNYdssNONWUx1=orzRKkVyr7+t2x9Ydcwsw@mail.gmail.com>
Subject: Re: [PATCH] x86/memcpy: Introduce memcpy_mcsafe_fast
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Tsaur, Erwin" <erwin.tsaur@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 1:57 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> >  (a) is a trap, not an exception - so the instruction has been done,
> > and you don't need to try to emulate it or anything to continue.
>
> Maybe for errors on the data side of the pipeline. On the instruction
> side we can usually recover from user space instruction fetches by
> just throwing away the page with the corrupted instructions and reading
> from disk into a new page. Then just point the page table to the new
> page, and hey presto, its all transparently fixed (modulo time lost fixing
> things).

That's true for things like ECC on real RAM, with traditional executables.

It's not so true of something like nvram that you execute out of
directly. There is not necessarily a disk to re-read things from.

But it's also not true of things like JIT's. They are kind of a big
thing. Asking the JIT to do "hey, I faulted at a random point, you
need to re-JIT" is no different from all the other "that's a _really_
painful recovery point, please delay it".

Sure, the JIT environment will probably just have to kill that thread
anyway, but I do think this falls under the same "you're better off
giving the _option_ to just continue and hope for the best" than force
a non-recoverable state.

For regular ECC, I literally would like the machine to just always
continue. I'd like to be informed that there's something bad going on
(because it might be RAM going bad, but it might also be a rowhammer
attack), but the decision to kill things or not should ultimately be
the *users*, not the JIT's, not the kernel.

So the basic rule should be that you should always have the _option_
to just continue. The corrupted state might not be critical - or it
might be the ECC bits themselves, not the data.

There are situations where stopping everything is worse than "let's
continue as best we can, and inform the user with a big red blinking
light".

ECC should not make things less reliable, even if it's another 10+% of
bits that can go wrong.

It should also be noted that even a good ECC pattern _can_ miss
corruption if you're unlucky with the corruption. So the whole
black-and-white model of "ECC means you need to stop everything" is
questionable to begin with, because the signal isn't that absolute in
the first place.

So when somebody brings up a "what if I use corrupted data and make
things worse", they are making an intellectually dishonest argument.
What if you saw corrupted data and simply never caught it, because it
was a unlucky multi-bit failure"?

There is no "absolute" thing about ECC. The only thing that is _never_
wrong is to report it and try to continue, and let some higher-level
entity decide what to do.

And that final decision might literally be "I ran this simulation for
2 days, I see that there's an error report, I will buy a new machine.
For now I'll use the data it generated, but I'll re-run to validate it
later".

                 Linus
