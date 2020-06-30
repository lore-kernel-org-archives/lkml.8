Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6261DC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BC4520663
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbgF3VZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:25:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:43379 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgF3VZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:25:24 -0400
IronPort-SDR: W4jmBZsaFJek7h53pkFtktKbbTrkz3Ts+sSkUxw0yh/oxeqTYLnfyfSWVkxAw0dpJkB8bQgNbr
 x/tgQiM9X0Ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="134676811"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="134676811"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 14:25:22 -0700
IronPort-SDR: Jq1y5A9nKENqGDoolHFOIpXH6FkcStD5ep1PzSL/VKZhwU7v3oFN7FRcGsrAA8jPwjL69dTfbp
 LDOkJ0zO1IsA==
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="481336255"
Received: from schittin-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.132.42])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 14:25:22 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-mm <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ben Widawsky <ben.widawsky@intel.com>
Subject: [PATCH 02/12] mm/mempolicy: convert single preferred_node to full nodemask
Date:   Tue, 30 Jun 2020 14:25:07 -0700
Message-Id: <20200630212517.308045-3-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200630212517.308045-1-ben.widawsky@intel.com>
References: <20200630212517.308045-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

The NUMA APIs currently allow passing in a "preferred node" as a
single bit set in a nodemask.  If more than one bit it set, bits
after the first are ignored.  Internally, this is implemented as
a single integer: mempolicy->preferred_node.

This single node is generally OK for location-based NUMA where
memory being allocated will eventually be operated on by a single
CPU.  However, in systems with multiple memory types, folks want
to target a *type* of memory instead of a location.  For instance,
someone might want some high-bandwidth memory but do not care about
the CPU next to which it is allocated.  Or, they want a cheap,
high capacity allocation and want to target all NUMA nodes which
have persistent memory in volatile mode.  In both of these cases,
the application wants to target a *set* of nodes, but does not
want strict MPOL_BIND behavior as that could lead to OOM killer or
SIGSEGV.

To get that behavior, a MPOL_PREFERRED mode is desirable, but one
that honors multiple nodes to be set in the nodemask.

The first step in that direction is to be able to internally store
multiple preferred nodes, which is implemented in this patch.

This should not have any function changes and just switches the
internal representation of mempolicy->preferred_node from an
integer to a nodemask called 'mempolicy->preferred_nodes'.

This is not a pie-in-the-sky dream for an API.  This was a response to a
specific ask of more than one group at Intel.  Specifically:

1. There are existing libraries that target memory types such as
   https://github.com/memkind/memkind.  These are known to suffer
   from SIGSEGV's when memory is low on targeted memory "kinds" that
   span more than one node.  The MCDRAM on a Xeon Phi in "Cluster on
   Die" mode is an example of this.
2. Volatile-use persistent memory users want to have a memory policy
   which is targeted at either "cheap and slow" (PMEM) or "expensive and
   fast" (DRAM).  However, they do not want to experience allocation
   failures when the targeted type is unavailable.
3. Allocate-then-run.  Generally, we let the process scheduler decide
   on which physical CPU to run a task.  That location provides a
   default allocation policy, and memory availability is not generally
   considered when placing tasks.  For situations where memory is
   valuable and constrained, some users want to allocate memory first,
   *then* allocate close compute resources to the allocation.  This is
   the reverse of the normal (CPU) model.  Accelerators such as GPUs
   that operate on core-mm-managed memory are interested in this model.

v2:
Fix spelling errors in commit message. (Ben)
clang-format. (Ben)
Integrated bit from another patch. (Ben)
Update the docs to reflect the internal data structure change (Ben)
Don't advertise MPOL_PREFERRED_MANY in UAPI until we can handle it (Ben)
Added more to the commit message (Dave)

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Co-developed-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 .../admin-guide/mm/numa_memory_policy.rst     |  6 +--
 include/linux/mempolicy.h                     |  4 +-
 mm/mempolicy.c                                | 40 ++++++++++---------
 3 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index 067a90a1499c..1ad020c459b8 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -205,9 +205,9 @@ MPOL_PREFERRED
 	of increasing distance from the preferred node based on
 	information provided by the platform firmware.
 
-	Internally, the Preferred policy uses a single node--the
-	preferred_node member of struct mempolicy.  When the internal
-	mode flag MPOL_F_LOCAL is set, the preferred_node is ignored
+	Internally, the Preferred policy uses a nodemask--the
+	preferred_nodes member of struct mempolicy.  When the internal
+	mode flag MPOL_F_LOCAL is set, the preferred_nodes are ignored
 	and the policy is interpreted as local allocation.  "Local"
 	allocation policy can be viewed as a Preferred policy that
 	starts at the node containing the cpu where the allocation
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index ea9c15b60a96..c66ea9f4c61e 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -47,8 +47,8 @@ struct mempolicy {
 	unsigned short mode; 	/* See MPOL_* above */
 	unsigned short flags;	/* See set_mempolicy() MPOL_F_* above */
 	union {
-		short 		 preferred_node; /* preferred */
-		nodemask_t	 nodes;		/* interleave/bind */
+		nodemask_t preferred_nodes; /* preferred */
+		nodemask_t nodes; /* interleave/bind */
 		/* undefined for default */
 	} v;
 	union {
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index bde193278301..1098995f234d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -205,7 +205,7 @@ static int mpol_new_preferred(struct mempolicy *pol, const nodemask_t *nodes)
 	else if (nodes_empty(*nodes))
 		return -EINVAL;			/*  no allowed nodes */
 	else
-		pol->v.preferred_node = first_node(*nodes);
+		pol->v.preferred_nodes = nodemask_of_node(first_node(*nodes));
 	return 0;
 }
 
@@ -345,22 +345,26 @@ static void mpol_rebind_preferred(struct mempolicy *pol,
 						const nodemask_t *nodes)
 {
 	nodemask_t tmp;
+	nodemask_t preferred_node;
+
+	/* MPOL_PREFERRED uses only the first node in the mask */
+	preferred_node = nodemask_of_node(first_node(*nodes));
 
 	if (pol->flags & MPOL_F_STATIC_NODES) {
 		int node = first_node(pol->w.user_nodemask);
 
 		if (node_isset(node, *nodes)) {
-			pol->v.preferred_node = node;
+			pol->v.preferred_nodes = nodemask_of_node(node);
 			pol->flags &= ~MPOL_F_LOCAL;
 		} else
 			pol->flags |= MPOL_F_LOCAL;
 	} else if (pol->flags & MPOL_F_RELATIVE_NODES) {
 		mpol_relative_nodemask(&tmp, &pol->w.user_nodemask, nodes);
-		pol->v.preferred_node = first_node(tmp);
+		pol->v.preferred_nodes = tmp;
 	} else if (!(pol->flags & MPOL_F_LOCAL)) {
-		pol->v.preferred_node = node_remap(pol->v.preferred_node,
-						   pol->w.cpuset_mems_allowed,
-						   *nodes);
+		nodes_remap(tmp, pol->v.preferred_nodes,
+			    pol->w.cpuset_mems_allowed, preferred_node);
+		pol->v.preferred_nodes = tmp;
 		pol->w.cpuset_mems_allowed = *nodes;
 	}
 }
@@ -913,7 +917,7 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
 		break;
 	case MPOL_PREFERRED:
 		if (!(p->flags & MPOL_F_LOCAL))
-			node_set(p->v.preferred_node, *nodes);
+			*nodes = p->v.preferred_nodes;
 		/* else return empty node mask for local allocation */
 		break;
 	default:
@@ -1906,9 +1910,9 @@ static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
 static int policy_node(gfp_t gfp, struct mempolicy *policy,
 								int nd)
 {
-	if (policy->mode == MPOL_PREFERRED && !(policy->flags & MPOL_F_LOCAL))
-		nd = policy->v.preferred_node;
-	else {
+	if (policy->mode == MPOL_PREFERRED && !(policy->flags & MPOL_F_LOCAL)) {
+		nd = first_node(policy->v.preferred_nodes);
+	} else {
 		/*
 		 * __GFP_THISNODE shouldn't even be used with the bind policy
 		 * because we might easily break the expectation to stay on the
@@ -1953,7 +1957,7 @@ unsigned int mempolicy_slab_node(void)
 		/*
 		 * handled MPOL_F_LOCAL above
 		 */
-		return policy->v.preferred_node;
+		return first_node(policy->v.preferred_nodes);
 
 	case MPOL_INTERLEAVE:
 		return interleave_nodes(policy);
@@ -2087,7 +2091,7 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 		if (mempolicy->flags & MPOL_F_LOCAL)
 			nid = numa_node_id();
 		else
-			nid = mempolicy->v.preferred_node;
+			nid = first_node(mempolicy->v.preferred_nodes);
 		init_nodemask_of_node(mask, nid);
 		break;
 
@@ -2225,7 +2229,7 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		 * node in its nodemask, we allocate the standard way.
 		 */
 		if (pol->mode == MPOL_PREFERRED && !(pol->flags & MPOL_F_LOCAL))
-			hpage_node = pol->v.preferred_node;
+			hpage_node = first_node(pol->v.preferred_nodes);
 
 		nmask = policy_nodemask(gfp, pol);
 		if (!nmask || node_isset(hpage_node, *nmask)) {
@@ -2364,7 +2368,7 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 		/* a's ->flags is the same as b's */
 		if (a->flags & MPOL_F_LOCAL)
 			return true;
-		return a->v.preferred_node == b->v.preferred_node;
+		return nodes_equal(a->v.preferred_nodes, b->v.preferred_nodes);
 	default:
 		BUG();
 		return false;
@@ -2508,7 +2512,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 		if (pol->flags & MPOL_F_LOCAL)
 			polnid = numa_node_id();
 		else
-			polnid = pol->v.preferred_node;
+			polnid = first_node(pol->v.preferred_nodes);
 		break;
 
 	case MPOL_BIND:
@@ -2825,7 +2829,7 @@ void __init numa_policy_init(void)
 			.refcnt = ATOMIC_INIT(1),
 			.mode = MPOL_PREFERRED,
 			.flags = MPOL_F_MOF | MPOL_F_MORON,
-			.v = { .preferred_node = nid, },
+			.v = { .preferred_nodes = nodemask_of_node(nid), },
 		};
 	}
 
@@ -2991,7 +2995,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 	if (mode != MPOL_PREFERRED)
 		new->v.nodes = nodes;
 	else if (nodelist)
-		new->v.preferred_node = first_node(nodes);
+		new->v.preferred_nodes = nodemask_of_node(first_node(nodes));
 	else
 		new->flags |= MPOL_F_LOCAL;
 
@@ -3044,7 +3048,7 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 		if (flags & MPOL_F_LOCAL)
 			mode = MPOL_LOCAL;
 		else
-			node_set(pol->v.preferred_node, nodes);
+			nodes_or(nodes, nodes, pol->v.preferred_nodes);
 		break;
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
-- 
2.27.0

