Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8FBC10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E4520637
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WcNCx5NY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgCIItv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:49:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47999 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725956AbgCIItu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583743789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8QZ2VpmXmGjbC2jzOGtJlLDEr7srXarmJid3qae+hIk=;
        b=WcNCx5NYwumGHMTwpCIK5mikEOHZ+dDOul6QY3o4Ra0u+bBCbSsdmN+dqR+ltUYBUnorcl
        e/O5mufUcPc0+sC7ZMfK0izZuo/sbn9SkQC6pkG4dV5vMdY688K7PL44vETWNVbXJoISvO
        1rDFa8j4dU+5VrjGnzUD2nwW4hLEIaM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-lzLAc4gnPQ6CJwC1rmfv3Q-1; Mon, 09 Mar 2020 04:49:47 -0400
X-MC-Unique: lzLAc4gnPQ6CJwC1rmfv3Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59F1DA3743;
        Mon,  9 Mar 2020 08:49:45 +0000 (UTC)
Received: from krava (ovpn-205-132.brq.redhat.com [10.40.205.132])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 14E2519C58;
        Mon,  9 Mar 2020 08:49:41 +0000 (UTC)
Date:   Mon, 9 Mar 2020 09:49:24 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, will@kernel.org, ak@linux.intel.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        james.clark@arm.com, qiangqing.zhang@nxp.com
Subject: Re: [PATCH 6/6] perf test: Add pmu-events test
Message-ID: <20200309084924.GA65888@krava>
References: <1583406486-154841-1-git-send-email-john.garry@huawei.com>
 <1583406486-154841-7-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583406486-154841-7-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 07:08:06PM +0800, John Garry wrote:
> Add a pmu-events test.
> 
> This test will scan all PMUs in the system, and run a PMU event aliasing
> test for each CPU or uncore PMU.
> 
> For known aliases added in pmu-events/arch/test, we need to add an entry
> in test_cpu_aliases[] or test_uncore_aliases[].

heya, awesome! ;-)

> 
> A sample run is as follows for x86:
> 
> Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
> 10: PMU event aliases                                     :
> --- start ---
> test child forked, pid 30869
> Using CPUID GenuineIntel-6-9E-9
> intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
> skipping testing PMU software
> testing PMU power: skip
> testing PMU cpu: matched event segment_reg_loads.any
> testing PMU cpu: matched event dispatch_blocked.any
> testing PMU cpu: matched event eist_trans
> testing PMU cpu: matched event bp_l1_btb_correct
> testing PMU cpu: matched event bp_l2_btb_correct
> testing PMU cpu: pass
> testing PMU cstate_core: skip
> testing PMU uncore_cbox_2: matched event unc_cbo_xsnp_response.miss_eviction
> testing PMU uncore_cbox_2: pass
> skipping testing PMU breakpoint
> testing PMU uncore_cbox_0: matched event unc_cbo_xsnp_response.miss_eviction
> testing PMU uncore_cbox_0: pass
> skipping testing PMU tracepoint
> testing PMU cstate_pkg: skip
> testing PMU uncore_arb: skip
> testing PMU msr: skip
> testing PMU uncore_cbox_3: matched event unc_cbo_xsnp_response.miss_eviction
> testing PMU uncore_cbox_3: pass
> testing PMU intel_pt: skip
> testing PMU uncore_cbox_1: matched event unc_cbo_xsnp_response.miss_eviction
> testing PMU uncore_cbox_1: pass
> test child finished with 0
> ---- end ----
> PMU event aliases: Ok

SNIP

> +int test__pmu_event_aliases(struct test *test __maybe_unused,
> +			    int subtest __maybe_unused)
> +{
> +	struct perf_pmu *pmu = NULL;
> +
> +	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
> +		int count = 0;

I don't follow the pmu iteration in here.. I'd expect
we create 'test' pmu and check that all the aliasses
are in place as we expect them.. why do we match them
to existing events?

or as I'm thinking about that now, would it be enough
to check pme_test_cpu array to have string that we
expect?

thanks for doing this,
jirka

