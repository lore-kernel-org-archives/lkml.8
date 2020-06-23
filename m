Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88861C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE9520706
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592873049;
	bh=lGmSWTDYJ686eqTsUf6IQ+UIbdDX/hPH49r+VAEJY0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=enDIFThB7V7iDGSfKJBBSxetank/uZY8oCmphbLMrNK5s82kzwJ1QrJfPA/ory9kv
	 7lvYymMqN3HRH7ZkcN9Yp9xTfxkGztakJWr+HoaDJWS/aAO3py8MfoZy9vCD8TIJ8l
	 mZo0lP9WSyfsxyKDGhEzEWw74NHJjSnzfh35WLk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732296AbgFWAoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:44:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732187AbgFWAng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:43:36 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A159208B8;
        Tue, 23 Jun 2020 00:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592873016;
        bh=lGmSWTDYJ686eqTsUf6IQ+UIbdDX/hPH49r+VAEJY0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zS5iaK9LxoOSu+9qIjN3Lmh+9mMhX9wexUTccFbM857fYxeOG3UyegGhdZXELel9r
         bkhVrVvHB/Uj6tY4Z68FPirHAn8JylDHPcv6fxAkZVRznBJuqAwLdyRdwROi5SoNsI
         +eLW/zH/0S+SC1I5oMESLtsiKopmHPMAivOFdPE8=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/10] kcsan: Rename test.c to selftest.c
Date:   Mon, 22 Jun 2020 17:43:31 -0700
Message-Id: <20200623004333.27227-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Rename 'test.c' to 'selftest.c' to better reflect its purpose (Kconfig
variable and code inside already match this). This is to avoid confusion
with the test suite module in 'kcsan-test.c'.

No functional change.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/Makefile               | 2 +-
 kernel/kcsan/{test.c => selftest.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename kernel/kcsan/{test.c => selftest.c} (100%)

diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
index 14533cf..092ce58 100644
--- a/kernel/kcsan/Makefile
+++ b/kernel/kcsan/Makefile
@@ -11,7 +11,7 @@ CFLAGS_core.o := $(call cc-option,-fno-conserve-stack,) \
 	$(call cc-option,-fno-stack-protector,)
 
 obj-y := core.o debugfs.o report.o
-obj-$(CONFIG_KCSAN_SELFTEST) += test.o
+obj-$(CONFIG_KCSAN_SELFTEST) += selftest.o
 
 CFLAGS_kcsan-test.o := $(CFLAGS_KCSAN) -g -fno-omit-frame-pointer
 obj-$(CONFIG_KCSAN_TEST) += kcsan-test.o
diff --git a/kernel/kcsan/test.c b/kernel/kcsan/selftest.c
similarity index 100%
rename from kernel/kcsan/test.c
rename to kernel/kcsan/selftest.c
-- 
2.9.5

