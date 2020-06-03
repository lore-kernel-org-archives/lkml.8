Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AF3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BEA920870
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgFCMY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:24:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:16382 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgFCMY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:24:56 -0400
IronPort-SDR: V0e7Czvd3FiJsWqowlZCx3hcQkivFvOK0mp8/J6zRORlbJPjV/zdEkjtg/LV3wgBG/N98dt9YA
 JvWzRo5NluzA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 05:24:56 -0700
IronPort-SDR: FSqn2gOn54W95GLSaBh5budl0/4Glu+k+PTCeuwbdEly+Eknx7XOWSUzJsepxlRsvQksR4+taE
 tHLRbp6QZydw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="269059414"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by orsmga003.jf.intel.com with ESMTP; 03 Jun 2020 05:24:53 -0700
Subject: Re: [PATCH v6 13/13] perf record: introduce --ctl-fd[-ack] options
To:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <f8e3a714-d9b1-4647-e1d2-9981cbaa83ec@linux.intel.com>
 <fdb10392-15d9-be66-12e7-b1f465737a0e@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b4315665-b5e7-ff56-d9a6-0e7870daf9c9@intel.com>
Date:   Wed, 3 Jun 2020 15:24:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <fdb10392-15d9-be66-12e7-b1f465737a0e@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/06/20 11:20 pm, Alexey Budankov wrote:
> 
> Introduce --ctl-fd[-ack] options to pass open file descriptors numbers
> from command line. Extend perf-record.txt file with --ctl-fd[-ack]

perf-record.txt change seems to be missing.

> options description. Document possible usage model introduced by
> --ctl-fd[-ack] options by providing example bash shell script.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 10 ++++++++++
>  tools/perf/util/record.h    |  2 ++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 0394e068dde8..8494ce964738 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1749,6 +1749,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		perf_evlist__start_workload(rec->evlist);
>  	}
>  
> +	if (evlist__initialize_ctlfd(rec->evlist, opts->ctl_fd, opts->ctl_fd_ack))
> +		goto out_child;
> +
>  	if (opts->initial_delay) {
>  		pr_info(EVLIST_DISABLED_MSG);
>  		if (opts->initial_delay > 0) {
> @@ -1895,6 +1898,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		record__synthesize_workload(rec, true);
>  
>  out_child:
> +	evlist__finalize_ctlfd(rec->evlist);
>  	record__mmap_read_all(rec, true);
>  	record__aio_mmap_read_sync(rec);
>  
> @@ -2380,6 +2384,8 @@ static struct record record = {
>  		},
>  		.mmap_flush          = MMAP_FLUSH_DEFAULT,
>  		.nr_threads_synthesize = 1,
> +		.ctl_fd              = -1,
> +		.ctl_fd_ack          = -1,
>  	},
>  	.tool = {
>  		.sample		= process_sample_event,
> @@ -2581,6 +2587,10 @@ static struct option __record_options[] = {
>  		"libpfm4 event selector. use 'perf list' to list available events",
>  		parse_libpfm_events_option),
>  #endif
> +	OPT_INTEGER(0, "ctl-fd", &record.opts.ctl_fd,
> +		    "Listen on fd descriptor for command to control measurement ('enable': enable events, 'disable': disable events)"),
> +	OPT_INTEGER(0, "ctl-fd-ack", &record.opts.ctl_fd_ack,
> +		   "Send control command completion ('ack') to fd ack descriptor"),
>  	OPT_END()
>  };
>  
> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> index da138dcb4d34..4cb72a478af1 100644
> --- a/tools/perf/util/record.h
> +++ b/tools/perf/util/record.h
> @@ -70,6 +70,8 @@ struct record_opts {
>  	int	      mmap_flush;
>  	unsigned int  comp_level;
>  	unsigned int  nr_threads_synthesize;
> +	int	      ctl_fd;
> +	int	      ctl_fd_ack;
>  };
>  
>  extern const char * const *record_usage;
> 

