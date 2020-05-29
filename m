Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF235C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 01:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1CA92078C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 01:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438295AbgE2BGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 21:06:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:2370 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438285AbgE2BGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 21:06:16 -0400
IronPort-SDR: goOj8Ke11zyTp+qK9Idgp/Q/81H1Wr3JRie4qIhl/TgX0483SQwtlqDy0ZItbN15hDbl5ioURV
 RJ/GktlEdC8w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 18:06:15 -0700
IronPort-SDR: wPLApbd6DYzMK/8MiFOPglf1AET+b5PdtqE5iRh/WyKy8aUWq5Ba752pxttb0WOuLgfYHgZjg+
 PBN1722ZgSrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,446,1583222400"; 
   d="scan'208";a="443187384"
Received: from shbuild999.sh.intel.com ([10.239.146.107])
  by orsmga005.jf.intel.com with ESMTP; 28 May 2020 18:06:11 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>, Qian Cai <cai@lca.pw>,
        andi.kleen@intel.com, tim.c.chen@intel.com, dave.hansen@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [PATCH v4 0/4] make vm_committed_as_batch aware of vm overcommit policy  
Date:   Fri, 29 May 2020 09:06:06 +0800
Message-Id: <1590714370-67182-1-git-send-email-feng.tang@intel.com>
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

Note: There are some style complain from checkpatch for patch 3,
as sysctl handler declaration follows the similar format of sibling
functions

patch1: a cleanup for /proc/meminfo
patch2: a preparation patch which also improve the accuracy of
        vm_memory_committed
patch3: remove the VM_WARN_ONCE for vm_committed_as underflow check
patch4: main change

This is against today's linux-mm git tree on github.

Please help to review, thanks!

- Feng

----------------------------------------------------------------
Changelog:

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


Feng Tang (4):
  proc/meminfo: avoid open coded reading of vm_committed_as
  mm/util.c: make vm_memory_committed() more accurate
  mm/util.c: remove the VM_WARN_ONCE for vm_committed_as underflow check
  mm: adjust vm_committed_as_batch according to vm overcommit policy

 fs/proc/meminfo.c    |  2 +-
 include/linux/mm.h   |  2 ++
 include/linux/mman.h |  4 ++++
 kernel/sysctl.c      |  2 +-
 mm/mm_init.c         | 18 ++++++++++++++----
 mm/util.c            | 22 +++++++++++++---------
 6 files changed, 35 insertions(+), 15 deletions(-)

-- 
2.7.4

