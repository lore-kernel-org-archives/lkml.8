Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B517BC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7435120C09
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599245821;
	bh=vi4wMcAnFlI7LP1Bsr5719yNonx1AiQkc7yCppe6TcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=phm3ck8yn38tfsjplJs18VRKiDAlOiqpBO/Q58qg6aW5qr64j9jrWFxmyrqdfSlY0
	 CHixgP5Cpg2gSnuvL45jyS7oG22q6SYSmlCcbNDXvBXOIbwI3gDAd5PacSj+/PwKUn
	 DE8wDcEYrfYc9wApKhN/m3743ltwDMTCflE8/BPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgIDS5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 14:57:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbgIDS47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 14:56:59 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D712D20665;
        Fri,  4 Sep 2020 18:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599245818;
        bh=vi4wMcAnFlI7LP1Bsr5719yNonx1AiQkc7yCppe6TcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EtsZ2ZZEPg1daImFEtJfC7roPo1epvE0FUhWXX1L2vyRfX1ner0GfebjNeZZOB9qM
         tlEJJWeaHk6sMuZRlV5YN5jltYX6Pd6k5XIH5EhE8GvzoTjAKgSo3Xs3ZqjWW+MbLq
         QCTZ11lTAxssqRbXd6Zh74DY28NHTGchysXba2nA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 01DBB40D3D; Fri,  4 Sep 2020 15:56:55 -0300 (-03)
Date:   Fri, 4 Sep 2020 15:56:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Consolidate close_control_option()'s into
 one function
Message-ID: <20200904185655.GC3752059@kernel.org>
References: <e4d294a9-9d97-2cb0-c43d-926fbf90b819@intel.com>
 <20200903122937.25691-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903122937.25691-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 03, 2020 at 03:29:37PM +0300, Adrian Hunter escreveu:
> Consolidate control option fifo closing into one function.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

Applied and added this:

Suggested-by: Alexey Budankov <alexey.budankov@linux.intel.com>

Thanks,

- Arnaldo
 
> 
> This patch is on top of patch:
> "perf tools: Add FIFO file names as alternative options to --control"
> 
> 
>  tools/perf/builtin-record.c | 12 +-----------
>  tools/perf/builtin-stat.c   | 12 +-----------
>  tools/perf/util/evlist.c    | 10 ++++++++++
>  tools/perf/util/evlist.h    |  1 +
>  4 files changed, 13 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 476b34ff3152..9db3901e6561 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2253,16 +2253,6 @@ static int parse_control_option(const struct option *opt,
>  	return evlist__parse_control(str, &opts->ctl_fd, &opts->ctl_fd_ack, &opts->ctl_fd_close);
>  }
>  
> -static void close_control_option(struct record_opts *opts)
> -{
> -	if (opts->ctl_fd_close) {
> -		opts->ctl_fd_close = false;
> -		close(opts->ctl_fd);
> -		if (opts->ctl_fd_ack >= 0)
> -			close(opts->ctl_fd_ack);
> -	}
> -}
> -
>  static void switch_output_size_warn(struct record *rec)
>  {
>  	u64 wakeup_size = evlist__mmap_size(rec->opts.mmap_pages);
> @@ -2849,7 +2839,7 @@ int cmd_record(int argc, const char **argv)
>  	symbol__exit();
>  	auxtrace_record__free(rec->itr);
>  out_opts:
> -	close_control_option(&rec->opts);
> +	evlist__close_control(rec->opts.ctl_fd, rec->opts.ctl_fd_ack, &rec->opts.ctl_fd_close);
>  	return err;
>  }
>  
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 21424ed0734b..68d4bdf15635 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1051,16 +1051,6 @@ static int parse_control_option(const struct option *opt,
>  	return evlist__parse_control(str, &config->ctl_fd, &config->ctl_fd_ack, &config->ctl_fd_close);
>  }
>  
> -static void close_control_option(struct perf_stat_config *config)
> -{
> -	if (config->ctl_fd_close) {
> -		config->ctl_fd_close = false;
> -		close(config->ctl_fd);
> -		if (config->ctl_fd_ack >= 0)
> -			close(config->ctl_fd_ack);
> -	}
> -}
> -
>  static struct option stat_options[] = {
>  	OPT_BOOLEAN('T', "transaction", &transaction_run,
>  		    "hardware transaction statistics"),
> @@ -2408,7 +2398,7 @@ int cmd_stat(int argc, const char **argv)
>  
>  	metricgroup__rblist_exit(&stat_config.metric_events);
>  	runtime_stat_delete(&stat_config);
> -	close_control_option(&stat_config);
> +	evlist__close_control(stat_config.ctl_fd, stat_config.ctl_fd_ack, &stat_config.ctl_fd_close);
>  
>  	return status;
>  }
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index e72ff7e78dec..ee7b576d3b12 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1802,6 +1802,16 @@ int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack, bool *c
>  	return 0;
>  }
>  
> +void evlist__close_control(int ctl_fd, int ctl_fd_ack, bool *ctl_fd_close)
> +{
> +	if (*ctl_fd_close) {
> +		*ctl_fd_close = false;
> +		close(ctl_fd);
> +		if (ctl_fd_ack >= 0)
> +			close(ctl_fd_ack);
> +	}
> +}
> +
>  int evlist__initialize_ctlfd(struct evlist *evlist, int fd, int ack)
>  {
>  	if (fd == -1) {
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 91d1da6e1fe3..bc38a53f6a1a 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -376,6 +376,7 @@ enum evlist_ctl_cmd {
>  };
>  
>  int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack, bool *ctl_fd_close);
> +void evlist__close_control(int ctl_fd, int ctl_fd_ack, bool *ctl_fd_close);
>  int evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack);
>  int evlist__finalize_ctlfd(struct evlist *evlist);
>  bool evlist__ctlfd_initialized(struct evlist *evlist);
> -- 
> 2.17.1
> 

-- 

- Arnaldo
