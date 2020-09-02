Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDC5C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC9CA20773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CWZ/sMVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgIBQFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:05:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7406 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726173AbgIBQFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:05:45 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 082G36Qo074715;
        Wed, 2 Sep 2020 12:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=5t0voTswmWjs0FQw/xOoECUsROl6pguWGAa0pWTTsg8=;
 b=CWZ/sMVFHO7Hhm9dd6wBTJLetWjpzRlvDVqE1iLC0KAWfR8YUxwmK5YLH9KJPvVk/0hc
 y569Z9vTNkC3tuqt1CLlq7FCV9ICgdXcdD7mPj4pTuLrI2ZkwXaRCQO3J6qzcisgTazX
 xvfyawtJIs6aG+Wg1Jglv/Q6UKZvyE3Sx4pyiR2Yi/AftZFPTg5C+3sLvDg9ELW/Jtp+
 mqvyS0hXQpuIOWNMOYJE9dzSRMprPY73uKMDbTKFPHPxPXpMG78O9KrRYs3DHuJhyJJG
 qRXljvWdn2w3SUY1jkz04Wu3Sm1jhQh0UFNNEYaEbCU1cJ3XXW4eEaLiZHuUcPv0y87Y FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33aa409tju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 12:05:29 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 082G39lJ075074;
        Wed, 2 Sep 2020 12:05:29 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33aa409tgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 12:05:28 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 082G37V7016004;
        Wed, 2 Sep 2020 16:05:25 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 337e9h30kc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 16:05:25 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 082G5Muk22151466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Sep 2020 16:05:22 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 805FDA404D;
        Wed,  2 Sep 2020 16:05:22 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6009EA4051;
        Wed,  2 Sep 2020 16:05:18 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.83.99])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Sep 2020 16:05:18 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        john.garry@huawei.com, kjain@linux.ibm.com
Subject: [PATCH v7 0/5] powerpc/perf: Add json file support for hv_24x7 core level events
Date:   Wed,  2 Sep 2020 21:34:34 +0530
Message-Id: <20200902160439.335232-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_11:2020-09-02,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020153
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

This patchset also adds  changes of adding new structure
called 'json_event' inside jevents.h
file to improve the callback prototype inside jevent files.
Initially, whenever user want to add new field, they need to update
in all function callback which makes it more and more complex with
increased number of parmeters.
With this change, we just need to add it in new structure 'json_event'.
link to the patch: https://lkml.org/lkml/2020/8/25/217

Changelog:
v6 -> v7
- Remove min and get_cpu_str functions from jevents.c
- Make json_events function static to solve warning part [John Garry].
- Add event attribute in json_events function to remove strcpy from
  real_event function, as suggested by Jiri Olsa.
- Add warning while checking aggr_mode value [Jiri Olsa].

v5 -> v6
- Made changes to improve callback prototype inside jevent file
  by adding new struture 'json_event' as suggested by Andi Kleen.

- Added Reviewd-by tag from Andi Kleen

- Made changes suggested by Jiri Olsa and John garry includes:
  - Removing jevents.h file.
  - Some nits like freeing je->event mem, adding typedef for func
    and not allocating mem for json_event structure.
  - Added free for each field in json_event as suggested by
    John Garry.
  - In real_event function, rather then returning fixed structure
    pointer, used strcpy to copy event to je->event field.

- Also merge some changes in this patch set from the patch-
  https://lkml.org/lkml/2020/8/21/222. except nest event
  change which was using capability of defining metric using other metric.

- Make power side changes as per new struture added.

Link to the previous version patchset: https://lkml.org/lkml/2020/8/27/799

Kajol Jain (5):
  perf/jevents: Remove jevents.h file
  perf/jevents: Add new structure to pass json fields.
  perf jevents: Add support for parsing perchip/percore events
  perf/tools: Pass pmu_event structure as a parameter for
    arch_get_runtimeparam
  perf/tools/pmu_events/powerpc: Add hv_24x7 core level metric events

 tools/perf/arch/powerpc/util/header.c         |   7 +-
 .../arch/powerpc/power9/nest_metrics.json     |  35 ++-
 tools/perf/pmu-events/jevents.c               | 234 +++++++++---------
 tools/perf/pmu-events/jevents.h               |  23 --
 tools/perf/pmu-events/pmu-events.h            |   6 +
 tools/perf/util/metricgroup.c                 |   5 +-
 tools/perf/util/metricgroup.h                 |   3 +-
 7 files changed, 154 insertions(+), 159 deletions(-)
 delete mode 100644 tools/perf/pmu-events/jevents.h

-- 
2.26.2

