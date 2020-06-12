Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6334FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40DB62063A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cgQaVUl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgFLTd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgFLTd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:33:57 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B55C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 12:33:57 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id d13so5437426ybk.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 12:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mswfdgdzx+2TexQxeT06feX4kOyrZlalUeDchfsNWxg=;
        b=cgQaVUl66dmOWC5t0q3/ouZypSbshyuwE6f80bk75brPARaM0MyTEqK2QvKyQEdslB
         JiBb5IF/nTPwxEwj9coEf1MpKefh/4ghrl5zdfBGzfbA+y2fmlRYHkw1gT+r7n0wwojU
         Z0UpOpKEcy8sD/xcKIaQPgKwEEXSQuYHp9IvPZyYcRxRdM8ndsXwiLLVQzbx5nbx7wCS
         H2AOE1WDRMQK3sw072a0x77kDVOlcV/Kb4fyCK7+jm3QFuOxDn6HQlaLGXd+8mvHbQwu
         p6bBI/lajbUu245jV8YT6ZWyYNZWWrNsQKVbqGuJ/N08pW2IyRSmVdeRqueRBCv7G6nz
         0n+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mswfdgdzx+2TexQxeT06feX4kOyrZlalUeDchfsNWxg=;
        b=fIQHNh+mHd584SI/me5W+WwMYCxtPn95sOu7dDWr3aMmW7b4kjpNB8c2art254Lm4W
         p2/WdNEq/ixKVQn0KTLXpdZQiFUYdIL+E274vgL2VM5kjgFgvUgA+wXVBAPquML/PJNm
         NHCwVkODJjiJEWRfb6lSlZ1uNNnnEMWHnEGs7MVk05mwzWdeXS/1uc8+tXIfpr/WXoEu
         AX5QTqCaXDwYkQ+UEmzXtnbzgeUMP9HAOlNZ5s31irfvYvm0Zn+XUVuxpt2ABuXfueEB
         zGSluHnq8Fl5HVzy8Oc6Un4fpGrDKT5ilNyG+bgLCW9kUXTOjKwtUAVDuFrAKh3K527d
         CFWw==
X-Gm-Message-State: AOAM533gI4XD65QilzvdusXcgTBTQ6hkQ/rPwg5qfxjIm3AogoQoM1Pv
        ZpwsyYU8wc4iJ7hOordnQ7rS/VhHmVcXtgcoC/Fwrw==
X-Google-Smtp-Source: ABdhPJyv4L4NsWKN5DdRjnKIloj4J9A3nl5J4ILfDWzqVIYobS10xILJIvBpaycSpQhAe4r0vaglF7+Pa9dPOoUg7tQ=
X-Received: by 2002:a25:504d:: with SMTP id e74mr23139770ybb.47.1591990436306;
 Fri, 12 Jun 2020 12:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <1590544271-125795-1-git-send-email-steve.maclean@linux.microsoft.com>
 <CAP-5=fXGXqkTbSwKv7eq9UkPvVqRJXDm3E-XNxD8+5fmQk3bpg@mail.gmail.com>
 <MN2PR21MB15185419971A29EF52B8138FF7B10@MN2PR21MB1518.namprd21.prod.outlook.com>
 <CAP-5=fVHo262Lo_Re31wM8Bt0soJ-m51J7MEnwvdTg5P8J6e6A@mail.gmail.com>
 <CAP-5=fV7F4u66388HC-q8btOYWKxtb1gTTi4LK_Besb-zE25Rw@mail.gmail.com>
 <xgl9tuzvz4wc.fsf@arm.com> <CAP-5=fWU==y-DMd5sD7AxHCUNg0L4Qt_VRVvyDVNYPCOdxmU_A@mail.gmail.com>
 <xgl9mu5nyugm.fsf@arm.com> <BN7PR21MB166740321F6EACF49E9BC874F7810@BN7PR21MB1667.namprd21.prod.outlook.com>
In-Reply-To: <BN7PR21MB166740321F6EACF49E9BC874F7810@BN7PR21MB1667.namprd21.prod.outlook.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 12 Jun 2020 12:33:45 -0700
Message-ID: <CAP-5=fX_8eKTTifL_ikR6z+JN5FrC2pi8jq+hcJ2me1pR56_=w@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v4] perf inject --jit: Remove //anon mmap events
To:     Steve MacLean <Steve.MacLean@microsoft.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Nick Gasson <nick.gasson@arm.com>,
        Steve MacLean <steve.maclean@linux.microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 12:00 PM Steve MacLean
<Steve.MacLean@microsoft.com> wrote:
>
> >>> Hi Ian,
> >>>
> >>>> I tried this as well with latest perf/core. The difference is that
> >>> unresolved addresses currently look like:
> >>>
> >>>      0.00%  java             [JIT] tid 221782       [.] 0x0000ffff451499a4
> >>>      0.00%  java             [JIT] tid 221782       [.] 0x0000ffff4514f3e8
> >>>      0.00%  java             [JIT] tid 221782       [.] 0x0000ffff45149394
> >>>
> >>> But after Steve's patch this becomes:
> >>>
> >>>      0.00%  java             [unknown]              [.] 0x0000ffff58557d14
> >>>      0.00%  java             [unknown]              [.] 0x0000ffff785c03b4
> >>>      0.00%  java             [unknown]              [.] 0x0000ffff58386520
> >>>
> >>> I couldn't see any events that were symbolised before but are no
> >>> longer symbolised after this patch.
> >>
> >> I see this, thanks for digging into the explanation! Were you able to
> >> get a test case where the unknowns went down? For example, by forcing
> >> the code cache size to be small? This is the result I'd expect to see.
> >
> >I tried the same Dacapo benchmark as you with different values of InitialCodeCacheSize and grepped for -e '\[unknown\]' -e '\[JIT\]'.
> >
> >       Base   Patched
> > 100M  338    373
> > 50M   333    315
> > 25M   323    368
> > 15M   1238   309
> > 10M   2600   333
> > 1M    6035   337
> >
> >This looks fairly convincing to me: the cliff at 15M is where the code cache starts needing to be enlarged.
> >
>
> Removing the anonymous mappings causes a small regression.  Specifically,
> the reporting of the module name goes from "[JIT] tid <tid>" to "[unknown]".
> This occurs when the JIT fails to report memory used in jitdump before it
> is used.
>
> However there is also confirmation that JAVA does see the reported issue
> when using a small code cache.  The current patch resolves the issue in
> this case.
>
> I see two options:
>
> + Accept the regression. Since this is a regression for a jit dump
> reporting synchronization error, this may be a reasonable option.
>
> + Design a more complicated patch. Either
>     + Only strip parts of // anon mmap events overlapping existing
>       jitted-<pid>-<code_index>.so mmap events.
>     + Only strip parts of // anon mmap events overlapping prior
>       // anon mmap events
>
> Any opinions?

Hi Steve,

I think we should merge this change. I wanted to get a test case
together showing the benefit. Based on Nick Gasson's feedback I was
trying with command lines like:
/tmp/perf/perf record -k 1 -e cycles:u -o /tmp/perf.data
/usr/lib/jvm/java-14-openjdk-amd64/bin/java
-agentpath:/tmp/perf/libperf-jvmti.so -XX:+PreserveFramePointer
-XX:InitialCodeCacheSize=10M -jar dacapo-9.12-bach.jar jython

I wanted to be able to demonstrate a non-zero effect in getting
samples. I spent limited time on the test and didn't get a result that
demonstrated a benefit, things weren't worse. I think the lack of
benefit is another bug where HotSpot's JVMTI code runs in parallel to
the new code being available in the JIT cache. We get samples ahead of
when the jitdump thinks the code is there and so it symbolizes them as
unknown. We should get HotSpot to provide the earliest timestamp to
avoid this problem.

I think a good way forward would be to merge this code as other issues
can be fixed as a follow up. Arnaldo, does that work for you? If so,
Acked-by: Ian Rogers <irogers@google.com>.

Thanks,
Ian
