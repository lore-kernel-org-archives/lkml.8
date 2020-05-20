Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB35C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC2920758
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUB/8DCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgETMih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:38:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38618 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726224AbgETMig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589978315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LpPWcWre6erap/QD2kzhcgnROeHj6DcH9s7pJSk+zGI=;
        b=cUB/8DCdtMakN+YiNzy2S1yPkNNvv+093diOFg4UYrcBp0FRqflCatrXzCifzIKr91mGo+
        vXRS07zto84O0jJ4FRVfE/2munwMaXM8kLxlEuV01+FZMp43f8aks5RYnOnkr4olsad72Q
        yzDoR97Nmm2subGoNw+8714r1xMc7kg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-Om-U037cN32Ar2lv3zo5WQ-1; Wed, 20 May 2020 08:38:30 -0400
X-MC-Unique: Om-U037cN32Ar2lv3zo5WQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16659835B51;
        Wed, 20 May 2020 12:38:29 +0000 (UTC)
Received: from krava (unknown [10.40.193.10])
        by smtp.corp.redhat.com (Postfix) with SMTP id 485C91010403;
        Wed, 20 May 2020 12:38:27 +0000 (UTC)
Date:   Wed, 20 May 2020 14:38:26 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/9] perf evlist: introduce control file descriptors
Message-ID: <20200520123826.GF157452@krava>
References: <eb38e9e5-754f-d410-1d9b-e26b702d51b7@linux.intel.com>
 <3a1ed73d-6d11-eeb1-0897-476c5367369d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a1ed73d-6d11-eeb1-0897-476c5367369d@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 10:59:00AM +0300, Alexey Budankov wrote:
> 
> Define and initialize control file descriptors.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/util/evlist.c | 3 +++
>  tools/perf/util/evlist.h | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 2a9de6491700..aa61619fa304 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -63,6 +63,9 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
>  	perf_evlist__set_maps(&evlist->core, cpus, threads);
>  	evlist->workload.pid = -1;
>  	evlist->bkw_mmap_state = BKW_MMAP_NOTREADY;
> +	evlist->ctl_fd = -1;
> +	evlist->ctl_fd_ack = -1;
> +	evlist->ctl_fd_pos = -1;
>  }
>  
>  struct evlist *evlist__new(void)
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index b6f325dfb4d2..62f259d89b41 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -74,6 +74,9 @@ struct evlist {
>  		pthread_t		th;
>  		volatile int		done;
>  	} thread;
> +	int		ctl_fd;
> +	int		ctl_fd_ack;
> +	int		ctl_fd_pos;

we are using the anonymous structs to keep related
parts together like for workload and thread

could you use it in there as well?

jirka

>  };
>  
>  struct evsel_str_handler {
> -- 
> 2.24.1
> 

