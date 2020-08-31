Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2412EC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E89272071B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897899;
	bh=kn4a4eecMtJj2Z5DiTMtbFxEcnjYmSoEoMQiSwT9L2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g6JRYs7ANB8L1iFq5lnT4j+HH2Xb+LRMZcVA82FCflYC4B3lQFeOSarY8B0SExRVX
	 OToEcRnc+GQo6aT9GhQUoZiu/lPQBfPSlk+ZpVxcVc14CYcTFmv5edcMdUEA474xun
	 a/9++7jXzb3c47LYdZzEA46gT0e/CrwoY03AwyKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbgHaSSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:18:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729390AbgHaSSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:18:07 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1383208DB;
        Mon, 31 Aug 2020 18:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897887;
        bh=kn4a4eecMtJj2Z5DiTMtbFxEcnjYmSoEoMQiSwT9L2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bU7A0k8F9Byj1RiyxAEESz+Pa7Iyhjlt/j3evzuafytReytYsXq+P+jyCGLV6j5eC
         rjjD1zewoj3uFZGVYJcxuflLxtMqSnfx9LFrM5KV8ArH+Qo4y3yC/hAfi5DJ4U5Sfo
         41uGpdsqy7CEQLDLi29oyLbO5hAjX18OHBl1Rkqs=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 05/19] objtool, kcsan: Add __tsan_read_write to uaccess whitelist
Date:   Mon, 31 Aug 2020 11:17:51 -0700
Message-Id: <20200831181805.1833-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181715.GA1530@paulmck-ThinkPad-P72>
References: <20200831181715.GA1530@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Adds the new __tsan_read_write compound instrumentation to objtool's
uaccess whitelist.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/objtool/check.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7546a9d..5eee156 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -528,6 +528,11 @@ static const char *uaccess_safe_builtin[] = {
 	"__tsan_write4",
 	"__tsan_write8",
 	"__tsan_write16",
+	"__tsan_read_write1",
+	"__tsan_read_write2",
+	"__tsan_read_write4",
+	"__tsan_read_write8",
+	"__tsan_read_write16",
 	"__tsan_atomic8_load",
 	"__tsan_atomic16_load",
 	"__tsan_atomic32_load",
-- 
2.9.5

