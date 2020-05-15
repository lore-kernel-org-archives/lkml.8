Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1127C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F03120657
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGnhzDVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgEOIdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 04:33:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30531 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726694AbgEOIdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 04:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589531602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AWBZW6PEKw6/UZUtcffoeHGKnskwQ+WAPGzslzn2sSs=;
        b=MGnhzDVw1CQpOgM2RvtH3YRlgYD9s4fO2ZeGg9YoThJmwqGVVNoeuOryy26r1kxmoLrXQy
        GJusKddypFuuru6qJBN1qP2dyoZhZAJ2LyfiG/KHKrC4K0Md3gHDL4Wzmwse7igSjDABf5
        CHExeYLpg7jE1wH2sa346hOVjv/Kg2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-zQLij6whPYGQlm8tJUIJKQ-1; Fri, 15 May 2020 04:33:18 -0400
X-MC-Unique: zQLij6whPYGQlm8tJUIJKQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A80FDEC1AB;
        Fri, 15 May 2020 08:33:16 +0000 (UTC)
Received: from krava (unknown [10.40.194.127])
        by smtp.corp.redhat.com (Postfix) with SMTP id 54FDF7D971;
        Fri, 15 May 2020 08:33:13 +0000 (UTC)
Date:   Fri, 15 May 2020 10:33:12 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf evsel: Get group fd from CPU0 for system wide event
Message-ID: <20200515083312.GB3511648@krava>
References: <20200430013451.17196-1-yao.jin@linux.intel.com>
 <20200501102337.GA1761222@krava>
 <b799b66a-42aa-6c55-647e-7b718473632a@linux.intel.com>
 <20200505000352.GH1916255@krava>
 <3e813227-4954-0d4b-bc7a-ca272b18454a@linux.intel.com>
 <68e53765-6f45-9483-7543-0a2f961cdc62@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68e53765-6f45-9483-7543-0a2f961cdc62@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 02:04:57PM +0800, Jin, Yao wrote:

SNIP

> I think I get the root cause. That should be a serious bug in get_group_fd, access violation!
> 
> For a group mixed with system-wide event and per-core event and the group
> leader is system-wide event, access violation will happen.
> 
> perf_evsel__alloc_fd allocates one FD member for system-wide event (only FD(evsel, 0, 0) is valid).
> 
> But for per core event, perf_evsel__alloc_fd allocates N FD members (N =
> ncpus). For example, for ncpus is 8, FD(evsel, 0, 0) to FD(evsel, 7, 0) are
> valid.
> 
> get_group_fd(struct evsel *evsel, int cpu, int thread)
> {
>     struct evsel *leader = evsel->leader;
> 
>     fd = FD(leader, cpu, thread);    /* access violation may happen here */
> }
> 
> If leader is system-wide event, only the FD(leader, 0, 0) is valid.
> 
> When get_group_fd accesses FD(leader, 1, 0), access violation happens.
> 
> My fix is:
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 28683b0eb738..db05b8a1e1a8 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1440,6 +1440,9 @@ static int get_group_fd(struct evsel *evsel, int cpu, int thread)
>         if (evsel__is_group_leader(evsel))
>                 return -1;
> 
> +       if (leader->core.system_wide && !evsel->core.system_wide)
> +               return -2;

so this effectively stops grouping system_wide events with others,
and I think it's correct, how about events that differ in cpumask?

should we perhaps ensure this before we call open? go throught all
groups and check they are on the same cpus?

thanks,
jirka


> +
>         /*
>          * Leader must be already processed/open,
>          * if not it's a bug.
> @@ -1665,6 +1668,11 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>                                 pid = perf_thread_map__pid(threads, thread);
> 
>                         group_fd = get_group_fd(evsel, cpu, thread);
> +                       if (group_fd == -2) {
> +                               errno = EINVAL;
> +                               err = -EINVAL;
> +                               goto out_close;
> +                       }
>  retry_open:
>                         test_attr__ready();
> 
> It enables the perf_evlist__reset_weak_group. And in the second_pass (in
> __run_perf_stat), the events will be opened successfully.
> 
> I have tested OK for this fix on cascadelakex.
> 
> Thanks
> Jin Yao
> 

