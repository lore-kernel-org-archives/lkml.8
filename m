Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7402C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE13420768
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9PQPldo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgGQUEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:04:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50011 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728183AbgGQUEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595016244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K/RYPuO7GhkWFUAIxEWg5zqDvxxg8rWVktNICE/3II4=;
        b=i9PQPldoz4SQtchZEkgfMK/LqeXgZmoR9NynDeplVFwch7vwpIPJMUtky2E+dmlX8FeFlE
        bw85b9f251O1f2tvWHYc+LNF0VvGx+fUHh3Uzdg5Bvw4vhu1Q9MdjG2Vi7k6orO8L0QqQT
        zDAURm4fhCRysrNl8Y6zjK7M3HjKO8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-i_3YedoZOfWaUC4xoVIrig-1; Fri, 17 Jul 2020 16:04:02 -0400
X-MC-Unique: i_3YedoZOfWaUC4xoVIrig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD62B1085;
        Fri, 17 Jul 2020 20:04:00 +0000 (UTC)
Received: from krava (unknown [10.40.192.79])
        by smtp.corp.redhat.com (Postfix) with SMTP id 622AF619C4;
        Fri, 17 Jul 2020 20:03:56 +0000 (UTC)
Date:   Fri, 17 Jul 2020 22:03:56 +0200
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
Message-ID: <20200717200356.GH528602@krava>
References: <20200712132634.138901-1-jolsa@kernel.org>
 <b085ecf9-207d-6204-41b7-0937bd95633d@huawei.com>
 <20200716113200.GD391962@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716113200.GD391962@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 01:32:04PM +0200, Jiri Olsa wrote:

SNIP

> > > ---
> > > Jiri Olsa (18):
> > >        perf metric: Rename expr__add_id to expr__add_val
> > >        perf metric: Add struct expr_id_data to keep expr value
> > >        perf metric: Add expr__add_id function
> > >        perf metric: Change expr__get_id to return struct expr_id_data
> > >        perf metric: Add expr__del_id function
> > >        perf metric: Add find_metric function
> > >        perf metric: Add add_metric function
> > >        perf metric: Rename __metricgroup__add_metric to __add_metric
> > >        perf metric: Collect referenced metrics in struct metric_ref_node
> > >        perf metric: Collect referenced metrics in struct metric_expr
> > >        perf metric: Add referenced metrics to hash data
> > >        perf metric: Compute referenced metrics
> > >        perf metric: Add events for the current group
> > >        perf metric: Add cache_miss_cycles to metric parse test
> > >        perf metric: Add DCache_L2 to metric parse test
> > >        perf metric: Add recursion check when processing nested metrics
> > >        perf metric: Rename struct egroup to metric
> > >        perf metric: Rename group_list to list
> > 
> > I was thinking that a test metric using this reuse feature could be added in
> > pmu-events/arch/test/test_cpu. But since no relevant parsing is done in
> > jevents, maybe not a lot of value. Just for a bit more completeness.
> 
> ok, I think it's a good idea

actually those tests treats all IDs in metrics as events,
so what will happen is that the nested metric ID will be
considered as event with assigned value

so I don't see too much value to add nested metrics there,
I think tests/parse-metric.c will cover all metrics usage

jirka

