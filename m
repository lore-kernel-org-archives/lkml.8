Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BA6C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97F0D21973
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgEGMCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:02:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:45016 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbgEGMCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:02:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7FD70ADC8;
        Thu,  7 May 2020 12:02:34 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] Documentation: update numastat explanation
Date:   Thu,  7 May 2020 14:02:17 +0200
Message-Id: <20200507120217.12313-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During recent patch discussion [1] it became apparent that the "other_node"
definition in the numastat documentation has always been different from actual
implementation. It was also noted that the stats can be innacurate on systems
with memoryless nodes.

This patch corrects the other_node definition (with minor tweaks to two more
definitions), adds a note about memoryless nodes and also two introductory
paragraphs to the numastat documentation.

[1] https://lore.kernel.org/linux-mm/20200504070304.127361-1-sandipan@linux.ibm.com/T/#u

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 Documentation/admin-guide/numastat.rst | 31 +++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/numastat.rst b/Documentation/admin-guide/numastat.rst
index aaf1667489f8..08ec2c2bdce3 100644
--- a/Documentation/admin-guide/numastat.rst
+++ b/Documentation/admin-guide/numastat.rst
@@ -6,6 +6,21 @@ Numa policy hit/miss statistics
 
 All units are pages. Hugepages have separate counters.
 
+The numa_hit, numa_miss and numa_foreign counters reflect how well processes
+are able to allocate memory from nodes they prefer. If they succeed, numa_hit
+is incremented on the preferred node, otherwise numa_foreign is incremented on
+the preferred node and numa_miss on the node where allocation succeeded.
+
+Usually preferred node is the one local to the CPU where the process executes,
+but restrictions such as mempolicies can change that, so there are also two
+counters based on CPU local node. local_node is similar to numa_hit and is
+incremented on allocation from a node by CPU on the same node. other_node is
+similar to numa_miss and is incremented on the node where allocation succeeds
+from a CPU from a different node. Note there is no counter analogical to
+numa_foreign.
+
+In more detail:
+
 =============== ============================================================
 numa_hit	A process wanted to allocate memory from this node,
 		and succeeded.
@@ -14,11 +29,13 @@ numa_miss	A process wanted to allocate memory from another node,
 		but ended up with memory from this node.
 
 numa_foreign	A process wanted to allocate on this node,
-		but ended up with memory from another one.
+		but ended up with memory from another node.
 
-local_node	A process ran on this node and got memory from it.
+local_node	A process ran on this node's CPU,
+		and got memory from this node.
 
-other_node	A process ran on this node and got memory from another node.
+other_node	A process ran on a different node's CPU
+		and got memory from this node.
 
 interleave_hit 	Interleaving wanted to allocate from this node
 		and succeeded.
@@ -28,3 +45,11 @@ For easier reading you can use the numastat utility from the numactl package
 (http://oss.sgi.com/projects/libnuma/). Note that it only works
 well right now on machines with a small number of CPUs.
 
+Note that on systems with memoryless nodes (where a node has CPUs but no
+memory) the numa_hit, numa_miss and numa_foreign statistics can be skewed
+heavily. In the current kernel implementation, if a process prefers a
+memoryless node (i.e.  because it is running on one of its local CPU), the
+implementation actually treats one of the nearest nodes with memory as the
+preferred node. As a result, such allocation will not increase the numa_foreign
+counter on the memoryless node, and will skew the numa_hit, numa_miss and
+numa_foreign statistics of the nearest node.
-- 
2.26.2

