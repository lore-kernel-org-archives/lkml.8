Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DC4C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB8FB20771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586978266;
	bh=XHeNfk+RvsFEdUEKBdrYeqc0dFZ4gjXC8xUbp/AyGBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bUs1bpctXGpbpKATQRk6ggNBfqDR3qp46uOgSgHstW2yQVxAwwirv54Y0sJjJFEfe
	 1TGB1++jepXze3/9wgq/vF75A9djVzg5RDkefmpvpGXBsZDnhsSS2vRB0LwBmy2XO1
	 f0qyEZK6GQKOVd+V2vlsDvlOZvrzQHj4tRO7Igps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411731AbgDOTHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:07:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416820AbgDOSeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:34:16 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9132F217D8;
        Wed, 15 Apr 2020 18:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586975655;
        bh=XHeNfk+RvsFEdUEKBdrYeqc0dFZ4gjXC8xUbp/AyGBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DXPlfztCxoKWzI1spL1DCIdLqG/S2QQFvqTcQEBso6ov2x8BuS6zoIWiEdHAh9Z/B
         cA2rPggQjK9uO8HBGfjCNgt4FpQvSLri8vYgu6rEILVBvyfihZMrqnb+au69Nh5urH
         C4cRtDR38yDJxNZKY3KVi2M9X4Cy48fychENGWEg=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 10/15] objtool, kcsan: Add explicit check functions to uaccess whitelist
Date:   Wed, 15 Apr 2020 11:34:06 -0700
Message-Id: <20200415183411.12368-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415183343.GA12265@paulmck-ThinkPad-P72>
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Add explicitly invoked KCSAN check functions to objtool's uaccess
whitelist. This is needed in order to permit calling into
kcsan_check_scoped_accesses() from the fast-path, which in turn calls
__kcsan_check_access().  __kcsan_check_access() is the generic variant
of the already whitelisted specializations __tsan_{read,write}N.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/objtool/check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b6da413..b6a573d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -468,8 +468,10 @@ static const char *uaccess_safe_builtin[] = {
 	"__asan_report_store8_noabort",
 	"__asan_report_store16_noabort",
 	/* KCSAN */
+	"__kcsan_check_access",
 	"kcsan_found_watchpoint",
 	"kcsan_setup_watchpoint",
+	"kcsan_check_scoped_accesses",
 	/* KCSAN/TSAN */
 	"__tsan_func_entry",
 	"__tsan_func_exit",
-- 
2.9.5

