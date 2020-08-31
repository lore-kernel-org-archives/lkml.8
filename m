Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3CEC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1758820E65
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598898010;
	bh=VCySDRyqnM32WR/NXyhDihc6qtydY7uLYW7Li7a5GjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sZqoh9wJEf6NapsUm4dDZqEQpRwL1DVVntVchkhQdXhkSG+Xa/Qkl/iCalxNG1Cms
	 zR2XJN+is37N/N5/T6ox4u8zc5T0fALlmRRb2RhZ5KGbo7MZ/O4hNphxvASD7CDVAl
	 KJcMC55AJEZGq0iMTqTBv0kojFJY0L4zfX1R4/0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgHaSSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:18:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729040AbgHaSSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:18:06 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A8DC20E65;
        Mon, 31 Aug 2020 18:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897886;
        bh=VCySDRyqnM32WR/NXyhDihc6qtydY7uLYW7Li7a5GjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UUxcBKpP5j5YwaWHenRXdjwPUg9l78QfzSP8wu/4KGMeBx9t894wOIgqEZH2vQXiD
         etN0mfdPPQdE/UEE45OJb8emw0zw3L01YbMbPWvXSuavR20XjgzNNZGQKbASOWa0Zc
         QYQc21WgtrbotvmweDGYELfsuaDgT0uz6qakuWzI=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH kcsan 02/19] objtool: Add atomic builtin TSAN instrumentation to uaccess whitelist
Date:   Mon, 31 Aug 2020 11:17:48 -0700
Message-Id: <20200831181805.1833-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181715.GA1530@paulmck-ThinkPad-P72>
References: <20200831181715.GA1530@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Adds the new TSAN functions that may be emitted for atomic builtins to
objtool's uaccess whitelist.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 tools/objtool/check.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e034a8f..7546a9d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -528,6 +528,56 @@ static const char *uaccess_safe_builtin[] = {
 	"__tsan_write4",
 	"__tsan_write8",
 	"__tsan_write16",
+	"__tsan_atomic8_load",
+	"__tsan_atomic16_load",
+	"__tsan_atomic32_load",
+	"__tsan_atomic64_load",
+	"__tsan_atomic8_store",
+	"__tsan_atomic16_store",
+	"__tsan_atomic32_store",
+	"__tsan_atomic64_store",
+	"__tsan_atomic8_exchange",
+	"__tsan_atomic16_exchange",
+	"__tsan_atomic32_exchange",
+	"__tsan_atomic64_exchange",
+	"__tsan_atomic8_fetch_add",
+	"__tsan_atomic16_fetch_add",
+	"__tsan_atomic32_fetch_add",
+	"__tsan_atomic64_fetch_add",
+	"__tsan_atomic8_fetch_sub",
+	"__tsan_atomic16_fetch_sub",
+	"__tsan_atomic32_fetch_sub",
+	"__tsan_atomic64_fetch_sub",
+	"__tsan_atomic8_fetch_and",
+	"__tsan_atomic16_fetch_and",
+	"__tsan_atomic32_fetch_and",
+	"__tsan_atomic64_fetch_and",
+	"__tsan_atomic8_fetch_or",
+	"__tsan_atomic16_fetch_or",
+	"__tsan_atomic32_fetch_or",
+	"__tsan_atomic64_fetch_or",
+	"__tsan_atomic8_fetch_xor",
+	"__tsan_atomic16_fetch_xor",
+	"__tsan_atomic32_fetch_xor",
+	"__tsan_atomic64_fetch_xor",
+	"__tsan_atomic8_fetch_nand",
+	"__tsan_atomic16_fetch_nand",
+	"__tsan_atomic32_fetch_nand",
+	"__tsan_atomic64_fetch_nand",
+	"__tsan_atomic8_compare_exchange_strong",
+	"__tsan_atomic16_compare_exchange_strong",
+	"__tsan_atomic32_compare_exchange_strong",
+	"__tsan_atomic64_compare_exchange_strong",
+	"__tsan_atomic8_compare_exchange_weak",
+	"__tsan_atomic16_compare_exchange_weak",
+	"__tsan_atomic32_compare_exchange_weak",
+	"__tsan_atomic64_compare_exchange_weak",
+	"__tsan_atomic8_compare_exchange_val",
+	"__tsan_atomic16_compare_exchange_val",
+	"__tsan_atomic32_compare_exchange_val",
+	"__tsan_atomic64_compare_exchange_val",
+	"__tsan_atomic_thread_fence",
+	"__tsan_atomic_signal_fence",
 	/* KCOV */
 	"write_comp_data",
 	"check_kcov_mode",
-- 
2.9.5

