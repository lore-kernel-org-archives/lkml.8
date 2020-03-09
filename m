Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C43AC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D81422522
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583780698;
	bh=lN4qH4vNqp5l/bIWdFMvNUi0fzMnmVZ3kmiGvIPNwKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WwW9cRzvDnMUZkGomSydpzIF7rSYVBsm+beSS/awaOeDtz2r6IVNLOHImfB5xt8TL
	 sfEx61hZottr12XqbxzXpbr4+1E9wbO8P3oI3Z/edPhFKGG7g8L9bHPxCXFgTkBVXj
	 AqAKQV2FcXniVthNoClR7ZmwLiAEDVpQOIwRBe+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgCITE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:04:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbgCITEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:04:30 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E5B12253D;
        Mon,  9 Mar 2020 19:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583780669;
        bh=lN4qH4vNqp5l/bIWdFMvNUi0fzMnmVZ3kmiGvIPNwKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y+8lvuqD9vbywzy49g0b2DZ7Fg94o5dFB+XQSwfK2CZfHsMvyuUdBsVN2KzkjxM6U
         MQaIJdCRb6klsTU0HDepLTQDACAXwhM6rccc3G+rNKtE+W9BmBHAOAAgN1xi5PeizI
         QlNiohXmiCXvuoZdIQ4GJ/9KYclaxObGSY+H/a0I=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        Qiujun Huang <hqjagain@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 30/32] kcsan: Fix a typo in a comment
Date:   Mon,  9 Mar 2020 12:04:18 -0700
Message-Id: <20200309190420.6100-30-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200309190359.GA5822@paulmck-ThinkPad-P72>
References: <20200309190359.GA5822@paulmck-ThinkPad-P72>
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

