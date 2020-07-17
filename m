Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4811C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DC0E207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJvnkmOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgGQIzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:55:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43888 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726204AbgGQIzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594976147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vUctOmDjuJh6zYZ81PXenChQ2Gr+yz9cxYwgYtbwwJ8=;
        b=KJvnkmOPQpEILoRP2IrmLQ+oNXIqFjDOROQzKAwRoWczxGs0oOywDKv8cr+IXfU/VYz/9o
        1xM5iJM7U7ut6VRNwjE2r2NtP3z9UI7tBmGRa8H+LOoFkEtP9Nl3U9sqfFmggy1b54W6aH
        9pCVTjdPGad3kI9tZIkvjmZ/WCht0z8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-3S48-WG6PvG2CLQtqqIOcQ-1; Fri, 17 Jul 2020 04:55:43 -0400
X-MC-Unique: 3S48-WG6PvG2CLQtqqIOcQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B27A15C22;
        Fri, 17 Jul 2020 08:55:41 +0000 (UTC)
Received: from krava (unknown [10.40.192.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id A938A9F63;
        Fri, 17 Jul 2020 08:55:37 +0000 (UTC)
Date:   Fri, 17 Jul 2020 10:55:36 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, maddy@linux.ibm.com,
        ravi.bangoria@linux.ibm.com, anju@linux.vnet.ibm.com,
        kan.liang@linux.intel.com, nasastry@in.ibm.com
Subject: Re: [PATCH v3 0/5] powerpc/perf: Add json file support for hv_24x7
 core level events
Message-ID: <20200717085536.GC528602@krava>
References: <20200716094216.1418659-1-kjain@linux.ibm.com>
 <20200716152237.GC373728@kernel.org>
 <a80eebc2-885c-171d-7c7a-74df727d60b4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a80eebc2-885c-171d-7c7a-74df727d60b4@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 01:41:22PM +0530, kajoljain wrote:
> 
> 
> On 7/16/20 8:52 PM, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Jul 16, 2020 at 03:12:11PM +0530, Kajol Jain escreveu:
> >> Patchset enhance current runtime parameter support. It introduces new
> >> fields like "PerChip" and "PerCore" similar to the field "PerPkg" which is
> >> used to specify perpkg events. 
> >>
> >> The "PerCore" and "PerChip" specifies whether its core or chip events.
> >> Based on which we can decide which runtime parameter user want to
> >> access. Now character  '?' can refers different parameter based on user
> >> requirement.
> >>
> >> Initially, every time we want to add new terms like chip, core, thread
> >> etc, we need to create corrsponding fields in pmu_events and event
> >> struct.
> >> This patchset adds an enum called 'aggr_mode_class' which store all these
> >> aggregation like perpkg/percore. It also adds new field 'AggregationMode'
> >> to capture these terms.
> >> Now, if user wants to add any new term, they just need to add it in
> >> the enum defined. I try to test it with  my current setup.
> >>
> >> I also need to replace PerPkg field to AggregationMode in all the
> >> x86 uncore json files. It will great if Andi and team can test it
> >> and let me know if they have any concerns.
> >>
> >> Changelog:
> >> v2 -> v3:
> >> - Did some nits changes suggested by Jiri include correction of
> >>   indentation, and making PerCore/PerChip values forward after
> >>   PerPkg as 1 in the enum.
> >> - Rebase the patchset on Arnaldo's tmp.perf/core branch.
> >> - Change RFC tag
> > 
> > Hey, have anybody provided Acked-by/Reviewed-by for previous revisions
> > of this patchset? If so you could have collected them for patches
> > without changes, was that the case?
> 
> Hi Arnaldo,
>       I did get "Acked-by: Ian Rogers" on my initial prototype which I send in my RFC.
> Link to the patch: https://lkml.org/lkml/2020/7/5/399
> 
> After that, I break it down and made some nits changes as suggested by Jiri, that's why I didn't
> add his Acked-by tag.
> Ian should I add it, if it seems fine to you.

I posted one more comment and I'd also like to hear from
guys maintainng json list on intel side that they are ok
with this, mainly the change introduced in:

  pmu-events/x86/uncore: Replace PerPkg field to AggregationMode in x86 json files

Andi?

thanks,
jirka

