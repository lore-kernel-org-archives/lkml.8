Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1EFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1C9E206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lF32krpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgHLNOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgHLNOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 09:14:45 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4805C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 06:14:44 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id a5so2343230ioa.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 06:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=79Y+QMDHezU/5SURd8Ma018LuzReHRkJThB2i60XPmw=;
        b=lF32krpO4NcmaJVg3GSzk3XwJJB5WCYVAl9nrA9tEULjvQDM4/2Esppyr6zdfgJuem
         lnD6DvUPJh0ZLb3qQT+MUoIpFyTqHaNe1hv5R95tCkzAwQlaAY/1upfAbl3pDehJS9fO
         qo8gEBztMC/SeqhIHikTr9j2H31MBu3VJ6ikQs/s/OxgWnsmBhnviI3uyFzb9KSBuTzM
         HB+35g0tGZlRNT3M/6YZn3lkxjSaf66tqhyNIVgmSG0Ef5v4f7x0585NokvUIP0n4oIK
         iU1XfBLzixoO3EfS4nOygsTzm8bhXAsGtB2QBp+Pd1/H+BmMqwpdPtAIbOE4xZLVPEGu
         V2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=79Y+QMDHezU/5SURd8Ma018LuzReHRkJThB2i60XPmw=;
        b=l/qeeJHoFUOyikfevf7tKy7VJ07ZeQ5qCIj7Jpzduq07RtSyFD5PM3owPvenhRxs0t
         5bpkG6uGfe9g/hMnvd0I/VuRtLkVmrtxJI/clnH0u9e7mTvqMnbxGf0UqB7m93UbkA2g
         7xHA8UlgpkdMOSY7FUb6KD2rz3g7TqJSS/2lIkN5k+k/mm/6dvuyzxwWUbmcEOiq7x3w
         x6UGcCx3yd47cJd4EyScgTRFSm8YV0+zBw4CBv1G9CaPDrdzCiAB+Nd/dr5n6oN/jpSg
         yA3NN5UButDjCNyqkLmXYONAgHQF67ffrMqvBD848n/FjzRyv0JytINJ4IMmRgxS6Rsn
         LHzA==
X-Gm-Message-State: AOAM5324yzzCwFMpVX0xSXnLXhwYtWM7MaoFHVocQC7TopRIXPxJ52zc
        KCsAsHkdU7chFoI2k+0WcwhyHjZ4jYS9IO+2SzE=
X-Google-Smtp-Source: ABdhPJzm7Ii2Y9Dh7M04BQ4c1S6/T30DEp63vJzfQBNjBxicvbkQWXd56m+UNfLzZoBCOgvokeRCjqT67GykjlZ3bsU=
X-Received: by 2002:a02:b159:: with SMTP id s25mr31218462jah.4.1597238084132;
 Wed, 12 Aug 2020 06:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200403171303.GK20760@hirez.programming.kicks-ass.net>
 <20200808101222.5103093e@coco.lan> <20200810092523.GA8612@linux-8ccs>
 <20200810150647.GB8612@linux-8ccs> <20200811163427.6edbf343@coco.lan>
 <20200811145524.GE2674@hirez.programming.kicks-ass.net> <20200811172738.2d632a09@coco.lan>
 <20200811160134.GA13652@linux-8ccs> <CAMj1kXF8fm=9CdQykqDbgYCJSP88ezMs3EOosCW+SDi+Lve0zg@mail.gmail.com>
 <20200812104005.GN2674@hirez.programming.kicks-ass.net> <20200812114127.GA10824@linux-8ccs.fritz.box>
In-Reply-To: <20200812114127.GA10824@linux-8ccs.fritz.box>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Wed, 12 Aug 2020 06:14:08 -0700
Message-ID: <CAMe9rOqVbZ=TmEtPXVU_rQbvNkmzht2bxs5qWuFzS3GLSbEOLQ@mail.gmail.com>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Binutils <binutils@sourceware.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miroslav Benes <mbenes@suse.cz>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 4:42 AM Jessica Yu via Binutils
<binutils@sourceware.org> wrote:
>
> +++ peterz@infradead.org [12/08/20 12:40 +0200]:
> >On Wed, Aug 12, 2020 at 10:56:56AM +0200, Ard Biesheuvel wrote:
> >> The module .lds has BYTE(0) in the section contents to prevent the
> >> linker from pruning them entirely. The (NOLOAD) is there to ensure
> >> that this byte does not end up in the .ko, which is more a matter of
> >> principle than anything else, so we can happily drop that if it helps.
> >>
> >> However, this should only affect the PROGBITS vs NOBITS designation,
> >> and so I am not sure whether it makes a difference.
> >>
> >> Depending on where the w^x check occurs, we might simply override the
> >> permissions of these sections, and strip the writable permission if it
> >> is set in the PLT handling init code, which manipulates the metadata
> >> of all these 3 sections before the module space is vmalloc'ed.
> >
> >What's curious is that this seems the result of some recent binutils
> >change. Every build with binutils-2.34 (or older) does not seem to
> >generate these as WAX, but has the much more sensible WA.
> >
> >I suppose we can change the kernel check and 'allow' W^X for 0 sized
> >sections, but I think we should still figure out why binutils-2.35 is
> >now generating WAX sections all of a sudden, it might come bite us
> >elsewhere.
>
> I have just tested with binutils-2.35 and am observing the same
> behavior. Both .plt and .text.ftrace_trampoline end up with
> SHT_PROGBITS and are marked 'WAX'. With binutils-2.34 they keep the
> NOBITS designation.
>
> I had thought NOLOAD implies NOBITS, but that doesn't seem to be the
> case anymore? I tinkered with module.lds a bit and noticed that the
> name of the section seems to matters. So this:
>
>   SECTIONS {
>       .plt (NOLOAD) : { BYTE(0) }
>       .init.plt (NOLOAD) : { BYTE(0) }
>       .text.ftrace_trampoline (NOLOAD) : { BYTE(0) }
> +     .test (NOLOAD) : { BYTE(0) }
> +     .text.test (NOLOAD) : { BYTE(0) }
> +     .plt.test (NOLOAD) : { BYTE(0) }
>   }
>
> Yielded the following:
>
>   [22] .plt              PROGBITS        0000000000000340 000e40 000001 00 WAX  0   0  1
>   [23] .init.plt         NOBITS          0000000000000341 000e41 000001 00  WA  0   0  1
>   [24] .text.ftrace_trampoline PROGBITS        0000000000000342 000e41 000001 00 WAX  0   0  1
>   [25] .test             NOBITS          0000000000000343 000e42 000001 00  WA  0   0  1
>   [26] .text.test        PROGBITS        0000000000000344 000e42 000001 00 WAX  0   0  1
>   [27] .plt.test         NOBITS          0000000000000345 000e43 000001 00  WA  0   0  1
>
> So ".plt" and any section starting with ".text" were automatically
> designated as SHT_PROGBITS and given the executable flag. It appears
> the NOLOAD directive has been ignored or overridden in the case of
> these sections. I am not sure if this is a bug in binutils or if this
> behavior is intentional.
>
> I tried to grok the changelog between 2.34 and 2.35 but could not find
> anything glaringly obvious that would cause this change. CC'ing the
> binutils mailing list, hopefully that's the right place to ask.
>

Please open a binutils bug with a testcase.


-- 
H.J.
