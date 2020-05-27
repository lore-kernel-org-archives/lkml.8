Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2375C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 21:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C56372088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 21:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DuAEPU1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgE0VAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 17:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgE0VAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 17:00:11 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC070C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 14:00:09 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id p123so11692yba.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 14:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VbTGqBEAJn7vOUI10dzvBC6GCHW95GnJA8YOb9SAJqI=;
        b=DuAEPU1cRI42BFnfXBzJAsWU1SICG9jB1tgTnRdUTLjbUdrAGZQIRRfIjyyb6rlaqd
         fQt3r6qWCtxqTEzLIA06d0rHSIeDAM59sIIy4xC7lqe48Fth1EFvVQZ1oZZCWZUc2wVo
         U1p06M58NHsCmXccWc7+OpTqVvMLfSx9E0zXXFIGw+rfyFyPxEaU4I4DZ9U1oYTWPQi6
         FvzHAiezxHxgjWTBiTsaFW3+XgZpvkAiQSbkzBqK9/ofQjfus3EWvocbbU/dDRyLqRd4
         mJDg+XWIUtWqbpIkaMNRgybB55pNMTydgGl3Pt30OLD42QultCXe86CGArrrE3ZUI38J
         JbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VbTGqBEAJn7vOUI10dzvBC6GCHW95GnJA8YOb9SAJqI=;
        b=kn2Ln9ZHBq/kTiZI/EcIlF2EqF2iL6dExZjFJfhyXbxc3XEmFs2a5Z/9MZ9Nroxax2
         KiCPuvnbBRDfoQc98uWKKHcOVyUK/uWdji6Vi2tfvmJwBBNZeqAtSvZWT/nVU25ar0P2
         D287fPA8gD9d8BWG+sQpAgavtiBiOXcw+2frwNRkQ3qpYypzwhRw6jNxG25S2WdDWs4K
         JNzSBeJ+rS/2M9cTuAlKHa3CpIe0tVsaVsCRxxk3bV7PXjx1AXuY8/amjfz11Hk6CyRS
         IidhTHapzqLWBdrb5Kyw7c6rDXh24jAwjCUCc0mTf3vr2jkHGR3L0vEzZBz9tqIE3jly
         Ujhg==
X-Gm-Message-State: AOAM530Kf+F2Y8OkGq1F+ak1uhW+aBna1vpsTPB1l1ypWlzsNpDSEusR
        I9tqPwRch3JXQaEHqW5DXGj31m6lLRu2f4m5cC5b6g==
X-Google-Smtp-Source: ABdhPJwfUT80P1C1eVddhqIGXH//SB7SDbS1Mdcx8uANWd4Vl3oEHWLuHKIHTCsGWi0CKOT/oqs/55ytVSWBfPa7Dag=
X-Received: by 2002:a25:5387:: with SMTP id h129mr145828ybb.47.1590613208522;
 Wed, 27 May 2020 14:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <1590544271-125795-1-git-send-email-steve.maclean@linux.microsoft.com>
 <CAP-5=fXGXqkTbSwKv7eq9UkPvVqRJXDm3E-XNxD8+5fmQk3bpg@mail.gmail.com> <MN2PR21MB15185419971A29EF52B8138FF7B10@MN2PR21MB1518.namprd21.prod.outlook.com>
In-Reply-To: <MN2PR21MB15185419971A29EF52B8138FF7B10@MN2PR21MB1518.namprd21.prod.outlook.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 27 May 2020 13:59:57 -0700
Message-ID: <CAP-5=fVHo262Lo_Re31wM8Bt0soJ-m51J7MEnwvdTg5P8J6e6A@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v4] perf inject --jit: Remove //anon mmap events
To:     Steve MacLean <Steve.MacLean@microsoft.com>
Cc:     Steve MacLean <steve.maclean@linux.microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Wed, May 27, 2020 at 12:27 PM Steve MacLean
<Steve.MacLean@microsoft.com> wrote:
>
> >> ** Implemented solution
> >>
> >> This patch solves the issue by removing // anon mmap events for any
> >> process which has a valid jit-<pid>.dump file.
> >>
> >> It tracks on a per process basis to handle the case where some running
> >> apps support jit-<pid>.dump, but some only support perf-<pid>.map.
> >>
> >> It adds new assumptions:
> >> * // anon mmap events are only required for perf-<pid>.map support.
> >> * An app that uses jit-<pid>.dump, no longer needs perf-<pid>.map
> >> support. It assumes that any perf-<pid>.map info is inferior.
> >>
> >> *** Details
> >>
> >> Use thread->priv to store whether a jitdump file has been processed
> >>
> >> During "perf inject --jit", discard "//anon*" mmap events for any pid
> >> which has sucessfully processed a jitdump file.
> >
> >
> > Thanks Steve this is an important fix! As //anon could be for malloc or other uses, should the stripping behavior be behind a flag?
> >
> > Ian
>
> I hadn't anticipated a need to preserve the //anon mmap events when profiling JIT generated code.
>
> As far as I know mmap events are captured by perf only for mapping code to symbols.  File mappings are kept
> by the change.  Only // anon mappings are stripped.  (Only for processes which emitted jitdump files.)
> And these are stripped only during the `perf inject --jit` step. I believe the // Anon mapping are only
> generally useful for mapping JIT code.
>
> I suppose if someone was trying to count mmap events it might be confusing, but `perf inject --jit` creates
> synthetic mmap file events which would also make this scenario confusing.
>
> I personally don't see a good reason to add a flag.  I also don't see a simple way either.  Not running `perf inject --jit`
> would preserve existing behavior w/o jitdump support.  Without stripping the anon events jitdump support is painfully
> broken....

Agreed that things are broken. In general only executable mappings are
held onto by perf, so it could be I'm over worrying about //anon
stripping breaking around memory allocations. We have some other use
cases for //anon at Google but they aren't impacted by jitdump. We
have also been trying to migrate jit caches to using memfd_create,
which has the same problem that this patch fixes for //anon. Fixing
memfd_create is a separate issue to //anon. I'll try to get a repro
for Java that demonstrates the problem and then add a Tested-by.

Thanks,
Ian
