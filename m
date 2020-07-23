Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B47C433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B067722B47
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbgGWRO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:14:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726717AbgGWRO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:14:26 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NH35Gq127744;
        Thu, 23 Jul 2020 13:14:11 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32fat20b7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 13:14:11 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06NH3KBT129461;
        Thu, 23 Jul 2020 13:14:10 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32fat20b6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 13:14:10 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06NHAHOA005213;
        Thu, 23 Jul 2020 17:14:09 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03dal.us.ibm.com with ESMTP id 32brqa1fvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 17:14:09 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06NHE8o655050678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 17:14:08 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4138E112064;
        Thu, 23 Jul 2020 17:14:08 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC2BA112063;
        Thu, 23 Jul 2020 17:14:06 +0000 (GMT)
Received: from li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com (unknown [9.65.235.84])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu, 23 Jul 2020 17:14:06 +0000 (GMT)
Date:   Thu, 23 Jul 2020 12:14:04 -0500
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     Jiri Olsa <jolsa@redhat.com>
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
Message-ID: <20200723171404.GA15993@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <20200721143702.GA15990@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
 <20200722181158.GF981884@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722181158.GF981884@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
Subject: RE: [PATCHv3 00/19] perf metric: Add support to reuse metric
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_09:2020-07-23,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 08:11:58PM +0200, Jiri Olsa wrote:
> On Tue, Jul 21, 2020 at 09:48:48AM -0500, Paul A. Clarke wrote:
> > On Sun, Jul 19, 2020 at 08:13:01PM +0200, Jiri Olsa wrote:
> > > hi,
> > > this patchset is adding the support to reused metric in
> > > another metric.
> > > 
> > > For example, to define IPC by using CPI with change like:
> > > 
> > >      {
> > >          "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
> > > -        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
> > > +        "MetricExpr": "1/CPI",
> > >          "MetricGroup": "TopDownL1",
> > >          "MetricName": "IPC"
> > >      },
> > > 
> > > I won't be able to find all the possible places we could
> > > use this at, so I wonder you guys (who was asking for this)
> > > would try it and come up with comments if there's something
> > > missing or we could already use it at some places.
> > > 
> > > It's based on Arnaldo's tmp.perf/core.
> > > 
> > > v3 changes:
> > >   - added some acks
> > >   - some patches got merged
> > >   - added missing zalloc include [John Garry]
> > >   - added ids array outside the egroup object [Ian]
> > >   - removed wrong m->has_constraint assignment [Ian]
> > >   - renamed 'list' to 'metric_list' [Ian]
> > >   - fixed group metric and added test for it [Paul A. Clarke]
> > >   - fixed memory leak [Arnaldo]
> > >   - using lowercase keys for metrics in hashmap, because jevents
> > >     converts metric_expr to lowercase
> > > 
> > > Also available in here:
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> > >   perf/metric
> > 
> > These changes seem to be mostly working for me.
> > 
> > I attempted to exploit the new capability in the metrics definitions in
> > tools/perf/pmu-events/arch/powerpc/power9/metrics.json.  Those changes
> > are included below.
> > 
> > The one problem I found is with the "cpi_breakdown" metric group, as it
> > no longer works:
> > ```
> > # perf stat --metrics cpi_breakdown ./command
> > Cannot find metric or group `cpi_breakdown'
> > ```
> > 
> > "cpi_breakdown" does show up in `perf list --metricgroup`, and all of the
> > (95!) metrics listed in that group are usable, so it's not obvious whether
> > my changes have a problem, or merely provoke one.
> 
> I underestimated the recursion depth setup for groups,
> your change is working for me with following change:
> 
> -#define RECURSION_ID_MAX 100
> +#define RECURSION_ID_MAX 1000

I just saw some odd behavior:
```
# perf stat --metrics cpi_breakdown --metrics cpi_breakdown --metric-only ./cmd
WARNING: grouped events cpus do not match, disabling group:
  anon group { raw 0x2d018 }                                                         
  anon group { raw 0x2d018 }   
  anon group { raw 0x2d018 }                                                                                                                                                                                      
  anon group { raw 0x2d018 }                                               
  anon group { raw 0x1006a }                                                                                                                                                                                      
  anon group { raw 0x400fa }                                                                                                                                                                                      
  anon group { raw 0x400fa }                                               
  anon group { raw 0x400fa }                                               
  anon group { raw 0x400fa }                                               
perf: util/evsel.c:1452: get_group_fd: Assertion `!(!leader->core.fd)' failed.                                                             
Aborted (core dumped)
```

It happened both with and without my changes on binaries which were built
yesterday.  Three or four times in a row.

Oddly, it went away without any action on my part. Same commands a minute or so
later. I haven't seen this before.  I can't reproduce it now.  :-/

PC
