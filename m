Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFD9C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 10:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D9920748
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 10:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/9jyUcl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgHHKWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 06:22:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31073 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725980AbgHHKWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 06:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596882136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w0gIWPGkiOKkQ7sXuDXnemjnvJ84JeLQi/Kr/jgf3ls=;
        b=d/9jyUcly/c6dyVFLrgsqDiA0VDLWk4XebV/jho2EqJmYQIcdZc6wPeN7WvQUQDuc8MHuJ
        WcKZxTchXf2q6EpioswABRNmXZMXCdgDC6aROtREi9PGHRK3R0zAWojyswWcfeHnPvBBse
        rQbfC6RDOQT1KoHcCPFVpi+a2YX5Uc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-R1kpnPYLM1aQ09EL8Wy_4g-1; Sat, 08 Aug 2020 06:22:12 -0400
X-MC-Unique: R1kpnPYLM1aQ09EL8Wy_4g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 768251030C20;
        Sat,  8 Aug 2020 10:22:11 +0000 (UTC)
Received: from krava (unknown [10.40.192.25])
        by smtp.corp.redhat.com (Postfix) with SMTP id A08C58AC21;
        Sat,  8 Aug 2020 10:22:09 +0000 (UTC)
Date:   Sat, 8 Aug 2020 12:22:08 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC] libperf: Add support for user space counter access
Message-ID: <20200808102208.GA619980@krava>
References: <20200807230517.57114-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807230517.57114-1-robh@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 05:05:17PM -0600, Rob Herring wrote:
> x86 and arm64 can both support direct access of event counters in
> userspace. The access sequence is less than trivial and currently exists
> in perf test code (tools/perf/arch/x86/tests/rdpmc.c) with copies in
> projects such as PAPI and libpfm4.
> 
> Patches to add arm64 userspace support are pending[1].
> 
> For this RFC, looking for a yes, seems like a good idea, or no, go away we
> don't want this in libperf.

hi,
looks great!

I wanted to add this for very long time.. so yes, we want this ;-)

> 
> TODO:
> - Handle userspace access not enabled.
> - Handle pmc_width and cap_user_time_short in read loop.
> - Move existing rdpmc test to libperf based test?
> - Abstract out rdtsc/rdpmc (currently only builds on x86 and need to add
>   Arm versions)

all of them seem good, also please add test for perf_mmap__read_self
itself and update the doc/man

SNIP

> +{
> +	struct perf_event_mmap_page *pc = map->base;
> +	u32 seq, idx, time_mult = 0, time_shift = 0;
> +	u64 count, cyc = 0, time_offset = 0, enabled, running, delta;
> +
> +	/*
> +	 * Check if event was unmapped due to a POLLHUP/POLLERR.
> +	 */
> +	if (!refcount_read(&map->refcnt))
> +		return ~0;
> +
> +	do {
> +		seq = pc->lock;
> +		barrier();
> +
> +		enabled = pc->time_enabled;
> +		running = pc->time_running;
> +
> +		if (enabled != running) {

should you check pc->cap_usr_time in here?

> +			cyc = rdtsc();
> +			time_mult = pc->time_mult;
> +			time_shift = pc->time_shift;
> +			time_offset = pc->time_offset;
> +		}
> +
> +		idx = pc->index;
> +		count = pc->offset;
> +		if (idx)

and pc->cap_user_rdpmc in here?

ok, it's probably in the TODO

thanks,
jirka

