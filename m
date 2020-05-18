Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41426C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B65520674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CnIHeCus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgERMsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 08:48:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45692 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726709AbgERMsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589806115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o4ExJo3ffdKAnYEo/Wg/KhFd/N7hrFLCbW9nHeiDoJU=;
        b=CnIHeCus2+Qqh/WjI2JqRf+PfWzsmNJNO3BwLn1IdSvTidMu7u7oAHHZdD/zbNYsf2m1g4
        kC6uL6xexWbE6RuzuKSRDP5NHUF4S5mp9c4PF6oBjgKC1Khzg5umMClW9QSR+izTvHU/41
        2mTV6CBW+91VOnZg823JdxtS0aWi93E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-7xxaR3QQNF2-mL8dNxc_pQ-1; Mon, 18 May 2020 08:48:31 -0400
X-MC-Unique: 7xxaR3QQNF2-mL8dNxc_pQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 050391054F8B;
        Mon, 18 May 2020 12:48:30 +0000 (UTC)
Received: from krava (unknown [10.40.196.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8CE6782ED0;
        Mon, 18 May 2020 12:48:27 +0000 (UTC)
Date:   Mon, 18 May 2020 14:48:26 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v5 4/5] perf stat: Save aggr value to first member of
 prev_raw_counts
Message-ID: <20200518124826.GF3726797@krava>
References: <20200514053638.3736-1-yao.jin@linux.intel.com>
 <20200514053638.3736-5-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514053638.3736-5-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 01:36:37PM +0800, Jin Yao wrote:
> To collect the overall statistics for interval mode, we copy the
> counts from evsel->prev_raw_counts to evsel->counts.
> 
> For AGGR_GLOBAL mode, because the perf_stat_process_counter creates
> aggr values from per cpu values, but the per cpu values are 0,
> so the calculated aggr values will be always 0.
> 
> This patch uses a trick that saves the previous aggr value to
> the first member of perf_counts, then aggr calculation in
> process_counter_values can work correctly for AGGR_GLOBAL.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/stat.c | 10 ++++++++++
>  tools/perf/util/stat.h |  1 +
>  2 files changed, 11 insertions(+)
> 
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index aadc723ce871..fbabdd5b9b62 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -249,6 +249,16 @@ void perf_evlist__copy_prev_raw_counts(struct evlist *evlist)
>  		perf_evsel__copy_prev_raw_counts(evsel);
>  }
>  

much better, please put some comments in here explaning wha
is this for, because it's not obvious ;-)

thanks,
jirka

> +void perf_evlist__save_aggr_prev_raw_counts(struct evlist *evlist)
> +{
> +	struct evsel *evsel;
> +
> +	evlist__for_each_entry(evlist, evsel) {
> +		*perf_counts(evsel->prev_raw_counts, 0, 0) =
> +			evsel->prev_raw_counts->aggr;
> +	}
> +}
> +
>  static void zero_per_pkg(struct evsel *counter)
>  {
>  	if (counter->per_pkg_mask)
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 62cf72c71869..18ead55756cc 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -199,6 +199,7 @@ void perf_evlist__free_stats(struct evlist *evlist);
>  void perf_evlist__reset_stats(struct evlist *evlist);
>  void perf_evlist__reset_prev_raw_counts(struct evlist *evlist);
>  void perf_evlist__copy_prev_raw_counts(struct evlist *evlist);
> +void perf_evlist__save_aggr_prev_raw_counts(struct evlist *evlist);
>  
>  int perf_stat_process_counter(struct perf_stat_config *config,
>  			      struct evsel *counter);
> -- 
> 2.17.1
> 

