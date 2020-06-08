Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0ECC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 908FA206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mhdT/14/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgFHT4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgFHT4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:56:40 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C13C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 12:56:40 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id p70so16452957oic.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 12:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QI4DBqiHipPrknIn6E/MZB9oOApEWMv02YSz8O1GoXE=;
        b=mhdT/14/y+LuftE2pLrKRm0IWxTJRt61cO1+DoKJtrRZaHiFa83D6XIKMV21rQUvUM
         yKPuD1Z5Od3gE7jdhouLm0ZYbXtt5cetxSpR9fAiX7aeEpsUQopUx+0YdAu+hyL7vqDs
         FPz+o9bjxPDZxclk68ou2cgpTfI8gfp6ZoggJtbJCogXKOHAsB954ZofUpK2lyjZ8ETH
         +wCP4rjsWhc/gxxRn6QFj5Gv1AJaPY7FtygYzdXa9i2clqJkzxDfCVYa2BDPRS7zNXh3
         m9b69f+hV6ALOD4EOKin3TiWD84lwlVS4If07oMp/czF+bDKaOSN4ggIr1LwWYUdxJlk
         hySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QI4DBqiHipPrknIn6E/MZB9oOApEWMv02YSz8O1GoXE=;
        b=GaIHqqYmR/KD+57IuR1Jgr8UbAl8B++fQdp+TmQ5WQgsFJALEIQDIEYSWylkR/da6n
         7uhwVocghbMWKRTTGR8xG3rv1CZTphW8p2x9eqO/Yo39ANZk4kcN1XnAmct56Inhuk/M
         WpitvBmlxqTh2lUcc5alBZsUevmF/hSJLbiUiB3kyvn0n8svMRMRZnz3gbUbfRLEYK/J
         FvWuHRM03Xxpzg4ImQcNynPf3TUPoFMXVrNc15Orog228HaYGL73/dipoHsRSIYruK32
         HcnBeVEVFVAdzuRrV+jjp6WAxmeGEjQOzp5ALCBbefXWl32LTKMp2S/TbMnQtZxX4lYH
         ylHQ==
X-Gm-Message-State: AOAM5315PaP+cDdvQLH8fsIRpmD89GjbMYRom44ULVTImki9iMGAYMBH
        tGy4++CCwGke5VAoZyYYW2ETCKPG1JoqH/hpC2nTfw==
X-Google-Smtp-Source: ABdhPJw7mGQpUxVFbuvjiMKl0lQ+CQSX9cQTTq2S1vcZhHzOJE7gr55nvYM9qbmEF6JZhVRyvkq8qPPkNqcZXcW/sig=
X-Received: by 2002:aca:530e:: with SMTP id h14mr812444oib.172.1591646199540;
 Mon, 08 Jun 2020 12:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200513124021.GB20278@willie-the-truck> <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
 <20200513165008.GA24836@willie-the-truck> <CANpmjNN=n59ue06s0MfmRFvKX=WB2NgLgbP6kG_MYCGy2R6PHg@mail.gmail.com>
 <20200513174747.GB24836@willie-the-truck> <CANpmjNNOpJk0tprXKB_deiNAv_UmmORf1-2uajLhnLWQQ1hvoA@mail.gmail.com>
 <20200513212520.GC28594@willie-the-truck> <CANpmjNOAi2K6knC9OFUGjpMo-rvtLDzKMb==J=vTRkmaWctFaQ@mail.gmail.com>
 <20200514110537.GC4280@willie-the-truck> <20200603185220.GA20613@zn.tnic>
 <20200603192353.GA180529@google.com> <87213fd1-950d-c2d5-4aa0-2f53ea3b505c@suse.cz>
In-Reply-To: <87213fd1-950d-c2d5-4aa0-2f53ea3b505c@suse.cz>
From:   Marco Elver <elver@google.com>
Date:   Mon, 8 Jun 2020 21:56:23 +0200
Message-ID: <CANpmjNNRz5OVKb6PE7K6GjfoGbht_ZhyPkNG9aD+KjNDzK7hGg@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
To:     =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>
Cc:     Borislav Petkov <bp@alien8.de>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jun 2020 at 19:32, Martin Li=C5=A1ka <mliska@suse.cz> wrote:
>
> On 6/3/20 9:23 PM, Marco Elver wrote:
> >
> >
> > On Wed, 03 Jun 2020, Borislav Petkov wrote:
> >
> >> On Thu, May 14, 2020 at 12:05:38PM +0100, Will Deacon wrote:
> >>> Talking off-list, Clang >=3D 7 is pretty reasonable wrt inlining deci=
sions
> >>> and the behaviour for __always_inline is:
> >>>
> >>>    * An __always_inline function inlined into a __no_sanitize functio=
n is
> >>>      not instrumented
> >>>    * An __always_inline function inlined into an instrumented functio=
n is
> >>>      instrumented
> >>>    * You can't mark a function as both __always_inline __no_sanitize,=
 because
> >>>      __no_sanitize functions are never inlined
> >>>
> >>> GCC, on the other hand, may still inline __no_sanitize functions and =
then
> >>> subsequently instrument them.
> >>
> >> Yeah, about that: I've been looking for a way to trigger this so that
> >> I can show preprocessed source to gcc people. So do you guys have a
> >> .config or somesuch I can try?
> >
> > For example take this:
> >
> >       int x;
> >
> >       static inline __attribute__((no_sanitize_thread)) void do_not_san=
itize(void) {
> >         x++;
> >       }
> >
> >       void sanitize_this(void) {
> >         do_not_sanitize();
> >       }
> >
> > Then
> >
> >       gcc-10 -O3 -fsanitize=3Dthread -o example.o -c example.c
> >       objdump -D example.o
>
> Hello.
>
> Thank you for the example. It seems to me that Clang does not inline a no=
_sanitize_* function
> into one which is instrumented. Is it a documented behavior ([1] doesn't =
mention that)?
> If so, we can do the same in GCC.

It is not explicitly mentioned in [1]. But the contract of
"no_sanitize" is "that a particular instrumentation or set of
instrumentations should not be applied". That contract is broken if a
function is instrumented, however that may happen. It sadly does
happen with GCC when a function is inlined. Presumably because the
sanitizer passes for TSAN/ASAN/MSAN run after the optimizer -- this
definitely can't change. Also because it currently gives us the
property that __always_inline functions are instrumented according to
the function they are inlined into (a property we want).

The easy fix to no_sanitize seems to be to do what Clang does, and
never inline no_sanitize functions (with or without "inline"
attribute).  always_inline functions should remain unchanged
(specifying no_sanitize on an always_inline function is an error).

Note this applies to all sanitizers (TSAN/ASAN/MSAN) and their
no_sanitize attribute that GCC has.

The list of requirements were also summarized in more detail here:
https://lore.kernel.org/lkml/CANpmjNMTsY_8241bS7=3DXAfqvZHFLrVEkv_uM4aDUWE_=
kh3Rvbw@mail.gmail.com/

Hope that makes sense. (I also need to send a v2 for param
tsan-distinguish-volatile, but haven't gotten around to it yet --
hopefully soon. And then we also need a param
tsan-instrument-func-entry-exit, which LLVM has for TSAN. One step at
a time though.)

Thanks,
-- Marco


> Thanks,
> Martin
>
> [1] https://clang.llvm.org/docs/AttributeReference.html#no-sanitize
>
> >
> > will show that do_not_sanitize() was inlined into sanitize_this() and i=
s
> > instrumented. (With Clang this doesn't happen.)
> >
> > Hope this is enough.
> >
> > Thanks,
> > -- Marco
> >
>
