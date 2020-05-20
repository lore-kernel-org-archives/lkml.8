Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2941FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F288B207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqZFHi+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgETMix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:38:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42460 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726224AbgETMiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589978330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M3olU3lUZcwVSO2O9FA5kHbjpoIwQyphRYLpBtUBo1U=;
        b=FqZFHi+wR3DEiaAyy6WwBLQD+Ah9NTaK+QQe5o3LhZHVxvzTPgpKIbDJcAXFUTOjUEmfBA
        XWqw8Ls1PHcqGNFdWJ6jLlc4I/u+UZ5ag4kCFuILC8B4/TtVqxCTo7X68a22q8a0gf7JF/
        pXMSrcuLqbPg8YZI85ghfHRUHmr8ioE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-nBlknq0OMUCkgxd46ZrGpg-1; Wed, 20 May 2020 08:38:46 -0400
X-MC-Unique: nBlknq0OMUCkgxd46ZrGpg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53B4F800053;
        Wed, 20 May 2020 12:38:45 +0000 (UTC)
Received: from krava (unknown [10.40.193.10])
        by smtp.corp.redhat.com (Postfix) with SMTP id 876D46AD03;
        Wed, 20 May 2020 12:38:43 +0000 (UTC)
Date:   Wed, 20 May 2020 14:38:42 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 9/9] perf record: introduce --ctl-fd[-ack] options
Message-ID: <20200520123842.GH157452@krava>
References: <eb38e9e5-754f-d410-1d9b-e26b702d51b7@linux.intel.com>
 <8df14d46-42c6-2f14-8842-5d0f40a78fbb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8df14d46-42c6-2f14-8842-5d0f40a78fbb@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 11:05:08AM +0300, Alexey Budankov wrote:
> 
> Introduce --ctl-fd[-ack] options to pass open file descriptors numbers
> from command line. Extend perf-record.txt file with --ctl-fd[-ack]
> options description. Document possible usage model introduced by
> --ctl-fd[-ack] options by providing example bash shell script.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-record.txt | 39 ++++++++++++++++++++++++
>  tools/perf/builtin-record.c              |  9 ++++++
>  tools/perf/util/record.h                 |  2 ++
>  3 files changed, 50 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index c2c4ce7ccee2..5c012cfe68a4 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -614,6 +614,45 @@ appended unit character - B/K/M/G
>  	The number of threads to run when synthesizing events for existing processes.
>  	By default, the number of threads equals 1.
>  
> +--ctl-fd::
> +--ctl-fd-ack::
> +Listen on ctl-fd descriptor for command to control measurement ('enable': enable events,
> +'disable': disable events. Optionally send control command completion ('ack') to fd-ack
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
> +perf record -D -1 -e cpu-cycles -a                        \
> +            --ctl-fd ${ctl_fd} --ctl-fd-ack ${ctl_fd_ack} \
> +            -- sleep 30 &
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
>  SEE ALSO
>  --------
>  linkperf:perf-stat[1], linkperf:perf-list[1], linkperf:perf-intel-pt[1]
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 72f388623364..218cfaafaf10 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1713,6 +1713,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		perf_evlist__start_workload(rec->evlist);
>  	}
>  
> +	evlist__initialize_ctlfd(rec->evlist, opts->ctl_fd, opts->ctl_fd_ack);

please check return value in here

jirka

> +
>  	if (opts->initial_delay) {
>  		pr_info(EVLIST_DISABLED_MSG);
>  		if (opts->initial_delay > 0) {
> @@ -1859,6 +1861,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		record__synthesize_workload(rec, true);
>  
>  out_child:
> +	evlist__finalize_ctlfd(rec->evlist);
>  	record__mmap_read_all(rec, true);
>  	record__aio_mmap_read_sync(rec);
>  
> @@ -2340,6 +2343,8 @@ static struct record record = {
>  		},
>  		.mmap_flush          = MMAP_FLUSH_DEFAULT,
>  		.nr_threads_synthesize = 1,
> +		.ctl_fd              = -1,
> +		.ctl_fd_ack          = -1,
>  	},
>  	.tool = {
>  		.sample		= process_sample_event,
> @@ -2535,6 +2540,10 @@ static struct option __record_options[] = {
>  	OPT_UINTEGER(0, "num-thread-synthesize",
>  		     &record.opts.nr_threads_synthesize,
>  		     "number of threads to run for event synthesis"),
> +	OPT_INTEGER(0, "ctl-fd", &record.opts.ctl_fd,
> +		    "Listen on fd descriptor for command to control measurement ('enable': enable events, 'disable': disable events)"),
> +	OPT_INTEGER(0, "ctl-fd-ack", &record.opts.ctl_fd_ack,
> +		    "Send control command completion ('ack') to fd ack descriptor"),
>  	OPT_END()
>  };
>  
> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> index 96a73bbd8cd4..da18aeca3623 100644
> --- a/tools/perf/util/record.h
> +++ b/tools/perf/util/record.h
> @@ -69,6 +69,8 @@ struct record_opts {
>  	int	      mmap_flush;
>  	unsigned int  comp_level;
>  	unsigned int  nr_threads_synthesize;
> +	int	      ctl_fd;
> +	int	      ctl_fd_ack;
>  };
>  
>  extern const char * const *record_usage;
> -- 
> 2.24.1
> 
> 

