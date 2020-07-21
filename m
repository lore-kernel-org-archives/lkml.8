Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5BAC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF0532077D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vXrgbBZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgGUKap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgGUKai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:30:38 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81662C0619D9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 03:30:38 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id w15so2094570qti.21
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 03:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vVlSyEcdwOQNKSx6Cnzx1nFD8CBubHuBwhuu4avdOuU=;
        b=vXrgbBZMeSjvDTESYkIbwmgjhHej1P9NPmtoI0jh82pgDLABLiJRVX4pp9/coI4VJR
         3OMaP53Sv9UFXLEOuyFlQ6LVm/IjXFe4BMvCzcgjNy/cDGZAfG4IYUrch2FwpM/va84U
         ZpbW3fDwwIPzU7/jN4c+KatCCX0HNHvXo48p7z9qckD7p8LscgFUMNf5iej+xYoar1h7
         mtB3W8wrurFcIwNEq703YUbX3QPhQzjMVB15yuF+fxwz3JFjvQ+48BeZDSMwTa1+2pos
         W2/Z1ShXiVoiRd78daIZJfsCNNYhNc+Whbprbm83B8mkONow9+d2FxLOF5l602RByaqu
         8R0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vVlSyEcdwOQNKSx6Cnzx1nFD8CBubHuBwhuu4avdOuU=;
        b=TEJYVGNer7PMurYtEBXVqG+MZm7lX79hRIJpr+MUhfm9ATy9lHomxpxdzE+N6h8xio
         CjArAPO3w5b/XCFXTpEYP53yfcm6rmsQy8AYk9CvtPv2gtxRz+5E4Zq+sOCLwLvYO08I
         G1g/sovdpKxCGWk/7I/ELTunZ8j7OtCIuo2leeBcDNC0mDgkdiLZI5IaZ9mdOmuHggDV
         hpn6664/C6mt3b7wYbouNIu4/bAnh3QaJmvlxyMq3w4U+RYFl//1lxzVXYL2QiCs8QP5
         oA7aL7K3gAQWXsr9pURhifFV5B3OQjpqRozLApEZYv2NXKYdtsHjmsNvaO2oSWFLO4PY
         HFrA==
X-Gm-Message-State: AOAM533o7rNGiSKTrIX4PVZYNoegiQeq46JFGjSGwZYch3Mo5EuTWBft
        BjRyTDsvVKO8BDwVW4Ai9B0HumRtew==
X-Google-Smtp-Source: ABdhPJw9AZJ6/Sq8gRuvn69c50PCI7j/zYVvTftn2YQFr3SnFEinKaitleRuJAZKsRV6Dc9/Ltu56y9PYg==
X-Received: by 2002:a0c:b48e:: with SMTP id c14mr26052857qve.47.1595327437707;
 Tue, 21 Jul 2020 03:30:37 -0700 (PDT)
Date:   Tue, 21 Jul 2020 12:30:11 +0200
In-Reply-To: <20200721103016.3287832-1-elver@google.com>
Message-Id: <20200721103016.3287832-4-elver@google.com>
Mime-Version: 1.0
References: <20200721103016.3287832-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 3/8] kcsan: Skew delay to be longer for certain access types
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     will@kernel.org, peterz@infradead.org, arnd@arndb.de,
        mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For compound instrumentation and assert accesses, skew the watchpoint
delay to be longer. We still shouldn't exceed the maximum delays, but it
is safe to skew the delay for these accesses.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index fb52de2facf3..4633baebf84e 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -283,11 +283,15 @@ static __always_inline bool kcsan_is_enabled(void)
 	return READ_ONCE(kcsan_enabled) && get_ctx()->disable_count == 0;
 }
 
-static inline unsigned int get_delay(void)
+static inline unsigned int get_delay(int type)
 {
 	unsigned int delay = in_task() ? kcsan_udelay_task : kcsan_udelay_interrupt;
+	/* For certain access types, skew the random delay to be longer. */
+	unsigned int skew_delay_order =
+		(type & (KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_ASSERT)) ? 1 : 0;
+
 	return delay - (IS_ENABLED(CONFIG_KCSAN_DELAY_RANDOMIZE) ?
-				prandom_u32_max(delay) :
+				prandom_u32_max(delay >> skew_delay_order) :
 				0);
 }
 
@@ -449,7 +453,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 * Delay this thread, to increase probability of observing a racy
 	 * conflicting access.
 	 */
-	udelay(get_delay());
+	udelay(get_delay(type));
 
 	/*
 	 * Re-read value, and check if it is as expected; if not, we infer a
-- 
2.28.0.rc0.105.gf9edc3c819-goog

