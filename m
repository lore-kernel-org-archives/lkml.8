Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B76C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C656A206B9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X7ie4/cL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgDQVbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 17:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727889AbgDQVbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 17:31:17 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A183C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 14:31:16 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id i16so1780950ybq.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 14:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VlK4+w1QC00q805dbGzDfZYQ3w7WLZTC7nlE4Jl0fcw=;
        b=X7ie4/cLiKiBHIRiKqysqBt6Y8oXdxEA6RDt+c8ynb1e67Xu8xKs+thBLBFZAo+f79
         fzZB+s+AukisujpubGehpG2nMKzMIEL2glau4ScakRGjO3yR3Ixn5APSzfrdexLOMpBv
         zBn/lfWpo5ucEdY1Q9lFgz4TW8NMp2rppz6z0cxDxarWVn90Sk6s/sVNbcy4zTKecDkK
         jz26PKlLgP3cw75scAckydb3RpW64jmmC61LK6/QLBKFRMj3molcynG3s9DplLWJJaX4
         zNFauyQj8jxYN5VUK3iG0MX5obd90h8VHPk8jkjjf5qAPzrMWt5eGKr2xU+UCgb9j7B+
         o0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VlK4+w1QC00q805dbGzDfZYQ3w7WLZTC7nlE4Jl0fcw=;
        b=kmrHHbV/w7zP/dGEEfaULCp/0w6iwIkihsRsNOiqAuMZHQxoaPM8CQWovzEFnyvIvx
         hGoB+YdxC2XKo0lX+MTFslc5iFFuteGO9LmcXf2zAsKn31T9FGlvWHGuhiPFjPiUeR42
         QuiVV9MocmlTzR9MQ2ZcUNPnFlM/Fi9PLZottRU3QtFr5pLUbTBNYGxVaTc56htdjZVm
         u+/jISI0Hnr5MKsaEt+gSJLQNSWkgWPV6C9n7v6vjC/HGPfPXzCdIYtT5LxaBJtERfXw
         wvuoEfn9teH0o2QcFdo1U6OgDRT8r/SodplBqCd0osYUjwexbKXlxUCRiC0WxyY1NfF/
         NEWg==
X-Gm-Message-State: AGi0PuYi+EPmZ3nmWYAS+MS0CKi4kyTNP1KF7qV0mi0K1Ka5yv7E+b20
        oqSE1UsngTg1j7Pe08kCxmMoQGLDziTpxvEg+6mIlw==
X-Google-Smtp-Source: APiQypImoXwKVREQerXGn/Kx6PmgTQ/vEYsDXv8PGwramrEP9mVfP8fi8esMQq8EGb9BiQ5tbFomrYgHLBh24hhhB2o=
X-Received: by 2002:a25:4443:: with SMTP id r64mr1384458yba.41.1587159075073;
 Fri, 17 Apr 2020 14:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200417182842.12522-1-irogers@google.com> <20200417184536.GK20730@hirez.programming.kicks-ass.net>
In-Reply-To: <20200417184536.GK20730@hirez.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 17 Apr 2020 14:31:04 -0700
Message-ID: <CAP-5=fU=mBqrZYqMYSXd6_12YV43ZPNSqQ=8GCRj5ZAQRJperg@mail.gmail.com>
Subject: Re: [PATCH] perf/core: fix parent pid/tid in task exit events
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        KP Singh <kpsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 11:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Apr 17, 2020 at 11:28:42AM -0700, Ian Rogers wrote:
> > Current logic yields the child task as the parent.
> >
> > Before:
> > $ perf record bash -c "perf list > /dev/null"
> > $ perf script -D |grep 'FORK\|EXIT'
> > 4387036190981094 0x5a70 [0x30]: PERF_RECORD_FORK(10472:10472):(10470:10470)
> > 4387036606207580 0xf050 [0x30]: PERF_RECORD_EXIT(10472:10472):(10472:10472)
> > 4387036607103839 0x17150 [0x30]: PERF_RECORD_EXIT(10470:10470):(10470:10470)
> >                                                    ^
> >   Note the repeated values here -------------------/
> >
> > After:
> > 383281514043 0x9d8 [0x30]: PERF_RECORD_FORK(2268:2268):(2266:2266)
> > 383442003996 0x2180 [0x30]: PERF_RECORD_EXIT(2268:2268):(2266:2266)
> > 383451297778 0xb70 [0x30]: PERF_RECORD_EXIT(2266:2266):(2265:2265)
> >
>
> Fixes: .... ?

Fixes:  94d5d1b2d891 ("perf_counter: Report the cloning task as parent
on perf_counter_fork()")

Sorry, re-sending as plain-text was disabled on the message and so it
bounced on lkml. Took some digging to find the original commit :-)

Thanks,
Ian

>
> > Reported-by: KP Singh <kpsingh@google.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
