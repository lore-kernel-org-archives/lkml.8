Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F385FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF6FB22B4E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O3tFzkly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgH0Oyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:54:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35438 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727790AbgH0NLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:11:31 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RD2etX144062;
        Thu, 27 Aug 2020 09:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=HdjXcqDCMa7PfGI38qoEfJ39ttLeWRgMbJnQsHWoBQQ=;
 b=O3tFzklyXjKJ0wcebxbXRYDAu1eHybHYfR3bBCsPzWcWbD0S8h6CoCaHGTOOqtGM7kMN
 60Umx/IAsbh/y6gyLvr8Zw19rcVp7vf2iiJXM90MeHQ8/HQtEJMON35lXcf3t7tbbCPe
 gSzll1k0XE8OqJqjX/ZCKiXrFzdoXn7QztXH8L+vkaZDQOXOJte2/VgyzclycJT3YoD4
 51kZ7w7LIXkHsQIs/D6cBfkkwWbjJyhll9fJSqCe0B6xTDrz3zOhEbFVl7IZkHETcVxl
 G4lkXUqCi0suyS2efjhoM3gWjcrhQ99TaIr/A1KaF1f9Hs949nMqquvVfK6u+xzH4J59 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 336a2kej1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:10:49 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07RD4wMu156055;
        Thu, 27 Aug 2020 09:10:48 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 336a2kej0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:10:48 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07RD7RUl018841;
        Thu, 27 Aug 2020 13:10:46 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 332ujrugcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 13:10:46 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07RDAh3M18743580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 13:10:43 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D543A4066;
        Thu, 27 Aug 2020 13:10:43 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B624EA405C;
        Thu, 27 Aug 2020 13:10:37 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.79.210.202])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Aug 2020 13:10:37 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        john.garry@huawei.com, kjain@linux.ibm.com
Subject: [PATCH v6 0/5] powerpc/perf: Add json file support for hv_24x7 core level events
Date:   Thu, 27 Aug 2020 18:39:53 +0530
Message-Id: <20200827130958.189146-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_07:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270094
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

Link to the previous version patchset: https://lkml.org/lkml/2020/8/16/50

Kajol Jain (5):
  perf/jevents: Remove jevents.h file
  perf/jevents: Add new structure to pass json fields.
  perf jevents: Add support for parsing perchip/percore events
  perf/tools: Pass pmu_event structure as a parameter for
    arch_get_runtimeparam
  perf/tools/pmu_events/powerpc: Add hv_24x7 core level metric events

 tools/perf/arch/powerpc/util/header.c         |   7 +-
 .../arch/powerpc/power9/nest_metrics.json     |  35 ++-
 tools/perf/pmu-events/jevents.c               | 247 +++++++++---------
 tools/perf/pmu-events/jevents.h               |  23 --
 tools/perf/pmu-events/pmu-events.h            |   6 +
 tools/perf/util/metricgroup.c                 |   5 +-
 tools/perf/util/metricgroup.h                 |   3 +-
 7 files changed, 166 insertions(+), 160 deletions(-)
 delete mode 100644 tools/perf/pmu-events/jevents.h

-- 
2.26.2

