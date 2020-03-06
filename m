Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05D3C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B6E20848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fFTuuzfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgCFQsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:48:04 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36539 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFQsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:48:04 -0500
Received: by mail-yw1-f68.google.com with SMTP id j71so2801050ywb.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 08:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lGrpixY/KajztTvkMkDBT1B96BNvHODkOsGOZbkrSZg=;
        b=fFTuuzfOkYiCnZ22xZtNdK9HT0L4FN3pjpbu7Mt3PCD7eWN8c9uXTj4suVczbwfgy4
         w0QciTMDNjeTdzLGDagG9s7rsUpGpF/p4waeA24sc8cpZ93QfT+UJYBOfauXZj7m8/CD
         1rJDFb8dCv5HWMas6PsXUI7WCJ3pnGOOBtUzdAJI7DCkmmmb+bJYaH3o5O7gA+JK9qW7
         8yS8va3re029AHujFSq0y9gJUVmgEeTRxV/mG4WJnCaBo1ptoankpLZDEm4Rmp4KoDmR
         HQd9xo2eX5E5EPvHDeY552GSr8KCZFEEAc/wYJLlbAoOwlPXaZ72Jy1ywIh82fjtbjGX
         wPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lGrpixY/KajztTvkMkDBT1B96BNvHODkOsGOZbkrSZg=;
        b=jxRKdE/gZhsPFHYwrm67icVdhNjBiwlbu8d/nb1f32sQMNKhWhMSMx7Ga9+ebioZuo
         HkyNB9nmPQQQU3BhFxHRKhdjoiJFN+9X65K9e2Ip6cpCbIW728dssn+y+neh50c9HJnw
         PV5Cr+W1fCvYvF/E089y5H8P7SEeOm9BReiTaBT7+440ytnZVY05gH7mcAlpmIFYPPkn
         oU5uUSDOF7Vz3OpF/kvs/Nm0cn4qraDeijNebcBLzqU+et8VJM1I3Ek89ZTojGkbYto9
         ODcgVsS2vYpqaECl0mh6gfoeABPaOIdXr4YjyrsrsIij8nmLvn3+N1Ryx91PzArJCUTy
         5elQ==
X-Gm-Message-State: ANhLgQ2vRQ7UxW4Bcmo2lYuFKzslLWIGPwVPsvd90i+FfCPbLrs83Y8h
        s7JWjoKXrusljHmIiD+S0dqlwkKUgSegBV62kAUmiQ==
X-Google-Smtp-Source: ADFU+vtO7hopVToGmyqZtDqH5TSGNHXMUiLaDYLuVNZRG1Jjfq/LNjpZ7Z+IgbsUaZxcC0SX4tqHJZrEi3kxL0r0eng=
X-Received: by 2002:a25:c482:: with SMTP id u124mr4887325ybf.286.1583513282457;
 Fri, 06 Mar 2020 08:48:02 -0800 (PST)
MIME-Version: 1.0
References: <20200306071110.130202-1-irogers@google.com> <20200306071110.130202-2-irogers@google.com>
 <20200306093355.GB281906@krava>
In-Reply-To: <20200306093355.GB281906@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 6 Mar 2020 08:47:51 -0800
Message-ID: <CAP-5=fUAjMxGDWfev_q6vKhe1M5D1UdXhPK6x5Y9bxUbrJ-tNw@mail.gmail.com>
Subject: Re: [PATCH 1/3] tools: fix off-by 1 relative directory includes
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Li <liwei391@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 1:34 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Mar 05, 2020 at 11:11:08PM -0800, Ian Rogers wrote:
> > This is currently working due to extra include paths in the build.
>
> if you're fixing this, why not remove that extra include path then?

TL;DR it is complicated, but the include paths are all currently
necessary I believe and doing this way is necessary due to how header
files may be copied out of the kernel.

The current build uses multiple -Is to ensure the correct version of a
file is included, for example there are 27 files called bitops.h and
29 called bitsperlong.h. In
Google we're using libraries and bazel build files:
https://docs.bazel.build/versions/master/be/c-cpp.html#cc_library
and there's no way to say if you depend on this library then you need
this include path. We've tried to make perf this way but having tied
ourselves in knots we decided instead to emulate the include path
behaviour by rewriting includes when we import code using copybara:
https://github.com/google/copybara
We are able when doing this to prioritize the include paths we rewrite
so that a local directory version of a header is preferred over say
one in tools/lib/perf and perhaps tools/perf. Having full include
paths isn't really an option upstream as the same header file may be
copied into a libc project that has a different directory layout.
As we have absolute include paths at the time of building we need
relative include paths to be correct. Upstream -Is allow the build to
find the file but it is a bit of a quirk of the C preprocessor, so
fixing these off-by 1s feels like value add both for us and upstream.
For upstream to do anything different I think is going to be a
significant rewrite of how the Makefile build works and I'm not sure
what the result would look like.

Thanks!
Ian

> jirka
>
