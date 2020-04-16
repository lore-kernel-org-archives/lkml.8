Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8455C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8172A21D91
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cp0tFgB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgDPPaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633977AbgDPP34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:29:56 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F308C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:29:56 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z90so16658429qtd.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OZ9eOPGrU56Z2lk/rWnddYcQeuhcQBoVYbmOXG53dmU=;
        b=Cp0tFgB6+NBM+awaYLECgMrLEuM9lI5P2QeWvHmJbWrwp7uQj1CBGPF5oVZrP8KHNU
         d/8S1q2QnLhXR9HcMfyhDlI0Yarfm63I0Om3mxHAfBhzAMRzOAolfWzWYmk8ow+yuyMZ
         Hy9/bZP5mHyVv3btpLdxMuqV12JS+EpCqelVIvFqBP0/4+6tTgBEfE6nyv50A3dh0ZHO
         2aC34xzUG6QSXCGl3O7uJYP61n303ak+RvqNTT8no3HfMyuTd6YFz2o0EcnzeoT70Rud
         8whBQbNp0Hg/0JIMJsj4rG2dF0LJw8FR5pHIGNFyir5sMJNF78fLMyUTRuBm9tgtKSuL
         hKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OZ9eOPGrU56Z2lk/rWnddYcQeuhcQBoVYbmOXG53dmU=;
        b=e5BIhwoRO6hTnBt0BuO8aqAK6ifqAvVrn0FYMnaeKIPYFCbEq1JSH64z6Tmyu/Jn0/
         VxD8SUMUQrqMkHs7NkLlCp1cMipWifs6n34ZcbS5W///zDTeglbwPXAoH5haqhvHDGSp
         yAgRTn3cn9oYyCn/s7BYZWn4KMIhmSTQbF38MOGHwBnGO1vmLkJfdDetSznqufo9j8K5
         C++p/9S6hziMMBSvG2oVSNAmTKrs20XTLHgHT1Ea5B6bXFYrdUSrVY2ccCM2M7oDqskm
         OQYUMZln3dYaKY995+B6pEqs1txEH+Zl1bdf2m1rDqbL7OyjyVaxp/+NJFhpk4LxEBiO
         y8Jg==
X-Gm-Message-State: AGi0PuYfgDdxbxmTo1JbtdmRyrQKxPKEEd00W8YWeS/EvfPWvi2IzzmK
        PzASsBAkuXOjzDsMI8a4zrHcRDuEe44=
X-Google-Smtp-Source: APiQypJ9AFrO4AG7bi2BBrju6CZN+3sTeQL68hfZEjurJNQldBng6issq+NjvvBLELewH/m1lIczXA==
X-Received: by 2002:ac8:ff2:: with SMTP id f47mr27245690qtk.48.1587050995109;
        Thu, 16 Apr 2020 08:29:55 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id f13sm15596440qti.47.2020.04.16.08.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:29:54 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D8626409A3; Thu, 16 Apr 2020 12:29:51 -0300 (-03)
Date:   Thu, 16 Apr 2020 12:29:51 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/16] perf tools: Move leader-sampling configuration
Message-ID: <20200416152951.GB2650@kernel.org>
References: <20200401101613.6201-1-adrian.hunter@intel.com>
 <20200401101613.6201-14-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200401101613.6201-14-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 01, 2020 at 01:16:10PM +0300, Adrian Hunter escreveu:
> Move leader-sampling configuration in preparation for adding support for
> leader sampling with AUX area events.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/evsel.c  | 19 -------------------
>  tools/perf/util/record.c | 29 +++++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d4ab073c9fe7..8ddcb95396ac 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1022,25 +1022,6 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
>  		}
>  	}
>  
> -	/*
> -	 * Disable sampling for all group members other
> -	 * than leader in case leader 'leads' the sampling.
> -	 */
> -	if ((leader != evsel) && leader->sample_read) {
> -		attr->freq           = 0;
> -		attr->sample_freq    = 0;
> -		attr->sample_period  = 0;
> -		attr->write_backward = 0;
> -
> -		/*
> -		 * We don't get sample for slave events, we make them
> -		 * when delivering group leader sample. Set the slave
> -		 * event to follow the master sample_type to ease up
> -		 * report.
> -		 */
> -		attr->sample_type = leader->core.attr.sample_type;
> -	}
> -
>  	if (opts->no_samples)
>  		attr->sample_freq = 0;
>  
> diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
> index 7def66168503..ce383fc1bbbc 100644
> --- a/tools/perf/util/record.c
> +++ b/tools/perf/util/record.c
> @@ -167,6 +167,31 @@ bool perf_can_aux_sample(void)
>  	return true;
>  }
>  
> +static void perf_evsel__config_leader_sampling(struct evsel *evsel)
> +{
> +	struct perf_event_attr *attr = &evsel->core.attr;
> +	struct evsel *leader = evsel->leader;
> +
> +	/*
> +	 * Disable sampling for all group members other
> +	 * than leader in case leader 'leads' the sampling.
> +	 */
> +	if (leader != evsel && leader->sample_read) {
> +		attr->freq           = 0;
> +		attr->sample_freq    = 0;
> +		attr->sample_period  = 0;
> +		attr->write_backward = 0;
> +
> +		/*
> +		 * We don't get sample for slave events, we make them
> +		 * when delivering group leader sample. Set the slave
> +		 * event to follow the master sample_type to ease up
> +		 * report.
> +		 */
> +		attr->sample_type = leader->core.attr.sample_type;
> +	}
> +}
> +
>  void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
>  			 struct callchain_param *callchain)
>  {
> @@ -193,6 +218,10 @@ void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
>  			evsel->core.attr.comm_exec = 1;
>  	}
>  
> +	/* Configure leader sampling here now that the sample type is known */
> +	evlist__for_each_entry(evlist, evsel)
> +		perf_evsel__config_leader_sampling(evsel, evlist);
> +
>  	if (opts->full_auxtrace) {
>  		/*
>  		 * Need to be able to synthesize and parse selected events with

  INSTALL  trace_plugins
util/record.c: In function ‘perf_evlist__config’:
util/record.c:223:3: error: too many arguments to function ‘perf_evsel__config_leader_sampling’
  223 |   perf_evsel__config_leader_sampling(evsel, evlist);
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
util/record.c:170:13: note: declared here
  170 | static void perf_evsel__config_leader_sampling(struct evsel *evsel)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mv: cannot stat '/tmp/build/perf/util/.record.o.tmp': No such file or directory
make[4]: *** [/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/record.o] Error 1


----------

I'm removing that evlist arg from here and fixing up the fallout in the
following patches :-)

- Arnaldo
