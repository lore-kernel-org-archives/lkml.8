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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49570C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A2820873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGPh/mxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgCJPOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:14:11 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42295 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgCJPOK (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:14:10 -0400
Received: by mail-qt1-f193.google.com with SMTP id g16so2253378qtp.9
        for <Linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 08:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+qR1nZB95A3CqTDYGX0bbznR/iFDjSAZBPiTL4z0/eI=;
        b=kGPh/mxFDAdC7K/ZfDS6Bt3bBJUaMwTHC+dLyfNBZrnQCt7emo3EBQS/hLNz3zwRQw
         vswtoebgyT0+D7br6MLB9i2MugPXD584KxQJD6khnjtYFFe9LnAhSVOPfZtqEkjJqH0C
         liEByWIw4c3Ffz0EwcaGJLJd3C71njCkiiVLdhmXjL8AUYc3ztiPGUqkwUcjbVShV9Xd
         LC9DpsRwf17tn4o3pWP4sakdp7ogN2XHo0Zv1gIMExo8JPwDt7TrHitjPxShM7aQo4Z3
         Ond7HsapBVpgZRLtAKCYBn6flBQn+JwN2gTpmzQdPaph1BZ/9GvCFnDZAz+Kv+tqYLcU
         pblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+qR1nZB95A3CqTDYGX0bbznR/iFDjSAZBPiTL4z0/eI=;
        b=SlIOywUEMK6uEvnPrQeJ8MfmrynULdh9zTF8m+rPoN1ec7GUCRgU6CnsZonOTzAv2Z
         ueXX9+oeXhOZxcDGxdxDXY4KU9S4S7nYtfpuK22LuOrhvgblpVdYWoxeV+9IgzjEElVe
         m1baBTylfOZYhk/fgbSCplx/B5mXGgVxOm5SNvI6yAgiDtRWPsXr5Aw/bqhmwpT+AC+E
         0+fmXaQZPhsqBZVMXT8x9a+GrfbcNofWEDxPb8VvD6wpZUPiMEnByivfv8lxqEG9QqwW
         LWA6MT7CixkFyIxbbKcf65xAH84H3IACxIBDJGNkqdjKpR2rx2wovsOq/STeZzGoQN6B
         A4/g==
X-Gm-Message-State: ANhLgQ3LpJmmDBozyN4HA/xJJVN3Mb1r/s8e+pgaNGGKtKAsBLe1OgZ2
        xNrIvlM8tDp0L2ZZ9qj2QUc=
X-Google-Smtp-Source: ADFU+vuElx2/vRs+yZrG6Wde8wjMCLXTgwJ2zJJPq2c6oyQwQf/J2QJRUG5ScJtJXeOIhO2gc+gjuA==
X-Received: by 2002:ac8:36a1:: with SMTP id a30mr8307340qtc.103.1583853249226;
        Tue, 10 Mar 2020 08:14:09 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id o57sm4420341qtf.42.2020.03.10.08.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 08:14:08 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 230E540009; Tue, 10 Mar 2020 12:14:06 -0300 (-03)
Date:   Tue, 10 Mar 2020 12:14:05 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 05/14] perf util: Calculate the sum of all streams hits
Message-ID: <20200310151405.GH15931@kernel.org>
References: <20200310070245.16314-1-yao.jin@linux.intel.com>
 <20200310070245.16314-6-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310070245.16314-6-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 10, 2020 at 03:02:36PM +0800, Jin Yao escreveu:
> We have used callchain_node->hit to measure the hot level of one
> stream. This patch calculates the sum of hits of all streams.
> 
> Then in next patch, we can use following formula to report hot
> percent for one stream.
> 
> hot percent = callchain_node->hit / sum of all hits
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/callchain.c | 35 +++++++++++++++++++++++++++++++++++
>  tools/perf/util/callchain.h |  1 +
>  2 files changed, 36 insertions(+)
> 
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index a9dd91268b00..040995405664 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -1685,6 +1685,39 @@ static void update_hot_streams(struct hist_entry *he,
>  	}
>  }
>  
> +static u64 count_callchain_hits(struct hist_entry *he)
> +{
> +	struct rb_root *root = &he->sorted_chain;
> +	struct rb_node *rb_node = rb_first(root);
> +	struct callchain_node *node;
> +	u64 chain_hits = 0;
> +
> +	while (rb_node) {
> +		node = rb_entry(rb_node, struct callchain_node, rb_node);
> +		chain_hits += node->hit;
> +		rb_node = rb_next(rb_node);
> +	}
> +
> +	return chain_hits;
> +}
> +
> +static u64 total_callchain_hits(struct hists *hists)
> +{
> +	struct rb_node *next;
> +	u64 chain_hits = 0;
> +
> +	next = rb_first_cached(&hists->entries);

Try to combine the variable decl line with its initial assignment,
saving one line, i.e.:

+static u64 total_callchain_hits(struct hists *hists)
+{
+	struct rb_node *next = rb_first_cached(&hists->entries);
+	u64 chain_hits = 0;
+
> +	while (next) {
> +		struct hist_entry *he;
> +
> +		he = rb_entry(next, struct hist_entry, rb_node);

Ditto:

+		struct hist_entry *he = rb_entry(next, struct hist_entry, rb_node);

> +		chain_hits += count_callchain_hits(he);
> +		next = rb_next(&he->rb_node);
> +	}
> +
> +	return chain_hits;
> +}
> +
>  static void get_hot_streams(struct hists *hists,
>  			    struct callchain_streams *s)
>  {
> @@ -1698,6 +1731,8 @@ static void get_hot_streams(struct hists *hists,
>  		update_hot_streams(he, s);
>  		next = rb_next(&he->rb_node);
>  	}
> +
> +	s->chain_hits = total_callchain_hits(hists);
>  }
>  
>  struct callchain_streams *callchain_evsel_streams_create(struct evlist *evlist,
> diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
> index c996ab4fb108..3c0e0b45656b 100644
> --- a/tools/perf/util/callchain.h
> +++ b/tools/perf/util/callchain.h
> @@ -173,6 +173,7 @@ struct callchain_streams {
>  	int			nr_streams_max;
>  	int			nr_streams;
>  	int			evsel_idx;
> +	u64			chain_hits;
>  };
>  
>  extern __thread struct callchain_cursor callchain_cursor;
> -- 
> 2.17.1
> 

-- 

- Arnaldo
