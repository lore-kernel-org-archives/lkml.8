Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE053C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37F920722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wI19RzK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgCYOzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:55:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39065 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgCYOzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:55:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id i20so2775452ljn.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 07:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tClvuEu9pWeb1x79xCQBbu9D0y79x9BZKfLEVx6id5I=;
        b=wI19RzK0wqnX7uLlPYQGV9dRj+z/hVLNVLPbB+8GBZJokXhcNQQQLwxzRMQzp8z1xL
         xo0ZoTkdH4hl4n7KcZ8cGvpFUUEUtFujUxCvCfpneaPWOsvyLg5s5qhOTtOD4xr2Vm7U
         e+gp7UDhEBlv6njzQz7K/7i1UzJjmLdNBXO63Kut8MtVp9C3UtQiwyc5L2TlH5m+xAUA
         FgMy+IYAyl4hW1hFnI19KvCerTF3iRVVibj5cKXJnDVHz/p35yaSgQez3YeEW47nH80l
         +L9hooquuP1D1mspFNNy2fq7JpL83dAL3mdPkjjFAHZk63yqNe8/A8l9ab/mIBCw+Nl3
         E3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tClvuEu9pWeb1x79xCQBbu9D0y79x9BZKfLEVx6id5I=;
        b=LOsqMdqiymPt5oCjFOyQctK+JD9kuEgyxk3YRBmAHv3Z639dtV9IASJOHmTl+Lqlzu
         HzCTw0BtpV9zLBHfSRQJcFf+hy3nWTUZse5hskN+W6wTRgiMG7D2rDCFcOIb8dYAasiB
         x31JEslBI224AstqG9b31cbE4+uXzkFGhMRqJhcv/U4expjmcFQFMpcXuTGhT/Thr9v3
         ByxweU9RCD8Hk4DGF17eObSz3VABXzNa33t+uHdorYdr+DLqz8MWphqUFOZseDPqC0Pi
         MZqqIsnHyQ6/rzbGoEC1BQoYyCdG5DREneH1u2pCN6R3vGNiCXC3jshnq1CG/IVjZE9w
         9tVA==
X-Gm-Message-State: ANhLgQ3x93KnQtGhCP1vJAlNyitH/ndjOxXtOsvuUQ3GpAnDVprohjsm
        cmZVvhqHuP6Xyqp3g/neZ4Xnvt4+zQKUkPp3D4bOcA==
X-Google-Smtp-Source: APiQypL8Qr4X286WSiXghK6eCjsBZaPQXYAe/v9k6tgkL3mtSNux4OVhLeLbtYNnWNlRoxanCdLDnL66kEACq4diAJ8=
X-Received: by 2002:a2e:b042:: with SMTP id d2mr2261110ljl.245.1585148127245;
 Wed, 25 Mar 2020 07:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtiroQnpwGu4oLA=ChmS==XGpmAAqB_Oa9nrXC3vQ0xsQ@mail.gmail.com>
 <20200325142323.GE14102@kernel.org>
In-Reply-To: <20200325142323.GE14102@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 25 Mar 2020 20:25:15 +0530
Message-ID: <CA+G9fYtr+Je4=pLWUgUvPNzUSUmg04oXPJ8zFwTRKji_udcZzA@mail.gmail.com>
Subject: Re: tools: Perf: build failed on linux next
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jolsa@redhat.com, Namhyung Kim <namhyung@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020 at 19:53, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Mar 25, 2020 at 07:37:10PM +0530, Naresh Kamboju escreveu:
> > Perf build broken on Linux next and mainline on x86_64.
> >
> > x86_64-linaro-linux-gcc: error: unrecognized command line option
> > '-m64/include/uapi/asm-generic/errno.h'
> > x86_64-linaro-linux-gcc: fatal error: no input files
> > compilation terminated.
> >   HOSTCC   /srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/perf-1.0/pmu-events/jevents.o
> >   MKDIR    /srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/perf-1.0/pmu-events/
> > x86_64-linaro-linux-gcc: warning: '-x c' after last input file has no effect
> >   HOSTCC   /srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/perf-1.0/pmu-events/jsmn.o
> > x86_64-linaro-linux-gcc: error: unrecognized command line option
>
> Right, there is some patch handling this, which we're trying to process
> but has some issues.

Thanks for responding on reported issue.

>
> - Arnaldo
