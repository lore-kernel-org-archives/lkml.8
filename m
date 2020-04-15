Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930E3C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A21120768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586977728;
	bh=uRBIJ6sd0gcFbtrSkv57SfMJWDHOcqP+JtoufcputUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1+BeW3PfT1+b7sbfLo12z05ZbHIOLayhtqVgs7s83G1c8hgeErNo+Lt071teXV52k
	 6/SX7nSnl96HnzhvMCSEfi20M/amK76aCwobawkkKNxMJAsIO1lCJ8INsh2UpflRWt
	 lViLdIGCuIrDyyyktrZV314EVdM9LJdSfrgrrbP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441562AbgDOTIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:08:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416823AbgDOSeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:34:17 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57D3721655;
        Wed, 15 Apr 2020 18:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586975656;
        bh=uRBIJ6sd0gcFbtrSkv57SfMJWDHOcqP+JtoufcputUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g9gpm3SVTpAKT3TXayFYQ4tINFhkZS8cGnIHPwsLoxvRcWXniN6AZkpAVzNYLRo8d
         qb31Kger5Sm5gvv8AShOKSV3QGk68dD38abhGe18p4XVE0dwEQDzAiQcv0ucCRSt7K
         FHslLNg+9TShr0sLvhbQE0hoGI/vLo0dkROHHJL0=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v4 tip/core/rcu 13/15] kcsan: Change data_race() to no longer require marking racing accesses
Date:   Wed, 15 Apr 2020 11:34:09 -0700
Message-Id: <20200415183411.12368-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415183343.GA12265@paulmck-ThinkPad-P72>
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Thus far, accesses marked with data_race() would still require the
racing access to be marked in some way (be it with READ_ONCE(),
WRITE_ONCE(), or data_race() itself), as otherwise KCSAN would still
report a data race.  This requirement, however, seems to be unintuitive,
and some valid use-cases demand *not* marking other accesses, as it
might hide more serious bugs (e.g. diagnostic reads).

Therefore, this commit changes data_race() to no longer require marking
racing accesses (although it's still recommended if possible).

The alternative would have been introducing another variant of
data_race(), however, since usage of data_race() already needs to be
carefully reasoned about, distinguishing between these cases likely adds
more complexity in the wrong place.

Link: https://lkml.kernel.org/r/20200331131002.GA30975@willie-the-truck
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Qian Cai <cai@lca.pw>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/compiler.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index f504ede..1729bd1 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -326,9 +326,9 @@ unsigned long read_word_at_a_time(const void *addr)
 #define data_race(expr)                                                        \
 	({                                                                     \
 		typeof(({ expr; })) __val;                                     \
-		kcsan_nestable_atomic_begin();                                 \
+		kcsan_disable_current();                                       \
 		__val = ({ expr; });                                           \
-		kcsan_nestable_atomic_end();                                   \
+		kcsan_enable_current();                                        \
 		__val;                                                         \
 	})
 #else
-- 
2.9.5

