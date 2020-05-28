Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06CAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BEB5207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e0y1I6xJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgE1HaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE1HaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:30:00 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F52C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 00:30:00 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id p123so624021yba.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 00:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c1YZIM0NI3O15IOd4xkTWsL2Ny/d8Gc9EvoFnsaWV/M=;
        b=e0y1I6xJulTfUMoLWTdcHx8v1oQv1J3WyninmF7Lzab1xGOzYtjaHM5KE1vXeXEyXh
         zoEV4u+vlyOOwmEcswJofTCNK3PzIjDNMVF1UJvyWAjNk+aMmRM3JRQXOhV3sECN5Hzv
         VSTyoBG1Hsr7+KPIlR1MoLi8k6dlntC6RCfhBA3jdPL79g2GmKtWtyE/FC/XtFEspM+y
         oOZOu2Igk8LpkZsK1009hrds5i/NcAJduNAn2mQ4MmfbpPgMlWeQpSNWGvi7yJoH2Xvc
         /3s8Pd5QisgbbHLLzjCA3pr2rf9QIphVi0flBWnoXM8CpoaC/Giar19Uin8wv663ppVE
         pShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c1YZIM0NI3O15IOd4xkTWsL2Ny/d8Gc9EvoFnsaWV/M=;
        b=oSKzA/KSfh1k4Op+De/ZDFFAqxKnmhJM26J+A1aCiG4a+eGMcwyADCzGDG6jzVmoPL
         p4DKIHv1CZnAbztvh2mMHwMxkmoXR6vwxM3Os3S0McsodOT4PhywL2U7LYNO3mOvOKPx
         ooucoeLizKgtxxnwLIsLN9qAbyjUatcYVrnbfjBU9pvJyplo7kk6JO2TXVy2oYX52PWo
         WDQWbSOCiLZXJbp6Z8nDgLsRaSesMcyyCvpVulQc4mHU4J5FP3x8omXkfP3JrgBEcuzP
         OxBN6jI0EVHg4SbWiPI+p356tgutjE3wJGLMTCUhfywSfHAkZ4d4wHGZTafU3I7VmjeN
         Wgyg==
X-Gm-Message-State: AOAM532HcY0syMfqbwJqyUDBJjfRS6ERV10o7qH190rME/tHHk1uYRIi
        YMjLMvH9874mgMKSASkHXtJofe8W0fvg/Ma4oCSAIUzE
X-Google-Smtp-Source: ABdhPJy4ZRKo2zO0+kDVjKr7X+zUPGBOgOTHbYaOJDdxQJMR1HMzVo2Ct02ltOZt9QVlVUr0lottWZcIecJUxU4uO0U=
X-Received: by 2002:a25:be81:: with SMTP id i1mr3101725ybk.184.1590650999333;
 Thu, 28 May 2020 00:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200522065330.34872-1-nick.gasson@arm.com> <CAP-5=fU8CJzOttgVDSxqHQoRg_eZ1+sToywOiek+8vw4j2GykA@mail.gmail.com>
 <xgl9wo4ylyv5.fsf@arm.com> <CAP-5=fUXP7OVEAX+u7-t8VZ9d8xq747kWgdvC_s7=wiHg7iBSw@mail.gmail.com>
 <xgl9y2pcfzbz.fsf@arm.com>
In-Reply-To: <xgl9y2pcfzbz.fsf@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 28 May 2020 00:29:48 -0700
Message-ID: <CAP-5=fVR9YzVHbyzMZs5OufH6_fv095c2T7cGJDNz7tV9xxAqQ@mail.gmail.com>
Subject: Re: [PATCH] perf jvmti: remove redundant jitdump line table entries
To:     Nick Gasson <nick.gasson@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 9:39 PM Nick Gasson <nick.gasson@arm.com> wrote:
>
> On 05/28/20 02:08 AM, Ian Rogers wrote:
> >>
> >> I noticed it loses information when the Hotspot code cache is
> >> resized. I've been working around that by setting
> >> -XX:InitialCodeCacheSize and -XX:ReservedCodeCacheSize to large
> >> values. Does this help in your case?
> >
> > Thanks, I tried and also with Steve's patch:
> > https://lore.kernel.org/lkml/1590544271-125795-1-git-send-email-steve.maclean@linux.microsoft.com/
>
> Thanks for the reference! That patch fixes the problem I had with code
> cache resizing so the workaround above is no longer necessary.
>
> >
> > Trying something very basic like just the -version command with compile only:
> > /tmp/perf/perf record -k 1 -e cycles:u -F 6500 -o /tmp/perf.data java
> > -agentpath:/tmp/perf/libperf-jvmti.so -XX:+PreserveFramePointer
> > -XX:InitialCodeCacheSize=2G -XX:ReservedCodeCacheSize=2G
> > -XX:CompileOnly=1 -version
> > /tmp/perf/perf inject -i /tmp/perf.data -o /tmp/perf-jit.data -j
> > /tmp/perf/perf report -i /tmp/perf-jit.data
> >
> > I don't see any of the JDK classes but 35 unknown symbols out of 272.
> > The JDK classes are stripped to some degree iirc, but we should be
> > able to give a symbol name as we don't care about local variables and
> > like.
> >
>
> I tried this with latest perf/core and JDK 11 but I don't see any
> [unknown] from jitted-*.so. All the events are in "Interpreter": I think
> the options you want are -Xcomp -Xbatch rather than -XX:CompileOnly=1?
> The latter restricts compilation to the named method/package.
>
> There was a bug where no jitdump debug info was written for classes
> compiled without line tables. That was fixed by d3ea46da3 ("perf jvmti:
> Fix jitdump for methods without debug info").

Thanks, that fixed it! There are still two unknowns running -version
with Xcomp for me, I suspect they are both C2 stub routines as there
is some work necessary on these. Fwiw, I tried -client and fighting
the tiered compilation flags but to no avail.

Thanks,
Ian

> --
> Nick
