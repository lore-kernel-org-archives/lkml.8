Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BEFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA4820738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgHCLcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 07:32:41 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42480 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgHCLcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 07:32:41 -0400
Received: by mail-oi1-f195.google.com with SMTP id j7so16553769oij.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 04:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ODp5lgvPXWeexmhqKkzjrjceKYAAQRDTCREmTlObIIg=;
        b=NQWkbyWJHIH/Wb2su7XXy+dXfd/tDKWsibjTG5zcqq6JgOSDOwlDEfjdX7oSDP26J/
         krtE7nDnz4V1OmbBJlApLS1vZqJdJl20LHbUl1oCSc6zuIxWx6zdT01MovwIwyzkgcur
         sTkwIBBKfSEo+Px0PJJFslRwH50tuMV2Ri0kkie0W23nD2e7Sr5uTlUi07U6e04BqFxn
         /+bs3Pf8PnePSxs1WVZNEvSNEp6do4PqsXWJ76IqBu5gIebF1bD/3Oqy8A/453yEAg1g
         RO3+4rZ/cFjeTkxiD1vAXmI/Bf/27gZoeWNbIJD+kFQ6KlSt0BnAp0Y6NuAsJUqDnWEQ
         ObXA==
X-Gm-Message-State: AOAM533qLtNawgubk6P0X6xlIJwu/9VvWj+lc7k+5jClHAKn2KrPd1xC
        ClknaD8fgtrZWLLDiPi0BxeDTYe2sqhVWfrEthA=
X-Google-Smtp-Source: ABdhPJyPFQ4bw8IbXQ+CjhalgL4Bx9xrlY7fHPl0cviem9in0yCgtWtlZ6PfpQU6UGJ0f3n0i4tMiNiRZ3XlbDZ64t8=
X-Received: by 2002:aca:adc4:: with SMTP id w187mr11723507oie.153.1596454359917;
 Mon, 03 Aug 2020 04:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200624035920.835571-1-natechancellor@gmail.com>
 <CAMuHMdU_KfQ-RT_nev5LgN=Vj_P97Fn=nwRoC6ZREFLa3Ysj7w@mail.gmail.com>
 <20200720210252.GO30544@gate.crashing.org> <CAMuHMdUmHE-KVQuo=b2rn9EPgmnqSDi4i16NPbL5rXLLSCoyKg@mail.gmail.com>
 <87zh7cyoi7.fsf@mpe.ellerman.id.au>
In-Reply-To: <87zh7cyoi7.fsf@mpe.ellerman.id.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Aug 2020 13:32:28 +0200
Message-ID: <CAMuHMdXEsTuRkt5-dt08DuxHGLpQ=dZiJsNzff6gydgnzoPTLQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/boot: Use address-of operator on section symbols
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geoff Levand <geoff@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Mon, Aug 3, 2020 at 1:09 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > On Mon, Jul 20, 2020 at 11:03 PM Segher Boessenkool
> > <segher@kernel.crashing.org> wrote:
> >> On Sat, Jul 18, 2020 at 09:50:50AM +0200, Geert Uytterhoeven wrote:
> >> > On Wed, Jun 24, 2020 at 6:02 AM Nathan Chancellor
> >> > <natechancellor@gmail.com> wrote:
> >> > >         /* If we have an image attached to us, it overrides anything
> >> > >          * supplied by the loader. */
> >> > > -       if (_initrd_end > _initrd_start) {
> >> > > +       if (&_initrd_end > &_initrd_start) {
> >> >
> >> > Are you sure that fix is correct?
> >> >
> >> >     extern char _initrd_start[];
> >> >     extern char _initrd_end[];
> >> >     extern char _esm_blob_start[];
> >> >     extern char _esm_blob_end[];
> >> >
> >> > Of course the result of their comparison is a constant, as the addresses
> >> > are constant.  If clangs warns about it, perhaps that warning should be moved
> >> > to W=1?
> >> >
> >> > But adding "&" is not correct, according to C.
> >>
> >> Why not?
> >>
> >> 6.5.3.2/3
> >> The unary & operator yields the address of its operand.  [...]
> >> Otherwise, the result is a pointer to the object or function designated
> >> by its operand.
> >>
> >> This is the same as using the name of an array without anything else,
> >> yes.  It is a bit clearer if it would not be declared as array, perhaps,
> >> but it is correct just fine like this.
> >
> > Thanks, I stand corrected.
> >
> > Regardless, the comparison is still a comparison between two constant
> > addresses, so my fear is that the compiler will start generating
> > warnings for that in the near or distant future, making this change
> > futile.
>
> They're not constant at compile time though. So I don't think the
> compiler could (sensibly) warn about that? (surely!)

They're constant, but the compiler doesn't know their value.
That doesn't change by (not) using the address-of operator.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
