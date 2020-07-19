Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D92C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 15:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE6AD22B51
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 15:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595173009;
	bh=94o7D2F4FGd2DEm55n4Eh6xXaFTpqGHFhCaS0GvT7+k=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FvepF/dFXlmFnF9xEUBLJi6EK2YskJ173tsd7hajuQ/erBh5U+X5J200M5SboXcKb
	 SA/UHNH5VsG5XOBBes1nWQhk9deFCPU8o+VhQSnWXlHc2T2NluZdVzDtKDV8HZb9In
	 iME94Lr11vuk+1E3ZK3JT9dTviJOMHlcNhcwgDXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgGSPgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 11:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgGSPgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 11:36:48 -0400
Received: from hump.s81c.com (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70F0E21775;
        Sun, 19 Jul 2020 15:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595173007;
        bh=94o7D2F4FGd2DEm55n4Eh6xXaFTpqGHFhCaS0GvT7+k=;
        h=From:To:Cc:Subject:Date:From;
        b=x42bk9SO17uErV6rvAyn9wzr+muvjQ4tZ5zhytPg/dPvQ2eZ1g0ldpA6ytCQ1MOdd
         o6nXQsCnHHo3K2OBTCOeVb80mp6yiaO3846atUg6ImHGKXCdUQczWTSP26PDAINrrL
         LPkWlmHylT39Fp9UzhjVXpUnPnGLnoqNvadrTxbc=
From:   Mike Rapoport <rppt@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH RESEND] docs/core-api: memory-allocation: describe reclaim behaviour
Date:   Sun, 19 Jul 2020 18:36:41 +0300
Message-Id: <20200719153641.231131-1-rppt@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Changelog of commit dcda9b04713c ("mm, tree wide: replace __GFP_REPEAT by
__GFP_RETRY_MAYFAIL with more useful semantic") has very nice description
of GFP flags that affect reclaim behaviour of the page allocator.

It would be pity to keep this description buried in the log so let's expose
it in the Documentation/ as well.

Cc: Michal Hocko <mhocko@suse.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 Documentation/core-api/memory-allocation.rst | 44 ++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/core-api/memory-allocation.rst b/Documentation/core-api/memory-allocation.rst
index 4aa82ddd01b8..4446a1ac36cc 100644
--- a/Documentation/core-api/memory-allocation.rst
+++ b/Documentation/core-api/memory-allocation.rst
@@ -84,6 +84,50 @@ driver for a device with such restrictions, avoid using these flags.
 And even with hardware with restrictions it is preferable to use
 `dma_alloc*` APIs.
 
+GFP flags and reclaim behavior
+------------------------------
+Memory allocations may trigger direct or background reclaim and it is
+useful to understand how hard the page allocator will try to satisfy that
+or another request.
+
+  * ``GFP_KERNEL & ~__GFP_RECLAIM`` - optimistic allocation without _any_
+    attempt to free memory at all. The most light weight mode which even
+    doesn't kick the background reclaim. Should be used carefully because it
+    might deplete the memory and the next user might hit the more aggressive
+    reclaim.
+
+  * ``GFP_KERNEL & ~__GFP_DIRECT_RECLAIM`` (or ``GFP_NOWAIT``)- optimistic
+    allocation without any attempt to free memory from the current
+    context but can wake kswapd to reclaim memory if the zone is below
+    the low watermark. Can be used from either atomic contexts or when
+    the request is a performance optimization and there is another
+    fallback for a slow path.
+
+  * ``(GFP_KERNEL|__GFP_HIGH) & ~__GFP_DIRECT_RECLAIM`` (aka ``GFP_ATOMIC``) -
+    non sleeping allocation with an expensive fallback so it can access
+    some portion of memory reserves. Usually used from interrupt/bottom-half
+    context with an expensive slow path fallback.
+
+  * ``GFP_KERNEL`` - both background and direct reclaim are allowed and the
+    **default** page allocator behavior is used. That means that not costly
+    allocation requests are basically no-fail but there is no guarantee of
+    that behavior so failures have to be checked properly by callers
+    (e.g. OOM killer victim is allowed to fail currently).
+
+  * ``GFP_KERNEL | __GFP_NORETRY`` - overrides the default allocator behavior
+    and all allocation requests fail early rather than cause disruptive
+    reclaim (one round of reclaim in this implementation). The OOM killer
+    is not invoked.
+
+  * ``GFP_KERNEL | __GFP_RETRY_MAYFAIL`` - overrides the default allocator
+    behavior and all allocation requests try really hard. The request
+    will fail if the reclaim cannot make any progress. The OOM killer
+    won't be triggered.
+
+  * ``GFP_KERNEL | __GFP_NOFAIL`` - overrides the default allocator behavior
+    and all allocation requests will loop endlessly until they succeed.
+    This might be really dangerous especially for larger orders.
+
 Selecting memory allocator
 ==========================
 
-- 
2.25.4

