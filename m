Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D486C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05753206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAmYQmtv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgCMKdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:33:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39312 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726055AbgCMKdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584095591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mGqpef0nt52hPE//tC+LYeJOZpKY1PtNUY8TQrYwFq8=;
        b=FAmYQmtvV9U+cUQit3OCce1dYOpL7gsyG7VpPAM4fkLYfFiR+bP9HIu9jpNjEv6YgLV6YH
        BRT8fiPfWHu+j7wZvwPstSyTMChY6HWyh0y+Oaxk1LwvIIwcf/yCjFclAr8QEZzAkMEv3h
        v+r3vD827Y9l90CwBONl15QDZ0CHvqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-1TngnJVWMMWTGG00PNSQbg-1; Fri, 13 Mar 2020 06:33:07 -0400
X-MC-Unique: 1TngnJVWMMWTGG00PNSQbg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E17448017CC;
        Fri, 13 Mar 2020 10:33:04 +0000 (UTC)
Received: from krava (ovpn-205-229.brq.redhat.com [10.40.205.229])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1364E5C1BB;
        Fri, 13 Mar 2020 10:33:01 +0000 (UTC)
Date:   Fri, 13 Mar 2020 11:32:59 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, will@kernel.org, ak@linux.intel.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        james.clark@arm.com, qiangqing.zhang@nxp.com
Subject: Re: [PATCH 6/6] perf test: Add pmu-events test
Message-ID: <20200313103259.GC389625@krava>
References: <1583406486-154841-1-git-send-email-john.garry@huawei.com>
 <1583406486-154841-7-git-send-email-john.garry@huawei.com>
 <20200309084924.GA65888@krava>
 <82c3fbfe-4ddc-db7d-c17f-29ca6f11e60c@huawei.com>
 <20200309152635.GD67774@krava>
 <6691dd26-7c53-26f0-b583-131707ede608@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6691dd26-7c53-26f0-b583-131707ede608@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 04:20:52PM +0000, John Garry wrote:
> > > 
> > > The events in test_cpu_aliases[] or test_uncore_aliases[] are checked
> > > against the events from pmu-events/arch/test/test_cpu/*.json
> > 
> 
> Hi Jirka,
> 
> > I don't understand the benefit of this.. so IIUC:
> > 
> >    - jevents will go through arch/test and populate pmu-events/pmu-events.c
> >      with:
> >         struct pmu_event pme_test_cpu[] ...
> >         struct pmu_events_map pmu_events_map_test ...
> 
> Right. And the idea is that pme_test_cpu[] can be used as generic set of
> events for testing on any arch/cpuid. (note: I'll just ignore uncore events
> for the moment)
> 
> > 
> >    - so we actualy have the parsed json events in C structs and we can go
> >      through them and check it contains fields with strings that we expect
> 
> No, we use pme_test_cpu[] to generate the event aliases for a PMU, and
> verify that the aliases are as expected.
> 
> > 
> >    - you go through all detected pmus and check if the tests events we
> >      generated are matching some of the events from these pmus,
> 
> Not exactly.
> 
> >      and that's where I'm lost ;-) why?
> 
> So consider the "cpu" HW PMU. During normal operation, we create the event
> aliases for this PMU in pmu_lookup()->pmu_add_cpu_aliases(). This step looks
> up a map of cpu events for that CPUID, and then creates the event aliases
> for that PMU from that map.
> 
> I want the test to recreate this and verify that the events from the test
> JSONs will have event aliases created properly.

aah ok, my first objective was to have some way to test pmu-events
changes we plan to do and their affect to generated pmu-event.c

you want to test the code paths after that.. perfect

> 
> So in the test when we scan the PMUs and find "cpu" HW PMU, we create a test
> PMU with the same name, create the event aliases from pme_test_cpu[] for
> that test PMU, and then verify that the event aliases created are as
> expected. Then the test PMU is deleted.
> 
> So overall the test covers:
> a. jevents code to generate the struct pmu_event []
> b. util/pmu.c code to create the event aliases for a given PMU
> 
> Note: the test does not (yet) cover matching of events declared in the HW
> PMU sysfs folder. I'm talking about these, for example:

ok

> 
> $ ls /sys/bus/event_source/devices/cpu/events/
> branch-instructions  cache-references  el-abort     el-start ref-cycles
> ...
> 
> > 
> > > 
> > > > 
> > > > or as I'm thinking about that now, would it be enough
> > > > to check pme_test_cpu array to have string that we
> > > > expect?
> > > 
> > > Right, I might change this.
> > > 
> > > So currently we iterate the PMU aliases to ensure that we have a matching
> > > event in pme_test_cpu[]. It may be better to iterate the events in
> > > pme_test_cpu[] to ensure that we have an alias.
> > 
> > that's what I described above.. I dont understand the connection/value
> > of this tests
> > 
> > > 
> > > The problem here is uncore PMUs. They have the "Unit" field, which is used
> > > for matching the PMU. So we cannot ensure test events from uncore.json will
> > > always have an event alias created per PMU. But maybe I could use
> > > pmu_uncore_alias_match() to check if the test event matches in this case.
> > 
> > hum I guess I don't follow all the details.. but some more explanation
> > of the test would be great
> 
> Let's just concentrate on core PMU ATM :)

ok, thanks,
jirka

