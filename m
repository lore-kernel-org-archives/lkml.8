Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A367C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 09:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FD0246D3
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 09:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgB2Jme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 04:42:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726671AbgB2Jme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 04:42:34 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01T9ckSc130778
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 04:42:32 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yfn140mg8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 04:42:32 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kjain@linux.ibm.com>;
        Sat, 29 Feb 2020 09:42:30 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 29 Feb 2020 09:42:24 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01T9gMVN57082062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Feb 2020 09:42:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D465F4C04E;
        Sat, 29 Feb 2020 09:42:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F10054C046;
        Sat, 29 Feb 2020 09:42:13 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.53.249])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 29 Feb 2020 09:42:13 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sukadev@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com, peterz@infradead.org,
        yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org,
        kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de, kjain@linux.ibm.com
Subject: [PATCH v3 0/8] powerpc/perf: Add json file metric support for the hv_24x7 socket/chip level events
Date:   Sat, 29 Feb 2020 15:11:51 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022909-0028-0000-0000-000003DF1B27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022909-0029-0000-0000-000024A43FF9
Message-Id: <20200229094159.25573-1-kjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-29_02:2020-02-28,2020-02-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002290074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First patch of the patchset fix inconsistent results we are getting when
we run multiple 24x7 events.

Patchset adds json file metric support for the hv_24x7 socket/chip level
events. "hv_24x7" pmu interface events needs system dependent parameter
like socket/chip/core. For example, hv_24x7 chip level events needs
specific chip-id to which the data is requested should be added as part
of pmu events.

So to enable JSON file support to "hv_24x7" interface, patchset expose
total number of sockets and chips per-socket details in sysfs
files (sockets, chips) under "/sys/devices/hv_24x7/interface/".

To get sockets and number of chips per sockets, patchset adds a rtas call
with token "PROCESSOR_MODULE_INFO" to get these details. Patchset also
handles partition migration case to re-init these system depended
parameters by adding proper calls in post_mobility_fixup() (mobility.c).

Patch 6 & 8 of the patchset handles perf tool plumbing needed to replace
the "?" character in the metric expression to proper value and hv_24x7
json metric file for different Socket/chip resources.

Patch set also enable Hz/hz prinitg for --metric-only option to print
metric data for bus frequency.

Applied and tested all these patches cleanly on top of jiri's flex changes
patchset and made required changes.

Changelog:
v2 -> v3
- Remove setting  event_count to 0 part in function 'h_24x7_event_read'
  with comment rather then adding 0 to event_count value.
  Suggested by: Sukadev Bhattiprolu

- Apply tool side changes require to replace "?" on Jiri's flex patch
  series and made all require changes to make it compatible with added
  flex change.

v1 -> v2
- Rename hv-24x7 metric json file as nest_metrics.json

Kajol Jain (8):
  powerpc/perf/hv-24x7: Fix inconsistent output values incase multiple
    hv-24x7 events run
  powerpc/hv-24x7: Add rtas call in hv-24x7 driver to get processor
    details
  powerpc/hv-24x7: Add sysfs files inside hv-24x7 device to show
    processor details
  Documentation/ABI: Add ABI documentation for chips and sockets
  powerpc/hv-24x7: Update post_mobility_fixup() to handle migration
  perf/tools: Enhance JSON/metric infrastructure to handle "?"
  tools/perf: Enable Hz/hz prinitg for --metric-only option
  perf/tools/pmu-events/powerpc: Add hv_24x7 socket/chip level metric
    events

 .../sysfs-bus-event_source-devices-hv_24x7    |  14 +++
 arch/powerpc/perf/hv-24x7.c                   | 104 ++++++++++++++--
 arch/powerpc/platforms/pseries/mobility.c     |  12 ++
 arch/powerpc/platforms/pseries/pseries.h      |   3 +
 tools/perf/arch/powerpc/util/header.c         |  47 ++++++++
 .../arch/powerpc/power9/nest_metrics.json     |  19 +++
 tools/perf/util/expr.h                        |   1 +
 tools/perf/util/expr.l                        |  18 ++-
 tools/perf/util/expr.y                        |   2 +
 tools/perf/util/metricgroup.c                 | 112 +++++++++++-------
 tools/perf/util/metricgroup.h                 |   1 +
 tools/perf/util/stat-display.c                |   2 -
 tools/perf/util/stat-shadow.c                 |   6 +
 13 files changed, 286 insertions(+), 55 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json

-- 
2.21.0

