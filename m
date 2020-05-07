Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F19C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F7A2073A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="isqa3qxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgEGPTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:19:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45671 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725948AbgEGPTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588864782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sk4ffog3i8B4UB/8TKz4vMDBCAylhdqDtRPqM+XCXzw=;
        b=isqa3qxf8w3yJOKr6zSTuPN4Lj4Zu7H187opBUP5kHI1J7aqDTrl7r9xqsC6EgJNCYPzUr
        IwhSf12ZCd3p8RmmAtT2E22UoxgoTYjT8fbtoiNN4bvvMKpHBPffqipCt05omOJc8hSCGq
        6qyS8s8XZgajGu6NOgWZ7l+LHrBF8LU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-sA-Rx1L_PwOpgfpvcCbuxA-1; Thu, 07 May 2020 11:19:39 -0400
X-MC-Unique: sA-Rx1L_PwOpgfpvcCbuxA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BC10107B267;
        Thu,  7 May 2020 15:19:37 +0000 (UTC)
Received: from krava (unknown [10.40.194.212])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CD1D60CCC;
        Thu,  7 May 2020 15:19:35 +0000 (UTC)
Date:   Thu, 7 May 2020 17:19:32 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 2/4] perf counts: Reset prev_raw_counts counts
Message-ID: <20200507151932.GF2804092@krava>
References: <20200507065822.8255-1-yao.jin@linux.intel.com>
 <20200507065822.8255-3-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507065822.8255-3-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 02:58:20PM +0800, Jin Yao wrote:
> The evsel->prev_raw_counts is updated in perf_evsel__compute_deltas:
> 
> perf_evsel__compute_deltas()
> {
> 	tmp = *perf_counts(evsel->prev_raw_counts, cpu, thread);
> 	*perf_counts(evsel->prev_raw_counts, cpu, thread) = *count;
> }
> 
> When we want to reset the evsel->prev_raw_counts in
> perf_evsel__reset_prev_raw_counts, zeroing the aggr is not enough,
> we need to reset the counts too.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/counts.c | 5 +++++
>  tools/perf/util/counts.h | 2 ++
>  tools/perf/util/stat.c   | 1 +
>  3 files changed, 8 insertions(+)
> 
> diff --git a/tools/perf/util/counts.c b/tools/perf/util/counts.c
> index f94e1a23dad6..af3bf36f7c63 100644
> --- a/tools/perf/util/counts.c
> +++ b/tools/perf/util/counts.c
> @@ -64,3 +64,8 @@ void perf_evsel__free_counts(struct evsel *evsel)
>  	perf_counts__delete(evsel->counts);
>  	evsel->counts = NULL;
>  }
> +
> +void perf_evsel__reset_raw_counts(struct evsel *evsel)
> +{
> +	perf_counts__reset(evsel->prev_raw_counts);
> +}
> diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
> index 92196df4945f..15bb9acb7cb0 100644
> --- a/tools/perf/util/counts.h
> +++ b/tools/perf/util/counts.h
> @@ -42,4 +42,6 @@ void perf_evsel__reset_counts(struct evsel *evsel);
>  int perf_evsel__alloc_counts(struct evsel *evsel, int ncpus, int nthreads);
>  void perf_evsel__free_counts(struct evsel *evsel);
>  
> +void perf_evsel__reset_raw_counts(struct evsel *evsel);
> +
>  #endif /* __PERF_COUNTS_H */
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 774468341851..89e541564ed5 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -168,6 +168,7 @@ static void perf_evsel__reset_prev_raw_counts(struct evsel *evsel)
>  		evsel->prev_raw_counts->aggr.val = 0;
>  		evsel->prev_raw_counts->aggr.ena = 0;
>  		evsel->prev_raw_counts->aggr.run = 0;
> +		perf_evsel__reset_raw_counts(evsel);

that seems needed, but we have it scathered all over the place,
could you centralize the reset? the way I see it the perf_counts__reset
should zero all the members of struct perf_counts.. so also
the aggr values

it could also check for counts != NULL and we could call it
instead of:
  perf_evsel__reset_prev_raw_counts
    perf_evsel__reset_raw_counts
      perf_counts__reset

jirka

