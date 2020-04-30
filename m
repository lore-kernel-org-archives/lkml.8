Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEE6C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA2392076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WW7+LBr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgD3PdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:33:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60636 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726344AbgD3PdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588260785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AAgBlx0Nlw3gaU+dOvATALPgPMDi8eTwXD0Smt+daVg=;
        b=WW7+LBr6WAYoYwLI1JEJo3fr+5SxQ/YeFHLreesTNsghtw5CeRKb0jHS88TCQy4H9WZG9X
        WlNJCc0Ew0sTuH9WR6QkA27wJoYUFbmJAJ3bEHkkMwhPF9eA1zN21kvisY3mP+6agS7T+C
        0pEZ6kRqnQfQkl6glnKJdhpjzdn+l1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-yQcHAZZCPAmLCnVLsJxkuA-1; Thu, 30 Apr 2020 11:33:01 -0400
X-MC-Unique: yQcHAZZCPAmLCnVLsJxkuA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A30DB8015D2;
        Thu, 30 Apr 2020 15:32:59 +0000 (UTC)
Received: from krava (unknown [10.40.192.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 265D8600E5;
        Thu, 30 Apr 2020 15:32:55 +0000 (UTC)
Date:   Thu, 30 Apr 2020 17:32:53 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] perf parse-events: Use strcmp to compare the PMU name
Message-ID: <20200430153253.GF1694693@krava>
References: <20200430003618.17002-1-yao.jin@linux.intel.com>
 <20200430084529.GC1681583@krava>
 <fc51012d-66c7-3e93-07df-22411b23fa8f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc51012d-66c7-3e93-07df-22411b23fa8f@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 09:45:14PM +0800, Jin, Yao wrote:
> Hi Jiri,
> 
> On 4/30/2020 4:45 PM, Jiri Olsa wrote:
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
> > 
> > 
> 
> I'm considering to use LKP to do the sanity tests for all perf events
> (core/uncore) and perf metrics periodically. It may help us to find the
> regressions on time.

sounds good ;) thanks

jirka

