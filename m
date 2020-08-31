Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AACC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27E1220E65
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598898007;
	bh=/nk8YeCMjNJjnS7CPKyiXGuR1+ViXtq3As9PVWEq2iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zjLGuLnge+14Wpwz/ubpY43Zm3bShl+Z44H5rm4i6vClcPSP1z6PxngeJBTg84A2k
	 uGSw39vH8fLcH/PjHUbJiHdZbI29S5jySxMaQhBqyuII3mpCeZxXuaAdgTxoR7xUXl
	 DrdorvpvTR1TYL3ZI4m6rTbf3mGAwm7Vyl+DM97k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgHaST5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:19:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729508AbgHaSSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:18:08 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92A81216C4;
        Mon, 31 Aug 2020 18:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897888;
        bh=/nk8YeCMjNJjnS7CPKyiXGuR1+ViXtq3As9PVWEq2iA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nJhWq4AE2njLfb8NxwnF6sJXDxwmbVo20kr1BMrtvAMY3yIM1cTRe4VECRo8rpOIj
         7JxKammAUU7qA2pyK39nzLzMcMwDpfRBN+I48tmdr9/tfpU/HLjHBArBWwrwfYUgpv
         D4Q92aEhyYStAAuZfi2Ve87TxQmSFsyCIv4e5Nis=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 15/19] kcsan: Show message if enabled early
Date:   Mon, 31 Aug 2020 11:18:01 -0700
Message-Id: <20200831181805.1833-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181715.GA1530@paulmck-ThinkPad-P72>
References: <20200831181715.GA1530@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Show a message in the kernel log if KCSAN was enabled early.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 99e5044..b176400 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#define pr_fmt(fmt) "kcsan: " fmt
+
 #include <linux/atomic.h>
 #include <linux/bug.h>
 #include <linux/delay.h>
@@ -463,7 +465,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 
 	if (IS_ENABLED(CONFIG_KCSAN_DEBUG)) {
 		kcsan_disable_current();
-		pr_err("KCSAN: watching %s, size: %zu, addr: %px [slot: %d, encoded: %lx]\n",
+		pr_err("watching %s, size: %zu, addr: %px [slot: %d, encoded: %lx]\n",
 		       is_write ? "write" : "read", size, ptr,
 		       watchpoint_slot((unsigned long)ptr),
 		       encode_watchpoint((unsigned long)ptr, size, is_write));
@@ -623,8 +625,10 @@ void __init kcsan_init(void)
 	 * We are in the init task, and no other tasks should be running;
 	 * WRITE_ONCE without memory barrier is sufficient.
 	 */
-	if (kcsan_early_enable)
+	if (kcsan_early_enable) {
+		pr_info("enabled early\n");
 		WRITE_ONCE(kcsan_enabled, true);
+	}
 }
 
 /* === Exported interface =================================================== */
-- 
2.9.5

