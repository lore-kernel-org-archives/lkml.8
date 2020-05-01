Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8D9C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 441E3206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYrUs1iT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgEAKXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 06:23:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32585 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728229AbgEAKXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 06:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588328628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=byxFlKeuowY0yc0XBoCAz1C2pz8gQc7fx1kR9pv0BaE=;
        b=aYrUs1iTCJo4lBsYPa08wa3Ba1cjvW3F/ao/oqupTMszljmLHM2Pb/K8laY5oj1brwS+n5
        M796zJMV1e/Sdmq3MTn1utSL4ZxE0noUkktIVfEuo/aAGc/gMYGgXHhlM7oeLeAYjT3CkQ
        hJ2R4cm9uoCNFhlLSVY9RMBw5t87z18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-7TQAXia3Oi295juXPFoMqQ-1; Fri, 01 May 2020 06:23:44 -0400
X-MC-Unique: 7TQAXia3Oi295juXPFoMqQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6284C80183C;
        Fri,  1 May 2020 10:23:42 +0000 (UTC)
Received: from krava (unknown [10.40.192.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 33AAD5C1B0;
        Fri,  1 May 2020 10:23:40 +0000 (UTC)
Date:   Fri, 1 May 2020 12:23:37 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf evsel: Get group fd from CPU0 for system wide event
Message-ID: <20200501102337.GA1761222@krava>
References: <20200430013451.17196-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430013451.17196-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 09:34:51AM +0800, Jin Yao wrote:
> A metric may consist of system wide event and non system-wide event.
> The event group leader may be the system wide event.
> 
> For example, the metric "C2_Pkg_Residency" consists of
> "cstate_pkg/c2-residency" and "msr/tsc". The former counts on the first
> CPU of socket (tagged system-wide) and the latter is per CPU.
> 
> But "C2_Pkg_Residency" hits assertion failure on cascadelakex.
> 
>  # perf stat -M "C2_Pkg_Residency" -a -- sleep 1
>  perf: util/evsel.c:1464: get_group_fd: Assertion `!(fd == -1)' failed.
>  Aborted
> 
> get_group_fd(evsel, cpu, thread)
> {
> 	leader = evsel->leader;
> 	fd = FD(leader, cpu, thread);
> 	BUG_ON(fd == -1);
> }
> 
> Considering this case, leader is "cstate_pkg/c2-residency", evsel is
> "msr/tsc" and cpu is 1. Because "cstate_pkg/c2-residency" is a system-wide
> event and it's processed on CPU0, so FD(leader, 1, thread) must return an
> invalid fd, then BUG_ON() may be triggered.
> 
> This patch gets group fd from CPU0 for system wide event if
> FD(leader, cpu, thread) returns invalid fd.
> 
> With this patch,
> 
>  # perf stat -M "C2_Pkg_Residency" -a -- sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>         1000850802      cstate_pkg/c2-residency/  #      0.5 C2_Pkg_Residency
>       201446161592      msr/tsc/
> 
>        1.010637051 seconds time elapsed
> 
> Fixes: 6a4bb04caacc ("perf tools: Enable grouping logic for parsed events")
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/evsel.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 6a571d322bb2..cd6470f63d6f 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1461,6 +1461,9 @@ static int get_group_fd(struct evsel *evsel, int cpu, int thread)
>  	BUG_ON(!leader->core.fd);
>  
>  	fd = FD(leader, cpu, thread);
> +	if (fd == -1 && leader->core.system_wide)

fd does not need to be -1 in here.. in my setup cstate_pkg/c2-residency/
has cpumask 0, so other cpus never get open and are 0, and the whole thing
ends up with:

	sys_perf_event_open: pid -1  cpu 1  group_fd 0  flags 0
	sys_perf_event_open failed, error -9

I actualy thought we put -1 to fd array but couldn't find it.. perhaps we should od that


> +		fd = FD(leader, 0, thread);
> +

so how do we group following events?

  cstate_pkg/c2-residency/ - cpumask 0
  msr/tsc/                 - all cpus

cpu 0 is fine.. the rest I have no idea ;-)

that's why metrics use the :W, that disables grouping on failure

jirka

>  	BUG_ON(fd == -1);
>  
>  	return fd;
> -- 
> 2.17.1
> 

