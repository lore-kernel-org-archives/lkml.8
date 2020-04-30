Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AF7C8300C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D47302076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gW4tUc7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgD3LQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:16:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51257 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726309AbgD3LQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588245365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ttdm/izBUFWBZD4wzRDP0cgZi0SkDAtR3HxA/ugdRQA=;
        b=gW4tUc7Y7E71s0zWw6rZvWMffDhbUgj0kEMoSuz39M6EdpfyKHFKPxIhUUSHPH9j+/gSA+
        zUHPCIQHtOnLLLgTgKnhVs+Z2dFwS2jdMjK+JjWS2akKx7AtdxxKJBmN77TpSLdp7atk32
        5S21PhLcd17sBC2YNQsOC6quHAyjdzs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-Fx35kZGVOb-g6RTBBVa6ew-1; Thu, 30 Apr 2020 07:15:59 -0400
X-MC-Unique: Fx35kZGVOb-g6RTBBVa6ew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E359835B41;
        Thu, 30 Apr 2020 11:15:57 +0000 (UTC)
Received: from krava (unknown [10.40.192.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B871560C84;
        Thu, 30 Apr 2020 11:15:54 +0000 (UTC)
Date:   Thu, 30 Apr 2020 13:15:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf parse-events: Use strcmp to compare the PMU name
Message-ID: <20200430111551.GC1694693@krava>
References: <20200430003618.17002-1-yao.jin@linux.intel.com>
 <20200430084529.GC1681583@krava>
 <66b84e3f-f7d8-bb65-616e-d159a509a439@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66b84e3f-f7d8-bb65-616e-d159a509a439@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 09:54:18AM +0100, John Garry wrote:
> On 30/04/2020 09:45, Jiri Olsa wrote:
> > On Thu, Apr 30, 2020 at 08:36:18AM +0800, Jin Yao wrote:
> > > A big uncore event group is split into multiple small groups which
> > > only include the uncore events from the same PMU. This has been
> > > supported in the commit 3cdc5c2cb924a ("perf parse-events: Handle
> > > uncore event aliases in small groups properly").
> > > 
> > > If the event's PMU name starts to repeat, it must be a new event.
> > > That can be used to distinguish the leader from other members.
> > > But now it only compares the pointer of pmu_name
> > > (leader->pmu_name == evsel->pmu_name).
> > > 
> > > If we use "perf stat -M LLC_MISSES.PCIE_WRITE -a" on cascadelakex,
> > > the event list is:
> > > 
> > > evsel->name					evsel->pmu_name
> > > ---------------------------------------------------------------
> > > unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_4 (as leader)
> > > unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_2
> > > unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_0
> > > unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_5
> > > unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_3
> > > unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_1
> > > unc_iio_data_req_of_cpu.mem_write.part1		uncore_iio_4
> > > ......
> > > 
> > > For the event "unc_iio_data_req_of_cpu.mem_write.part1" with
> > > "uncore_iio_4", it should be the event from PMU "uncore_iio_4".
> > > It's not a new leader for this PMU.
> > > 
> > > But if we use "(leader->pmu_name == evsel->pmu_name)", the check
> > > would be failed and the event is stored to leaders[] as a new
> > > PMU leader.
> > > 
> > > So this patch uses strcmp to compare the PMU name between events.
> > > 
> > > Fixes: 3cdc5c2cb924a ("perf parse-events: Handle uncore event aliases in small groups properly")
> > > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > 
> > looks good, any chance we could have automated test
> > for this uncore leader setup logic? like maybe the way
> > John did the pmu-events tests? like test will trigger
> > only when there's the pmu/events in the system
> > 
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > 
> > thanks,
> > jirka
> 
> Hi jirka,
> 
> JFYI, this is effectively the same patch as I mentioned to you, which was a
> fix for the same WARN:
> 
> https://lore.kernel.org/linux-arm-kernel/1587120084-18990-2-git-send-email-john.garry@huawei.com/
> 
> but I found that it "fixed" d4953f7ef1a2 ("perf parse-events: Fix 3 use
> after frees found with clang ASANutil/parse-events.c"), based on bisect
> breakage

hum right.. sorry I did not recalled that, there's
also the warn removal in here, could you guys also
plz sync on the fixes clauses?

thanks,
jirka

> 
> cheers
> 
> > 
> > 
> > > ---
> > >   tools/perf/util/parse-events.c | 5 ++---
> > >   1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > > index 10107747b361..786eddb6a097 100644
> > > --- a/tools/perf/util/parse-events.c
> > > +++ b/tools/perf/util/parse-events.c
> > > @@ -1629,12 +1629,11 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
> > >   		 * event. That can be used to distinguish the leader from
> > >   		 * other members, even they have the same event name.
> > >   		 */
> > > -		if ((leader != evsel) && (leader->pmu_name == evsel->pmu_name)) {
> > > +		if ((leader != evsel) &&
> > > +		    !strcmp(leader->pmu_name, evsel->pmu_name)) {
> > >   			is_leader = false;
> > >   			continue;
> > >   		}
> > > -		/* The name is always alias name */
> > > -		WARN_ON(strcmp(leader->name, evsel->name));
> > >   		/* Store the leader event for each PMU */
> > >   		leaders[nr_pmu++] = (uintptr_t) evsel;
> > > -- 
> > > 2.17.1
> > > 
> > 
> > .
> > 
> 

