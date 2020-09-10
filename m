Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A452C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 227B020731
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgIKQKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:10:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:22472 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbgIKPnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:43:18 -0400
IronPort-SDR: v2h8cI4U2lW7Ge1lt9CEeY+eJ+wnXthXqgxXceDsrvZf7sKjrVCrOIi6bxlJ4Iukb729sjhwDP
 xhXEQ0X7F9GA==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="146483395"
X-IronPort-AV: E=Sophos;i="5.76,415,1592895600"; 
   d="scan'208";a="146483395"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 06:28:26 -0700
IronPort-SDR: 8M6e0lLQQ8exeFWaCMzgHU12m5LqC0cmkp6B32lg20xnzP/03rHUyEBr4qftr/yey5wB0jisE0
 zUm9ecDqdtFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,415,1592895600"; 
   d="scan'208";a="408157980"
Received: from aubrey-work.sh.intel.com ([10.239.53.113])
  by fmsmga001.fm.intel.com with ESMTP; 11 Sep 2020 06:28:23 -0700
From:   Aubrey Li <aubrey.li@intel.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        valentin.schneider@arm.com
Cc:     tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@intel.com>
Subject: [RFC PATCH v1 0/1] select idle cpu from idle cpumask in sched domain
Date:   Thu, 10 Sep 2020 13:42:02 +0800
Message-Id: <20200910054203.525420-1-aubrey.li@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm writting to see if it makes sense to track idle cpus in a shared cpumask
in sched domain, then a task wakes up it can select idle cpu from this cpumask
instead of scanning all the cpus in the last level cache domain, especially
when the system is heavily loaded, the scanning cost could be significantly
reduced. The price is that the atomic cpumask ops are added to the idle entry
and exit paths.

I tested the following benchmarks on a x86 4 socket system with 24 cores per
socket and 2 hyperthreads per core, total 192 CPUs:

uperf throughput: netperf workload, tcp_nodelay, r/w size = 90

  threads	baseline-avg	%std	patch-avg	%std
  96		1		1.24	0.98		2.76
  144		1		1.13	1.35		4.01
  192		1		0.58	1.67		3.25
  240		1		2.49	1.68		3.55

hackbench: process mode, 100000 loops, 40 file descriptors per group

  group		baseline-avg	%std	patch-avg	%std
  2(80)		1		12.05	0.97		9.88
  3(120)	1		12.48	0.95		11.62
  4(160)	1		13.83	0.97		13.22
  5(200)	1		2.76	1.01		2.94	 

schbench: 99th percentile latency, 16 workers per message thread

  mthread	baseline-avg	%std	patch-avg	%std
  6(96)		1		1.24	0.993		1.73
  9(144)	1		0.38	0.998		0.39
  12(192)	1		1.58	0.995		1.64
  15(240)	1		51.71	0.606		37.41

sysbench mysql throughput: read/write, table size = 10,000,000

  thread	baseline-avg	%std	patch-avg	%std
  96		1		1.77	1.015		1.71
  144		1		3.39	0.998		4.05
  192		1		2.88	1.002		2.81
  240		1		2.07	1.011		2.09

kbuild: kexec reboot every time

  baseline-avg	patch-avg
  1		1

Any suggestions are highly appreciated!

Thanks,
-Aubrey

Aubrey Li (1):
  sched/fair: select idle cpu from idle cpumask in sched domain

 include/linux/sched/topology.h | 13 +++++++++++++
 kernel/sched/fair.c            |  4 +++-
 kernel/sched/topology.c        |  2 +-
 3 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.25.1

