Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADA0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 452A6206A1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgGIIaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:30:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:11690 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgGIIaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:30:39 -0400
IronPort-SDR: JgX9nfpcq+TENKXiD9xiM35D2c7IrgfNq2w+Zl8UW4srpy08DhkslI4dGYBwzIaBvsVoSmawIL
 uqvsJlYVEPmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="127543224"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="127543224"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 01:30:37 -0700
IronPort-SDR: qnYzIlQgQt+nxNchKqado3en+5FR0Hmt5y8GKskuFJhX8R+0ia3AWdmGNqtAWVQZWjG3Sf2BiO
 PSHw3k4RzOcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="267348926"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jul 2020 01:30:37 -0700
Received: from [10.249.229.62] (abudanko-mobl.ccr.corp.intel.com [10.249.229.62])
        by linux.intel.com (Postfix) with ESMTP id CF3135805F0;
        Thu,  9 Jul 2020 01:30:35 -0700 (PDT)
Subject: Re: [PATCH 0/2] perf: Allow closing siblings' file descriptors
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, adrian.hunter@intel.com
References: <20200708151635.81239-1-alexander.shishkin@linux.intel.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <9a6e9cd6-1ba2-3519-563f-c1eb45329539@linux.intel.com>
Date:   Thu, 9 Jul 2020 11:30:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708151635.81239-1-alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 08.07.2020 18:16, Alexander Shishkin wrote:
> Hi guys,
> 
> I've been looking at reducing the number of open file descriptors per perf
> session. If we retain one descriptor per event, in a large group they add
> up. At the same time, we're not actually using them for anything after the
> SET_OUTPUT and maybe SET_FILTER ioctls. So, this series is a stab at that.

PERF_EVENT_IOC_ENABLE, PERF_EVENT_IOC_DISABLE ioctls are still assumed to
work, right?

Asking w.r.t. functionality on --control fd:ctl_fd[,ack_fd] option for stat
and record modes [1].

Thanks,
Alexey

[1] https://lore.kernel.org/lkml/4af50c95-36f6-7a61-5a22-2949970fe7a5@linux.intel.com/

> 
> So, I added a new flag to the perf_event_open() that tells perf to keep
> the event around after its file descriptor gets closed, for as long as its
> group leader is alive. Since this is a new behavior, the flag is an opt-in.
> 
> I also hacked this into the perf tool (mostly perf record, but I'll hack
> stat as well if this general approach is agreeable).
> 
> Alexander Shishkin (2):
>   perf: Add closing sibling events' file descriptors
>   perf record: Support closing siblings' file descriptors
> 
>  include/linux/perf_event.h              |   7 ++
>  include/uapi/linux/perf_event.h         |   1 +
>  kernel/events/core.c                    | 149 +++++++++++++++++-------
>  tools/include/uapi/linux/perf_event.h   |   1 +
>  tools/lib/perf/evlist.c                 |  30 ++++-
>  tools/lib/perf/evsel.c                  |  21 ++++
>  tools/lib/perf/include/internal/evsel.h |   4 +
>  tools/perf/builtin-record.c             |  48 ++++++--
>  tools/perf/util/cpumap.c                |   4 +
>  tools/perf/util/evlist.c                |   4 +-
>  tools/perf/util/evsel.c                 |  17 ++-
>  tools/perf/util/evsel.h                 |   3 +
>  12 files changed, 234 insertions(+), 55 deletions(-)
> 
