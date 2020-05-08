Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E31C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D7BA20736
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgEHHZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 03:25:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:27650 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgEHHZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 03:25:22 -0400
IronPort-SDR: OJYSn+/+lIb7j86ASAD0ZRVs8yfORZvdfzS9XbrvUbWOY6lAl+JkTFop7QBBo/EK9O5z1S2d3D
 EHsKM6ndFnCg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 00:25:22 -0700
IronPort-SDR: 1UP0CFtipWjgq6gQJZBzzZajBTmR3A4NjdCKdgyxGhXkDCpDK7ixJn3UVKURlKus5kQgvXntPF
 hyx/BhGficZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,366,1583222400"; 
   d="scan'208";a="264210525"
Received: from shbuild999.sh.intel.com ([10.239.147.136])
  by orsmga006.jf.intel.com with ESMTP; 08 May 2020 00:25:18 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [PATCH 0/3] make vm_committed_as_batch aware of vm overcommit policy  
Date:   Fri,  8 May 2020 15:25:14 +0800
Message-Id: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When checking a performance change for will-it-scale scalability
mmap test [1], we found very high lock contention for spinlock of
percpu counter 'vm_committed_as':

    94.14%     0.35%  [kernel.kallsyms]         [k] _raw_spin_lock_irqsave
    48.21% _raw_spin_lock_irqsave;percpu_counter_add_batch;__vm_enough_memory;mmap_region;do_mmap;
    45.91% _raw_spin_lock_irqsave;percpu_counter_add_batch;__do_munmap;

Actually this heavy lock contention is not always necessary. The
'vm_committed_as' needs to be very precise when the strict
OVERCOMMIT_NEVER policy is set, which requires a rather small batch
number for the percpu counter.

So lift the batch number to 16X for OVERCOMMIT_ALWAYS and
OVERCOMMIT_GUESS policies, and add a sysctl handler to adjust it
when the policy is reconfigured.

Benchmark with the same testcase in [1] shows 53% improvement on a
8C/16T desktop, and 2097%(20X) on a 4S/72C/144T server. And no change
for some platforms, due to the test mmap size of the case is bigger
than the batch number computed, though the patch will help mmap/munmap
generally.

[1] https://lkml.org/lkml/2020/3/5/57

There are some style complain from checkpatch for patch 3, as it
follows the similar format of sibling functions

patch1: a cleanup for /proc/meminfo
patch2: a preparation patch which also improve the accuracy of
        vm_memory_committed
patch3: the main change

Please help to review, thanks!

- Feng

----------------------------------------------------------------
Changelog:
  v2:
     * add the sysctl handler to cover runtime overcommit policy
       change, as suggested by Andres Morton 
     * address the accuracy concern of vm_memory_committed()
       from Andi Kleen 

Feng Tang (3):
  proc/meminfo: avoid open coded reading of vm_committed_as
  mm/util.c: make vm_memory_committed() more accurate
  mm: adjust vm_committed_as_batch according to vm overcommit policy

 fs/proc/meminfo.c    |  2 +-
 include/linux/mm.h   |  2 ++
 include/linux/mman.h |  4 ++++
 kernel/sysctl.c      |  2 +-
 mm/mm_init.c         | 19 +++++++++++++++----
 mm/util.c            | 15 ++++++++++++++-
 6 files changed, 37 insertions(+), 7 deletions(-)

-- 
2.7.4

