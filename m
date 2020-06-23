Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F05C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D07520C09
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592870992;
	bh=5NMjRuK6gvsvEYyIQaANOY2aNGclRQmhcrdEIQW/hxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=caZ2hIUh/9OIqbnvbIwju7RpnTg+MpmKtMqoG26oGJlntkRSoZChpgCLDSmSETVjg
	 4iPU/2jdjTDsYsAD+buEgf5JdvZJOQ9NxUeq+1sRQKifzFgcfgSSTY7oSjVfUMe4+T
	 AjDRQmsMD/qj0oNA8mpsVDslxGKaWyI5zUceBLyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbgFWAJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:09:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731410AbgFWAJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:09:50 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DFBF2076A;
        Tue, 23 Jun 2020 00:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592870989;
        bh=5NMjRuK6gvsvEYyIQaANOY2aNGclRQmhcrdEIQW/hxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sKmLMg+/GVQ+tjg849OL4yRSka7Lg1QxFF+aUHZDJfpkS4PzrG0BW8vJ0+L5Ydk6P
         QCsUHNOedVyBhLgSr15y+bXAm6igtGdoomUI74PL2Ds1gDpV1COUH+7ww7XRBS9rlp
         X0mGNGrfgznOaCtltzIDoAEq63LPXKrbhd68HFO8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/10] docs: RCU: Convert checklist.txt to ReST
Date:   Mon, 22 Jun 2020 17:09:38 -0700
Message-Id: <20200623000947.25222-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623000923.GA25047@paulmck-ThinkPad-P72>
References: <20200623000923.GA25047@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

- Add a SPDX header;
- Adjust document title;
- Some whitespace fixes and new line breaks;
- Use the right list markups;
- Add it to RCU/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/{checklist.txt => checklist.rst} | 17 ++++++++++++-----
 Documentation/RCU/index.rst                        |  3 +++
 2 files changed, 15 insertions(+), 5 deletions(-)
 rename Documentation/RCU/{checklist.txt => checklist.rst} (98%)

diff --git a/Documentation/RCU/checklist.txt b/Documentation/RCU/checklist.rst
similarity index 98%
rename from Documentation/RCU/checklist.txt
rename to Documentation/RCU/checklist.rst
index e98ff26..2efed99 100644
--- a/Documentation/RCU/checklist.txt
+++ b/Documentation/RCU/checklist.rst
@@ -1,4 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================================
 Review Checklist for RCU Patches
+================================
 
 
 This document contains a checklist for producing and reviewing patches
@@ -411,18 +415,21 @@ over a rather long period of time, but improvements are always welcome!
 	__rcu sparse checks to validate your RCU code.	These can help
 	find problems as follows:
 
-	CONFIG_PROVE_LOCKING: check that accesses to RCU-protected data
+	CONFIG_PROVE_LOCKING:
+		check that accesses to RCU-protected data
 		structures are carried out under the proper RCU
 		read-side critical section, while holding the right
 		combination of locks, or whatever other conditions
 		are appropriate.
 
-	CONFIG_DEBUG_OBJECTS_RCU_HEAD: check that you don't pass the
+	CONFIG_DEBUG_OBJECTS_RCU_HEAD:
+		check that you don't pass the
 		same object to call_rcu() (or friends) before an RCU
 		grace period has elapsed since the last time that you
 		passed that same object to call_rcu() (or friends).
 
-	__rcu sparse checks: tag the pointer to the RCU-protected data
+	__rcu sparse checks:
+		tag the pointer to the RCU-protected data
 		structure with __rcu, and sparse will warn you if you
 		access that pointer without the services of one of the
 		variants of rcu_dereference().
@@ -442,8 +449,8 @@ over a rather long period of time, but improvements are always welcome!
 
 	You instead need to use one of the barrier functions:
 
-	o	call_rcu() -> rcu_barrier()
-	o	call_srcu() -> srcu_barrier()
+	-	call_rcu() -> rcu_barrier()
+	-	call_srcu() -> srcu_barrier()
 
 	However, these barrier functions are absolutely -not- guaranteed
 	to wait for a grace period.  In fact, if there are no call_rcu()
diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 81a0a1e..c1ba4d1 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. _rcu_concepts:
 
 ============
@@ -8,6 +10,7 @@ RCU concepts
    :maxdepth: 3
 
    arrayRCU
+   checklist
    rcubarrier
    rcu_dereference
    whatisRCU
-- 
2.9.5

