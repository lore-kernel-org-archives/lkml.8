Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F97AC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBF4206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSwjkgGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgC0Qft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:35:49 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40579 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbgC0Qft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:35:49 -0400
Received: by mail-qt1-f196.google.com with SMTP id c9so9059876qtw.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 09:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EeTdbPcwG7sV1Jp+6pzaay04o+c2fNiGM5kQ0pSLS4g=;
        b=cSwjkgGsHc144U7lV3/9cGVt6Bsfr6e1qYlpR8W41DZYQnBkHPdOVgICYLgYgCgPXT
         BEqMx8XP5QjH2sTcMAr4X0J3OgLUPA+WN49wG09m/siImIeKoItGtQ+6h0L0dQuArK5p
         2sA+7g/6oy6y0F1LwbS1oYq8iwiGHuJ3e2X26Jdmf6kdS0/ClgaeDEj0QajwuR0bNQ/v
         xNopsy0B/jnSwW0b7o4BMO/IIPMCYeGaYoXNgHghusmyRvNtUPEUJAj5Q6oCv9RAiagn
         aSvswa/3thWH9uHKpHrkhSCoDZhMIHcpb7KEQuPW2uj1boNMwFg6hroTxvhmEZWPRdSl
         zb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EeTdbPcwG7sV1Jp+6pzaay04o+c2fNiGM5kQ0pSLS4g=;
        b=lDJVkT68+wBRYkuu5L2FeSOHW5MOiaz9Tr9zjlFmiULemimqpVJWVDzVYDqk1gaW7P
         gejqgkJJpJthcH/o60GqxxsZfkmrS0hvsP8qzrF9U7Puwa7C5AF5V6F2LR3zlsD8hslU
         aPuTvE8xvLUrrpfGAiRCIFeXmfi/hg2Kuf3wCpTwSAqCEeGpjvqyD2ZJsxpok89McHDr
         J9HlUKINiCQmWWri0YItPxsI884Nb6Zk5JKxPj4p3OwkdA/rmhNUtpMCaChBQTwRPJv9
         xfXgS4r1CyG1QgcHnMZJpUYGIbPO2QfKL1jZ59FSMx1EYW/b+UqjHymgXFB84aglCDaz
         65Pw==
X-Gm-Message-State: ANhLgQ0nfSAnsp5E5RqOWTjew8jd7QBHi8wdrB5YUlZ640NUdVJNbvbv
        mxXMLkfv7H8jMG7HU1RKFsE=
X-Google-Smtp-Source: ADFU+vv/WtC5GFyta0U346llmC8bCpKGD0uSKIWxdz4TvTD9tqCnH/DaprrZCkJwgU2AEz5XIz5AxA==
X-Received: by 2002:aed:2da7:: with SMTP id i36mr84401qtd.84.1585326948296;
        Fri, 27 Mar 2020 09:35:48 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id p38sm4368288qtf.50.2020.03.27.09.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 09:35:46 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5616F409A3; Fri, 27 Mar 2020 13:35:43 -0300 (-03)
Date:   Fri, 27 Mar 2020 13:35:43 -0300
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH 8/9] perf top: Add --all-cgroups option
Message-ID: <20200327163543.GB19927@kernel.org>
References: <20200325124536.2800725-1-namhyung@kernel.org>
 <20200325124536.2800725-9-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325124536.2800725-9-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 25, 2020 at 09:45:35PM +0900, Namhyung Kim escreveu:
> The --all-cgroups option is to enable cgroup profiling support.  It
> tells kernel to record CGROUP events in the ring buffer so that perf
> report can identify task/cgroup association later.
 s/report/top/g in this case, and I added:

     Committer testing:

    Use:

      # perf top --all-cgroups -s cgroup_id,cgroup,pid

- Arnaldo

 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-top.txt | 4 ++++
>  tools/perf/builtin-top.c              | 9 +++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
> index 324b6b53c86b..ddab103af8c7 100644
> --- a/tools/perf/Documentation/perf-top.txt
> +++ b/tools/perf/Documentation/perf-top.txt
> @@ -272,6 +272,10 @@ Default is to monitor all CPUS.
>  	Record events of type PERF_RECORD_NAMESPACES and display it with the
>  	'cgroup_id' sort key.
>  
> +--all-cgroups::
> +	Record events of type PERF_RECORD_CGROUP and display it with the
> +	'cgroup' sort key.
> +
>  --switch-on EVENT_NAME::
>  	Only consider events after this event is found.
>  
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index d2539b793f9d..56b2dd0db88e 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1246,6 +1246,8 @@ static int __cmd_top(struct perf_top *top)
>  
>  	if (opts->record_namespaces)
>  		top->tool.namespace_events = true;
> +	if (opts->record_cgroup)
> +		top->tool.cgroup_events = true;
>  
>  	ret = perf_event__synthesize_bpf_events(top->session, perf_event__process,
>  						&top->session->machines.host,
> @@ -1253,6 +1255,11 @@ static int __cmd_top(struct perf_top *top)
>  	if (ret < 0)
>  		pr_debug("Couldn't synthesize BPF events: Pre-existing BPF programs won't have symbols resolved.\n");
>  
> +	ret = perf_event__synthesize_cgroups(&top->tool, perf_event__process,
> +					     &top->session->machines.host);
> +	if (ret < 0)
> +		pr_debug("Couldn't synthesize cgroup events.\n");
> +
>  	machine__synthesize_threads(&top->session->machines.host, &opts->target,
>  				    top->evlist->core.threads, false,
>  				    top->nr_threads_synthesize);
> @@ -1545,6 +1552,8 @@ int cmd_top(int argc, const char **argv)
>  			"number of thread to run event synthesize"),
>  	OPT_BOOLEAN(0, "namespaces", &opts->record_namespaces,
>  		    "Record namespaces events"),
> +	OPT_BOOLEAN(0, "all-cgroups", &opts->record_cgroup,
> +		    "Record cgroup events"),
>  	OPTS_EVSWITCH(&top.evswitch),
>  	OPT_END()
>  	};
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 

-- 

- Arnaldo
