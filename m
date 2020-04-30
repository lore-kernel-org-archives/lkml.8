Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBC7C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC7EE20838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KzR2HT/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgD3Ipt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 04:45:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24236 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726420AbgD3Ips (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 04:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588236347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZzTxE6KURiJFVV0CKCAzn9c9oUCjh4xSOPyYt4wCu8w=;
        b=KzR2HT/FG8Q0F5mno/CUiHG7+hL25pFqHIa+cdPxnE/hWww2HDiG08q1osQX9NIsUF7zT2
        F+Wc4QaBYBlwfv/sTvPH5JgYkhhLX1fQ5b9EspHL2r7XnMhWiE36FhAzxKCmzHQTwdTuW8
        BFqsTKpUKBCV4pswnZtifzwNbQQZZx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-0HWIZ2qGNEWcdz4yQGFVUQ-1; Thu, 30 Apr 2020 04:45:42 -0400
X-MC-Unique: 0HWIZ2qGNEWcdz4yQGFVUQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40C9D107ACF4;
        Thu, 30 Apr 2020 08:45:40 +0000 (UTC)
Received: from krava (unknown [10.40.192.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 682155D9FC;
        Thu, 30 Apr 2020 08:45:35 +0000 (UTC)
Date:   Thu, 30 Apr 2020 10:45:29 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] perf parse-events: Use strcmp to compare the PMU name
Message-ID: <20200430084529.GC1681583@krava>
References: <20200430003618.17002-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430003618.17002-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 08:36:18AM +0800, Jin Yao wrote:
> A big uncore event group is split into multiple small groups which
> only include the uncore events from the same PMU. This has been
> supported in the commit 3cdc5c2cb924a ("perf parse-events: Handle
> uncore event aliases in small groups properly").
> 
> If the event's PMU name starts to repeat, it must be a new event.
> That can be used to distinguish the leader from other members.
> But now it only compares the pointer of pmu_name
> (leader->pmu_name == evsel->pmu_name).
> 
> If we use "perf stat -M LLC_MISSES.PCIE_WRITE -a" on cascadelakex,
> the event list is:
> 
> evsel->name					evsel->pmu_name
> ---------------------------------------------------------------
> unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_4 (as leader)
> unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_2
> unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_0
> unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_5
> unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_3
> unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_1
> unc_iio_data_req_of_cpu.mem_write.part1		uncore_iio_4
> ......
> 
> For the event "unc_iio_data_req_of_cpu.mem_write.part1" with
> "uncore_iio_4", it should be the event from PMU "uncore_iio_4".
> It's not a new leader for this PMU.
> 
> But if we use "(leader->pmu_name == evsel->pmu_name)", the check
> would be failed and the event is stored to leaders[] as a new
> PMU leader.
> 
> So this patch uses strcmp to compare the PMU name between events.
> 
> Fixes: 3cdc5c2cb924a ("perf parse-events: Handle uncore event aliases in small groups properly")
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>

looks good, any chance we could have automated test
for this uncore leader setup logic? like maybe the way
John did the pmu-events tests? like test will trigger
only when there's the pmu/events in the system

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka


> ---
>  tools/perf/util/parse-events.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 10107747b361..786eddb6a097 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1629,12 +1629,11 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
>  		 * event. That can be used to distinguish the leader from
>  		 * other members, even they have the same event name.
>  		 */
> -		if ((leader != evsel) && (leader->pmu_name == evsel->pmu_name)) {
> +		if ((leader != evsel) &&
> +		    !strcmp(leader->pmu_name, evsel->pmu_name)) {
>  			is_leader = false;
>  			continue;
>  		}
> -		/* The name is always alias name */
> -		WARN_ON(strcmp(leader->name, evsel->name));
>  
>  		/* Store the leader event for each PMU */
>  		leaders[nr_pmu++] = (uintptr_t) evsel;
> -- 
> 2.17.1
> 

