Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13E7C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 11:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B1A2076D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 11:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnndoZWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgEALhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 07:37:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28931 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728575AbgEALhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 07:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588333020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pXALvqSczWksRPsKFQBXEvKLu6/WFAxjc1PH4JSzo0A=;
        b=QnndoZWN1yWwIBNCv6tIyXnievoQThZvJ2fOnXONovqxFUog4tiCI/r4nRqjGEv0yzF9hm
        nJGjDUQ/+OaSUtKvbVahFRyO4+2KnbzPNWddEnkRTxHNCqHtcsLS8lJ6wwaH0VXl83D2q2
        5SKpnPDLUf47psRHRoMA2wy0vQ9dXEQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-8Yar2eGcPWmM-56BjOhdmA-1; Fri, 01 May 2020 07:36:51 -0400
X-MC-Unique: 8Yar2eGcPWmM-56BjOhdmA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CE7F1800D42;
        Fri,  1 May 2020 11:36:50 +0000 (UTC)
Received: from krava (unknown [10.40.192.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA849610AB;
        Fri,  1 May 2020 11:36:45 +0000 (UTC)
Date:   Fri, 1 May 2020 13:36:41 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH 0/2] perf stat: Support overall statistics for interval
 mode
Message-ID: <20200501113641.GA1808514@krava>
References: <20200430030740.27156-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430030740.27156-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 11:07:38AM +0800, Jin Yao wrote:
> Currently perf-stat supports to print counts at regular interval (-I),
> but it's not very easy for user to get the overall statistics.
> 
> With this patchset, it supports to report the summary at the end of
> interval output.
> 
> For example,
> 
>  root@kbl-ppc:~# perf stat -e cycles -I1000 --interval-count 2
>  #           time             counts unit events
>       1.000412064          2,281,114      cycles
>       2.001383658          2,547,880      cycles
> 
>   Performance counter stats for 'system wide':
> 
>           4,828,994      cycles
> 
>         2.002860349 seconds time elapsed
> 
>  root@kbl-ppc:~# perf stat -e cycles,instructions -I1000 --interval-count 2
>  #           time             counts unit events
>       1.000389902          1,536,093      cycles
>       1.000389902            420,226      instructions              #    0.27  insn per cycle
>       2.001433453          2,213,952      cycles
>       2.001433453            735,465      instructions              #    0.33  insn per cycle
> 
>   Performance counter stats for 'system wide':
> 
>           3,750,045      cycles
>           1,155,691      instructions              #    0.31  insn per cycle
> 
>         2.003023361 seconds time elapsed
> 
>  root@kbl-ppc:~# perf stat -M CPI,IPC -I1000 --interval-count 2
>  #           time             counts unit events
>       1.000435121            905,303      inst_retired.any          #      2.9 CPI
>       1.000435121          2,663,333      cycles
>       1.000435121            914,702      inst_retired.any          #      0.3 IPC
>       1.000435121          2,676,559      cpu_clk_unhalted.thread
>       2.001615941          1,951,092      inst_retired.any          #      1.8 CPI
>       2.001615941          3,551,357      cycles
>       2.001615941          1,950,837      inst_retired.any          #      0.5 IPC
>       2.001615941          3,551,044      cpu_clk_unhalted.thread
> 
>   Performance counter stats for 'system wide':
> 
>           2,856,395      inst_retired.any          #      2.2 CPI
>           6,214,690      cycles
>           2,865,539      inst_retired.any          #      0.5 IPC
>           6,227,603      cpu_clk_unhalted.thread
> 
>         2.003403078 seconds time elapsed
> 
> Jin Yao (2):
>   perf evsel: Create counts for collecting summary data
>   perf stat: Report summary for interval mode

good idea, but I can't apply this on latest Arnaldo's perf/core,
could you please rebase?

thanks,
jirka

> 
>  tools/perf/builtin-stat.c | 14 ++++++-
>  tools/perf/util/evsel.c   | 10 ++++-
>  tools/perf/util/evsel.h   |  1 +
>  tools/perf/util/stat.c    | 77 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/stat.h    |  5 +++
>  5 files changed, 103 insertions(+), 4 deletions(-)
> 
> -- 
> 2.17.1
> 

