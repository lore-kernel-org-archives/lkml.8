Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69325C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 320A72070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LP2INSYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgG2WD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2WD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 18:03:56 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495FFC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 15:03:56 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f1so22467262wro.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 15:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E4PKYzgH7Xt5Ygpx63duAD8XNCgXcZTvrVIXz3IBuMA=;
        b=LP2INSYG4hKopzUpJZJa/6pi4BSMDCi2ktjH6BCcAOqnKRq2DvT2CUmAuMpbNI4fK+
         aQawXlFxnrIHKNG+Bye8zE40vTjsd3RRfhT0JZs74TceGygp7LiyXm56TCXBoQAIf5N1
         RBCu5uembtJ4mMYo60FQ/VaFReUo5/S34N4D/lbWjtqYjAc8sFYWwfAXojtXBxeAhMjo
         fi4Vc6TqM5LoN4ncZhR3lbho67OauxB5AVj0WEOlpV+gWcwHRWlR1pkNuNbFBSlV7XSV
         7qIdpkwtJDtEGPGx6z1uqft8tjoOKfSRrrLC0RqvYg23LvH3Rt1ZDu46fCp8QeglR3Xg
         CS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E4PKYzgH7Xt5Ygpx63duAD8XNCgXcZTvrVIXz3IBuMA=;
        b=sRoIT7cIhk5wUPy16zl+oS9ktly6Lw8D7Av/ZNfnF+2CM8EPoaL+Lfm9GWqRyy3Jxg
         v9/CqE+yDvSPX2h2Bi/F6hHwbrouWUSw4O0H40Rr0LBp1ccgbHd2UNzpz3DJDPEguKJA
         9zWc3m9ln4zPy7ZUAQrWBFQgnXQBovuwFW6rsmvtVBne4vDMxkoqLG1J5m/Mgy/FsZsr
         sIRHgrWb024u+mW2Z0fdgspbg0IVqXNWez2MtKg5n1Wlv9cWN5Q+PjeKEdAA5xarzJrD
         PB8hA992irFmAVL2gObrCyOkuxhZambU4VX3/jZQdTvMmWRrpkJJL4SDA40iI6WqoLrf
         iL/g==
X-Gm-Message-State: AOAM532VVMde/EaxUb+LleB/HSGLz8HpZXpVkOWawxYPqRqHAjLkNMus
        cEjMQEaemHxlrp2tdtWeY+UDpxIwNhCnQ01/UKrl/g==
X-Google-Smtp-Source: ABdhPJwVB2BFzw0JMuu4oCPLjFjsBcaAa7wcPZm1oB3VAXSsAXunqBNt2BQM7g9xPctBrfgQElpZDr/APliK73o0U+k=
X-Received: by 2002:adf:fe0c:: with SMTP id n12mr463074wrr.48.1596060234829;
 Wed, 29 Jul 2020 15:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200724071959.3110510-1-irogers@google.com> <20200728115152.GB3328@kernel.org>
 <20200729195918.GE433799@kernel.org> <20200729204409.GF433799@kernel.org>
In-Reply-To: <20200729204409.GF433799@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 29 Jul 2020 15:03:43 -0700
Message-ID: <CAP-5=fUogdWNHzWF8TYFVTSmKHTPq=jvb7XxYEiEu9qo6-4T+w@mail.gmail.com>
Subject: Re: [PATCH] perf bench: Add benchmark of find_next_bit
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 1:44 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Jul 29, 2020 at 04:59:18PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Jul 28, 2020 at 08:51:52AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Fri, Jul 24, 2020 at 12:19:59AM -0700, Ian Rogers escreveu:
> > > > for_each_set_bit, or similar functions like for_each_cpu, may be hot
> > > > within the kernel. If many bits were set then one could imagine on
> > > > Intel a "bt" instruction with every bit may be faster than the function
> > > > call and word length find_next_bit logic. Add a benchmark to measure
> > > > this.
> > >
> > > Thanks, applied.
>
> > > > This benchmark on AMD rome and Intel skylakex shows "bt" is not a good
> > > > option except for very small bitmaps.
> >
> > > > +++ b/tools/perf/bench/find-bit-bench.c
> >
> > > > +#if defined(__i386__) || defined(__x86_64__)
> > > > +static bool asm_test_bit(long nr, const unsigned long *addr)
> > > > +{
> > > > + bool oldbit;
> > > > +
> > > > + asm volatile("bt %2,%1"
> > > > +              : "=@ccc" (oldbit)
> > > > +              : "m" (*(unsigned long *)addr), "Ir" (nr) : "memory");
> > > > +
> > > > + return oldbit;
> >
> > Some old clang versions are not liking this:
>
> Failed with:
>
>   clang version 3.8.0 (tags/RELEASE_380/final)
>   clang version 3.8.1 (tags/RELEASE_381/final)
>   clang version 4.0.0 (tags/RELEASE_400/final)
>   Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
>   Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
>   Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
>   Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
>
> Worked with:
>
>   Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
>   Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
>   Alpine clang version 10.0.0 (git://git.alpinelinux.org/aports 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
>
>
> Also failed for;
>
> # grep FAIL dm.log/summary  | grep -v alpine
>  alt:p8: FAIL
>    clang version 3.8.0 (tags/RELEASE_380/final)
>  alt:p9: FAIL
>    clang version 7.0.1
>  amazonlinux:1: FAIL
>    clang version 3.6.2 (tags/RELEASE_362/final)
>  amazonlinux:2: FAIL
>    clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
> #

Thanks, I added a __GCC_ASM_FLAG_OUTPUTS__ guard:
https://lore.kernel.org/lkml/20200729220034.1337168-1-irogers@google.com/T/#u

Ian
