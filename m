Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE25C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A06D23119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596731245;
	bh=2A04CCh0r3ZG1AtnVdzEPjeWyJnjOLJg36o/MAiKiZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FtSoMGbtIjHg0Yghh4UsfKqULtKiW4MjtvjJMbRw/K+9qpx6Wr31306o4ZEIMVD7d
	 WF1/Dges7Qc7B3WdWfIp0oKYI8jW/9n/IqZgVK9gHYfWKOtsWVUMLtecxtf+ARt3IP
	 k63rlaYsJB2yxzLPdbPSsI/Y+MDOHpe9oaQQ6ldI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgHFQ0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:26:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbgHFQSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:18:44 -0400
Received: from quaco.ghostprotocols.net (unknown [179.162.129.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 403DC22D37;
        Thu,  6 Aug 2020 12:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596717962;
        bh=2A04CCh0r3ZG1AtnVdzEPjeWyJnjOLJg36o/MAiKiZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QmYNTm5JI9STyBtUlkKKtJYLIlQ+qsn8bmrWJRJxDHGm8VD+BeX3mtWXbTHsEPwr4
         G9nnmCa5l2dkdIfoivYS4wYL/RjffMhcoXlhbn+6/T/SjjpvdUYY8aMoN0MaCuWE+L
         E/SQo6wrgZXtaHr8tBGg6qUO4bUnjLKfJvn1PYeY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4085540524; Thu,  6 Aug 2020 09:46:00 -0300 (-03)
Date:   Thu, 6 Aug 2020 09:46:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        =?iso-8859-1?Q?Genevi=E8ve?= Bastien <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
Subject: Re: [PATCH v2 5/7] perf tools: Add support to store time of day in
 CTF data conversion
Message-ID: <20200806124600.GG71359@kernel.org>
References: <20200805093444.314999-1-jolsa@kernel.org>
 <20200805093444.314999-6-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805093444.314999-6-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 05, 2020 at 11:34:42AM +0200, Jiri Olsa escreveu:
> Adding support to convert and store time of day in CTF
> data conversion for 'perf data convert' subcommand.
> 
> The perf.data used for conversion needs to have clock data
> information - must be recorded with -k/--clockid option).
> 
> New --tod option is added to 'perf data convert' subcommand
> to convert data with timestamps converted to wall clock time.

Thanks, applied.

- Arnaldo
 
> Record data with clockid set:
>   # perf record -k CLOCK_MONOTONIC kill
>   kill: not enough arguments
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.033 MB perf.data (8 samples) ]
> 
> Convert data with TOD timestamps:
>   # perf data convert --tod --to-ctf ./ctf
>   [ perf data convert: Converted 'perf.data' into CTF data './ctf' ]
>   [ perf data convert: Converted and wrote 0.000 MB (8 samples) ]
> 
> Display data in perf script:
>   # perf script -F+tod --ns
>             perf 262150 2020-07-13 18:38:50.097678523 153633.958246159:          1 cycles: ...
>             perf 262150 2020-07-13 18:38:50.097682941 153633.958250577:          1 cycles: ...
>             perf 262150 2020-07-13 18:38:50.097684997 153633.958252633:          7 cycles: ...
>   ...
> 
> Display data in babeltrace:
>   # babeltrace --clock-date  ./ctf
>   [2020-07-13 18:38:50.097678523] (+?.?????????) cycles: { cpu_id = 0 }, { perf_ip = 0xFFF ...
>   [2020-07-13 18:38:50.097682941] (+0.000004418) cycles: { cpu_id = 0 }, { perf_ip = 0xFFF ...
>   [2020-07-13 18:38:50.097684997] (+0.000002056) cycles: { cpu_id = 0 }, { perf_ip = 0xFFF ...
>   ...
> 
> It's available only for recording with clockid specified,
> because it's the only case where we can get reference time
> to wallclock time. It's can't do that with perf clock yet.
> 
> Error is display if you want to use --tod on data without
> clockid specified:
> 
>   # perf data convert --tod --to-ctf ./ctf
>   Can't provide --tod time, missing clock data. Please record with -k/--clockid option.
>   Failed to setup CTF writer.
>   Error during conversion setup.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/Documentation/perf-data.txt |  3 ++
>  tools/perf/builtin-data.c              |  1 +
>  tools/perf/util/data-convert-bt.c      | 57 +++++++++++++++++---------
>  tools/perf/util/data-convert.h         |  1 +
>  4 files changed, 42 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-data.txt b/tools/perf/Documentation/perf-data.txt
> index c87180764829..726b9bc9e1a7 100644
> --- a/tools/perf/Documentation/perf-data.txt
> +++ b/tools/perf/Documentation/perf-data.txt
> @@ -27,6 +27,9 @@ OPTIONS for 'convert'
>  --to-ctf::
>  	Triggers the CTF conversion, specify the path of CTF data directory.
>  
> +--tod::
> +	Convert time to wall clock time.
> +
>  -i::
>  	Specify input perf data file path.
>  
> diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
> index ca2fb44874e4..8d23b8d6ee8e 100644
> --- a/tools/perf/builtin-data.c
> +++ b/tools/perf/builtin-data.c
> @@ -65,6 +65,7 @@ static int cmd_data_convert(int argc, const char **argv)
>  		OPT_STRING('i', "input", &input_name, "file", "input file name"),
>  #ifdef HAVE_LIBBABELTRACE_SUPPORT
>  		OPT_STRING(0, "to-ctf", &to_ctf, NULL, "Convert to CTF format"),
> +		OPT_BOOLEAN(0, "tod", &opts.tod, "Convert time to wall clock time"),
>  #endif
>  		OPT_BOOLEAN('f', "force", &opts.force, "don't complain, do it"),
>  		OPT_BOOLEAN(0, "all", &opts.all, "Convert all events"),
> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
> index 5f36fc6a5578..27c5fef9ad54 100644
> --- a/tools/perf/util/data-convert-bt.c
> +++ b/tools/perf/util/data-convert-bt.c
> @@ -31,6 +31,9 @@
>  #include "config.h"
>  #include <linux/ctype.h>
>  #include <linux/err.h>
> +#include <linux/time64.h>
> +#include "util.h"
> +#include "clockid.h"
>  
>  #define pr_N(n, fmt, ...) \
>  	eprintf(n, debug_data_convert, fmt, ##__VA_ARGS__)
> @@ -1381,11 +1384,26 @@ do {									\
>  	return 0;
>  }
>  
> -static int ctf_writer__setup_clock(struct ctf_writer *cw)
> +static int ctf_writer__setup_clock(struct ctf_writer *cw,
> +				   struct perf_session *session,
> +				   bool tod)
>  {
>  	struct bt_ctf_clock *clock = cw->clock;
> +	const char *desc = "perf clock";
> +	int64_t offset = 0;
>  
> -	bt_ctf_clock_set_description(clock, "perf clock");
> +	if (tod) {
> +		struct perf_env *env = &session->header.env;
> +
> +		if (!env->clock.enabled) {
> +			pr_err("Can't provide --tod time, missing clock data. "
> +			       "Please record with -k/--clockid option.\n");
> +			return -1;
> +		}
> +
> +		desc   = clockid_name(env->clock.clockid);
> +		offset = env->clock.tod_ns - env->clock.clockid_ns;
> +	}
>  
>  #define SET(__n, __v)				\
>  do {						\
> @@ -1394,8 +1412,8 @@ do {						\
>  } while (0)
>  
>  	SET(frequency,   1000000000);
> -	SET(offset_s,    0);
> -	SET(offset,      0);
> +	SET(offset,      offset);
> +	SET(description, desc);
>  	SET(precision,   10);
>  	SET(is_absolute, 0);
>  
> @@ -1481,7 +1499,8 @@ static void ctf_writer__cleanup(struct ctf_writer *cw)
>  	memset(cw, 0, sizeof(*cw));
>  }
>  
> -static int ctf_writer__init(struct ctf_writer *cw, const char *path)
> +static int ctf_writer__init(struct ctf_writer *cw, const char *path,
> +			    struct perf_session *session, bool tod)
>  {
>  	struct bt_ctf_writer		*writer;
>  	struct bt_ctf_stream_class	*stream_class;
> @@ -1505,7 +1524,7 @@ static int ctf_writer__init(struct ctf_writer *cw, const char *path)
>  
>  	cw->clock = clock;
>  
> -	if (ctf_writer__setup_clock(cw)) {
> +	if (ctf_writer__setup_clock(cw, session, tod)) {
>  		pr("Failed to setup CTF clock.\n");
>  		goto err_cleanup;
>  	}
> @@ -1613,17 +1632,15 @@ int bt_convert__perf2ctf(const char *input, const char *path,
>  	if (err)
>  		return err;
>  
> -	/* CTF writer */
> -	if (ctf_writer__init(cw, path))
> -		return -1;
> -
>  	err = -1;
>  	/* perf.data session */
>  	session = perf_session__new(&data, 0, &c.tool);
> -	if (IS_ERR(session)) {
> -		err = PTR_ERR(session);
> -		goto free_writer;
> -	}
> +	if (IS_ERR(session))
> +		return PTR_ERR(session);
> +
> +	/* CTF writer */
> +	if (ctf_writer__init(cw, path, session, opts->tod))
> +		goto free_session;
>  
>  	if (c.queue_size) {
>  		ordered_events__set_alloc_size(&session->ordered_events,
> @@ -1632,17 +1649,17 @@ int bt_convert__perf2ctf(const char *input, const char *path,
>  
>  	/* CTF writer env/clock setup  */
>  	if (ctf_writer__setup_env(cw, session))
> -		goto free_session;
> +		goto free_writer;
>  
>  	/* CTF events setup */
>  	if (setup_events(cw, session))
> -		goto free_session;
> +		goto free_writer;
>  
>  	if (opts->all && setup_non_sample_events(cw, session))
> -		goto free_session;
> +		goto free_writer;
>  
>  	if (setup_streams(cw, session))
> -		goto free_session;
> +		goto free_writer;
>  
>  	err = perf_session__process_events(session);
>  	if (!err)
> @@ -1670,10 +1687,10 @@ int bt_convert__perf2ctf(const char *input, const char *path,
>  
>  	return err;
>  
> -free_session:
> -	perf_session__delete(session);
>  free_writer:
>  	ctf_writer__cleanup(cw);
> +free_session:
> +	perf_session__delete(session);
>  	pr_err("Error during conversion setup.\n");
>  	return err;
>  }
> diff --git a/tools/perf/util/data-convert.h b/tools/perf/util/data-convert.h
> index af90b6076c06..feab5f114e37 100644
> --- a/tools/perf/util/data-convert.h
> +++ b/tools/perf/util/data-convert.h
> @@ -5,6 +5,7 @@
>  struct perf_data_convert_opts {
>  	bool force;
>  	bool all;
> +	bool tod;
>  };
>  
>  #endif /* __DATA_CONVERT_H */
> -- 
> 2.25.4
> 

-- 

- Arnaldo
