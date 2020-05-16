Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34904C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 06:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D9122065C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 06:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgEPGrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 02:47:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:41251 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgEPGro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 02:47:44 -0400
IronPort-SDR: mXMbkJFZWSbaeNQxTO8s4DCcfQ0l0+Fbmoysl++7nAZvd30Nam3jaBPsda8Xe7j9E/e3Td3wP1
 T7BkAQ3usLDg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 23:47:44 -0700
IronPort-SDR: 4mIIABA26zylbkkwoCiiMNX7ixGCSArWEWULx0/ShWNRQWleiQuk1oghQxLFw7xONW0+w04E55
 AV/fIpwuG5kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,398,1583222400"; 
   d="scan'208";a="464984919"
Received: from shbuild999.sh.intel.com ([10.239.146.107])
  by fmsmga005.fm.intel.com with ESMTP; 15 May 2020 23:47:41 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [PATCH v3 0/3] make vm_committed_as_batch aware of vm overcommit policy  
Date:   Sat, 16 May 2020 14:47:37 +0800
Message-Id: <1589611660-89854-1-git-send-email-feng.tang@intel.com>
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
patch3: the main change

Please help to review, thanks!

- Feng

----------------------------------------------------------------
Changelog:
  v3:
    * refine commit log and cleanup code, according to comments
      from Michal Hocko and Matthew Wilcox
    * change the lift from 16X and 64X after test 
  
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
 mm/mm_init.c         | 18 ++++++++++++++----
 mm/util.c            | 15 ++++++++++++++-
 6 files changed, 36 insertions(+), 7 deletions(-)

-- 
2.7.4

