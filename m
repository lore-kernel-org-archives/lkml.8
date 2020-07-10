Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A074FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 857B6207D0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgGJOCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:02:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:10776 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbgGJOCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:02:04 -0400
IronPort-SDR: McT6vivCzeV4dLSodRiiQbgwKcs+k/XWDpQAPXSuapnOTdVtFyK2WUWHpOy2g0fi2oUIUm0lbm
 nN4VwRClbfAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="146267614"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="146267614"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 07:01:53 -0700
IronPort-SDR: brHzR9HIyMBI1+gJQrxq5ZsKl13vJiFgkj6prqj+KXafPbY59Tz4sE8o1IEjKv8wLlPolRHmUb
 eduseNop2XBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="458287037"
Received: from shbuild999.sh.intel.com ([10.239.146.107])
  by orsmga005.jf.intel.com with ESMTP; 10 Jul 2020 07:01:49 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>, Qian Cai <cai@lca.pw>,
        Dennis Zhou <dennis@kernel.org>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [PATCH v6 0/4] make vm_committed_as_batch aware of vm overcommit policy  
Date:   Fri, 10 Jul 2020 22:01:44 +0800
Message-Id: <1594389708-60781-1-git-send-email-feng.tang@intel.com>
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

So keep 'batch' number unchanged for strict OVERCOMMIT_NEVER policy,
and enlarge it for not-so-strict  OVERCOMMIT_ALWAYS and OVERCOMMIT_GUESS
policies.

Benchmark with the same testcase in [1] shows 53% improvement on a
8C/16T desktop, and 2097%(20X) on a 4S/72C/144T server. And for that
case, whether it shows improvements depends on if the test mmap size
is bigger than the batch number computed.

We tested 10+ platforms in 0day (server, desktop and laptop). If we
lift it to 64X, 80%+ platforms show improvements, and for 16X lift,
1/3 of the platforms will show improvements.

And generally it should help the mmap/unmap usage,as Michal Hocko
mentioned:
"
I believe that there are non-synthetic worklaods which would benefit
from a larger batch. E.g. large in memory databases which do large
mmaps during startups from multiple threads.
"

Note: There are some style complain from checkpatch for patch 4,
as sysctl handler declaration follows the similar format of sibling
functions

[1] https://lore.kernel.org/lkml/20200305062138.GI5972@shao2-debian/

patch1: a cleanup for /proc/meminfo
patch2: a preparation patch which also improve the accuracy of
        vm_memory_committed
patch3: add a percpu_counter sync func 
patch4: main change

Please help to review, thanks!

- Feng

----------------------------------------------------------------
Changelog:

  v6: 
      * fix the ltp vm-overcommit test case fail reported
        by 0day test robot, by syncing the percpu-counter
	when changing policy to OVERCOMMIT_NEVER

  v5:
      * rebase after 5.8-rc1
      * remove the 3/4 patch in v4 which is merged in v5.7
      * add code comments for vm_memory_committed()

  v4:
    * Remove the VM_WARN_ONCE check for vm_committed_as underflow,
      thanks to Qian Cai for finding and testing the warning

  v3:
    * refine commit log and cleanup code, according to comments
      from Michal Hocko and Matthew Wilcox
    * change the lift from 16X and 64X after test 
  
  v2:
     * add the sysctl handler to cover runtime overcommit policy
       change, as suggested by Andres Morton 
     * address the accuracy concern of vm_memory_committed()
       from Andi Kleen 


*** BLURB HERE ***

Feng Tang (4):
  proc/meminfo: avoid open coded reading of vm_committed_as
  mm/util.c: make vm_memory_committed() more accurate
  percpu_counter: add percpu_counter_sync()
  mm: adjust vm_committed_as_batch according to vm overcommit policy

 fs/proc/meminfo.c              |  2 +-
 include/linux/mm.h             |  2 ++
 include/linux/mman.h           |  4 ++++
 include/linux/percpu_counter.h |  4 ++++
 kernel/sysctl.c                |  2 +-
 lib/percpu_counter.c           | 19 +++++++++++++++++
 mm/mm_init.c                   | 22 +++++++++++++------
 mm/util.c                      | 48 +++++++++++++++++++++++++++++++++++++++++-
 8 files changed, 94 insertions(+), 9 deletions(-)

-- 
2.7.4

