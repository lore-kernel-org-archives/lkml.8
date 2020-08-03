Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6ACC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 03:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D2442075A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 03:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596426959;
	bh=hBmxE44X3M+MnBISQBZeOnNZ4mr0P1/Mbs8MZlyPGz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nYSmSe6LPejOtdvl/BHRoevlEEzzFdnRGsVXODiH2Trw0XVqDKhowdv7Gq3/KErqV
	 NFYVoCLi+i1gmFQtfx8NSTu+79yJEBfEO/Je/oKNgR7WkshSps2Pj2RW3qXEk1dGZr
	 svINjptUPwM8mZ0txe12zqjk8Wv/T/nLe0G0QJRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgHCDz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 23:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgHCDz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 23:55:57 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A72C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 20:55:57 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ep8so1364084pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 20:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OWglYyVOB5sXk55+ncU7s2f3LrJjWdYMwNRWbicXowE=;
        b=C5suuJXIiCrDv0dG45dm8AOJOIJmQ1nfece8ziF20Zz/vXWxN3al0uNzdR0bk20pfd
         aBAY++I+7GOIFv5PbQwBoWQa0poL/RnwXqn77FOe4ywZNta3gP2n9/f/2RS5ZTqo+7Od
         GIIdA9n/LfzesFhLyUsmI7flGdiZsKk0+pYEFTABP3EImBLSpE2xTGHF5B6URaTBf5HJ
         7XZerSxJN6uV309rv5p6pk3bbbrddVDgKHRN+ntLmrJ4xIVVAvFmsIT9e6KtDCtbZVgz
         58ieSud0cvQfrzWmROkB9/JXxllQdEyWLcXfwLyCI6XTF4F5Z0T3uvLBa6movdl8qYM/
         kRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OWglYyVOB5sXk55+ncU7s2f3LrJjWdYMwNRWbicXowE=;
        b=MAikczL8GqxlTMFI+mtf5AxO61s2cpSC43rkPdnR2v0eMzuAK48p9u1YDbof0exLKw
         JmYsCaDBZeTOWs1xsLfQKYUGZ2tpn44gm8iQOq8ytIQajW+xAmQ2WZyAXiUfX21JEQMT
         ID+K3veuJ+L/bKH6xtMPFSR8vi2anRqzny0yeHYAMIFQXDE6AFbBaJY53+wRJ/6EDHmA
         ZdH6JKdnXtqbAtL6zLXkMK6L6jzw2hZmX6tjD10NnC3FNrns50plTIeSQjlM8+Kkv85H
         90SazCf8PVpCWguNo6sKjVK8xiYorlbG/vfXX4DAUwpKdbq3RiUUyFbV7RXtNBYVRIei
         QScA==
X-Gm-Message-State: AOAM532yfiV9DMFYHF8ieFV/rT0icEfFqv0POjPQmImdA+WM58SE+02/
        xwBr9hk5lMUMljf1w/fBeIc=
X-Google-Smtp-Source: ABdhPJxdvCxZ2Z0OtR6av9Oo8rCD+bfyuVdVUE4Etp9z/2tb/Kw7m1tiAEFL31xAxtOfhWr3jdNIOg==
X-Received: by 2002:a17:90a:e64b:: with SMTP id ep11mr15386488pjb.86.1596426957217;
        Sun, 02 Aug 2020 20:55:57 -0700 (PDT)
Received: from google.com ([112.159.19.5])
        by smtp.gmail.com with ESMTPSA id q17sm17841265pfh.32.2020.08.02.20.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:55:56 -0700 (PDT)
Date:   Mon, 3 Aug 2020 12:55:50 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        =?utf-8?Q?Genevi=C3=A8ve?= Bastien <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
Subject: Re: [PATCH 2/6] perf tools: Store clock references for -k/--clockid
 option
Message-ID: <20200803035550.GA686281@google.com>
References: <20200730213950.1503773-1-jolsa@kernel.org>
 <20200730213950.1503773-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200730213950.1503773-3-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 11:39:46PM +0200, Jiri Olsa wrote:
> Adding new CLOCK_DATA feature that stores reference times
> when -k/--clockid option is specified.
> 
> It contains clock id and its reference time together with
> wall clock time taken at the 'same time', both values are
> in nanoseconds.
> 
> The format of data is as below:
> 
>   struct {
>        u32 version;  /* version = 1 */
>        u32 clockid;
>        u64 clockid_time_ns;
>        u64 wall_clock_ns;
>   };
> 
> This clock reference times will be used in following changes
> to display wall clock for perf events.
> 
> It's available only for recording with clockid specified,
> because it's the only case where we can get reference time
> to wallclock time. It's can't do that with perf clock yet.
> 
> Original-patch-by: David Ahern <dsahern@gmail.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../Documentation/perf.data-file-format.txt   |  13 ++
>  tools/perf/builtin-record.c                   |  41 +++++++
>  tools/perf/util/env.h                         |  12 ++
>  tools/perf/util/header.c                      | 112 ++++++++++++++++++
>  tools/perf/util/header.h                      |   1 +
>  5 files changed, 179 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> index b6472e463284..c484e81987c7 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> @@ -389,6 +389,19 @@ struct {
>  Example:
>   cpu pmu capabilities: branches=32, max_precise=3, pmu_name=icelake
>  
> +	HEADER_CLOCK_DATA = 29,
> +
> +	Contains clock id and its reference time together with wall clock
> +	time taken at the 'same time', both values are in nanoseconds.
> +	The format of data is as below.
> +
> +struct {
> +	u32 version;  /* version = 1 */
> +	u32 clockid;
> +	u64 clockid_time_ns;
> +	u64 wall_clock_ns;
> +};
> +

It seems that it's slightly different than what it actually write to a file.
Specifically the last two fields should be reversed IMHO.


>  	other bits are reserved and should ignored for now
>  	HEADER_FEAT_BITS	= 256,
>
[SNIP]

> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index 1ab2682d5d2b..4098a63d5e64 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -100,6 +100,18 @@ struct perf_env {
>  	/* For fast cpu to numa node lookup via perf_env__numa_node */
>  	int			*numa_map;
>  	int			 nr_numa_map;
> +
> +	/* For real clock time refference. */

typo: reference

> +	struct {
> +		u64	tod_ns;
> +		u64	clockid_ns;
> +		int	clockid;
> +		/*
> +		 * enabled is valid for report mode, and is true if above
> +		 * values are set, it's set in process_clock_data
> +		 */
> +		bool	enabled;
> +	} clock;
>  };
>  
>  enum perf_compress_type {

[SNIP]
> +static void print_clock_data(struct feat_fd *ff, FILE *fp)
> +{
> +	struct timespec clockid_ns;
> +	char tstr[64], date[64];
> +	struct timeval tod_ns;
> +	clockid_t clockid;
> +	struct tm ltime;
> +	u64 ref;
> +
> +	if (!ff->ph->env.clock.enabled) {
> +		fprintf(fp, "# reference time disabled\n");
> +		return;
> +	}
> +
> +	/* Compute TOD time. */
> +	ref = ff->ph->env.clock.tod_ns;
> +	tod_ns.tv_sec = ref / NSEC_PER_SEC;
> +	ref -= tod_ns.tv_sec * NSEC_PER_SEC;
> +	tod_ns.tv_usec = ref / NSEC_PER_USEC;
> +
> +	/* Compute clockid time. */
> +	ref = ff->ph->env.clock.clockid_ns;
> +	clockid_ns.tv_sec = ref / NSEC_PER_SEC;
> +	ref -= clockid_ns.tv_sec * NSEC_PER_SEC;
> +	clockid_ns.tv_nsec = ref;
> +
> +	clockid = ff->ph->env.clock.clockid;
> +
> +	if (localtime_r(&tod_ns.tv_sec, &ltime) == NULL)
> +		snprintf(tstr, sizeof(tstr), "<error>");
> +	else {
> +		strftime(date, sizeof(date), "%F %T", &ltime);
> +		scnprintf(tstr, sizeof(tstr), "%s.%06d",
> +			  date, (int) tod_ns.tv_usec);
> +	}
> +
> +	fprintf(fp, "# clockid: %s (%u)\n", clockid_name(clockid), clockid);
> +	fprintf(fp, "# reference time: %s = %ld.%06d (TOD) = %ld.%ld (%s)\n",

Shouldn't the last one be %ld.%09ld?

Thanks
Namhyung


> +		    tstr, tod_ns.tv_sec, (int) tod_ns.tv_usec,
> +		    clockid_ns.tv_sec, clockid_ns.tv_nsec,
> +		    clockid_name(clockid));
> +}
> +
>  static void print_dir_format(struct feat_fd *ff, FILE *fp)
>  {
>  	struct perf_session *session;
> @@ -2738,6 +2815,40 @@ static int process_clockid(struct feat_fd *ff,
>  	return 0;
>  }
>  
> +static int process_clock_data(struct feat_fd *ff,
> +			      void *_data __maybe_unused)
> +{
> +	u32 data32;
> +	u64 data64;
> +
> +	/* version */
> +	if (do_read_u32(ff, &data32))
> +		return -1;
> +
> +	if (data32 != 1)
> +		return -1;
> +
> +	/* clockid */
> +	if (do_read_u32(ff, &data32))
> +		return -1;
> +
> +	ff->ph->env.clock.clockid = data32;
> +
> +	/* TOD ref time */
> +	if (do_read_u64(ff, &data64))
> +		return -1;
> +
> +	ff->ph->env.clock.tod_ns = data64;
> +
> +	/* clockid ref time */
> +	if (do_read_u64(ff, &data64))
> +		return -1;
> +
> +	ff->ph->env.clock.clockid_ns = data64;
> +	ff->ph->env.clock.enabled = true;
> +	return 0;
> +}
> +
>  static int process_dir_format(struct feat_fd *ff,
>  			      void *_data __maybe_unused)
>  {
> @@ -3008,6 +3119,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
>  	FEAT_OPR(BPF_BTF,       bpf_btf,        false),
>  	FEAT_OPR(COMPRESSED,	compressed,	false),
>  	FEAT_OPR(CPU_PMU_CAPS,	cpu_pmu_caps,	false),
> +	FEAT_OPR(CLOCK_DATA,	clock_data,	false),
>  };
>  
>  struct header_print_data {
> diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> index 650bd1c7a99b..2aca71763ecf 100644
> --- a/tools/perf/util/header.h
> +++ b/tools/perf/util/header.h
> @@ -44,6 +44,7 @@ enum {
>  	HEADER_BPF_BTF,
>  	HEADER_COMPRESSED,
>  	HEADER_CPU_PMU_CAPS,
> +	HEADER_CLOCK_DATA,
>  	HEADER_LAST_FEATURE,
>  	HEADER_FEAT_BITS	= 256,
>  };
> -- 
> 2.25.4
