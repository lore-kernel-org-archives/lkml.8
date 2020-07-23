Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE01C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42BF320771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgGWQA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:00:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44162 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728134AbgGWQA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:00:27 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NFWKh9038374;
        Thu, 23 Jul 2020 12:00:06 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32fb9b5ps2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 12:00:05 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06NFX31D041579;
        Thu, 23 Jul 2020 12:00:05 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32fb9b5prj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 12:00:05 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06NFt9JZ018599;
        Thu, 23 Jul 2020 16:00:04 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03wdc.us.ibm.com with ESMTP id 32brq9nk9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 16:00:04 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06NG005H50069810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 16:00:00 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10A2D6E060;
        Thu, 23 Jul 2020 16:00:03 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A5BD6E054;
        Thu, 23 Jul 2020 16:00:01 +0000 (GMT)
Received: from li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com (unknown [9.65.235.84])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 23 Jul 2020 16:00:00 +0000 (GMT)
Date:   Thu, 23 Jul 2020 10:59:58 -0500
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
Message-ID: <20200723155958.GA7141@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
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
 definitions=2020-07-23_08:2020-07-23,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230113
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

That indeed addressed the issue.

Is there a point where that limit was being hit and the code silently fails?
If so, should that failure be less silent?

PC
