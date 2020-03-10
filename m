Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D688C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1DB20727
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XS0O8AY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgCJPLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:11:23 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34403 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgCJPLW (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:11:22 -0400
Received: by mail-qk1-f194.google.com with SMTP id f3so13055401qkh.1
        for <Linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 08:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oxhe0PrZsQFgyHVc2/WcQsqA5L+HXUdj6F8srto3/nk=;
        b=XS0O8AY0crFTndkqZ7z6hAbD7uM5epqnvOiQB9sCrW96BfRTFwFFDAdz6sZ4ivpstO
         T9AhQqr9Brw3aRj/fR6LtlujIAW36tzinurFqU+xKqt471lZVaOSZ8RA6NBW+0Bh3SXI
         viASgeGXB/aytZgCfjcDLpumxmpG+g6+CR4a7FrbfY/PDqo7GpriCW4Y4Y6Rl9ShdDsa
         YnDHldKvGAM4Qf+EWdv0eobbhGTmYhHcRCsacGBmsUBYIQnOoi9h53Ee8apajayiVYfS
         +eG3oaEuVLQBsEo2YLn1vJtkJYE7q9Alh8jdOTU2ERKMBXX/5bc0MQslnyK11KZsEEdX
         L+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oxhe0PrZsQFgyHVc2/WcQsqA5L+HXUdj6F8srto3/nk=;
        b=kcsNaHpjuD85imhdds9P3XCQfZMoASjb+HWWZ7F0NVcLSUx+7kQgFe2FYV/+rncRRC
         0J8mTIXN9ciUwPZBX01mFe9WWCWs/lVo9LIVL153h4OwWx5r79D993Zjckfy8uG1GZGx
         K0/411Zny/lmEgoWL8rtCVhbNgL18PD3KsHTq2nA3PYwRN7MvBxH/mFY3qnfQupZNT2B
         lK2mfPwKmSltLEN93ksmMhLabP2b1elNGNfozTpfChY4EIAd/w9q7un5f77/EB6Yjpxc
         rQEdTdXbFaPhpH5he13jC1Eup0vGCVzvuIRcXIAunX22SP0YNnk4wBiJnaJDFVo0vfku
         GK9w==
X-Gm-Message-State: ANhLgQ0aX/isma2SyPJrcqQcZ8TegJD3snyJby9lmH5p7TI+ZIqCTaQK
        kEYukwyC+CzZ/Aj7XqSMXhoDDNfJQGw=
X-Google-Smtp-Source: ADFU+vsGpKlRQTdcBPX8nCMPLvbpchN/BGa5oo1CcMZlNDRjjB+W+fVn8X2F9xso/YAixzbwl079AA==
X-Received: by 2002:a37:9d8f:: with SMTP id g137mr3912773qke.133.1583853080107;
        Tue, 10 Mar 2020 08:11:20 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id r29sm2196146qkk.85.2020.03.10.08.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 08:11:19 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6094F40009; Tue, 10 Mar 2020 12:11:17 -0300 (-03)
Date:   Tue, 10 Mar 2020 12:11:17 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 02/14] perf util: Create streams for managing top N
 hottest callchains
Message-ID: <20200310151117.GG15931@kernel.org>
References: <20200310070245.16314-1-yao.jin@linux.intel.com>
 <20200310070245.16314-3-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310070245.16314-3-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 10, 2020 at 03:02:33PM +0800, Jin Yao escreveu:
> We think the stream is a callchain which is aggregated by the LBR
> records from samples. By browsing the stream, we can understand
> the code flow.
> 
> The struct callchain_node represents one callchain and we use the
> callchain_node->hit to measure the hot level of this callchain.
> Higher is hotter.
> 
> Since in perf data file, there may be many callchains so we just
> need to focus on the top N hottest callchains. N is a user defined
> parameter or just a predefined default value.
> 
> This patch saves the top N hottest callchains in 'struct stream_node'
> type array, which is defined in a per event 'struct callchain_streams'.
> 
> So now we can get the per-event top N hottest callchains.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/callchain.c | 125 ++++++++++++++++++++++++++++++++++++
>  tools/perf/util/callchain.h |  16 +++++
>  2 files changed, 141 insertions(+)
> 
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 818aa4efd386..d9c68a8e7619 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -31,6 +31,7 @@
>  #include "callchain.h"
>  #include "branch.h"
>  #include "symbol.h"
> +#include "evlist.h"
>  #include "../perf.h"
>  
>  #define CALLCHAIN_PARAM_DEFAULT			\
> @@ -1599,3 +1600,127 @@ void callchain_cursor_reset(struct callchain_cursor *cursor)
>  	for (node = cursor->first; node != NULL; node = node->next)
>  		map__zput(node->ms.map);
>  }
> +
> +static void free_evsel_streams(struct callchain_streams *callchain_streams,
> +			       int nr_evsel)
> +{
> +	for (int i = 0; i < nr_evsel; i++) {
> +		if (callchain_streams[i].streams)
> +			free(callchain_streams[i].streams);

free(NULL) is valid, so remove that extra check and use zfree() to reset
that entry to NULL, i.e.:

	for ()
		zfree(&callchain_streams[i].streams);

> +	}
> +
> +	free(callchain_streams);
> +}
> +
> +static struct callchain_streams *create_evsel_streams(int nr_evsel,
> +						      int nr_streams_max)
> +{
> +	struct callchain_streams *callchain_streams;
> +
> +	callchain_streams = calloc(nr_evsel, sizeof(struct callchain_streams));

calloc is the right thing here, as this is an array

> +	if (!callchain_streams)
> +		return NULL;
> +
> +	for (int i = 0; i < nr_evsel; i++) {
> +		struct callchain_streams *s = &callchain_streams[i];
> +
> +		s->streams = calloc(nr_streams_max, sizeof(struct stream_node));
> +		if (!s->streams)
> +			goto err;
> +
> +		s->nr_streams_max = nr_streams_max;
> +		s->evsel_idx = -1;
> +	}
> +
> +	return callchain_streams;
> +
> +err:
> +	free_evsel_streams(callchain_streams, nr_evsel);
> +	return NULL;
> +}
> +
> +/*
> + * The cnodes with high hit number are hot callchains.
> + */
> +static void set_hot_cnode(struct callchain_streams *s,
> +			  struct callchain_node *cnode)
> +{
> +	int i, idx = 0;
> +	u64 hit;
> +
> +	if (s->nr_streams < s->nr_streams_max) {
> +		i = s->nr_streams;
> +		s->streams[i].cnode = cnode;
> +		s->nr_streams++;
> +		return;
> +	}
> +
> +	/*
> +	 * Since only a few number of hot streams, so only use simple
> +	 * way to find the cnode with smallest hit number and replace.
> +	 */
> +	hit = (s->streams[0].cnode)->hit;
> +	for (i = 1; i < s->nr_streams; i++) {
> +		if ((s->streams[i].cnode)->hit < hit) {
> +			hit = (s->streams[i].cnode)->hit;
> +			idx = i;
> +		}
> +	}
> +
> +	if (cnode->hit > hit)
> +		s->streams[idx].cnode = cnode;
> +}
> +
> +static void update_hot_streams(struct hist_entry *he,
> +			       struct callchain_streams *s)
> +{
> +	struct rb_root *root = &he->sorted_chain;
> +	struct rb_node *rb_node = rb_first(root);
> +	struct callchain_node *node;
> +
> +	while (rb_node) {
> +		node = rb_entry(rb_node, struct callchain_node, rb_node);
> +		set_hot_cnode(s, node);
> +		rb_node = rb_next(rb_node);
> +	}
> +}
> +
> +static void get_hot_streams(struct hists *hists,
> +			    struct callchain_streams *s)
> +{
> +	struct rb_node *next;
> +
> +	next = rb_first_cached(&hists->entries);
> +	while (next) {
> +		struct hist_entry *he;
> +
> +		he = rb_entry(next, struct hist_entry, rb_node);
> +		update_hot_streams(he, s);
> +		next = rb_next(&he->rb_node);
> +	}
> +}
> +
> +struct callchain_streams *callchain_evsel_streams_create(struct evlist *evlist,
> +							 int nr_streams_max,
> +							 int *nr_evsel_streams)
> +{
> +	int nr_evsel = evlist->core.nr_entries, i = 0;
> +	struct callchain_streams *callchain_streams;
> +	struct evsel *pos;
> +
> +	callchain_streams = create_evsel_streams(nr_evsel, nr_streams_max);
> +	if (!callchain_streams)
> +		return NULL;
> +
> +	evlist__for_each_entry(evlist, pos) {
> +		struct hists *hists = evsel__hists(pos);
> +
> +		hists__output_resort(hists, NULL);
> +		get_hot_streams(hists, &callchain_streams[i]);
> +		callchain_streams[i].evsel_idx = pos->idx;
> +		i++;
> +	}
> +
> +	*nr_evsel_streams = nr_evsel;
> +	return callchain_streams;
> +}
> diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
> index 706bb7bbe1e1..5852990cdf60 100644
> --- a/tools/perf/util/callchain.h
> +++ b/tools/perf/util/callchain.h
> @@ -13,6 +13,7 @@ struct ip_callchain;
>  struct map;
>  struct perf_sample;
>  struct thread;
> +struct evlist;
>  
>  #define HELP_PAD "\t\t\t\t"
>  
> @@ -159,6 +160,17 @@ struct callchain_cursor {
>  	struct callchain_cursor_node	*curr;
>  };
>  
> +struct stream_node {
> +	struct callchain_node	*cnode;
> +};
> +
> +struct callchain_streams {
> +	struct stream_node	*streams;
> +	int			nr_streams_max;
> +	int			nr_streams;
> +	int			evsel_idx;
> +};
> +
>  extern __thread struct callchain_cursor callchain_cursor;
>  
>  static inline void callchain_init(struct callchain_root *root)
> @@ -289,4 +301,8 @@ int callchain_branch_counts(struct callchain_root *root,
>  			    u64 *branch_count, u64 *predicted_count,
>  			    u64 *abort_count, u64 *cycles_count);
>  
> +struct callchain_streams *callchain_evsel_streams_create(struct evlist *evlist,
> +							 int nr_streams_max,
> +							 int *nr_evsel_streams);
> +
>  #endif	/* __PERF_CALLCHAIN_H */
> -- 
> 2.17.1
> 

-- 

- Arnaldo
