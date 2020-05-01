Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71050C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 11:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D29520787
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 11:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YeT1YTWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgEAL0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 07:26:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34705 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728588AbgEAL0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 07:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588332365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l3RHNYGjb1a5HNCgNnXjPkumXM1n3FPkYqlluDFBk0o=;
        b=YeT1YTWcp08YIDfx1y5AowVGOyyAbEW+iaQQrD7cs8/tw7AMIsO+aTrLcOd/jyY8wzyqVs
        Sk69q6s6yNqnJ7fXKk8wEUWzOTTCvEdP07/Gcfn+qrGrKDAzEc3RqJ23aVEXuZ4eTJw9cj
        zUa3uEpzCPYTbrrjGB4DZsrUoxKKZZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-WZ8oG6IAPiO3enbg9DlwwA-1; Fri, 01 May 2020 07:25:59 -0400
X-MC-Unique: WZ8oG6IAPiO3enbg9DlwwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AFA6107B7C3;
        Fri,  1 May 2020 11:25:57 +0000 (UTC)
Received: from krava (unknown [10.40.192.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF3DC5C1B0;
        Fri,  1 May 2020 11:25:54 +0000 (UTC)
Date:   Fri, 1 May 2020 13:25:52 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH 5/8] perf evlist: Allow reusing the side band thread for
 more purposes
Message-ID: <20200501112552.GC1789042@krava>
References: <20200429131106.27974-1-acme@kernel.org>
 <20200429131106.27974-6-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429131106.27974-6-acme@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 10:11:03AM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> I.e. so far we had just one event in that side band thread, a dummy one
> with attr.bpf_event set, so that 'perf record' can go ahead and ask the
> kernel for further information about BPF programs being loaded.
> 
> Allow for more than one event to be there, so that we can use it as
> well for the upcoming --switch-output-event feature.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Song Liu <songliubraving@fb.com>
> Link: http://lore.kernel.org/lkml/20200427211935.25789-7-acme@kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/evlist.c | 22 ++++++++++++++++++++++
>  tools/perf/util/evlist.h |  1 +
>  2 files changed, 23 insertions(+)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 1d0d36da223b..849058766757 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1777,6 +1777,19 @@ static void *perf_evlist__poll_thread(void *arg)
>  	return NULL;
>  }
>  
> +void evlist__set_cb(struct evlist *evlist, perf_evsel__sb_cb_t cb, void *data)
> +{
> +	struct evsel *evsel;
> +
> +	evlist__for_each_entry(evlist, evsel) {
> +		evsel->core.attr.sample_id_all	  = 1;
> +		evsel->core.attr.watermark	  = 1;
> +		evsel->core.attr.wakeup_watermark = 1;
> +		evsel->side_band.cb   = cb;
> +		evsel->side_band.data = data;
> +	}
> +}
> +
>  int perf_evlist__start_sb_thread(struct evlist *evlist,
>  				 struct target *target)
>  {
> @@ -1788,6 +1801,15 @@ int perf_evlist__start_sb_thread(struct evlist *evlist,
>  	if (perf_evlist__create_maps(evlist, target))
>  		goto out_delete_evlist;
>  
> +	if (evlist->core.nr_entries > 1) {
> +		bool can_sample_identifier = perf_can_sample_identifier();

I just found this breaks python, because perf_can_sample_identifier
is defined in util/record.c

	19: 'import perf' in python                               :
	--- start ---
	test child forked, pid 1808205
	Traceback (most recent call last):
	  File "<stdin>", line 1, in <module>
	ImportError: python/perf.so: undefined symbol: perf_can_sample_identifier
	test child finished with -1
	---- end ----
	'import perf' in python: FAILED!

jirka

