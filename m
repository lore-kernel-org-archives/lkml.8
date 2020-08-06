Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC23EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DBB22224D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596736593;
	bh=3xzHH0YOdimQ7prDQNY9UsOPG/UlHTYjQ9W95b4/4Dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zXzO/y0XyOzBsWX4UPZH3LKOcEELIY8V+WJ2E87aRsLG+nwytIW8QzzCRleUa4TzZ
	 Vtlo0RwDsDS/uphw8CXQKfgS/cyArFV+03DIOyThKRKuFUe2aKCKu6hOu5a9K2mRe0
	 LBUqPSOX/EHnaSVUP7r5tLjkUOVu9obyyBJiDQu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbgHFR4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:56:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbgHFQR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:17:26 -0400
Received: from quaco.ghostprotocols.net (unknown [179.162.129.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2299C23106;
        Thu,  6 Aug 2020 12:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596717781;
        bh=3xzHH0YOdimQ7prDQNY9UsOPG/UlHTYjQ9W95b4/4Dk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1i4Uq2gfGVgF3q2LXeO+W3B+wZ/1E9I9GskjNAhpltUtWsciYmV/Hd5f2305Dt2Hc
         CogVh7Paknz3RgO1Uesho8Iud1g/T2/ayOVTYN1iJNYekHkluT7Qr0sC0pFtHZV67b
         d7vfW959eVJj/nhov9Bay8LRpEOM2Q4c+NnuM7F4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F13CD40524; Thu,  6 Aug 2020 09:42:58 -0300 (-03)
Date:   Thu, 6 Aug 2020 09:42:58 -0300
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
Subject: Re: [PATCH v2 4/7] perf tools: Move clockid_res_ns under clock struct
Message-ID: <20200806124258.GF71359@kernel.org>
References: <20200805093444.314999-1-jolsa@kernel.org>
 <20200805093444.314999-5-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805093444.314999-5-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 05, 2020 at 11:34:41AM +0200, Jiri Olsa escreveu:
> Moving clockid_res_ns under clock struct, so we have
> clock related stuff in one place.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-record.c | 6 +++---
>  tools/perf/util/env.h       | 2 +-
>  tools/perf/util/header.c    | 8 ++++----
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 48d721af0096..c0f845021a16 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1566,6 +1566,9 @@ static int record__init_clock(struct record *rec)
>  	if (!rec->opts.use_clockid)
>  		return 0;
>  
> +	if (rec->opts.use_clockid && rec->opts.clockid_res_ns)
> +		session->header.env.clock.clockid_res_ns = rec->opts.clockid_res_ns;
> +
>  	session->header.env.clock.clockid = rec->opts.clockid;
>  
>  	if (gettimeofday(&ref_tod, NULL) != 0) {
> @@ -1674,9 +1677,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  
>  	record__init_features(rec);
>  
> -	if (rec->opts.use_clockid && rec->opts.clockid_res_ns)
> -		session->header.env.clockid_res_ns = rec->opts.clockid_res_ns;
> -
>  	if (forks) {
>  		err = perf_evlist__prepare_workload(rec->evlist, &opts->target,
>  						    argv, data->is_pipe,
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index 7218f7db57af..a12972652006 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -77,7 +77,6 @@ struct perf_env {
>  	struct numa_node	*numa_nodes;
>  	struct memory_node	*memory_nodes;
>  	unsigned long long	 memory_bsize;
> -	u64                     clockid_res_ns;
>  
>  	/*
>  	 * bpf_info_lock protects bpf rbtrees. This is needed because the
> @@ -105,6 +104,7 @@ struct perf_env {
>  	struct {
>  		u64	tod_ns;
>  		u64	clockid_ns;
> +		u64     clockid_res_ns;
>  		int	clockid;
>  		/*
>  		 * enabled is valid for report mode, and is true if above
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index eece94cf6f86..251faa9a5789 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -892,8 +892,8 @@ static int write_auxtrace(struct feat_fd *ff,
>  static int write_clockid(struct feat_fd *ff,
>  			 struct evlist *evlist __maybe_unused)
>  {
> -	return do_write(ff, &ff->ph->env.clockid_res_ns,
> -			sizeof(ff->ph->env.clockid_res_ns));
> +	return do_write(ff, &ff->ph->env.clock.clockid_res_ns,
> +			sizeof(ff->ph->env.clock.clockid_res_ns));
>  }
>  
>  static int write_clock_data(struct feat_fd *ff,
> @@ -1581,7 +1581,7 @@ static void print_cpu_topology(struct feat_fd *ff, FILE *fp)
>  static void print_clockid(struct feat_fd *ff, FILE *fp)
>  {
>  	fprintf(fp, "# clockid frequency: %"PRIu64" MHz\n",
> -		ff->ph->env.clockid_res_ns * 1000);
> +		ff->ph->env.clock.clockid_res_ns * 1000);
>  }
>  
>  static void print_clock_data(struct feat_fd *ff, FILE *fp)
> @@ -2810,7 +2810,7 @@ static int process_mem_topology(struct feat_fd *ff,
>  static int process_clockid(struct feat_fd *ff,
>  			   void *data __maybe_unused)
>  {
> -	if (do_read_u64(ff, &ff->ph->env.clockid_res_ns))
> +	if (do_read_u64(ff, &ff->ph->env.clock.clockid_res_ns))
>  		return -1;
>  
>  	return 0;
> -- 
> 2.25.4
> 

-- 

- Arnaldo
