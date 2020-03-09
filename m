Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772E3C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C44421D7E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivz0jehS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCIP0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:26:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32840 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726605AbgCIP0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583767606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pad4UgQwNlr5rwbQw4SSfpppJOImtohRQQl+5KGIId8=;
        b=ivz0jehS0sxdcCKkW+qFT9aL1AFTYLph4IRpxpnS32Hi01JwELQXAt4zWLpzuJ+L2QIhHU
        HExxcIOF/MwOe5a8taU+EZxDti/8DKVyrTOvYMR7Jz1KRmQKlnPsqpN7UTLdVZvoE6/T6Z
        4b3b7Thyv7TO4CfINA7KoOrpQRVRwZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-ffkHswiONfKPrARmns6TdA-1; Mon, 09 Mar 2020 11:26:42 -0400
X-MC-Unique: ffkHswiONfKPrARmns6TdA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 621CE1005512;
        Mon,  9 Mar 2020 15:26:40 +0000 (UTC)
Received: from krava (unknown [10.43.17.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C02BB90A00;
        Mon,  9 Mar 2020 15:26:37 +0000 (UTC)
Date:   Mon, 9 Mar 2020 16:26:35 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, will@kernel.org, ak@linux.intel.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        james.clark@arm.com, qiangqing.zhang@nxp.com
Subject: Re: [PATCH 6/6] perf test: Add pmu-events test
Message-ID: <20200309152635.GD67774@krava>
References: <1583406486-154841-1-git-send-email-john.garry@huawei.com>
 <1583406486-154841-7-git-send-email-john.garry@huawei.com>
 <20200309084924.GA65888@krava>
 <82c3fbfe-4ddc-db7d-c17f-29ca6f11e60c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82c3fbfe-4ddc-db7d-c17f-29ca6f11e60c@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 10:12:15AM +0000, John Garry wrote:
> > > 
> > > A sample run is as follows for x86:
> > > 
> > > Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
> > > 10: PMU event aliases                                     :
> > > --- start ---
> > > test child forked, pid 30869
> > > Using CPUID GenuineIntel-6-9E-9
> > > intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
> > > skipping testing PMU software
> > > testing PMU power: skip
> > > testing PMU cpu: matched event segment_reg_loads.any
> > > testing PMU cpu: matched event dispatch_blocked.any
> > > testing PMU cpu: matched event eist_trans
> > > testing PMU cpu: matched event bp_l1_btb_correct
> > > testing PMU cpu: matched event bp_l2_btb_correct
> > > testing PMU cpu: pass
> > > testing PMU cstate_core: skip
> > > testing PMU uncore_cbox_2: matched event unc_cbo_xsnp_response.miss_eviction
> > > testing PMU uncore_cbox_2: pass
> > > skipping testing PMU breakpoint
> > > testing PMU uncore_cbox_0: matched event unc_cbo_xsnp_response.miss_eviction
> > > testing PMU uncore_cbox_0: pass
> > > skipping testing PMU tracepoint
> > > testing PMU cstate_pkg: skip
> > > testing PMU uncore_arb: skip
> > > testing PMU msr: skip
> > > testing PMU uncore_cbox_3: matched event unc_cbo_xsnp_response.miss_eviction
> > > testing PMU uncore_cbox_3: pass
> > > testing PMU intel_pt: skip
> > > testing PMU uncore_cbox_1: matched event unc_cbo_xsnp_response.miss_eviction
> > > testing PMU uncore_cbox_1: pass
> > > test child finished with 0
> > > ---- end ----
> > > PMU event aliases: Ok
> > 
> > SNIP
> > 
> > > +int test__pmu_event_aliases(struct test *test __maybe_unused,
> > > +			    int subtest __maybe_unused)
> > > +{
> > > +	struct perf_pmu *pmu = NULL;
> > > +
> > > +	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
> > > +		int count = 0;
> > 
> 
> Hi jirka,
> 
> > I don't follow the pmu iteration in here.. I'd expect
> > we create 'test' pmu
> 
> well, that's what we do next in the call to __test__pmu_event_aliases():
> 
> static int __test__pmu_event_aliases(char *pmu_name, int *count)
> {
> 	struct perf_pmu_alias *alias;
> 	struct perf_pmu *pmu;
> 	LIST_HEAD(aliases);
> 	int res = 0;
> 
> 	pmu = zalloc(sizeof(*pmu));
> 	if (!pmu)
> 		return -1;
> 
> 	pmu->name = pmu_name;
> 
> 	pmu_add_cpu_aliases_map(&aliases, pmu, &pmu_events_map_test);
> 
> 
> Here we clone the HW PMU, create the aliases, and verify them against a
> known, expected list.
> 
> and check that all the aliasses
> > are in place as we expect them.. why do we match them
> > to existing events?
> 
> The events in test_cpu_aliases[] or test_uncore_aliases[] are checked
> against the events from pmu-events/arch/test/test_cpu/*.json

I don't understand the benefit of this.. so IIUC:

  - jevents will go through arch/test and populate pmu-events/pmu-events.c
    with:
       struct pmu_event pme_test_cpu[] ...
       struct pmu_events_map pmu_events_map_test ...

  - so we actualy have the parsed json events in C structs and we can go
    through them and check it contains fields with strings that we expect

  - you go through all detected pmus and check if the tests events we
    generated are matching some of the events from these pmus,
    and that's where I'm lost ;-) why?

> 
> > 
> > or as I'm thinking about that now, would it be enough
> > to check pme_test_cpu array to have string that we
> > expect?
> 
> Right, I might change this.
> 
> So currently we iterate the PMU aliases to ensure that we have a matching
> event in pme_test_cpu[]. It may be better to iterate the events in
> pme_test_cpu[] to ensure that we have an alias.

that's what I described above.. I dont understand the connection/value
of this tests

> 
> The problem here is uncore PMUs. They have the "Unit" field, which is used
> for matching the PMU. So we cannot ensure test events from uncore.json will
> always have an event alias created per PMU. But maybe I could use
> pmu_uncore_alias_match() to check if the test event matches in this case.

hum I guess I don't follow all the details.. but some more explanation
of the test would be great

jirka

