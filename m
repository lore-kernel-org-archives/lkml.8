Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390DBC3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D34E20784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586977607;
	bh=lN4qH4vNqp5l/bIWdFMvNUi0fzMnmVZ3kmiGvIPNwKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mHd5u5beKc/jZk2XeunbLhkYw/Hrhfl2+gwkwkRbFW9ULxdQmTSzEPeV5Q3lI+L0R
	 ZsOD/cKroe1Mc54ZKSC8eHoUUqd7oLjQv1La0iIqiXVjboBw2GltgeEyG6IB57vYA0
	 s+J6/ku+2w4c3KhXYSX5eAE+x7xUVdIw3kOOBo2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389474AbgDOTGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:06:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416812AbgDOSeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:34:14 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1ADC2168B;
        Wed, 15 Apr 2020 18:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586975654;
        bh=lN4qH4vNqp5l/bIWdFMvNUi0fzMnmVZ3kmiGvIPNwKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZzPgZgiX2cyx6hZpOLPg8tbuO0xuGXjZuk1Fqp7lp615PIsRt7pnJ8XyvNxlPGl0h
         Awz5CUhXLOuUVhBrmEXDi+e/MuxrFJnnBhjc9dMizbmobcpMwvp7kY4oeynxUDkwW/
         GH1l2M7O2Uz/71rwPMTdUC9P2eUvEXqqu5Vj2/jE=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        Qiujun Huang <hqjagain@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 04/15] kcsan: Fix a typo in a comment
Date:   Wed, 15 Apr 2020 11:34:00 -0700
Message-Id: <20200415183411.12368-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415183343.GA12265@paulmck-ThinkPad-P72>
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

s/slots slots/slots/

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
[elver: commit message]
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index eb30ecd..ee82008 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -45,7 +45,7 @@ static DEFINE_PER_CPU(struct kcsan_ctx, kcsan_cpu_ctx) = {
 };
 
 /*
- * Helper macros to index into adjacent slots slots, starting from address slot
+ * Helper macros to index into adjacent slots, starting from address slot
  * itself, followed by the right and left slots.
  *
  * The purpose is 2-fold:
-- 
2.9.5

