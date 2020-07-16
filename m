Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3148C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D9D20791
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgGPBZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 21:25:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726776AbgGPBZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 21:25:18 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06G12Zg9061921;
        Wed, 15 Jul 2020 21:25:09 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 329apy6qh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 21:25:09 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06G14F3e066840;
        Wed, 15 Jul 2020 21:25:08 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 329apy6qgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 21:25:08 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06G1KkTP000939;
        Thu, 16 Jul 2020 01:25:07 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02wdc.us.ibm.com with ESMTP id 327ursx51a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 01:25:07 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06G1P7JT48890262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jul 2020 01:25:07 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 617F42805C;
        Thu, 16 Jul 2020 01:25:07 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 115F328058;
        Thu, 16 Jul 2020 01:25:06 +0000 (GMT)
Received: from oc3272150783.ibm.com (unknown [9.65.192.198])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu, 16 Jul 2020 01:25:05 +0000 (GMT)
Date:   Wed, 15 Jul 2020 20:25:04 -0500
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
Message-ID: <20200716012504.GA27583@oc3272150783.ibm.com>
References: <20200712132634.138901-1-jolsa@kernel.org>
 <20200715183327.GA21935@oc3272150783.ibm.com>
 <20200715214134.GW183694@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715214134.GW183694@krava>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
Subject: RE: [PATCH 00/18] perf metric: Add support to reuse metric
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 11:41:34PM +0200, Jiri Olsa wrote:
> On Wed, Jul 15, 2020 at 01:33:27PM -0500, Paul A. Clarke wrote:
> > On Sun, Jul 12, 2020 at 03:26:16PM +0200, Jiri Olsa wrote:
> > > hi,
> > > this patchset is adding the support to reused metric in another 
> > > metric. The metric needs to be referenced by 'metric:' prefix.
> > > 
> > > For example, to define IPC by using CPI with change like:
> > > 
> > >          "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
> > >  -       "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
> > >  +       "MetricExpr": "1/metric:CPI",
> > >          "MetricGroup": "TopDownL1",
> > >          "MetricName": "IPC"
> > > 
> > > I won't be able to find all the possible places we could
> > > use this at, so I wonder you guys (who was asking for this)
> > > would try it and come up with comments if there's something
> > > missing or we could already use it at some places.
> > > 
> > > It's based on Arnaldo's tmp.perf/core.
> > > 
> > > v2 changes:
> > >   - collected Ian's acks for few patches [Ian]
> > >   - renamed expr__add_id to expr__add_id_val [Ian]
> > >   - renamed expr_parse_data to expr_id_data [Ian]
> > >   - added recursion check [Ian]
> > >   - added metric test for DCache_L2 metric [Ian]
> > >   - added some renames as discussed in review [Ian]
> > > 
> > > Also available in here:
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> > >   perf/metric
> > 
> > I'm having trouble testing this.
> > 
> > I checked out this tree, and am able to build with a JSON metrics definition
> > file which uses other metrics.  I put this aside, though, because of the
> > following issue.
> > 
> > I built the kernel from this same tree and booted it successfully.
> > However, the metrics are not working correctly.  (I may very well be
> > doing something wrong.)
> 
> if you'll share the metric change I can help debugging that

It fails as described below without any changes from me.

> > The base system is RHEL8, but it's now booted with the new kernel.
> > ```
> > # uname -a
> > Linux system 5.8.0-rc4-g7dd02cf0b #1 SMP Wed Jul 15 12:31:45 EDT 2020 ppc64le ppc64le ppc64le GNU/Linux
> > # perf stat --metrics cpi_breakdown ./load
> > failed: way too many variables
> 
> hm, this ^^^ error string was removed in:
>   43fe337c86a9 perf expr: Migrate expr ids table to a hashmap
> 
> looks like you're not running the correct perf binary

I should've explained this better in my post, but there are two runs of
perf there.  The first is above, and is the perf that comes with the
distribution.  I'll repeat that here:
```
# perf --version
perf version 4.18.0-214.el8.ppc64le
# perf stat --metrics cpi_breakdown ./load >/dev/null             
failed: way too many variables                                                               
 Performance counter stats for './load':                                                     
                                                                                             
           818,130      pm_cmplu_stall_bru        #      0.0 bru_stall_cpi            (0.45%)
     5,013,082,026      pm_run_inst_cmpl                                              (0.45%)
                 0      pm_cmplu_stall_crypto     #      0.0 crypto_stall_cpi         (0.89%)
     6,580,655,094      pm_run_inst_cmpl                                              (0.89%)
        25,729,751      pm_cmplu_stall_dcache_miss #      0.0 dcache_miss_stall_cpi    (1.77%)
     6,690,035,175      pm_run_inst_cmpl                                              (1.77%)
                 0      pm_cmplu_stall_dflong     #      0.0 dflong_stall_cpi         (1.77%)
     6,769,854,632      pm_run_inst_cmpl                                              (1.77%)
                 0      pm_cmplu_stall_dfu        #      0.0 dfu_other_stall_cpi      (0.89%)
[...and LOTS more...]
```

The second example in my previous post was from
git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
branch perf/metric
```
commit 7dd02cf0b9f04ca5339fa97f9a2280ebdd60b1db (grafted, HEAD -> perf/metric, origin/perf/metric)
Author: Jiri Olsa <jolsa@kernel.org>
Date:   Thu Jul 9 13:45:30 2020 +0200

    perf metric: Rename group_list to list
```

This build of `perf` fails:
```
# ~/install/bin/perf --version
perf version 5.8.rc4.g7dd02cf0b9f0
# ~/install/bin/perf stat --metrics cpi_breakdown ./load >/dev/null

 Performance counter stats for './load':

     6,729,400,541      pm_run_inst_cmpl          #     0.00 bru_stall_cpi          
            57,953      pm_cmplu_stall_bru                                          

       1.127319209 seconds time elapsed

       1.124906000 seconds user
       0.000890000 seconds sys
```

PC
