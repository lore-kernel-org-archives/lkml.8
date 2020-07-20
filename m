Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3D9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0584207DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgGTHCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:02:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44936 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgGTHCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:02:09 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06K6Y69k122985;
        Mon, 20 Jul 2020 03:01:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32d5pe9ct5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 03:01:59 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06K6xiwc029601;
        Mon, 20 Jul 2020 03:01:58 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32d5pe9cs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 03:01:58 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06K70ME3025590;
        Mon, 20 Jul 2020 07:01:56 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 32brq82adf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 07:01:56 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06K70UAo52822290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 07:00:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82287AE256;
        Mon, 20 Jul 2020 07:01:53 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9615DAE248;
        Mon, 20 Jul 2020 07:01:49 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.114.242])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 Jul 2020 07:01:49 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        anju@linux.vnet.ibm.com, kan.liang@linux.intel.com,
        nasastry@in.ibm.com, kjain@linux.ibm.com
Subject: [PATCH v4 0/5] powerpc/perf: Add json file support for hv_24x7 core level events
Date:   Mon, 20 Jul 2020 12:31:22 +0530
Message-Id: <20200720070127.109234-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-20_01:2020-07-17,2020-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=1 lowpriorityscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007200047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patchset enhance current runtime parameter support. It introduces new
fields like "PerChip" and "PerCore" similar to the field "PerPkg" which is
used to specify perpkg events. 

The "PerCore" and "PerChip" specifies whether its core or chip events.
Based on which we can decide which runtime parameter user want to
access. Now character  '?' can refers different parameter based on user
requirement.

Initially, every time we want to add new terms like chip, core, thread
etc, we need to create corrsponding fields in pmu_events and event
struct.
This patchset adds an enum called 'aggr_mode_class' which store all these
aggregation like perpkg/percore. It also adds new field 'AggregationMode'
to capture these terms.
Now, if user wants to add any new term, they just need to add it in
the enum defined. I try to test it with  my current setup.

I also need to replace PerPkg field to AggregationMode in all the
x86 uncore json files. It will great if Andi and team can test it
and let me know if they have any concerns.

Changelog:
v3 -> v4:
- Include pmu-events.h header file in jevents.c and remove
  redecalaration of enum aggr_mode_class as Suggested by Jiri.
- Add Acked-by tag.

v2 -> v3:
- Did some nits changes suggested by Jiri include correction of
  indentation, and making PerCore/PerChip values forward after
  PerPkg as 1 in the enum.
- Rebase the patchset on Arnaldo's tmp.perf/core branch.
- Change RFC tag

v1 -> v2:
- Rather then adding new field as PerCore/PerChip, created a new enum
  to get these fields. And new field as "AggregationMode" which can
  be used to capture these fields from json file.
  - Suggested By Ian Rogers


Kajol Jain (5):
  perf/pmu-events/jevents: Add enum to store aggregation like PerPkg
  pmu-events/x86/uncore: Replace PerPkg field to AggregationMode in x86
    json files
  perf jevents: Add support for parsing perchip/percore events
  perf/tools: Pass pmu_event structure as a parameter for
    arch_get_runtimeparam
  perf/tools/pmu_events/powerpc: Add hv_24x7 core level metric events

 tools/perf/arch/powerpc/util/header.c         |   7 +-
 .../arch/powerpc/power9/nest_metrics.json     |  27 +-
 .../arch/x86/broadwellde/uncore-cache.json    |  62 ++--
 .../arch/x86/broadwellde/uncore-memory.json   |  18 +-
 .../arch/x86/broadwellde/uncore-power.json    |  18 +-
 .../arch/x86/broadwellx/uncore-cache.json     |  62 ++--
 .../x86/broadwellx/uncore-interconnect.json   |   6 +-
 .../arch/x86/broadwellx/uncore-memory.json    |  18 +-
 .../arch/x86/broadwellx/uncore-power.json     |  18 +-
 .../arch/x86/cascadelakex/uncore-memory.json  |  64 ++--
 .../arch/x86/cascadelakex/uncore-other.json   | 332 +++++++++---------
 .../arch/x86/haswellx/uncore-cache.json       |  62 ++--
 .../x86/haswellx/uncore-interconnect.json     |   6 +-
 .../arch/x86/haswellx/uncore-memory.json      |  18 +-
 .../arch/x86/haswellx/uncore-power.json       |  18 +-
 .../arch/x86/ivytown/uncore-cache.json        |  62 ++--
 .../arch/x86/ivytown/uncore-interconnect.json |  10 +-
 .../arch/x86/ivytown/uncore-memory.json       |  16 +-
 .../arch/x86/ivytown/uncore-power.json        |  52 +--
 .../arch/x86/jaketown/uncore-cache.json       |  40 +--
 .../x86/jaketown/uncore-interconnect.json     |  10 +-
 .../arch/x86/jaketown/uncore-memory.json      |  18 +-
 .../arch/x86/jaketown/uncore-power.json       |  52 +--
 .../x86/knightslanding/uncore-memory.json     |   8 +-
 .../arch/x86/skylakex/uncore-memory.json      |  36 +-
 .../arch/x86/skylakex/uncore-other.json       | 220 ++++++------
 .../arch/x86/tremontx/uncore-memory.json      |  14 +-
 .../arch/x86/tremontx/uncore-other.json       |  70 ++--
 .../arch/x86/tremontx/uncore-power.json       |   2 +-
 tools/perf/pmu-events/jevents.c               |  40 ++-
 tools/perf/pmu-events/jevents.h               |   2 +-
 tools/perf/pmu-events/pmu-events.h            |   8 +-
 tools/perf/tests/pmu-events.c                 |   8 +-
 tools/perf/util/metricgroup.c                 |   5 +-
 tools/perf/util/metricgroup.h                 |   3 +-
 tools/perf/util/pmu.c                         |   6 +-
 36 files changed, 724 insertions(+), 694 deletions(-)

-- 
2.26.2

