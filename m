Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387BCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA4C20706
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592873022;
	bh=wBAiO7bXcA3ok+x3Llo09qQpqbRCMVAmyrQ2t28M81M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sm7ZBSxmjwLl5wIvE73yQNcuDuhb2IPNJF8Z2UZ5I8U5naT9CbXzG5Y/Q4nLap0e8
	 Mjb9mWiXsSP9gXuco1vmbondKmyC76HC93Pp3MY0Nh1Jq+UjEjWT+3wntdmnnypwqh
	 ZipF1rURj3MeOJH7ZCaSmcv7YjpQuCS2bUKdxXZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbgFWAnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:43:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732171AbgFWAng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:43:36 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D099207DD;
        Tue, 23 Jun 2020 00:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592873016;
        bh=wBAiO7bXcA3ok+x3Llo09qQpqbRCMVAmyrQ2t28M81M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q5W+mGocvExqYAxhu7egXZBjSKdhT0Hl5thzACKyowwLGIb+Ef7fsvD5D1REoJ8sO
         XG42WGmbBh4bd95bUvxZCqqClYyWGHSzMbTkNXb96A8UVyFWmcOVctqTJNwUhMZbqS
         FCdLTweQSJABAqz8iWoUdNxMnZc4QRRZ+QiDayts=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/10] kcsan: Prefer '__no_kcsan inline' in test
Date:   Mon, 22 Jun 2020 17:43:29 -0700
Message-Id: <20200623004333.27227-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Instead of __no_kcsan_or_inline, prefer '__no_kcsan inline' in test --
this is in case we decide to remove __no_kcsan_or_inline.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/kcsan-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kcsan/kcsan-test.c b/kernel/kcsan/kcsan-test.c
index a8c1150..3af420a 100644
--- a/kernel/kcsan/kcsan-test.c
+++ b/kernel/kcsan/kcsan-test.c
@@ -43,7 +43,7 @@ static struct {
 };
 
 /* Setup test checking loop. */
-static __no_kcsan_or_inline void
+static __no_kcsan inline void
 begin_test_checks(void (*func1)(void), void (*func2)(void))
 {
 	kcsan_disable_current();
@@ -60,7 +60,7 @@ begin_test_checks(void (*func1)(void), void (*func2)(void))
 }
 
 /* End test checking loop. */
-static __no_kcsan_or_inline bool
+static __no_kcsan inline bool
 end_test_checks(bool stop)
 {
 	if (!stop && time_before(jiffies, end_time)) {
-- 
2.9.5

