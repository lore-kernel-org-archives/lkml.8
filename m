Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2110C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5DFC20738
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgG0H4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:56:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65514 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726387AbgG0H4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:56:40 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06R7hZEO195271;
        Mon, 27 Jul 2020 03:56:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32htsjr9rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 03:56:26 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06R7i0cG196081;
        Mon, 27 Jul 2020 03:56:25 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32htsjr9qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 03:56:25 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06R7tNoo015936;
        Mon, 27 Jul 2020 07:56:22 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 32gcy4hxrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 07:56:22 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06R7uKqh30409212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 07:56:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62ABBAE04D;
        Mon, 27 Jul 2020 07:56:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9CB2AE051;
        Mon, 27 Jul 2020 07:56:17 +0000 (GMT)
Received: from srikart450.in.ibm.com (unknown [9.199.36.96])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Jul 2020 07:56:17 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH 0/7] Optimization to improve cpu online/offline on Powerpc
Date:   Mon, 27 Jul 2020 13:25:25 +0530
Message-Id: <20200727075532.30058-1-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_04:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anton reported that his 4096 cpu (1024 cores in a socket) was taking too
long to boot. He also analyzed that most of the time was being spent on
updating cpu_core_mask.

Here are some optimizations and fixes to make ppc64_cpu --smt=8/ppc64_cpu
--smt=1 run faster and hence boot the kernel also faster.

Its based on top of my v4 coregroup support patchset.
http://lore.kernel.org/lkml/20200727053230.19753-1-srikar@linux.vnet.ibm.com/t/#u

The first two patches should solve Anton's immediate problem.
On the unofficial patches, Anton reported that the boot time came from 30
mins to 6 seconds. (Basically a high core count in a single socket
configuration). Satheesh also reported similar numbers.

The rest are simple cleanups/optimizations.

Since cpu_core_mask is an exported symbol for a long duration, lets retain
as a snapshot of cpumask_of_node.

Architecture:        ppc64le
Byte Order:          Little Endian
CPU(s):              160
On-line CPU(s) list: 0-159
Thread(s) per core:  4
Core(s) per socket:  20
Socket(s):           2
NUMA node(s):        2
Model:               2.2 (pvr 004e 1202)
Model name:          POWER9, altivec supported
CPU max MHz:         3800.0000
CPU min MHz:         2166.0000
L1d cache:           32K
L1i cache:           32K
L2 cache:            512K
L3 cache:            10240K
NUMA node0 CPU(s):   0-79
NUMA node8 CPU(s):   80-159

without patch (powerpc/next)
[    0.099347] smp: Bringing up secondary CPUs ...
[    0.832513] smp: Brought up 2 nodes, 160 CPUs

with powerpc/next + coregroup support patchset
[    0.099241] smp: Bringing up secondary CPUs ...
[    0.835627] smp: Brought up 2 nodes, 160 CPUs

with powerpc/next + coregroup + this patchset
[    0.097232] smp: Bringing up secondary CPUs ...
[    0.528457] smp: Brought up 2 nodes, 160 CPUs

x ppc64_cpu --smt=1
+ ppc64_cpu --smt=4

without patch
    N           Min           Max        Median           Avg        Stddev
x 100         11.82         17.06         14.01         14.05     1.2665247
+ 100         12.25         16.59         13.86       14.1143      1.164293

with patch
    N           Min           Max        Median           Avg        Stddev
x 100         12.68         16.15         14.24        14.238    0.75489246
+ 100         12.93         15.85         14.35       14.2897    0.60041813

Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Anton Blanchard <anton@ozlabs.org>
Cc: Oliver O'Halloran <oohall@gmail.com>
Cc: Nathan Lynch <nathanl@linux.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>

Srikar Dronamraju (7):
  powerpc/topology: Update topology_core_cpumask
  powerpc/smp: Stop updating cpu_core_mask
  powerpc/smp: Remove get_physical_package_id
  powerpc/smp: Optimize remove_cpu_from_masks
  powerpc/smp: Limit cpus traversed to within a node.
  powerpc/smp: Stop passing mask to update_mask_by_l2
  powerpc/smp: Depend on cpu_l1_cache_map when adding cpus

 arch/powerpc/include/asm/smp.h      |  5 --
 arch/powerpc/include/asm/topology.h |  7 +--
 arch/powerpc/kernel/smp.c           | 79 +++++++++--------------------
 3 files changed, 24 insertions(+), 67 deletions(-)

-- 
2.17.1

