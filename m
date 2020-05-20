Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03111C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC09420758
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GyuzwZ3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgETMib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:38:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23019 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726224AbgETMi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589978307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YRkP9yrnnteaS5Rww4TgocKUE1QxNtgUdSZQwMB1PeY=;
        b=GyuzwZ3iQBpH3aEwHZpwd/+H2GpIY+/xGpekmve2M5Ca++Up128Qfd17jF/uUMjFRzpsr1
        PixG08oXBmLuladlHwQS4ilc4LIb9EaAgGc1A4o7vF42/Q9IdMUkhBA9mkt7nlrSbxxE59
        8cdRDeDU6EdDoXMPkDsC2QprL2qSuQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-03c2jG1JNj2sWbZdAhILSQ-1; Wed, 20 May 2020 08:38:23 -0400
X-MC-Unique: 03c2jG1JNj2sWbZdAhILSQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13211835B42;
        Wed, 20 May 2020 12:38:22 +0000 (UTC)
Received: from krava (unknown [10.40.193.10])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4536E26198;
        Wed, 20 May 2020 12:38:20 +0000 (UTC)
Date:   Wed, 20 May 2020 14:38:19 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 6/9] perf stat: introduce --ctl-fd[-ack] options
Message-ID: <20200520123819.GE157452@krava>
References: <eb38e9e5-754f-d410-1d9b-e26b702d51b7@linux.intel.com>
 <6b8f7e1f-f89c-2c96-95ac-2a128b365a81@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b8f7e1f-f89c-2c96-95ac-2a128b365a81@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 11:03:03AM +0300, Alexey Budankov wrote:
> 
> Introduce --ctl-fd[-ack] options to pass open file descriptors numbers
> from command line. Extend perf-stat.txt file with --ctl-fd[-ack] options
> description. Document possible usage model introduced by --ctl-fd[-ack]
> options by providing example bash shell script.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-stat.txt | 40 ++++++++++++++++++++++++++
>  tools/perf/builtin-stat.c              | 10 +++++++
>  tools/perf/util/stat.h                 |  2 ++
>  3 files changed, 52 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 3b91b30d7672..7f7a0019fbfc 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -164,6 +164,46 @@ with it.  --append may be used here.  Examples:
>       3>results  perf stat --log-fd 3          -- $cmd
>       3>>results perf stat --log-fd 3 --append -- $cmd
>  
> +--ctl-fd::
> +--ctl-fd-ack::
> +
> +Listen on ctl-fd descriptor for command to control measurement ('enable': enable events,
> +'disable': disable events). Optionally send control command completion ('ack') to fd-ack
> +descriptor to synchronize with the controlling process. Example of bash shell script
> +to enable and disable events during measurements:
> +
> +#!/bin/bash
> +
> +ctl_dir=/tmp/
> +
> +ctl_fifo=${ctl_dir}perf_ctl.fifo
> +test -p ${ctl_fifo} && unlink ${ctl_fifo}
> +mkfifo ${ctl_fifo}
> +exec {ctl_fd}<>${ctl_fifo}
> +
> +ctl_ack_fifo=${ctl_dir}perf_ctl_ack.fifo
> +test -p ${ctl_ack_fifo} && unlink ${ctl_ack_fifo}
> +mkfifo ${ctl_ack_fifo}
> +exec {ctl_fd_ack}<>${ctl_ack_fifo}
> +
> +perf stat -D -1 -e cpu-cycles -a -I 1000                \
> +          --ctl-fd ${ctl_fd} --ctl-fd-ack ${ctl_fd_ack} \
> +          -- sleep 30 &
> +perf_pid=$!
> +
> +sleep 5  && echo 'enable' >&${ctl_fd} && read -u ${ctl_fd_ack} e1 && echo "enabled(${e1})"
> +sleep 10 && echo 'disable' >&${ctl_fd} && read -u ${ctl_fd_ack} d1 && echo "disabled(${d1})"
> +
> +exec {ctl_fd_ack}>&-
> +unlink ${ctl_ack_fifo}
> +
> +exec {ctl_fd}>&-
> +unlink ${ctl_fifo}
> +
> +wait -n ${perf_pid}
> +exit $?
> +
> +
>  --pre::
>  --post::
>  	Pre and post measurement hooks, e.g.:
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index abea82a1ba24..88055aaf670f 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -187,6 +187,8 @@ static struct perf_stat_config stat_config = {
>  	.metric_only_len	= METRIC_ONLY_LEN,
>  	.walltime_nsecs_stats	= &walltime_nsecs_stats,
>  	.big_num		= true,
> +	.ctl_fd			= -1,
> +	.ctl_fd_ack		= -1
>  };
>  
>  static inline void diff_timespec(struct timespec *r, struct timespec *a,
> @@ -984,6 +986,10 @@ static struct option stat_options[] = {
>  		    "Use with 'percore' event qualifier to show the event "
>  		    "counts of one hardware thread by sum up total hardware "
>  		    "threads of same physical core"),
> +	OPT_INTEGER(0, "ctl-fd", &stat_config.ctl_fd,
> +		    "Listen on fd descriptor for command to control measurement ('enable': enable events, 'disable': disable events)"),
> +	OPT_INTEGER(0, "ctl-fd-ack", &stat_config.ctl_fd_ack,
> +		    "Send control command completion ('ack') to fd ack descriptor"),
>  	OPT_END()
>  };
>  
> @@ -2180,6 +2186,8 @@ int cmd_stat(int argc, const char **argv)
>  	signal(SIGALRM, skip_signal);
>  	signal(SIGABRT, skip_signal);
>  
> +	evlist__initialize_ctlfd(evsel_list, stat_config.ctl_fd, stat_config.ctl_fd_ack);

please check the return value

jirka

> +
>  	status = 0;
>  	for (run_idx = 0; forever || run_idx < stat_config.run_count; run_idx++) {
>  		if (stat_config.run_count != 1 && verbose > 0)
> @@ -2199,6 +2207,8 @@ int cmd_stat(int argc, const char **argv)
>  	if (!forever && status != -1 && !interval)
>  		print_counters(NULL, argc, argv);
>  
> +	evlist__finalize_ctlfd(evsel_list);
> +
>  	if (STAT_RECORD) {
>  		/*
>  		 * We synthesize the kernel mmap record just so that older tools
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 027b9dcd902f..0b0fa3a2cde2 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -130,6 +130,8 @@ struct perf_stat_config {
>  	struct perf_cpu_map		*cpus_aggr_map;
>  	u64			*walltime_run;
>  	struct rblist		 metric_events;
> +	int			 ctl_fd;
> +	int			 ctl_fd_ack;
>  };
>  
>  void update_stats(struct stats *stats, u64 val);
> -- 
> 2.24.1
> 
> 

