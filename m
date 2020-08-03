Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C1CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D99220678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgHCKGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 06:06:47 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41454 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgHCKGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:06:46 -0400
Received: by mail-ot1-f65.google.com with SMTP id a65so18318855otc.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 03:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OpbEohH8OUi/epyUcg1f5tBFIW7tKev1cp8OSm9Qyi4=;
        b=n6XYC6aSPyxdP+K8fleJR77XF/g6c4k7ygEXE+1JJ/EPDGebbj3WEoOi/Il1gkrl4x
         fxSNYz7rgjaRxUrdzYyaxtuVdSg/UTB9c3hI4tIRbRm6oNj1ZtrPqmu3R6VBEkpt4Du4
         IuQ1OpVQEaR9ls8aoGsmZjd1oJTH09O7ioQcI2mzZUi6SRGiHpbiOs1vguQzQhvhl+o3
         6REPBgYOVFxbI6nRV6rVqTW45ZNX5LdcHM7cETt7irDdYVUB08CEUzONEMhOQRxosnQH
         yk+Yn314ckYaZXSmClkBRAigeaVflBkNqCnejbytlwvgJC978EBnGbPV+hahSSQs9PiU
         I6ZA==
X-Gm-Message-State: AOAM531M1+v8KGmP/VFhiS5G7QqHphy9sAa0Cej3lkD0AlFTz72aK5sX
        U8PR+SP9ovKKoYXz7SDM+py2h3l2vKSXEkoU7o0=
X-Google-Smtp-Source: ABdhPJx6E8jYekM61xWgh5QG5QIcwianLym1nuVniubEPeWhR5+9U4zRKDcBThxt+YKKXL5S6joXDgPgsop9nM33pkg=
X-Received: by 2002:a9d:7d8c:: with SMTP id j12mr13074211otn.250.1596449205821;
 Mon, 03 Aug 2020 03:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200624035920.835571-1-natechancellor@gmail.com>
 <CAMuHMdU_KfQ-RT_nev5LgN=Vj_P97Fn=nwRoC6ZREFLa3Ysj7w@mail.gmail.com> <20200720210252.GO30544@gate.crashing.org>
In-Reply-To: <20200720210252.GO30544@gate.crashing.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Aug 2020 12:06:34 +0200
Message-ID: <CAMuHMdUmHE-KVQuo=b2rn9EPgmnqSDi4i16NPbL5rXLLSCoyKg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/boot: Use address-of operator on section symbols
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
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

Hi Segher,

On Mon, Jul 20, 2020 at 11:03 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> On Sat, Jul 18, 2020 at 09:50:50AM +0200, Geert Uytterhoeven wrote:
> > On Wed, Jun 24, 2020 at 6:02 AM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >         /* If we have an image attached to us, it overrides anything
> > >          * supplied by the loader. */
> > > -       if (_initrd_end > _initrd_start) {
> > > +       if (&_initrd_end > &_initrd_start) {
> >
> > Are you sure that fix is correct?
> >
> >     extern char _initrd_start[];
> >     extern char _initrd_end[];
> >     extern char _esm_blob_start[];
> >     extern char _esm_blob_end[];
> >
> > Of course the result of their comparison is a constant, as the addresses
> > are constant.  If clangs warns about it, perhaps that warning should be moved
> > to W=1?
> >
> > But adding "&" is not correct, according to C.
>
> Why not?
>
> 6.5.3.2/3
> The unary & operator yields the address of its operand.  [...]
> Otherwise, the result is a pointer to the object or function designated
> by its operand.
>
> This is the same as using the name of an array without anything else,
> yes.  It is a bit clearer if it would not be declared as array, perhaps,
> but it is correct just fine like this.

Thanks, I stand corrected.

Regardless, the comparison is still a comparison between two constant
addresses, so my fear is that the compiler will start generating
warnings for that in the near or distant future, making this change
futile.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
