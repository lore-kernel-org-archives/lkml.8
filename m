Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5087C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E2DF2065D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbgF3VZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:25:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:43377 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgF3VZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:25:22 -0400
IronPort-SDR: scSEToNKF/P2RDY2Jubk+jC0OeBE/cSfMyU7civbMfNfxI0zXesHqcMxujQoUTX0717folzSnF
 EhBCimRmfLcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="134676809"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="134676809"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 14:25:21 -0700
IronPort-SDR: 0Dm7H4ot46cFuHqYGR1zawviMVBVZ6zULCwfW/37YAiNCyvgOB21iihkeWg2qne9LL4zO5dY6y
 +0Tmf1IM+tRg==
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="481336247"
Received: from schittin-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.132.42])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 14:25:20 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-mm <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 00/12] Introduced multi-preference mempolicy
Date:   Tue, 30 Jun 2020 14:25:05 -0700
Message-Id: <20200630212517.308045-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Significant changes since v1:
* Dropped patch to replace numa_node_id in some places (mhocko)
* Dropped all the page allocation patches in favor of new mechanism to use
  fallbacks. (mhocko)
* Dropped the special snowflake preferred node algorithm (bwidawsk)
* If the preferred node fails, ALL nodes are rechecked instead of just the
  non-preferred nodes.

In v1, Andi Kleen brought up reusing MPOL_PREFERRED as the mode for the API.
There wasn't consensus around this, so I've left the existing API as it was. I'm
open to more feedback here, but my slight preference is to use a new API as it
ensures if people are using it, they are entirely aware of what they're doing
and not accidentally misusing the old interface. (In a similar way to how
MPOL_LOCAL was introduced).

In v1, Michal also brought up renaming this MPOL_PREFERRED_MASK. I'm equally
fine with that change, but I hadn't heard much emphatic support for one way or
another, so I've left that too.

v2 Summary:
1: Random fix I found along the way
2-5: Represent node preference as a mask internally
6-7: Tread many preferred like bind
8-11: Handle page allocation for the new policy
12: Enable the uapi

This patch series introduces the concept of the MPOL_PREFERRED_MANY mempolicy.
This mempolicy mode can be used with either the set_mempolicy(2) or mbind(2)
interfaces. Like the MPOL_PREFERRED interface, it allows an application to set a
preference for nodes which will fulfil memory allocation requests. Unlike the
MPOL_PREFERRED mode, it takes a set of nodes. Like the MPOL_BIND interface, it
works over a set of nodes. Unlike MPOL_BIND, it will not cause a SIGSEGV or
invoke the OOM killer if those preferred nodes are not available.

Along with these patches are patches for libnuma, numactl, numademo, and memhog.
They still need some polish, but can be found here:
https://gitlab.com/bwidawsk/numactl/-/tree/prefer-many
It allows new usage: `numactl -P 0,3,4`

The goal of the new mode is to enable some use-cases when using tiered memory
usage models which I've lovingly named.
1a. The Hare - The interconnect is fast enough to meet bandwidth and latency
requirements allowing preference to be given to all nodes with "fast" memory.
1b. The Indiscriminate Hare - An application knows it wants fast memory (or
perhaps slow memory), but doesn't care which node it runs on. The application
can prefer a set of nodes and then xpu bind to the local node (cpu, accelerator,
etc). This reverses the nodes are chosen today where the kernel attempts to use
local memory to the CPU whenever possible. This will attempt to use the local
accelerator to the memory.
2. The Tortoise - The administrator (or the application itself) is aware it only
needs slow memory, and so can prefer that.

Much of this is almost achievable with the bind interface, but the bind
interface suffers from an inability to fallback to another set of nodes if
binding fails to all nodes in the nodemask.

Like MPOL_BIND a nodemask is given. Inherently this removes ordering from the
preference.

> /* Set first two nodes as preferred in an 8 node system. */
> const unsigned long nodes = 0x3
> set_mempolicy(MPOL_PREFER_MANY, &nodes, 8);

> /* Mimic interleave policy, but have fallback *.
> const unsigned long nodes = 0xaa
> set_mempolicy(MPOL_PREFER_MANY, &nodes, 8);

Some internal discussion took place around the interface. There are two
alternatives which we have discussed, plus one I stuck in:
1. Ordered list of nodes. Currently it's believed that the added complexity is
   nod needed for expected usecases.
2. A flag for bind to allow falling back to other nodes. This confuses the
   notion of binding and is less flexible than the current solution.
3. Create flags or new modes that helps with some ordering. This offers both a
   friendlier API as well as a solution for more customized usage. It's unknown
   if it's worth the complexity to support this. Here is sample code for how
   this might work:

> // Prefer specific nodes for some something wacky
> set_mempolicy(MPOL_PREFER_MANY, 0x17c, 1024);
>
> // Default
> set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_SOCKET, NULL, 0);
> // which is the same as
> set_mempolicy(MPOL_DEFAULT, NULL, 0);
>
> // The Hare
> set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_TYPE, NULL, 0);
>
> // The Tortoise
> set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_TYPE_REV, NULL, 0);
>
> // Prefer the fast memory of the first two sockets
> set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_TYPE, -1, 2);
>

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>


Ben Widawsky (8):
  mm/mempolicy: Add comment for missing LOCAL
  mm/mempolicy: kill v.preferred_nodes
  mm/mempolicy: handle MPOL_PREFERRED_MANY like BIND
  mm/mempolicy: Create a page allocator for policy
  mm/mempolicy: Thread allocation for many preferred
  mm/mempolicy: VMA allocation for many preferred
  mm/mempolicy: huge-page allocation for many preferred
  mm/mempolicy: Advertise new MPOL_PREFERRED_MANY

Dave Hansen (4):
  mm/mempolicy: convert single preferred_node to full nodemask
  mm/mempolicy: Add MPOL_PREFERRED_MANY for multiple preferred nodes
  mm/mempolicy: allow preferred code to take a nodemask
  mm/mempolicy: refactor rebind code for PREFERRED_MANY

 .../admin-guide/mm/numa_memory_policy.rst     |  22 +-
 include/linux/mempolicy.h                     |   6 +-
 include/uapi/linux/mempolicy.h                |   6 +-
 mm/hugetlb.c                                  |  20 +-
 mm/mempolicy.c                                | 273 ++++++++++++------
 5 files changed, 222 insertions(+), 105 deletions(-)

-- 
2.27.0

