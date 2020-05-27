Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8526AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A6862075A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DaauPIoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391898AbgE0SIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 14:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389335AbgE0SIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:08:37 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0569BC03E97D
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 11:08:37 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id l67so8404073ybl.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 11:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LilynF8mshIvC0Upgr8IPWCgl4tRTVI81vHoimM9wU4=;
        b=DaauPIoa8L08RuFPkYHXo1eLlJ0My32Hioosh1w8TaN0pV230njz7WYntz09Bhnjsd
         zONY/nXYWNpGNNuknWXaKvNHcyENSRPr2TeFghZcQmYTtb8fSkQnplIUi6KqNjH8RHr8
         8sRmFVkCG2GULzoQBHfyFj9Pv2HSqafrZ5S0dUuijjTG/nQPfK69gGaPVNFrcWLaWdJP
         iRkFRYSDhavxqkJ04d7cI3YxNZzULattlc0u/PGA2UbjHlFB0nlaUL+08kOl3ywFWeq6
         YpCtU5ht+KQYUIdMq9/eJJXYiWhU5gO7AhuJWwrd1O1wnHoD03eFuuBmAmSRwltZh+po
         RICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LilynF8mshIvC0Upgr8IPWCgl4tRTVI81vHoimM9wU4=;
        b=tRJcnIdEhvY245x6NOn6V8iT6lphp6rDrn/oRg4kU1CN2YjWsRlYxKOr6fAE3f2E/G
         a8ZO3cXOHinlbCZZUsZp2qVcOYFzF08H6GcgWmi5YnR4Ojwf5W15qQlX1Ovpq52Ve9Lq
         phitPASzRaR/Lj4ijxXBrDAMn4iQ3V5TlDvnujm78aCulXMQQkYK2f0cysE4GqQ0VNHq
         vTNUmdOQX+6A8In/PRBwPJU/wqGNh0L8k2H/JQriw/puwww2YRMxeSov5xxeNl27/5DD
         f8BDw8pmlYK6Xm8B1v/oCVf9ip6XYQvHQrBFJl3O8/hHsS8mok6mkNzz5+Ffx0ObPMP4
         dWMQ==
X-Gm-Message-State: AOAM532Oy8cgWX5NW+ckk1/SwTpim0L1yZB0FozsX8CwrvJekucZZEu7
        pOElYnicLZ0r6wwkQ6ekxHYoH7iA4hImY0nAIGnhJA==
X-Google-Smtp-Source: ABdhPJxcheuoiwLeBepunvKFsu4Yi/KigWG5nP2y/ME1+2ZWZvlsrsl3zUffJcbGV8N5Lf0oL/VtHktVCyu5D4G9dk8=
X-Received: by 2002:a25:5387:: with SMTP id h129mr10984884ybb.47.1590602915974;
 Wed, 27 May 2020 11:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200522065330.34872-1-nick.gasson@arm.com> <CAP-5=fU8CJzOttgVDSxqHQoRg_eZ1+sToywOiek+8vw4j2GykA@mail.gmail.com>
 <xgl9wo4ylyv5.fsf@arm.com>
In-Reply-To: <xgl9wo4ylyv5.fsf@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 27 May 2020 11:08:24 -0700
Message-ID: <CAP-5=fUXP7OVEAX+u7-t8VZ9d8xq747kWgdvC_s7=wiHg7iBSw@mail.gmail.com>
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

On Tue, May 26, 2020 at 10:40 PM Nick Gasson <nick.gasson@arm.com> wrote:
>
> On 05/27/20 13:03 PM, Ian Rogers wrote:
> >
> > Great result, thanks! I note there is a lack of symbolization when
> > benchmarking a few Java applications. I'll try to see if there's a
> > sensible resolution for those.
> >
>
> I noticed it loses information when the Hotspot code cache is
> resized. I've been working around that by setting
> -XX:InitialCodeCacheSize and -XX:ReservedCodeCacheSize to large
> values. Does this help in your case?

Thanks, I tried and also with Steve's patch:
https://lore.kernel.org/lkml/1590544271-125795-1-git-send-email-steve.maclean@linux.microsoft.com/

Trying something very basic like just the -version command with compile only:
/tmp/perf/perf record -k 1 -e cycles:u -F 6500 -o /tmp/perf.data java
-agentpath:/tmp/perf/libperf-jvmti.so -XX:+PreserveFramePointer
-XX:InitialCodeCacheSize=2G -XX:ReservedCodeCacheSize=2G
-XX:CompileOnly=1 -version
/tmp/perf/perf inject -i /tmp/perf.data -o /tmp/perf-jit.data -j
/tmp/perf/perf report -i /tmp/perf-jit.data

I don't see any of the JDK classes but 35 unknown symbols out of 272.
The JDK classes are stripped to some degree iirc, but we should be
able to give a symbol name as we don't care about local variables and
like.

This isn't a blocker for this patch and perhaps I'm special in seeing
this problem. Thanks,
Ian

> >
> > It'd be better to make this into two patches. Also on acme's perf/core
> > branch if possible:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf/core
>
> OK sure, I'll do that.
>
> --
> Nick
