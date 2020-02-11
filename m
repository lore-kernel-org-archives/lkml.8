Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AC9C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0C1206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IggwhQyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbgBKOnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:43:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27195 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727728AbgBKOnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581432202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Uo6Yj+q6VJYat5WHAhzWGNRtS9DME8uSiVN5weyl/Y=;
        b=IggwhQyD8pr8kx4c86lwdrvL7BKCenqmULEr8Ew3zHN9eVflyAuUeCpPL+1EQuuDb60+aj
        2Vxgn2KW4sxim7CIC89f/UxHhIQ7hKODMsJ+D/lZzzdpq889O5TFzm1puoQksK/KZBUUhn
        X9YNMk99K/vxNkh+NKxNdefsNWYJb3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-A1EvZX6yOLSeHIdoYDVguw-1; Tue, 11 Feb 2020 09:43:18 -0500
X-MC-Unique: A1EvZX6yOLSeHIdoYDVguw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA579800EB2;
        Tue, 11 Feb 2020 14:43:15 +0000 (UTC)
Received: from krava (ovpn-206-93.brq.redhat.com [10.40.206.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 345426055B;
        Tue, 11 Feb 2020 14:43:11 +0000 (UTC)
Date:   Tue, 11 Feb 2020 15:43:08 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, will@kernel.org, ak@linux.intel.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        james.clark@arm.com, zhangshaokun@hisilicon.com,
        robin.murphy@arm.com
Subject: Re: [PATCH RFC 4/7] perf pmu: Rename uncore symbols to include
 system PMUs
Message-ID: <20200211144308.GC93194@krava>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
 <1579876505-113251-5-git-send-email-john.garry@huawei.com>
 <20200210120715.GC1907700@krava>
 <fac99c40-dace-3e2e-c8f4-b2afed8b7c61@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fac99c40-dace-3e2e-c8f4-b2afed8b7c61@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 03:44:48PM +0000, John Garry wrote:
> On 10/02/2020 12:07, Jiri Olsa wrote:
> > On Fri, Jan 24, 2020 at 10:35:02PM +0800, John Garry wrote:
> > 
> > SNIP
> > 
> > >   		/* Only split the uncore group which members use alias */
> > > -		if (!evsel->use_uncore_alias)
> > > +		if (!evsel->use_uncore_or_system_alias)
> > >   			goto out;
> > >   		/* The events must be from the same uncore block */
> > > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > > index 8b99fd312aae..569aba4cec89 100644
> > > --- a/tools/perf/util/pmu.c
> > > +++ b/tools/perf/util/pmu.c
> > > @@ -623,7 +623,7 @@ static struct perf_cpu_map *pmu_cpumask(const char *name)
> > >   	return NULL;
> > >   }
> > > -static bool pmu_is_uncore(const char *name)
> > > +static bool pmu_is_uncore_or_sys(const char *name)
> > 
> 
> Hi jirka,
> 
> > so we detect uncore PMU by checking for cpumask file
> > 
> 
> For PMUs which could be considered "system" PMUs, they also have a cpumask,
> like the PMU I use as motivation for this series:
> 
> root@(none)$ pwd
> /sys/bus/event_source/devices/smmuv3_pmcg_100020
> root@(none)$ ls -l
> total 0
> -r--r--r--    1 root     root          4096 Feb 10 14:50 cpumask
> drwxr-xr-x    2 root     root             0 Feb 10 14:50 events
> drwxr-xr-x    2 root     root             0 Feb 10 14:50 format
> -rw-r--r--    1 root     root          4096 Feb 10 14:50
> perf_event_mux_interval_ms
> drwxr-xr-x    2 root     root             0 Feb 10 14:50 power
> lrwxrwxrwx    1 root     root             0 Feb 10 14:50 subsystem ->
> ../../bus/event_source
> -r--r--r--    1 root     root          4096 Feb 10 14:50 type
> -rw-r--r--    1 root     root          4096 Feb 10 14:50 uevent
> 
> 
> Other PMU drivers which I have checked in drivers/perf also have the same.
> 
> Indeed I see no way to differentiate whether a PMU is an uncore or system.
> So that is why I change the name to cover both. Maybe there is a better name
> than the verbose pmu_is_uncore_or_sys().
> 
> > I don't see the connection here with the sysid or '_sys' checking,
> > that's just telling which ID to use when looking for an alias, no?
> 
> So the connection is that in perf_pmu__find_map(), for a given PMU, the
> matching is now extended from only core or uncore PMUs to also these system
> PMUs. And I use the sysid to find an aliasing table for any system PMUs
> present.

I see.. can't we just check sysid for uncore PMUs? because
that's what the code is doing, right? having pmu_is_uncore_or_sys
makes me think there's some sysid-type PMU

jirka

