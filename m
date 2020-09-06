Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F075C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 11:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91E852087C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 11:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CRUaYeWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgIFLWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 07:22:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725803AbgIFLUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 07:20:51 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 086BE76V166489;
        Sun, 6 Sep 2020 07:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=1C/6RXlw1HL6mYl72FbWoIUfygeMH4Mn1+qsI8tkUqU=;
 b=CRUaYeWCvCnAA1h1CzzWr0FoZ/4p9A9mZGlc3BOyCyIO45bA+csyypnoGtiaueKvcRjd
 S+l9Tg+PdWKoUwgIsVZI2rznyHHWOrpXsekLYq6EIhR72yGvf8u4eIyXmpG1y5VDAfqe
 X1NaxMYtaNGRvqioAkR2BDonhnSOMz+CUQ38Ds96VzJkrFGCuuD9k1iF6PXyQLrmL5cO
 u7ypea8Gnhsd5YnEoOxoFRJz3i/Qe1P38hqZl+Iq7SHaAybPlGDjPWJc5vk6in+amBCX
 AGxsZN65I6w1KfEUqx9iomdaQM49eCndFtzmSkU0UaJxIub4ZDfp6hRZOFAy2BueZa36 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33cxq5g34x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Sep 2020 07:20:32 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 086BJh5i003180;
        Sun, 6 Sep 2020 07:20:31 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33cxq5g34d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Sep 2020 07:20:31 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 086BJ55P019003;
        Sun, 6 Sep 2020 11:20:29 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 33c2a88qeh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Sep 2020 11:20:29 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 086BKPgu34210230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Sep 2020 11:20:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7909AE055;
        Sun,  6 Sep 2020 11:20:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AB22AE051;
        Sun,  6 Sep 2020 11:20:19 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.79.216.239])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  6 Sep 2020 11:20:18 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        john.garry@huawei.com, kjain@linux.ibm.com
Subject: [PATCH v8 0/5] powerpc/perf: Add json file support for hv_24x7 core level events
Date:   Sun,  6 Sep 2020 16:49:59 +0530
Message-Id: <20200906112004.49574-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-06_07:2020-09-04,2020-09-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009060109
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
called 'json_event' inside jevents.c
file to improve the callback prototype inside jevent file.
Initially, whenever user want to add new field, they need to update
in all function callback which makes it more and more complex with
increased number of parmeters.
With this change, we just need to add it in new structure 'json_event'.
link to the RFC patch: https://lkml.org/lkml/2020/8/25/217

Changelog:
v7 -> v8
- Change commit typo from jevents.h to jevents.c
- Make json_events function static in first patch.

v6 -> v7
- Remove min and get_cpu_str functions from jevents.c
- Make json_events function static to solve warning part [John Garry].
- Add event attribute in json_events function to remove strcpy from
  real_event function, as suggested by Jiri Olsa.
- Add warning while checking aggr_mode value [Jiri Olsa].

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

