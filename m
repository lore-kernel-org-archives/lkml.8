Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DFDC35280
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 19:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B0352166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 19:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgEATrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 15:47:37 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:42097 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgEATrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 15:47:37 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mr8SG-1iqXej04RS-00oExn for <linux-kernel@vger.kernel.org>; Fri, 01 May
 2020 21:47:35 +0200
Received: by mail-qk1-f179.google.com with SMTP id h124so10288389qke.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 12:47:34 -0700 (PDT)
X-Gm-Message-State: AGi0PuYD55mm+N6tv356HBqD8VQxYbjKsKvdHc8CExoOUnOEqt6443Ie
        phxz7FIvmNKwWetHHOIKG4cAc2uaOmlEX02ke6c=
X-Google-Smtp-Source: APiQypIMMXBc+ZC9udlQgMgh20G/t+TBYExcY6lhHyuX30JjHrYL92Cl6+BVcERHYQ7AsKKfU8XAfPjfYpWxygu12cU=
X-Received: by 2002:a37:a492:: with SMTP id n140mr5339856qke.352.1588362453876;
 Fri, 01 May 2020 12:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <CAK8P3a2Gzj9SVZSGo+PxWR0cMJb1sFwv+ii9J6jEGE-Z41Fr+A@mail.gmail.com>
 <CAK8P3a3exNWHzv7pyV4yvn2hPxUswzSF=G3UJ=evykT5bjfEsw@mail.gmail.com>
 <20200501172616.GG3762@hirez.programming.kicks-ass.net> <20200501175022.yf3a34lu3ufui5ag@treble>
In-Reply-To: <20200501175022.yf3a34lu3ufui5ag@treble>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 1 May 2020 21:47:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3uiuS4g7eMtnq7ESQ5NZz5uwGDq7rJ5udQ84jf4T17-A@mail.gmail.com>
Message-ID: <CAK8P3a3uiuS4g7eMtnq7ESQ5NZz5uwGDq7rJ5udQ84jf4T17-A@mail.gmail.com>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:kCe/75rrtP5uA4CcPBLNPGdFw5wjx42O736SFohH1VHTTb1oie1
 4asOyfbwVlL3SgnQvKh9dYX4LWs2G9fVFhnHwurE8qpUK+OLnv08X0O4xdc7HeFMl4+DcBa
 Ev/jBZxsKhLOVS5rocbn+tg17XZt0SiAlck58jQxTY4Cr5VHB0IDxKaBK6W0zigk1wqo4Wh
 eg1LRlnWSGy0NaX+ivnnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8yX7Yxp8mcM=:yQJ0202Ded2+UXsRhLDX4Q
 66I5xQ4CGCl4BcuSWJAlmHBmBS/xeZ6FAvHaESBURnvVKfqrR/+5s5G0TNafbB7DqM38iTcNJ
 tog65Bg4V5Y653w4oyNP2AY5Xp33eeCqZ6X0z3X6c0ALmujpkawTx+GLb0EA3d2VkDqvLkGzn
 q1R1xrmCk0OlnwcUw82D+zt2FM4pfuA+VxxQtwA/Ohg0fFBr3gDFokqmrpv83sCCdSvWNoGg9
 Dvwy0K5EaF8VhwFN377FGsXCwm07n7YwoaIumJWXF/GZHi2lumWj6ad7L35EvIVlCn1D9aAQ4
 rpQspI0Ko1JEWkq+wVu+JG55Hxq3aXgfECWIlgC47xJEwULChprRyPu6C1bKr0h1fu85gxkIA
 fa7VNtiMmwyr2lk6vbzMQXmwxAt70u1s1OBuO9Gm1H2RNuq2Plxi1qa7nvO8q5neHH/b4A190
 Zj0b6UuzexwG3GkTHgodKMw5thejcagIkdRRf2cv7yLbSQGsps5HOIY5ftSKYH4DKjrFJFZ4E
 a9UBy48tIghq3wMEWACeLet7SoCDg34ST8FwY8BucvykxHu783cR2VJbiabKcSPY7QGT7f0kD
 O0b/CPQUm0uyPz81oeaU2C+GxRAdNIyfxrb2Dr0fb4GVuENsiaTI3lPjlYw1sfyQS7/REzNqf
 mqeGxu8it5fqSuNLsOHDGf0s2X17bjpPOYyjMAjRybUrCxZz8XwJGKZLbddm26fwxyXea608m
 TT4t7cQqUFXMX1LPj7MyepYWvbrh7gS/icF9Pein0R2eRnPMDJQv6hUZZwZdAIlbQ2n/ARZH6
 +3SlxlAq4DPYkRT4JRJWLHtBh/wqug8FzUzIFKb20yJQLolMEw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 1, 2020 at 7:50 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, May 01, 2020 at 07:26:16PM +0200, Peter Zijlstra wrote:
> > On Fri, May 01, 2020 at 07:21:31PM +0200, Arnd Bergmann wrote:
> > > On Thu, Apr 30, 2020 at 4:05 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > it gets into undefined behavior and stops emitting code after the call to
> >
> > > Do we consider this expected behavior on gcc's side, or is it something
> > > that should not happen and needs a gcc bug report?
> >
> > When it hits UB it is of course free to do whatever it damn well
> > pleases, but just stopping code gen seems a little extreme, at least
> > issue a WARN that something is up or so.
> >
> > Not sure how the GCC folks feel about this though.
>
> When we've seen truncated code flow like this in the past, it's either
> been a code bug (undefined behavior) or a GCC bug.  So this is new.
>
> Is it only seen with GCC_PLUGIN_SANCOV enabled?  Maybe (hopefully) it's
> an issue with the plugin and how it interacts with GCC 10.

This is not the plugin but the built-in -fsanitize-coverage=trace-pc. With
the reduced test case, I can also reproduce it on gcc-9.2 and gcc-9.3 but
not on gcc-8.4.

So far I have not been able to reproduce it without
-fsanitize-coverage=trace-pc,
as the automated creduce tends to run off into undefined behavior unless
I tell it to ignore runs that produce the objtool warning without the
-fsanitize-coverage=trace-pc flag.

       Arnd
