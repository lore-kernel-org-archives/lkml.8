Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD53C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E0D207F9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFZjlkTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgGPLcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 07:32:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35510 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728124AbgGPLcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 07:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594899128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OM0/E3JTIV3DiHHi14L/MCyUHZ2lg/8TgZHfcW5otWg=;
        b=BFZjlkTCWbpCjfjRZzrGxHpo4tdQDl07AZZW90CJ+WAMEXeiBlmBZfVqVx0aEPAPOFSDlr
        BSSu94UlXNWozTJnNx0HsG36DnwZxOFMSa0p4nOUWi1G9IaUvBZDYVul2FxXMIq7CscsBp
        XR4hpfdMG1DAkY6Z6W5OtVEDuUwoTqo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-ZzxdcRKeMkq7VfOuRqwVDQ-1; Thu, 16 Jul 2020 07:32:06 -0400
X-MC-Unique: ZzxdcRKeMkq7VfOuRqwVDQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2B498015F7;
        Thu, 16 Jul 2020 11:32:04 +0000 (UTC)
Received: from krava (unknown [10.40.192.177])
        by smtp.corp.redhat.com (Postfix) with SMTP id 97D13710D7;
        Thu, 16 Jul 2020 11:32:01 +0000 (UTC)
Date:   Thu, 16 Jul 2020 13:32:00 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 00/18] perf metric: Add support to reuse metric
Message-ID: <20200716113200.GD391962@krava>
References: <20200712132634.138901-1-jolsa@kernel.org>
 <b085ecf9-207d-6204-41b7-0937bd95633d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b085ecf9-207d-6204-41b7-0937bd95633d@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 08:50:56AM +0100, John Garry wrote:
> On 12/07/2020 14:26, Jiri Olsa wrote:
> > hi,
> > this patchset is adding the support to reused metric in another
> > metric. The metric needs to be referenced by 'metric:' prefix.
> > 
> > For example, to define IPC by using CPI with change like:
> > 
> >           "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
> >   -       "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
> >   +       "MetricExpr": "1/metric:CPI",
> >           "MetricGroup": "TopDownL1",
> >           "MetricName": "IPC"
> > 
> > I won't be able to find all the possible places we could
> > use this at, so I wonder you guys (who was asking for this)
> > would try it and come up with comments if there's something
> > missing or we could already use it at some places.
> > 
> > It's based on Arnaldo's tmp.perf/core.
> > 
> > v2 changes:
> >    - collected Ian's acks for few patches [Ian]
> >    - renamed expr__add_id to expr__add_id_val [Ian]
> >    - renamed expr_parse_data to expr_id_data [Ian]
> >    - added recursion check [Ian]
> >    - added metric test for DCache_L2 metric [Ian]
> >    - added some renames as discussed in review [Ian]
> > 
> > Also available in here:
> >    git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >    perf/metric
> > 
> > thanks,
> > jirka
> > 
> > 
> > ---
> > Jiri Olsa (18):
> >        perf metric: Rename expr__add_id to expr__add_val
> >        perf metric: Add struct expr_id_data to keep expr value
> >        perf metric: Add expr__add_id function
> >        perf metric: Change expr__get_id to return struct expr_id_data
> >        perf metric: Add expr__del_id function
> >        perf metric: Add find_metric function
> >        perf metric: Add add_metric function
> >        perf metric: Rename __metricgroup__add_metric to __add_metric
> >        perf metric: Collect referenced metrics in struct metric_ref_node
> >        perf metric: Collect referenced metrics in struct metric_expr
> >        perf metric: Add referenced metrics to hash data
> >        perf metric: Compute referenced metrics
> >        perf metric: Add events for the current group
> >        perf metric: Add cache_miss_cycles to metric parse test
> >        perf metric: Add DCache_L2 to metric parse test
> >        perf metric: Add recursion check when processing nested metrics
> >        perf metric: Rename struct egroup to metric
> >        perf metric: Rename group_list to list
> 
> I was thinking that a test metric using this reuse feature could be added in
> pmu-events/arch/test/test_cpu. But since no relevant parsing is done in
> jevents, maybe not a lot of value. Just for a bit more completeness.

ok, I think it's a good idea

thanks,
jirka

