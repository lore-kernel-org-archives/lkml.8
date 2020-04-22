Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C03BC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E3C2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vx6ksF3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgDVPeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgDVPeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:34:16 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707EFC03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:34:15 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id o139so1370260ybc.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0swt+GeZSXW6Eflw++OF9bLRU7Pp5VCRQPX3j3z34UQ=;
        b=vx6ksF3hk5yh5M7mF0Mp+4K+xF/3TgLsEW6adSFK8R3F+l1DWxyl/+b6UDRlYvRKCl
         CAS/DrfANcNdkR8KsrMtGXt2ego+uLPunneqXzWSJgxW67jl/adIfR1KhWUbZSN9kuYj
         nNGtZc0aQR71uiqClRR7ho5JTvAZOwHH4ULND9p2NaIWBTAugbwq95rROIBdUiaxkXlp
         jf5XVQ3M9AL6MoJWdGHMFaHrxn5sUBlH9hF9PUkTmkn1XISq3HlIHZ7293R800zK0Xrm
         SS1JH1yxfsL/6xpx9kQncVvh2HgyABvW8Cn0xOAWTEiuvhkEbbS3zwA3kHP4xigvWxEm
         uEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0swt+GeZSXW6Eflw++OF9bLRU7Pp5VCRQPX3j3z34UQ=;
        b=JUlVrtacUFw5/Cdh8nPqgwabUgMvcamOWTyorWWRuM4Gjuva2En+RqQy6Jc9zlgvMt
         HvYuhCR3bvGpi++FQuLCF8SaVWu6oM/Z9ya4Lb9Pl7BTMb26DvsnoQK1ox8cIC9gdw7q
         wRbLgV+zOpdQRgxmt5hdeZDg6FaWx+wJDj7SnFyZHNUWairWXwbGh9PwBs6t/g9mJLhN
         IB5q8BQTnicr91jRfFODbIJcK8MG5tfel+ZM1xJ8MWWIccQUmTLd6QSIUuLXFwY4jDbw
         G3SdGndvQSglnx9NKtOJ7VxYXU1kqve0d1bMYQSOyzCc0OHObmXkVpgkuH61bXlrKHz+
         dxzw==
X-Gm-Message-State: AGi0PubN3eQd/TnoZjV4bzFqPFQDL4EIPgWeVOuWF11AyT2NT1DOX9JY
        hn7VA5x9jzx3u7/pzJALa1mavxGByU3dFtp8GTLigg==
X-Google-Smtp-Source: APiQypK8JN4UihZi6+27xjX6jnB0MFAW45iOjXQBCHIFJd5Ny0Wk6IyIRuue0WbgwHZMYsuI1WSSHPlViwnURMiLkw4=
X-Received: by 2002:a25:4443:: with SMTP id r64mr35953653yba.41.1587569654285;
 Wed, 22 Apr 2020 08:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200422074809.160248-1-irogers@google.com> <20200422074809.160248-3-irogers@google.com>
 <20200422143840.GJ608746@tassilo.jf.intel.com>
In-Reply-To: <20200422143840.GJ608746@tassilo.jf.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 22 Apr 2020 08:34:02 -0700
Message-ID: <CAP-5=fUnWAycQehCJ9=btquV2c3DVDX+tTEc85H8py9Kfehq4w@mail.gmail.com>
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

On Wed, Apr 22, 2020 at 7:38 AM Andi Kleen <ak@linux.intel.com> wrote:
>
> On Wed, Apr 22, 2020 at 12:48:03AM -0700, Ian Rogers wrote:
> > Remove over escaping with \\.
> > Remove extraneous if 1 if 0 == 1 else 0 else 0.
>
> So where do these parse errors happen exactly? Some earlier
> patches introduced them as regressions?

I'll work to track down a Fixes tag. I can repro the Skylakex errors
without the test in this series, by doing:

$ perf stat -M DRAM_Read_Latency sleep 1
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument)
for event (cha/event=0x36\,uma
sk=0x21/).
/bin/dmesg | grep -i perf may provide additional information.

This was just the escaping issue. I'm less clear on the other cascade
lake issue, and it is a bit more work for me to test on cascade lake.
What is "if 1 if 0 == 1 else 0 else 0" trying to do? Perhaps hunting
for the Fixes will let me know, but it looks like a copy-paste error.

> The original metrics worked without parse errors as far as I know.

The skylake issue above repros on 5.2.17 and so it seems like it is
broken for a while. The test in this series will prevent this in the
future, but without this patch that test fails.

> If it fixes something earlier it would need Fixes: tags.

Working on it. Thanks for the input!

Ian

> -Andi
