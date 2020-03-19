Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC34C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACED208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584626627;
	bh=FWXyAoEKtY5Oa0DXiGTrR1Ol2YqELjqm8FQSM8IA/fE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mYThBulOf930NB8qOSoc5VMVPRNPbqgeuzGaqtaRWtMeIxtxGYJ73EX722HLz6mzN
	 IIKRo09TvTAq65ggUjs1eZLsSBf4Jf8VrsBCU5mIMOqSVQ+9sFGutSbkdTKhgNkhFM
	 z4vyEoLWAsnitofT4HWdJWjr6XgMZWgJQ+vjTRv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgCSODq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:03:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44790 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCSODq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:03:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id o12so2621164wrh.11;
        Thu, 19 Mar 2020 07:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NHec6MbVYxp86Yvb8reNLOOa3O5dahsrVr+UUij3Su0=;
        b=eDbun/opNXfDTkCwlzmvAV3+jvEcrxK9XM2Lzl2HVveB7ajApQm5YHDD47JTQqqSQu
         dRpbqh3M9cV7j0oxWBFIkMvjs1EzSK3hB9etUOO/e14KEFSqbW+jw2yDNKx2xVZb4JWY
         le6CCVL9VzJzfsM0nmaSewFbKCNRRI69R2i0SwdZhPqaW9N3IJwlp/I8qdVTEJRoimAS
         E8wOcXoiUTL6KBLYsnj0GphqpGV8yIrXsp2j5zzK2E/iEtqLyd2uTFc4yFSMyPvDVB2W
         lkrncj3/UAiYVhU/CcfxXQwEYrY427ocIzdAcfOG6y+Oeh2B+Ym6Bjuw/82wRPqCS3rD
         RHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NHec6MbVYxp86Yvb8reNLOOa3O5dahsrVr+UUij3Su0=;
        b=m/rDYt9UILseLg2Lbm7dhBWbyvseWEpiW4sVPVEu7AqzsiX6SKEg6BHMeP+p/CvHW+
         u6dYF6cnX44OnK4tBMkfNxbPv6WrUpP3G9eYk7cF0YDY+h+5MJSJP+n3XPfBO/l+Kxnk
         819FOagjyQW6x18VtLo8oCjXJM3BrDHGsyNtI8flbyIQxOD9FFjEsbN23yQGRjVXf3P9
         N7i2jyq1K+kySxLXAm3MlIJ9BrWw/uidVZYiij0AHzbMDJfC/Jk6LtcDud2y7xenmaHc
         cQ7CxNIKLGMvyFjFTtnvBfSvuMDIIyg8JRX6SF2f+/bMM2RkJV13gWL+pkYIJ9PrVL2v
         MKgw==
X-Gm-Message-State: ANhLgQ3DCN6n676cPgVulug5pV9XZcn8PGokh75YSIUBHrvNC4dtsWa5
        A2rl7A07SzetE4E0/S+wd0E=
X-Google-Smtp-Source: ADFU+vtF9/WzUrXL6R7jUr5dRKK6eOaIDQQYdvlYvP9R08MsaxreTVx6d7BDimfvZHAQ4ILObTDVqw==
X-Received: by 2002:adf:df04:: with SMTP id y4mr4395488wrl.318.1584626621693;
        Thu, 19 Mar 2020 07:03:41 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id s7sm3633116wro.10.2020.03.19.07.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 07:03:41 -0700 (PDT)
Date:   Thu, 19 Mar 2020 15:03:38 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        disconnect3d <dominik.b.czarnota@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Mike Leach <mike.leach@linaro.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Message-ID: <20200319140338.GB52834@gmail.com>
References: <20200317213259.15494-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317213259.15494-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit f787feff69c466dfc6f261c9632627e383b49187:
> 
>   perf block-info: Support color ops to print block percents in color (2020-03-09 21:43:25 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.7-20200317
> 
> for you to fetch changes up to 59a08b4b3b1a9374adacd13cd7544c03e5582e0e:
> 
>   perf expr: Fix copy/paste mistake (2020-03-17 18:01:40 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf record:
> 
>   Alexey Budankov:
> 
>   - Fix binding of AIO user space buffers to nodes
> 
> maps:
> 
>   Dominik b. Czarnota:
> 
>   - Fix off by one in strncpy() size argument.
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Use strstarts() to look for Android libraries.
> 
>   Ian Rogers:
> 
>   - Give synthetic mmap events an inode generation.
> 
> man pages:
> 
>   Ian Rogers:
> 
>   - Set man page date to last git commit.
> 
> perf test:
> 
>   Ian Rogers:
> 
>   - Print if shell directory isn't present.
> 
> perf report:
> 
>   Jin Yao:
> 
>   - Fix no branch type statistics report issue.
> 
> perf expr:
> 
>   Jiri Olsa:
> 
>   - Fix copy/paste mistake
> 
> vendor events:
> 
>   Kan Liang:
> 
>   - Support metric constraints.
> 
> vendor events intel:
> 
>   Kan Liang:
> 
>   - Add NO_NMI_WATCHDOG metric constraint.
> 
> vendor events s390:
> 
>   Thomas Richter:
> 
>  - Add new deflate counters for IBM z15.
> 
> ARM cs-etm:
> 
>   Leo Yan:
> 
>   - Last branch improvements.
> 
> intel-pt:
> 
>   Adrian Hunter:
> 
>   - Update intel-pt.txt file with new location of the documentation.
> 
>   - Add Intel PT man page references.
> 
>   - Rename intel-pt.txt and put it in man page format.
> 
> perl scripting:
> 
>   Michael Petlan:
> 
>  - Add common_callchain to fix argument order.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (3):
>       perf intel-pt: Rename intel-pt.txt and put it in man page format
>       perf intel-pt: Add Intel PT man page references
>       perf intel-pt: Update intel-pt.txt file with new location of the documentation
> 
> Alexey Budankov (1):
>       perf record: Fix binding of AIO user space buffers to nodes
> 
> Arnaldo Carvalho de Melo (1):
>       perf map: Use strstarts() to look for Android libraries
> 
> Ian Rogers (3):
>       perf doc: Set man page date to last git commit
>       perf test: Print if shell directory isn't present
>       perf tools: Give synthetic mmap events an inode generation
> 
> Jin Yao (1):
>       perf report: Fix no branch type statistics report issue
> 
> Jiri Olsa (1):
>       perf expr: Fix copy/paste mistake
> 
> Kan Liang (5):
>       perf jevents: Support metric constraint
>       perf metricgroup: Factor out metricgroup__add_metric_weak_group()
>       perf util: Factor out sysctl__nmi_watchdog_enabled()
>       perf metricgroup: Support metric constraint
>       perf vendor events intel: Add NO_NMI_WATCHDOG metric constraint
> 
> Leo Yan (5):
>       perf cs-etm: Swap packets for instruction samples
>       perf cs-etm: Continuously record last branch
>       perf cs-etm: Correct synthesizing instruction samples
>       perf cs-etm: Optimize copying last branches
>       perf cs-etm: Fix unsigned variable comparison to zero
> 
> Michael Petlan (1):
>       perf scripting perl: Add common_callchain to fix argument order
> 
> Thomas Richter (1):
>       perf vendor events s390: Add new deflate counters for IBM z15
> 
> disconnect3d (1):
>       perf map: Fix off by one in strncpy() size argument
> 
>  tools/perf/Documentation/Makefile                  |    5 +-
>  tools/perf/Documentation/intel-pt.txt              |  992 +------------------
>  tools/perf/Documentation/perf-inject.txt           |    3 +-
>  tools/perf/Documentation/perf-intel-pt.txt         | 1007 ++++++++++++++++++++
>  tools/perf/Documentation/perf-record.txt           |    2 +-
>  tools/perf/Documentation/perf-report.txt           |    3 +-
>  tools/perf/Documentation/perf-script.txt           |    2 +-
>  tools/perf/builtin-report.c                        |    9 +-
>  .../perf/pmu-events/arch/s390/cf_z15/crypto6.json  |    8 +-
>  .../perf/pmu-events/arch/s390/cf_z15/extended.json |   30 +-
>  .../arch/x86/cascadelakex/clx-metrics.json         |    3 +-
>  .../pmu-events/arch/x86/skylake/skl-metrics.json   |    3 +-
>  .../pmu-events/arch/x86/skylakex/skx-metrics.json  |    3 +-
>  tools/perf/pmu-events/jevents.c                    |   19 +-
>  tools/perf/pmu-events/jevents.h                    |    2 +-
>  tools/perf/pmu-events/pmu-events.h                 |    1 +
>  tools/perf/scripts/perl/check-perf-trace.pl        |    6 +-
>  tools/perf/scripts/perl/failed-syscalls.pl         |    2 +-
>  tools/perf/scripts/perl/rw-by-file.pl              |    6 +-
>  tools/perf/scripts/perl/rw-by-pid.pl               |   10 +-
>  tools/perf/scripts/perl/rwtop.pl                   |   10 +-
>  tools/perf/scripts/perl/wakeup-latency.pl          |    6 +-
>  tools/perf/tests/builtin-test.c                    |    5 +-
>  tools/perf/util/cs-etm.c                           |  157 ++-
>  tools/perf/util/expr.l                             |    4 +-
>  tools/perf/util/map.c                              |    8 +-
>  tools/perf/util/metricgroup.c                      |  109 ++-
>  tools/perf/util/mmap.c                             |   21 +-
>  tools/perf/util/stat-display.c                     |    6 +-
>  tools/perf/util/synthetic-events.c                 |    1 +
>  tools/perf/util/util.c                             |   18 +
>  tools/perf/util/util.h                             |    2 +
>  32 files changed, 1340 insertions(+), 1123 deletions(-)
>  create mode 100644 tools/perf/Documentation/perf-intel-pt.txt

Pulled this and the previous perf/core pull request into tip:perf/core, thanks Arnaldo!

(You might want to double check my conflict resolution with perf/urgent, 
to tools/perf/util/map.c.)

Thanks,

	Ingo
