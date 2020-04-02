Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01337C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8EC02078B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIvf+o6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387643AbgDBIKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:10:40 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:34799 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387449AbgDBIKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:10:40 -0400
Received: by mail-vk1-f193.google.com with SMTP id p123so647979vkg.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 01:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4bE/P5QRiIPVIk+HS8o/GuyaLeRlIHc/vpiFLIW3628=;
        b=LIvf+o6De+0RaBbwtWEoEAptfdZMe0Tu3sJeB1IA9SjLJC/XJdpmGPjoNToMA4Q69P
         I24Zs/XfThwmpkr2gNrGNryD5rN5zajr/uGIjyCep7d0g+gHWwU6z4NZ4MO04JN3o1wX
         x1pZdiSk0R63juyw5tB7bWFE9qBhCHLOoRE7HAAZ6I55ak0Yg/YRBbRsADxYJWaM5+5W
         391Lc3+RitaL46WTShZHt2EUfib1jpXpxbE3zB9yVBdoMGqWOHKTXxVcNZewuHwdlkIS
         4HARo33DpKQS4IUbZrPzZe6hLZ+9SIDoAX9v67GkIlujCC5oZZ/OJsnDZX+gmlryGHtU
         iX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4bE/P5QRiIPVIk+HS8o/GuyaLeRlIHc/vpiFLIW3628=;
        b=sGDp5fFIT/g6w5XNkr7vTaYhYB/mrpmDVYfAlEdGdaLPKQhP4JcCrjShUe9TxrrSdm
         DscJ5FgCLv9prTBfCikjheXl3E0JgjTNsX1LPbvL3mEy06/P1dBj2qvvQb+NtdluB3om
         NbH/+HQYsE/E6t/pj/L1WG8j1AWsM1+7+evRu48HsJJ5/wRHXK/CQq5ryRRec/kqhsK+
         qRg5zquJP5MUCbZLB/l+x6fPGBWGxld7ZlGei2ZSh6YaiOjl0x0Q0Ij1M7BjQmEemZAV
         /hF0BjgelSfGGjKvdk5JD2U4zsXG4NGoHFzTrEB1LnU0jPjwx+UZ048q58YUsSgzN9EG
         5lwQ==
X-Gm-Message-State: AGi0Pubsyd/kGT013lPU3/6IBOLUmiAEHpwyKYeVKdNzo5Gi+esNzxqC
        0eTOgqbafJ3Qv4/kjOm3k4F509juFlYOUJ1L4ew=
X-Google-Smtp-Source: APiQypIQJhYpg5u1nZdNMQEdZsk+1RgGZcHR8b75FyTrxYu2HsqvwSqJ6vfEmOoJXSI0oU69GPLvArhZCWJ/qrVNuEs=
X-Received: by 2002:a1f:a055:: with SMTP id j82mr1181103vke.75.1585815038690;
 Thu, 02 Apr 2020 01:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200327155355.18668-1-Eugeniy.Paltsev@synopsys.com>
 <20200327131020.79e68313@gandalf.local.home> <fe7ae84c-745a-04b4-dcc0-5df8cc35ee0c@synopsys.com>
In-Reply-To: <fe7ae84c-745a-04b4-dcc0-5df8cc35ee0c@synopsys.com>
From:   Claudiu Zissulescu Ianculescu <claziss@gmail.com>
Date:   Thu, 2 Apr 2020 11:10:27 +0300
Message-ID: <CAL0iMy3i5+_owqJcUKWzGNFakVV2P=oFdyAWCY2LP7YTusKP_Q@mail.gmail.com>
Subject: Re: [RFC] ARC: initial ftrace support
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ARC-gcc has two modes to call the mcount routines. When using elf32
configuration, the toolchain is set to use newlib mcount. When
configured for linux, gcc toolchain is using a library call to _mcall
(single underscore)  having blink as input argument.
So, using the proper linux toolchain, your patch should work.

//C

On Thu, Apr 2, 2020 at 4:17 AM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>
> +CC Claudiu
>
> On 3/27/20 10:10 AM, Steven Rostedt wrote:
> > On Fri, 27 Mar 2020 18:53:55 +0300
> > Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com> wrote:
>
> Maybe add a comment that gcc does the heavy lifting: I have following in glibc
>
> +/* this is very simple as gcc does all the heavy lifting at _mcount call site
> + *  - sets up caller's blink in r0, so frompc is setup correctly
> + *  - preserve argument registers for original call */
>
> >> +noinline void _mcount(unsigned long parent_ip)
> >> +{
> >> +    unsigned long ip = (unsigned long)__builtin_return_address(0);
> >> +
> >> +    if (unlikely(ftrace_trace_function != ftrace_stub))
> >> +            ftrace_trace_function(ip - MCOUNT_INSN_SIZE, parent_ip,
> >> +                                  NULL, NULL);
> >> +}
> >> +EXPORT_SYMBOL(_mcount);
> >
> > So, ARCv2 allows the _mcount code to be written in C? Nice!
>
> Yeah, the gcc backend for -pg was overhauled recently so it is a first class "lib
> call" meaning we get all the register save/restore for free as well as caller PC
> (blink) as explicit argument to _mcount
>
> void bar(int a, int b, int c) {
>         printf("%d\n", a, b, c);
> }
>
> bar:
>         push_s  blink
>         std.a r14,[sp,-8]
>         push_s  r13
>         mov_s   r14,r1
>         mov_s   r13,r0
>         mov_s   r0,blink
>         bl.d @_mcount
>         mov_s   r15,r2
>
>         mov_s   r3,r15   <-- restore args for call
>         mov_s   r2,r14
>         mov_s   r1,r13
>         mov_s   r0,@.LC0
>         ld      blink,[sp,12]
>         pop_s   r13
>         b.d     @printf
>         ldd.ab r14,[sp,12]
>
> @Eugeniy, this patch looks ok to me, but a word of caution. This won't work with
> elf32 toolchain which some of the build systems tend to use (Alexey ?)
>
> The above _mcount semantics is only implemented for the linux tool-chains.
> elf32-gcc generates "legacy" __mcount (2 underscores, blink not provided as arg)
> likely done by Claudiu to keep newlib stuff unchanged. Perhaps elf32 gcc can add a
> toggle to get new _mcount.
>
> And this is conditional to ARCv2 due to future ties into dynamic ftrace and
> instruction fudging etc ? We may have to revisit that for BE anyhow given such a
> customer lining up.
>
> -Vineet
