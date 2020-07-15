Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6F2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 364EC206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bh7Oatj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgGOVlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:41:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56921 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726370AbgGOVlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594849304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HPp/HlsNwAVm/pjHizUH7Kzh5g/yyTFfD5FiXrIaenc=;
        b=bh7Oatj1V/OlKSLArHGm+vtNAMMs6lj3cb6APa2Aa6ziDrHqIVV8+d3NAcyelu/RzIE87a
        F3hGjMRChP+5O0l5DtBVqFQWWX1GtX7JGTcR/nRzBEsmNoTIHj/NEK2UQOeIFlM6fMHjF9
        tGYRjmULOIGCixeUYTNJE7acRLFSaZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-byN9LZkZO6WkWp8O9HgHMw-1; Wed, 15 Jul 2020 17:41:40 -0400
X-MC-Unique: byN9LZkZO6WkWp8O9HgHMw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E86E1080;
        Wed, 15 Jul 2020 21:41:38 +0000 (UTC)
Received: from krava (unknown [10.40.194.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6E5ED6FEF5;
        Wed, 15 Jul 2020 21:41:35 +0000 (UTC)
Date:   Wed, 15 Jul 2020 23:41:34 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Paul A. Clarke" <pc@us.ibm.com>
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
        John Garry <john.garry@huawei.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 00/18] perf metric: Add support to reuse metric
Message-ID: <20200715214134.GW183694@krava>
References: <20200712132634.138901-1-jolsa@kernel.org>
 <20200715183327.GA21935@oc3272150783.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715183327.GA21935@oc3272150783.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 01:33:27PM -0500, Paul A. Clarke wrote:
> On Sun, Jul 12, 2020 at 03:26:16PM +0200, Jiri Olsa wrote:
> > hi,
> > this patchset is adding the support to reused metric in another 
> > metric. The metric needs to be referenced by 'metric:' prefix.
> > 
> > For example, to define IPC by using CPI with change like:
> > 
> >          "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
> >  -       "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
> >  +       "MetricExpr": "1/metric:CPI",
> >          "MetricGroup": "TopDownL1",
> >          "MetricName": "IPC"
> > 
> > I won't be able to find all the possible places we could
> > use this at, so I wonder you guys (who was asking for this)
> > would try it and come up with comments if there's something
> > missing or we could already use it at some places.
> > 
> > It's based on Arnaldo's tmp.perf/core.
> > 
> > v2 changes:
> >   - collected Ian's acks for few patches [Ian]
> >   - renamed expr__add_id to expr__add_id_val [Ian]
> >   - renamed expr_parse_data to expr_id_data [Ian]
> >   - added recursion check [Ian]
> >   - added metric test for DCache_L2 metric [Ian]
> >   - added some renames as discussed in review [Ian]
> > 
> > Also available in here:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   perf/metric
> 
> I'm having trouble testing this.
> 
> I checked out this tree, and am able to build with a JSON metrics definition
> file which uses other metrics.  I put this aside, though, because of the
> following issue.
> 
> I built the kernel from this same tree and booted it successfully.
> However, the metrics are not working correctly.  (I may very well be
> doing something wrong.)

if you'll share the metric change I can help debugging that

> 
> The base system is RHEL8, but it's now booted with the new kernel.
> ```
> # uname -a
> Linux system 5.8.0-rc4-g7dd02cf0b #1 SMP Wed Jul 15 12:31:45 EDT 2020 ppc64le ppc64le ppc64le GNU/Linux
> # perf stat --metrics cpi_breakdown ./load
> failed: way too many variables

hm, this ^^^ error string was removed in:
  43fe337c86a9 perf expr: Migrate expr ids table to a hashmap

looks like you're not running the correct perf binary

thanks for testing this,
jirka

