Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12A6C38A2A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 03:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C58DB20746
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 03:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgEIDju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 23:39:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:45288 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgEIDju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 23:39:50 -0400
IronPort-SDR: mbEd1kAVhL0OPVX7rLs0fjEb4lhkQMMbesrpkHV4tQDeGseW4eJPG0WSihN3KqWiVjFVX6VDfZ
 W/TlVk6wTB0A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 20:39:49 -0700
IronPort-SDR: bVSjGjevKStSj6tP43zjGYyP1HL5+fkTNPz85zM0Z6aCR2Ex/wxvoUlXKdKumRWBXUqFoZILRx
 9dW9NMNt/56g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,370,1583222400"; 
   d="scan'208";a="408317293"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 08 May 2020 20:39:49 -0700
Received: from [10.238.0.150] (hongyuni-mobl1.ccr.corp.intel.com [10.238.0.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 9D3AA580378;
        Fri,  8 May 2020 20:39:44 -0700 (PDT)
Subject: Re: [RFC PATCH 00/13] Core scheduling v5
To:     vpillai@digitalocean.com, naravamudan@digitalocean.com,
        jdesfossez@digitalocean.com, peterz@infradead.org,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <38805656-2e2f-222a-c083-692f4b113313@linux.intel.com>
From:   "Ning, Hongyu" <hongyu.ning@linux.intel.com>
Cc:     vpillai@digitalocean.com, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com, pauld@redhat.com,
        aaron.lwe@gmail.com, aubrey.intel@gmail.com,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        valentin.schneider@arm.com, mgorman@techsingularity.net,
        pawan.kumar.gupta@linux.intel.com, pbonzini@redhat.com,
        joelaf@google.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org
Message-ID: <d08e6a2f-842f-2145-321d-be4971111065@linux.intel.com>
Date:   Sat, 9 May 2020 11:39:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <38805656-2e2f-222a-c083-692f4b113313@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


- Test environment:
Intel Xeon Server platform
CPU(s):              192
On-line CPU(s) list: 0-191
Thread(s) per core:  2
Core(s) per socket:  48
Socket(s):           2
NUMA node(s):        4

- Kernel under test: 
Core scheduling v5 base
https://github.com/digitalocean/linux-coresched/tree/coresched/v5-v5.5.y

- Test set based on sysbench 1.1.0-bd4b418:
A: sysbench cpu in cgroup cpu 1 + sysbench mysql in cgroup mysql 1 (192 workload tasks for each cgroup)
B: sysbench cpu in cgroup cpu 1 + sysbench cpu in cgroup cpu 2 + sysbench mysql in cgroup mysql 1 + sysbench mysql in cgroup mysql 2 (192 workload tasks for each cgroup)

- Test results briefing:
1 Good results:
1.1 For test set A, coresched could achieve same or better performance compared to smt_off, for both cpu workload and sysbench workload
1.2 For test set B, cpu workload, coresched could achieve better performance compared to smt_off

2 Bad results:
2.1 For test set B, mysql workload, coresched performance is lower than smt_off, potential fairness issue between cpu workloads and mysql workloads
2.2 For test set B, cpu workload, potential fairness issue between 2 cgroups cpu workloads

- Test results:
Note: test results in following tables are Tput normalized to default baseline

-- Test set A Tput normalized results:
+--------------------+--------+-----------+-------------+-----------+-------+-------------+---------------+-------------+
|                    | ****   | default   | coresched   | smt_off   | ***   | default     | coresched     | smt_off     |
+====================+========+===========+=============+===========+=======+=============+===============+=============+
| cgroups            | ****   | cg cpu 1  | cg cpu 1    | cg cpu 1  | ***   | cg mysql 1  | cg mysql 1    | cg mysql 1  |
+--------------------+--------+-----------+-------------+-----------+-------+-------------+---------------+-------------+
| sysbench workload  | ****   | cpu       | cpu         | cpu       | ***   | mysql       | mysql         | mysql       |
+--------------------+--------+-----------+-------------+-----------+-------+-------------+---------------+-------------+
| 192 tasks / cgroup | ****   | 1         | 0.95        | 0.54      | ***   | 1           | 0.92          | 0.97        |
+--------------------+--------+-----------+-------------+-----------+-------+-------------+---------------+-------------+

-- Test set B Tput normalized results:
+--------------------+--------+-----------+-------------+-----------+-------+-------------+---------------+-------------+------+-------------+---------------+-------------+-----+-------------+---------------+-------------+
|                    | ****   | default   | coresched   | smt_off   | ***   | default     | coresched     | smt_off     | **   | default     | coresched     | smt_off     | *   | default     | coresched     | smt_off     |
+====================+========+===========+=============+===========+=======+=============+===============+=============+======+=============+===============+=============+=====+=============+===============+=============+
| cgroups            | ****   | cg cpu 1  | cg cpu 1    | cg cpu 1  | ***   | cg cpu 2    | cg cpu 2      | cg cpu 2    | **   | cg mysql 1  | cg mysql 1    | cg mysql 1  | *   | cg mysql 2  | cg mysql 2    | cg mysql 2  |
+--------------------+--------+-----------+-------------+-----------+-------+-------------+---------------+-------------+------+-------------+---------------+-------------+-----+-------------+---------------+-------------+
| sysbench workload  | ****   | cpu       | cpu         | cpu       | ***   | cpu         | cpu           | cpu         | **   | mysql       | mysql         | mysql       | *   | mysql       | mysql         | mysql       |
+--------------------+--------+-----------+-------------+-----------+-------+-------------+---------------+-------------+------+-------------+---------------+-------------+-----+-------------+---------------+-------------+
| 192 tasks / cgroup | ****   | 1         | 0.9         | 0.47      | ***   | 1           | 1.32          | 0.66        | **   | 1           | 0.42          | 0.89        | *   | 1           | 0.42          | 0.89        |
+--------------------+--------+-----------+-------------+-----------+-------+-------------+---------------+-------------+------+-------------+---------------+-------------+-----+-------------+---------------+-------------+


> On Date: Wed,  4 Mar 2020 16:59:50 +0000, vpillai <vpillai@digitalocean.com> wrote:
> To: Nishanth Aravamudan <naravamudan@digitalocean.com>, Julien Desfossez <jdesfossez@digitalocean.com>, Peter Zijlstra <peterz@infradead.org>, Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org, tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
> CC: vpillai <vpillai@digitalocean.com>, linux-kernel@vger.kernel.org, fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com, Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>, Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com, Valentin Schneider <valentin.schneider@arm.com>, Mel Gorman <mgorman@techsingularity.net>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org
> 
> 
> Fifth iteration of the Core-Scheduling feature.
> 
> Core scheduling is a feature that only allows trusted tasks to run
> concurrently on cpus sharing compute resources(eg: hyperthreads on a
> core). The goal is to mitigate the core-level side-channel attacks
> without requiring to disable SMT (which has a significant impact on
> performance in some situations). So far, the feature mitigates user-space
> to user-space attacks but not user-space to kernel attack, when one of
> the hardware thread enters the kernel (syscall, interrupt etc).
> 
> By default, the feature doesn't change any of the current scheduler
> behavior. The user decides which tasks can run simultaneously on the
> same core (for now by having them in the same tagged cgroup). When
> a tag is enabled in a cgroup and a task from that cgroup is running
> on a hardware thread, the scheduler ensures that only idle or trusted
> tasks run on the other sibling(s). Besides security concerns, this
> feature can also be beneficial for RT and performance applications
> where we want to control how tasks make use of SMT dynamically.
> 
> This version was focusing on performance and stability. Couple of
> crashes related to task tagging and cpu hotplug path were fixed.
> This version also improves the performance considerably by making
> task migration and load balancing coresched aware.
> 
> In terms of performance, the major difference since the last iteration
> is that now even IO-heavy and mixed-resources workloads are less
> impacted by core-scheduling than by disabling SMT. Both host-level and
> VM-level benchmarks were performed. Details in:
> https://lkml.org/lkml/2020/2/12/1194
> https://lkml.org/lkml/2019/11/1/269
> 
> v5 is rebased on top of 5.5.5(449718782a46)
> https://github.com/digitalocean/linux-coresched/tree/coresched/v5-v5.5.y
> 

