Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6098AC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 453072073A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgEGNhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 09:37:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725947AbgEGNht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 09:37:49 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047DWCgu110161;
        Thu, 7 May 2020 09:37:33 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30twj0d26q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 09:37:33 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 047DXwZa124917;
        Thu, 7 May 2020 09:37:32 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30twj0d24u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 09:37:32 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 047DUlTk010103;
        Thu, 7 May 2020 13:37:30 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 30s0g5cp36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 13:37:30 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 047DbSGM11731420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 May 2020 13:37:28 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7825AE058;
        Thu,  7 May 2020 13:37:27 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7029AE04D;
        Thu,  7 May 2020 13:37:24 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.85.97.135])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 May 2020 13:37:24 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com,
        chris.hyser@oracle.com, pkondeti@codeaurora.org,
        valentin.schneider@arm.com, rjw@rjwysocki.net
Subject: [RFC 0/4] IDLE gating in presence of latency-sensitive tasks
Date:   Thu,  7 May 2020 19:07:19 +0530
Message-Id: <20200507133723.18325-1-parth@linux.ibm.com>
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_08:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=935
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Abstract:
=========
The IDLE states provides a way to save power at the cost of wakeup
latencies. The deeper the IDLE state selected by the CPUIDLE governor, the
more the exit latency of the state will be. This exit latency adds to the
task's wakeup latency. Hence choosing the best trade-off between the power
save feature and the increase observable latency is what CPUIDLE governor
focus upon.

But CPUIDLE governor is generic in nature to provide best of both the
worlds. However, the CPUIDLE governor does not have the capability to
distinguish between latency sensitivity of tasks queued on the runqueue.

With the introduction of latency-nice attribute to provide the latency
requirements from the userspace, the CPUIDLE governor can use it to
identify latency sensitive tasks.

Hence, this patch-set restricts the CPU running latency-sensitive tasks to
go into any IDLE state, thus minimizing the impact of exit latency for such
tasks. Expected results is better power-saving and comparable performance
than compared to disabling all IDLE states.

- Why not use PM_QoS?
PM_QoS provide ways to assist CPUIDLE governor decision with per device(s)
(like CPU, network, etc.) attributes.  This behavior of decision assistance
at "per device" level lacks in providing the best of both power saving and
the latency minimization for specific task only. Hence, PM_QoS like feature
can be clubbed with scheduler to retrieve latency_nice information of a
task and provide better decision at per task level.  This leads to
providing better performance to only those CPUs which is queued up for
running latency sensitive tasks and thus saving power from other CPUs.


Implementation:
===============
- latency sensitive tasks are the task's marked with latency_nice == -20.
- Use the per-CPU variable to keep track of the (to be) queued up latency
  sensitive tasks.
- CPUIDLE governor does not choose a non-polling idle state on such marked
  CPUS until the percpu counter goes back to zero

This strategy solves many latency related problems for the tasks showing
sleep-wake-sleep pattern (basically most of GPU workloads, schbench,
RT-app, database workloads, and many more).

This series is based on latency_nice patch-set
PATCH v5 https://lkml.org/lkml/2020/2/28/166

One may use below file to set latency_nice value:
- lnice.c: lnice -l -20 <workload>
  https://github.com/parthsl/tools/blob/master/misc_scripts/lnice.c
or
- relnice.c: relnice -p <PID> -l 19
  https://github.com/parthsl/tools/blob/master/misc_scripts/relnice.c


Results:
========
# Baseline = tip/sched/core + latency_nice patches
# w/ patch = Baseline + this patch-set + workload's latency_nice = -20

=> Schbench (Lower is better)
-----------------------------
- Baseline:
$> schbench -r 30
+---------------------+----------+-------------------------+-----------+
| %ile Latency (in us)| Baseline | cpupower idle-set -D 10 | w/ patch  |
+---------------------+----------+-------------------------+-----------+
| 50                  |      371 | 21                      | 22        |
| 90                  |      729 | 33                      | 37        |
| 99                  |      889 | 40 (-95%)               | 48 (-94%) |
| max                 |     2197 | 59                      | 655       |
| Avg. Energy (Watts) |       73 | 96 (+31%)               | 88 (+20%) |
+---------------------+----------+-------------------------+-----------+

$> schbench -r 10 -m 2 -t 1
+---------------------+----------+-------------------------+-----------+
| %ile Latency (in us)| Baseline | cpupower idle-set -D 10 | w/ patch  |
+---------------------+----------+-------------------------+-----------+
| 50                  |      336 | 5                       | 4         |
| 90                  |      464 | 7                       | 6         |
| 99                  |      579 | 10 (-98%)               | 11 (-98%) |
| max                 |      691 | 12                      | 489       |
| Avg. Energy (Watts) |       28 | 40 (+42%)               | 33 (+17%) |
+---------------------+----------+-------------------------+-----------+


=> PostgreSQL (lower is better):
----------------------------------
- 44 Clients running in parallel
$> pgbench -T 30 -S -n -R 10  -c 44
+---------------------+----------+-------------------------+--------------+
|                     | Baseline | cpupower idle-set -D 10 |   w/ patch   |
+---------------------+----------+-------------------------+--------------+
| latency avg. (ms)   |    2.028 | 0.424 (-80%)            | 1.202 (-40%) |
| latency stddev      |    3.149 | 0.473                   | 0.234        |
| trans. completed    |      294 | 304 (+3%)               | 300 (+2%)    |
| Avg. Energy (Watts) |     23.6 | 42.5 (+80%)             | 26.5 (+20%)  |
+---------------------+----------+-------------------------+--------------+

- 1 Client running
$> pgbench -T 30 -S -n -R 10 -c 1
+---------------------+----------+-------------------------+--------------+
|                     | Baseline | cpupower idle-set -D 10 |   w/ patch   |
+---------------------+----------+-------------------------+--------------+
| latency avg. (ms)   |    1.292 | 0.282 (-78%)            | 0.237 (-81%) |
| latency stddev      |    0.572 | 0.126                   | 0.116        |
| trans. completed    |      294 | 268 (-8%)               | 315 (+7%)    |
| Avg. Energy (Watts) |      9.8 | 29.6 (+302%)            | 27.7 (+282%) |
+---------------------+----------+-------------------------+--------------+
*trans. completed = Total transactions processed (Higher is better)


Parth Shah (4):
  sched/core: Introduce per_cpu counter to track latency sensitive tasks
  sched/core: Set nr_lat_sensitive counter at various scheduler
    entry/exit points
  sched/idle: Disable idle call on least latency requirements
  sched/idle: Add debugging bits to validate inconsistency in latency
    sensitive task calculations

 kernel/sched/core.c  | 32 ++++++++++++++++++++++++++++++--
 kernel/sched/idle.c  |  8 +++++++-
 kernel/sched/sched.h |  7 +++++++
 3 files changed, 44 insertions(+), 3 deletions(-)

-- 
2.17.2

