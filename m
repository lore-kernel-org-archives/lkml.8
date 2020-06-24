Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD22C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE9020836
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593025396;
	bh=dAQJRRuIZ238Q6iprvv0e5hEIUYrGp3iDUCMfcYdrkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rP+sEDLzwGZR8X6kMantRlXhhFftmwrdQ0MjodpgPALHamyWiPReVfXrGl0Xh4PAh
	 36DtT1tgzd7xt267oA1/A1qD5fNSaJ1vXgXN3VgsvEUghzMRJunjX/fJPAetsEq7yI
	 0w5LbDmst2jRVFExzanb6/OdonkGG4te8XlRni6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404915AbgFXTDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:03:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404725AbgFXTDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 15:03:10 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CACD920885;
        Wed, 24 Jun 2020 19:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593025389;
        bh=dAQJRRuIZ238Q6iprvv0e5hEIUYrGp3iDUCMfcYdrkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fpCeZNxC7d1NbUykBCaqhZuqag+I3eJPI9sNQuX1tBtVMafdLfh90sb0u6KAW3M6y
         RMnnBlF2JiqCrw9hpzdPl/hilp4XjTLbeuh2hIwtnn7ewaC11uoK7M0cC+DzwUPXuQ
         Zg75vHz8FIhg/v4fN8qIByyq238Jvu8wcHEUPt/w=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 2/3] kcsan: Simplify compiler flags
Date:   Wed, 24 Jun 2020 12:03:06 -0700
Message-Id: <20200624190307.15191-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200624190236.GA6603@paulmck-ThinkPad-P72>
References: <20200624190236.GA6603@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Simplify the set of compiler flags for the runtime by removing cc-option
from -fno-stack-protector, because all supported compilers support it.
This saves us one compiler invocation during build.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
index 092ce58..fea064a 100644
--- a/kernel/kcsan/Makefile
+++ b/kernel/kcsan/Makefile
@@ -7,8 +7,8 @@ CFLAGS_REMOVE_core.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_debugfs.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
 
-CFLAGS_core.o := $(call cc-option,-fno-conserve-stack,) \
-	$(call cc-option,-fno-stack-protector,)
+CFLAGS_core.o := $(call cc-option,-fno-conserve-stack) \
+	-fno-stack-protector
 
 obj-y := core.o debugfs.o report.o
 obj-$(CONFIG_KCSAN_SELFTEST) += selftest.o
-- 
2.9.5

