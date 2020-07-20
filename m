Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD7EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFDB222B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJtzgqwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgGTHWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:22:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49608 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725815AbgGTHWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595229767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bek0ySfXXA3P6GFLDS22HsXDbXvDBBttNAFibaiJYz4=;
        b=DJtzgqwtPEgycDYv6gnm5YLtNkv9/b1QAVj9gcdzwqjpIINnp0iukqPoPjrNTmQcoskRLi
        BaALf95SYRYQQ+QcGwkYR7dAjHsUqHboz9fgYroavOj/R3PSl5DS6w4PX8pldmQ1YAW/WJ
        fT7AkkaBD724Nc0pokWB4OX8uEMzcBQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-o3Lg3hjPPIKBP0zYwEvylA-1; Mon, 20 Jul 2020 03:22:43 -0400
X-MC-Unique: o3Lg3hjPPIKBP0zYwEvylA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B354E91D;
        Mon, 20 Jul 2020 07:22:41 +0000 (UTC)
Received: from krava (unknown [10.40.192.229])
        by smtp.corp.redhat.com (Postfix) with SMTP id EEA6C1A8F7;
        Mon, 20 Jul 2020 07:22:37 +0000 (UTC)
Date:   Mon, 20 Jul 2020 09:22:37 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCHv3 00/19] perf metric: Add support to reuse metric
Message-ID: <20200720072237.GC760733@krava>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <dbe59791-937d-de95-4ba0-c34e7a1cd273@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbe59791-937d-de95-4ba0-c34e7a1cd273@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 12:14:00PM +0530, kajoljain wrote:
> 
> 
> On 7/19/20 11:43 PM, Jiri Olsa wrote:
> > hi,
> > this patchset is adding the support to reused metric in
> > another metric.
> > 
> > For example, to define IPC by using CPI with change like:
> > 
> >      {
> >          "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
> > -        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
> > +        "MetricExpr": "1/CPI",
> >          "MetricGroup": "TopDownL1",
> >          "MetricName": "IPC"
> >      },
> > 
> > I won't be able to find all the possible places we could
> > use this at, so I wonder you guys (who was asking for this)
> > would try it and come up with comments if there's something
> > missing or we could already use it at some places.
> > 
> > It's based on Arnaldo's tmp.perf/core.
> > 
> > v3 changes:
> >   - added some acks
> >   - some patches got merged
> >   - added missing zalloc include [John Garry]
> >   - added ids array outside the egroup object [Ian]
> >   - removed wrong m->has_constraint assignment [Ian]
> >   - renamed 'list' to 'metric_list' [Ian]
> >   - fixed group metric and added test for it [Paul A. Clarke]
> >   - fixed memory leak [Arnaldo]
> >   - using lowercase keys for metrics in hashmap, because jevents
> >     converts metric_expr to lowercase
> > 
> > Also available in here:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   perf/metric
> > 
> 
> Hi Jiri,
>    I am trying to review these patches and also test it in power box. I am testing your `perf/metric` branch.
> With your current patches,some of hv-24x7 events not giving appropriate result
> while doing "--metric-only" command. I can't see corresponding output for all chips.

hi,
is that just for --metric-only option?

> 
> This is output on power9 machine:
> 
> Without your patches on upstream kernel:
> 
> command# ./perf stat --metric-only -M PowerBUS_Frequency -I 1000 -C 0
> #           time GHz  PowerBUS_Frequency_0 GHz  PowerBUS_Frequency_1 
>      1.000073877                        2.0                        2.0 
>      2.000240551                        2.0                        1.9 
> ^C     2.452590532                        0.9                        0.9 
> 
>  Performance counter stats for 'CPU(s) 0':
> 
>                        4.8                        4.8 
> 
>        2.452654834 seconds time elapsed
> 
> With your patches on perf/metric branch:
> 
> command# ./perf stat --metric-only -M PowerBUS_Frequency -I 1000 -C 0
> assertion failed at util/metricgroup.c:709
> #           time GHz  PowerBUS_Frequency_0 
>      1.000073875                        2.0 
>      2.000380706                        2.0 
> ^C     2.658962182                        1.3 
> 
>  Performance counter stats for 'CPU(s) 0':
> 
>                        5.2 
> 
> Please let me know, if I am missing something. 

hum, I'll need to add test for metric with hv-24x7 events

thanks,
jirka

