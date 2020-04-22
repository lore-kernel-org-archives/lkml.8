Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FCAC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BF972076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RHKYJuvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgDVQTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgDVQTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 12:19:09 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80D7C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 09:19:09 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id f13so1465520ybk.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 09:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MdFV6oxCT5U94DDUA8tMXvti7DUCxcfVIn4legiry/M=;
        b=RHKYJuvZpmyAPj3eqmYkeJwOcFp+ks7i8s+GO2DeBExw8MhxvzCBuz1k/2M9wn1MMc
         SBwb7m6dnbOh7Vq5Hot90q92Ypnx8ZdHgD3rpNJB4dSZmd2BTLIo0y+vElsYinww1uIt
         xfjKIFwVggOF68sLw+CHknIEK8zxF9VhHXxdH7Vxcl7LdzOJj5m0WI/8r3FpO1vQUgK2
         hZo7xEoiHiiMbscFsbHa0lbjZaEKlY0rVKDcQh3BL1NXlQ+Q9Vm0KEObmY9CZOgdv2Fn
         84AzYAtBQ5+ROkWXKF5dXXi8PBXPFaerd+4yvRxz5sGmbgu1gTWDOVPiJi5r3cdJMn+l
         6Inw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MdFV6oxCT5U94DDUA8tMXvti7DUCxcfVIn4legiry/M=;
        b=TcAjUq5mk0aGWe5ntD4qOEJVs5Vq3TNIW9QxjJLWikSCSWB6VUmjHvwDSVcVvvUZqN
         dQWaITjFrG6/UUv7aBYdbNAArGf4sqD+aKWTH24PD7543UAjxcH6VpGb17tLU6yG+qH2
         Y/+zyn1e8xbKKAXWk1Sbjv4cCxzMf3fKXUiVxT4lhz9cD38kTFVoCIB/Y9ajrw8nRTNa
         ujeZ0z3OTXWjhaodEStp127D+qz1ZXCJmUrqh8O7tjyn7scRktznY91pcNyrU+8ilxJv
         v5OCp89g5gnt30gEpphHB3NaNrDlmXADzxymWuoSpiaXB1Y46M1thEpHhMv8DCd5uqM+
         u3+g==
X-Gm-Message-State: AGi0PuY/aoH30O493mr2O2ZO2K5arWL+ueZG/ajTWLAxz1yjAYhZTcMd
        pKuutucS/B5d8Pnag3bUx0R1ZfLrSPjoK2iVaYaI3A==
X-Google-Smtp-Source: APiQypL/pYUKxSIInGr9Pqzne3qLZ830PwfqHGoOwDaRvdCHGewpfdrvXjb8ZABUQp4uhepnIU21Yu0TdhJzl5iJfI0=
X-Received: by 2002:a5b:9cb:: with SMTP id y11mr38625798ybq.177.1587572348432;
 Wed, 22 Apr 2020 09:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200422074809.160248-1-irogers@google.com> <20200422074809.160248-3-irogers@google.com>
 <20200422143840.GJ608746@tassilo.jf.intel.com> <CAP-5=fUnWAycQehCJ9=btquV2c3DVDX+tTEc85H8py9Kfehq4w@mail.gmail.com>
In-Reply-To: <CAP-5=fUnWAycQehCJ9=btquV2c3DVDX+tTEc85H8py9Kfehq4w@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 22 Apr 2020 09:18:57 -0700
Message-ID: <CAP-5=fUMFqiSFLbKA-XWStrePwxiYfq7Jk6mS9=F56Q9y-KVsA@mail.gmail.com>
Subject: Re: [PATCH 2/8] perf metrics: fix parse errors in cascade lake metrics
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 8:34 AM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Apr 22, 2020 at 7:38 AM Andi Kleen <ak@linux.intel.com> wrote:
> >
> > On Wed, Apr 22, 2020 at 12:48:03AM -0700, Ian Rogers wrote:
> > > Remove over escaping with \\.
> > > Remove extraneous if 1 if 0 == 1 else 0 else 0.
> >
> > So where do these parse errors happen exactly? Some earlier
> > patches introduced them as regressions?
>
> I'll work to track down a Fixes tag. I can repro the Skylakex errors
> without the test in this series, by doing:
>
> $ perf stat -M DRAM_Read_Latency sleep 1
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> for event (cha/event=0x36\,uma
> sk=0x21/).
> /bin/dmesg | grep -i perf may provide additional information.
>
> This was just the escaping issue. I'm less clear on the other cascade
> lake issue, and it is a bit more work for me to test on cascade lake.
> What is "if 1 if 0 == 1 else 0 else 0" trying to do? Perhaps hunting
> for the Fixes will let me know, but it looks like a copy-paste error.
>
> > The original metrics worked without parse errors as far as I know.
>
> The skylake issue above repros on 5.2.17 and so it seems like it is
> broken for a while. The test in this series will prevent this in the
> future, but without this patch that test fails.

The parse errors were introduced with the metrics, so they've never worked:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=fd5500989c8f3c3944ac0a144be04bae2506f7ba

I will send out a v2 with Fixes in the commit message but wanted to
wait in case there was any more feedback. In particular the fixes to
the new test and expr parser lex code. The lex code wasn't broken at
the time the metrics were added and should be working again after this
patch set.

Thanks,
Ian

> > If it fixes something earlier it would need Fixes: tags.
>
> Working on it. Thanks for the input!
>
> Ian
>
> > -Andi
