Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCF9C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 11:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92302206F6
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 11:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgHALlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 07:41:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728255AbgHALlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 07:41:15 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 071BV1ba016580;
        Sat, 1 Aug 2020 07:41:05 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32n4bu3g61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 Aug 2020 07:41:05 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 071Bcuos036019;
        Sat, 1 Aug 2020 07:41:04 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32n4bu3g55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 Aug 2020 07:41:04 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 071Be24c011414;
        Sat, 1 Aug 2020 11:41:04 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01wdc.us.ibm.com with ESMTP id 32n017a98p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 Aug 2020 11:41:04 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 071Bf0F223069056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 1 Aug 2020 11:41:00 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16B8E7805C;
        Sat,  1 Aug 2020 11:41:03 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E6247805E;
        Sat,  1 Aug 2020 11:41:00 +0000 (GMT)
Received: from li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com (unknown [9.160.66.173])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Sat,  1 Aug 2020 11:41:00 +0000 (GMT)
Date:   Sat, 1 Aug 2020 06:40:50 -0500
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <20200801114050.GB377079@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
References: <20200729091908.1378911-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729091908.1378911-1-jolsa@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
Subject: Re:  [PATCHv4 00/19] perf metric: Add support to reuse metric
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-01_07:2020-07-31,2020-08-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008010084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 11:18:49AM +0200, Jiri Olsa wrote:
> this patchset is adding the support to reused metric in
> another metric.
> 
> For example, to define IPC by using CPI with change like:
> 
>      {
>          "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
> -        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
> +        "MetricExpr": "1/CPI",
>          "MetricGroup": "TopDownL1",
>          "MetricName": "IPC"
>      },
> 
> I won't be able to find all the possible places we could
> use this at, so I wonder you guys (who was asking for this)
> would try it and come up with comments if there's something
> missing or we could already use it at some places.
> 
> It's based on Arnaldo's tmp.perf/core.
> 
> v4 changes:
>   - removed acks from patch because it changed a bit
>     with the last fixes:
>       perf metric: Collect referenced metrics in struct metric_ref_node
>   - fixed runtime metrics [Kajol Jain]
>   - increased recursion depth [Paul A. Clarke]
>   - changed patches due to dependencies:
>       perf metric: Collect referenced metrics in struct metric_ref_node
>       perf metric: Add recursion check when processing nested metrics
>       perf metric: Rename struct egroup to metric
>       perf metric: Rename group_list to metric_list
> 
> Also available in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/metric

I built and ran from the above git branch, and things seem to work.
Indeed, I was able to apply my changes to exploit the new capabilities
via modifications to tools/perf/pmu-events/arch/powerpc/power9/metrics.json,
as I posted earlier (and will submit once this set gets merged).

Tested-by: Paul A. Clarke <pc@us.ibm.com>

One thing I noted, but which also occurs without these patches, is that
the perf metrics are not computed unless run as root:
--
$ perf stat --metrics br_misprediction_percent command

 Performance counter stats for 'command':

     1,823,530,051      pm_br_pred:u                                                
         2,662,705      pm_br_mpred_cmpl:u                                          

$ /usr/bin/sudo perf stat --metrics br_misprediction_percent command

 Performance counter stats for 'command':

     1,824,655,269      pm_br_pred                #     0.09 br_misprediction_percent
         1,654,466      pm_br_mpred_cmpl
--

Is that expected?  I don't think it's always been that way.

PC
