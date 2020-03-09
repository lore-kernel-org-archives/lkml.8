Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949EEC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6541620637
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583780750;
	bh=dmTYlWB7kxW8OXHx6yaSTsrH3kc4vn2vfr2xOrYY8Fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s1mMtmBKNywTkXz6q6XXDP9gg+oeeLW1m+szJP/7Acw3ntSVHL5tnlPKq1NE5QkiY
	 T/pJX1y2QPRmei0J4gugLfwq7UhvyD+Ldl8TkaZttaQFT/xychdm6U1L98ab2Ed/8f
	 zqChc9dS6r4VfDRMxD+UrwhN3NKYZNkfWLFkemuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgCITFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:05:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727588AbgCITEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:04:25 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56EE524654;
        Mon,  9 Mar 2020 19:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583780665;
        bh=dmTYlWB7kxW8OXHx6yaSTsrH3kc4vn2vfr2xOrYY8Fo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z+YIvqnlsSfeteE99FXBBOxC2PcBKtUyyc7zj0rs03i/9vit7pQ2cD1uvK1myO26G
         hYcQq/lKird3txDVrbAXrYu9YYv5PdSnYCoy7YruHXQzs4bV84K8a0l+te33C7dmsj
         A9RO9g/Hj911mosECWqVy056NDKcCrk3owb4SVSQ=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 13/32] kcsan: Clarify Kconfig option KCSAN_IGNORE_ATOMICS
Date:   Mon,  9 Mar 2020 12:04:01 -0700
Message-Id: <20200309190420.6100-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200309190359.GA5822@paulmck-ThinkPad-P72>
References: <20200309190359.GA5822@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Clarify difference between options KCSAN_IGNORE_ATOMICS and
KCSAN_ASSUME_PLAIN_WRITES_ATOMIC in help text.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/Kconfig.kcsan | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 6612685..020ac63 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -132,8 +132,18 @@ config KCSAN_ASSUME_PLAIN_WRITES_ATOMIC
 config KCSAN_IGNORE_ATOMICS
 	bool "Do not instrument marked atomic accesses"
 	help
-	  If enabled, never instruments marked atomic accesses. This results in
-	  not reporting data races where one access is atomic and the other is
-	  a plain access.
+	  Never instrument marked atomic accesses. This option can be used for
+	  additional filtering. Conflicting marked atomic reads and plain
+	  writes will never be reported as a data race, however, will cause
+	  plain reads and marked writes to result in "unknown origin" reports.
+	  If combined with CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN=n, data
+	  races where at least one access is marked atomic will never be
+	  reported.
+
+	  Similar to KCSAN_ASSUME_PLAIN_WRITES_ATOMIC, but including unaligned
+	  accesses, conflicting marked atomic reads and plain writes will not
+	  be reported as data races; however, unlike that option, data races
+	  due to two conflicting plain writes will be reported (aligned and
+	  unaligned, if CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n).
 
 endif # KCSAN
-- 
2.9.5

