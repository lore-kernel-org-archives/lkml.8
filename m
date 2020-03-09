Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2B5C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D212215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583780676;
	bh=i+1jmjTjWHxCmraBO7UxjK4l0oHxOIm/j4QSytAN0iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XrEVRdTGFZdknNWbfbOMurZ5Vs/FmaaRFByjxwDYT0sUYdHtHAwdJR/W8+Yx4Qjyk
	 CmZU8Ys2S6hOHXqigoyNsDLl2yeLTeOLSj46IMrx02t0lNLnI7eWuKOCtnbcUeujdg
	 MpxN54fBFuwVVtPOvYL/5nbonJ1tziwo7ZZ6OM1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgCITEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:04:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727621AbgCITE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:04:28 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92FA72467F;
        Mon,  9 Mar 2020 19:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583780667;
        bh=i+1jmjTjWHxCmraBO7UxjK4l0oHxOIm/j4QSytAN0iA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oNQ6AOwV329LYLxza1NJpLQL7L3OTaC9PYmogRcWf/SMqsAwKnNHWUPrBqLxKH5+8
         08XyG2JsehP2TROUFa0+IfwLykmVAcUOZ2+fntOYFo+ffw4zieRDOvcHyG+TGP7F9C
         4+893RdVsZBT36B0UhBp753mk8xL2oeO2pdj3+7M=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 22/32] compiler.h, seqlock.h: Remove unnecessary kcsan.h includes
Date:   Mon,  9 Mar 2020 12:04:10 -0700
Message-Id: <20200309190420.6100-22-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200309190359.GA5822@paulmck-ThinkPad-P72>
References: <20200309190359.GA5822@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

No we longer have to include kcsan.h, since the required KCSAN interface
for both compiler.h and seqlock.h are now provided by kcsan-checks.h.

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/compiler.h | 2 --
 include/linux/seqlock.h  | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index c1bdf37..f504ede 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -313,8 +313,6 @@ unsigned long read_word_at_a_time(const void *addr)
 	__u.__val;					\
 })
 
-#include <linux/kcsan.h>
-
 /**
  * data_race - mark an expression as containing intentional data races
  *
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 239701c..8b97204 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -37,7 +37,7 @@
 #include <linux/preempt.h>
 #include <linux/lockdep.h>
 #include <linux/compiler.h>
-#include <linux/kcsan.h>
+#include <linux/kcsan-checks.h>
 #include <asm/processor.h>
 
 /*
-- 
2.9.5

