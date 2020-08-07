Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB22C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D76722D3E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erQMpDgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgHGTx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:53:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37724 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725893AbgHGTxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596830033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uzj/Jm3SXcRvHijz2Kmie91ulWWmqXl5JeoopHrIsOc=;
        b=erQMpDgtZkt8cI63bwLV9lK50kJcMNuVbYPydPEJ4WQbltiBfZ6nIk9ic8Uc0jB5rLhwHG
        8faIebCx+G81x5Dh+zPQYLijSwoWIgCWRx7H6AzJp01F01ZHJJNPc8olcdp7yNBCATSWhY
        CHkAICymP08xtCmyklYxlGGGtYDumj4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-hgjTMoxmMISRSLGhJ-l3Ww-1; Fri, 07 Aug 2020 15:53:50 -0400
X-MC-Unique: hgjTMoxmMISRSLGhJ-l3Ww-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 968571902EA0;
        Fri,  7 Aug 2020 19:53:48 +0000 (UTC)
Received: from krava (unknown [10.40.193.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id D25E27B90B;
        Fri,  7 Aug 2020 19:53:46 +0000 (UTC)
Date:   Fri, 7 Aug 2020 21:53:45 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] libperf: Fix man page typos
Message-ID: <20200807195345.GE561444@krava>
References: <20200807193241.3904545-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807193241.3904545-1-robh@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 01:32:41PM -0600, Rob Herring wrote:
> Fix various typos and inconsistent capitalization of CPU in the libperf
> man pages.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/lib/perf/Documentation/libperf-counting.txt | 14 ++++++++------
>  tools/lib/perf/Documentation/libperf-sampling.txt | 13 +++++++------
>  tools/lib/perf/Documentation/libperf.txt          |  4 ++--
>  3 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/lib/perf/Documentation/libperf-counting.txt b/tools/lib/perf/Documentation/libperf-counting.txt
> index cae9757f49c1..8b75efcd67ce 100644
> --- a/tools/lib/perf/Documentation/libperf-counting.txt
> +++ b/tools/lib/perf/Documentation/libperf-counting.txt
> @@ -7,13 +7,13 @@ libperf-counting - counting interface
>  
>  DESCRIPTION
>  -----------
> -The counting interface provides API to meassure and get count for specific perf events.
> +The counting interface provides API to measure and get count for specific perf events.
>  
>  The following test tries to explain count on `counting.c` example.
>  
>  It is by no means complete guide to counting, but shows libperf basic API for counting.
>  
> -The `counting.c` comes with libbperf package and can be compiled and run like:
> +The `counting.c` comes with libperf package and can be compiled and run like:
>  
>  [source,bash]
>  --
> @@ -26,7 +26,8 @@ count 176242, enabled 176242, run 176242
>  It requires root access, because of the `PERF_COUNT_SW_CPU_CLOCK` event,
>  which is available only for root.
>  
> -The `counting.c` example monitors two events on the current process and displays their count, in a nutshel it:
> +The `counting.c` example monitors two events on the current process and displays
> +their count, in a nutshell it:
>  
>  * creates events
>  * adds them to the event list
> @@ -152,7 +153,7 @@ Configure event list with the thread map and open events:
>  --
>  
>  Both events are created as disabled (note the `disabled = 1` assignment above),
> -so we need to enable the whole list explicitely (both events).
> +so we need to enable the whole list explicitly (both events).
>  
>  From this moment events are counting and we can do our workload.
>  
> @@ -167,7 +168,8 @@ When we are done we disable the events list.
>   79         perf_evlist__disable(evlist);
>  --
>  
> -Now we need to get the counts from events, following code iterates throught the events list and read counts:
> +Now we need to get the counts from events, following code iterates through the
> +events list and read counts:
>  
>  [source,c]
>  --
> @@ -178,7 +180,7 @@ Now we need to get the counts from events, following code iterates throught the
>   85         }
>  --
>  
> -And finaly cleanup.
> +And finally cleanup.
>  
>  We close the whole events list (both events) and remove it together with the threads map:
>  
> diff --git a/tools/lib/perf/Documentation/libperf-sampling.txt b/tools/lib/perf/Documentation/libperf-sampling.txt
> index d71a7b4fcf5f..d6ca24f6ef78 100644
> --- a/tools/lib/perf/Documentation/libperf-sampling.txt
> +++ b/tools/lib/perf/Documentation/libperf-sampling.txt
> @@ -8,13 +8,13 @@ libperf-sampling - sampling interface
>  
>  DESCRIPTION
>  -----------
> -The sampling interface provides API to meassure and get count for specific perf events.
> +The sampling interface provides API to measure and get count for specific perf events.
>  
>  The following test tries to explain count on `sampling.c` example.
>  
>  It is by no means complete guide to sampling, but shows libperf basic API for sampling.
>  
> -The `sampling.c` comes with libbperf package and can be compiled and run like:
> +The `sampling.c` comes with libperf package and can be compiled and run like:
>  
>  [source,bash]
>  --
> @@ -33,7 +33,8 @@ cpu   0, pid   4465, tid   4470, ip         7f84fe0ebebf, period             176
>  
>  It requires root access, because it uses hardware cycles event.
>  
> -The `sampling.c` example profiles/samples all CPUs with hardware cycles, in a nutshel it:
> +The `sampling.c` example profiles/samples all CPUs with hardware cycles, in a
> +nutshell it:
>  
>  - creates events
>  - adds them to the event list
> @@ -90,7 +91,7 @@ Once the setup is complete we start by defining cycles event using the `struct p
>   36         };
>  --
>  
> -Next step is to prepare cpus map.
> +Next step is to prepare CPUs map.
>  
>  In this case we will monitor all the available CPUs:
>  
> @@ -152,7 +153,7 @@ Once the events list is open, we can create memory maps AKA perf ring buffers:
>  --
>  
>  The event is created as disabled (note the `disabled = 1` assignment above),
> -so we need to enable the events list explicitely.
> +so we need to enable the events list explicitly.
>  
>  From this moment the cycles event is sampling.
>  
> @@ -212,7 +213,7 @@ Each sample needs to get parsed:
>  106                                 cpu, pid, tid, ip, period);
>  --
>  
> -And finaly cleanup.
> +And finally cleanup.
>  
>  We close the whole events list (both events) and remove it together with the threads map:
>  
> diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> index 5a6bb512789d..0c74c30ed23a 100644
> --- a/tools/lib/perf/Documentation/libperf.txt
> +++ b/tools/lib/perf/Documentation/libperf.txt
> @@ -29,7 +29,7 @@ SYNOPSIS
>    void libperf_init(libperf_print_fn_t fn);
>  --
>  
> -*API to handle cpu maps:*
> +*API to handle CPU maps:*
>  
>  [source,c]
>  --
> @@ -217,7 +217,7 @@ Following objects are key to the libperf interface:
>  
>  [horizontal]
>  
> -struct perf_cpu_map:: Provides a cpu list abstraction.
> +struct perf_cpu_map:: Provides a CPU list abstraction.
>  
>  struct perf_thread_map:: Provides a thread list abstraction.
>  
> -- 
> 2.25.1
> 

