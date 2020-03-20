Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6430C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7FA2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgCTMym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:54:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726814AbgCTMyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:54:41 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02KCWQIx080890
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 08:54:40 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yu7aehgsa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 08:54:40 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kjain@linux.ibm.com>;
        Fri, 20 Mar 2020 12:54:38 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 20 Mar 2020 12:54:31 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02KCrSXj47710592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Mar 2020 12:53:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 278734C04A;
        Fri, 20 Mar 2020 12:54:30 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FDE54C044;
        Fri, 20 Mar 2020 12:54:24 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.35.76])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 20 Mar 2020 12:54:23 +0000 (GMT)
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
Subject: [PATCH v6 00/11] powerpc/perf: Add json file metric support for the hv_24x7 socket/chip level events
Date:   Fri, 20 Mar 2020 18:23:55 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20032012-0016-0000-0000-000002F47B81
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032012-0017-0000-0000-000033580A5C
Message-Id: <20200320125406.30995-1-kjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-20_03:2020-03-20,2020-03-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 phishscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=641 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003200054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patchset fixes the inconsistent results we are getting when
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

Second patch of the patchset adds expr_scanner_ctx object to hold user
data for the expr scanner, which can be used to hold runtime parameter.

Patch 9 & 11 of the patchset handles perf tool plumbing needed to replace
the "?" character in the metric expression to proper value and hv_24x7
json metric file for different Socket/chip resources.

Patch set also enable Hz/hz prinitg for --metric-only option to print
metric data for bus frequency.

Applied and tested all these patches cleanly on top of jiri's flex changes
with the changes done by Kan Liang for "Support metric group constraint"
patchset and made required changes.

Changelog:
v5 -> v6
- resolve compilation issue due to rearranging patch series.
- Rather then adding new function to take careof case for runtime param
  in metricgroup__add_metric, using metricgroup__add_metric_param itself
  for that work.
- Address some optimization suggested like using directly file path
  rather then adding new macro in header.c
- Change commit message on patch where we are adding "?" support
  by adding simple example.

v4 -> v5
- Using sysfs__read_int instead of sysfs__read_ull while reading
  parameter value in powerpc/util/header.c file.

- Using asprintf rather then malloc and sprintf 
  Suggested by Arnaldo Carvalho de Melo

- Break patch 6 from previous version to two patch,
  - One to add refactor current "metricgroup__add_metric" function
    and another where actually "?" handling infra added.

- Add expr__runtimeparam as part of 'expr_scanner_ctx' struct
  rather then making it global variable. Thanks Jiri for
  adding this structure to hold user data for the expr scanner.

- Add runtime param as agrugement to function 'expr__find_other'
  and 'expr__parse' and made changes on references accordingly.

v3 -> v4
- Apply these patch on top of Kan liang changes.
  As suggested by Jiri.

v2 -> v3
- Remove setting  event_count to 0 part in function 'h_24x7_event_read'
  with comment rather then adding 0 to event_count value.
  Suggested by: Sukadev Bhattiprolu

- Apply tool side changes require to replace "?" on Jiri's flex patch
  series and made all require changes to make it compatible with added
  flex change.

v1 -> v2
- Rename hv-24x7 metric json file as nest_metrics.json

Jiri Olsa (2):
  perf expr: Add expr_ prefix for parse_ctx and parse_id
  perf expr: Add expr_scanner_ctx object

Kajol Jain (9):
  powerpc/perf/hv-24x7: Fix inconsistent output values incase multiple
    hv-24x7 events run
  powerpc/hv-24x7: Add rtas call in hv-24x7 driver to get processor
    details
  powerpc/hv-24x7: Add sysfs files inside hv-24x7 device to show
    processor details
  Documentation/ABI: Add ABI documentation for chips and sockets
  powerpc/hv-24x7: Update post_mobility_fixup() to handle migration
  perf/tools: Refactoring metricgroup__add_metric function
  perf/tools: Enhance JSON/metric infrastructure to handle "?"
  tools/perf: Enable Hz/hz prinitg for --metric-only option
  perf/tools/pmu-events/powerpc: Add hv_24x7 socket/chip level metric
    events

 .../sysfs-bus-event_source-devices-hv_24x7    |  14 +++
 arch/powerpc/perf/hv-24x7.c                   | 104 ++++++++++++++++--
 arch/powerpc/platforms/pseries/mobility.c     |  12 ++
 arch/powerpc/platforms/pseries/pseries.h      |   3 +
 tools/perf/arch/powerpc/util/header.c         |   8 ++
 .../arch/powerpc/power9/nest_metrics.json     |  19 ++++
 tools/perf/tests/expr.c                       |  12 +-
 tools/perf/util/expr.c                        |  25 +++--
 tools/perf/util/expr.h                        |  19 ++--
 tools/perf/util/expr.l                        |  37 +++++--
 tools/perf/util/expr.y                        |   6 +-
 tools/perf/util/metricgroup.c                 |  88 +++++++++++----
 tools/perf/util/metricgroup.h                 |   1 +
 tools/perf/util/stat-display.c                |   2 -
 tools/perf/util/stat-shadow.c                 |  14 ++-
 15 files changed, 287 insertions(+), 77 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json

-- 
2.18.1

