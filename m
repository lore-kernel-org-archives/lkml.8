Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7EAC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 09:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 231CD20674
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 09:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RwJZ0giq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgHPJIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 05:08:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727913AbgHPJIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 05:08:11 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07G923AD048541;
        Sun, 16 Aug 2020 05:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=3ZC/b8qV9i71bxv5bkaPgw3ZoFlWzjtAxyENBS8c168=;
 b=RwJZ0giqNjnrkeW4A0fXa7jGk7Rwc9QVd6cvIsslx+Bru1WMGxA6eg+Wnrud87FMAvEV
 2IkUbYSQQ6LZ5AsfteX6J++0/zi18ko6EkdZYZKm/KI6lZod19/Y4zXGKASuqlEgTnJd
 Uv58RrTJt6i//YDoQd8t4OZSv0q4sC7/a2z4K5h30L8lgfY/y8yDEMGQcnqTr/1VnPIA
 +B0VaFttW9cyKwiSZrnLfKywc6z8yv5GEVBFPyzXCGIsrkhoG0WGkk/CBU93Xc7BXRic
 d2LL4I7fQH24PTVX/UZ3qGTT0sNdlkst8dpBrTyFxLfz/5PYnEOZyqEc3bq251mQdzEP Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32xvs2wsfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Aug 2020 05:07:38 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07G93Ttd055747;
        Sun, 16 Aug 2020 05:07:37 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32xvs2wseg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Aug 2020 05:07:37 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07G95Lsf011546;
        Sun, 16 Aug 2020 09:07:35 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 32x7b813sq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Aug 2020 09:07:34 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07G97Wph31195504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Aug 2020 09:07:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 130084C046;
        Sun, 16 Aug 2020 09:07:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0D7D4C050;
        Sun, 16 Aug 2020 09:07:26 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.90.146])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 16 Aug 2020 09:07:26 +0000 (GMT)
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
Subject: [PATCH v5 0/3]  powerpc/perf: Add json file support for hv_24x7 core level events
Date:   Sun, 16 Aug 2020 14:37:16 +0530
Message-Id: <20200816090719.72018-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-16_02:2020-08-14,2020-08-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 impostorscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008160069
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
aggregation like perchip/percore. It also adds new field 'AggregationMode'
to capture these terms.
Now, if user wants to add any new term, they just need to add it in
the enum defined.

Changelog:
v4 -> v5
- Remove intel side changes on uncore events by removing PerPkg
  field from enum "AggregationMode" and other corresponding changes.

Link to previous patchset: https://lkml.org/lkml/2020/7/20/124

Kajol Jain (3):
  perf jevents: Add support for parsing perchip/percore events
  perf/tools: Pass pmu_event structure as a parameter for
    arch_get_runtimeparam
  perf/tools/pmu_events/powerpc: Add hv_24x7 core level metric events

 tools/perf/arch/powerpc/util/header.c         |  7 ++--
 .../arch/powerpc/power9/nest_metrics.json     | 35 ++++++++++++-------
 tools/perf/pmu-events/jevents.c               | 32 +++++++++++++----
 tools/perf/pmu-events/jevents.h               |  2 +-
 tools/perf/pmu-events/pmu-events.h            |  6 ++++
 tools/perf/util/metricgroup.c                 |  5 ++-
 tools/perf/util/metricgroup.h                 |  3 +-
 7 files changed, 63 insertions(+), 27 deletions(-)

-- 
2.26.2

