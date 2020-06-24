Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715B0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58A392082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593025394;
	bh=ei0Jqp3I9nhWh4bhWBsvoOAw69GmcA9g2P0YkI+LMEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hG6+vRIjF/qFzRANQ5Oci88beb7Zu8DSKr+xLc5CPiCuDL/F3iGEVs9hw4xwucqzI
	 4HCKOYXTeu2iFE+JsI1XPkT6NvrgLKIjxMXn1Od7tgXGu5izoW+QpozrkzWtmyQX7K
	 MsGGBPxSHuAzXiuhjvQugE2uAhyZ++tHKSjxknwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405025AbgFXTDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404055AbgFXTDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 15:03:10 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A26FD2082F;
        Wed, 24 Jun 2020 19:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593025389;
        bh=ei0Jqp3I9nhWh4bhWBsvoOAw69GmcA9g2P0YkI+LMEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cy5H4ScOUCe6zZNFIoGkJo3zzQUEtVgOEAT7hy3fU4BMEyi5Sle9Vh+wATDEB31Je
         e1OraH8+meqx91PTNrEECCsxrYW0Kdpl7YIngrcR0PyNb9sn7+dg3qz050frM9Clkm
         F5htZIXUUB3r7OgJxvea4AosuDG/ChALOhgyyHxI=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        Martin Liska <mliska@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 1/3] kcsan: Re-add GCC as a supported compiler
Date:   Wed, 24 Jun 2020 12:03:05 -0700
Message-Id: <20200624190307.15191-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200624190236.GA6603@paulmck-ThinkPad-P72>
References: <20200624190236.GA6603@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

GCC version 11 recently implemented all requirements to correctly
support KCSAN:

1. Correct no_sanitize-attribute inlining behaviour:
   https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=4089df8ef4a63126b0774c39b6638845244c20d2

2. --param=tsan-distinguish-volatile
   https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=ab2789ec507a94f1a75a6534bca51c7b39037ce0

3. --param=tsan-instrument-func-entry-exit
   https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=06712fc68dc9843d9af7c7ac10047f49d305ad76

Therefore, we can re-enable GCC for KCSAN, and document the new compiler
requirements.

Signed-off-by: Marco Elver <elver@google.com>
Cc: Martin Liska <mliska@suse.cz>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/dev-tools/kcsan.rst | 3 ++-
 lib/Kconfig.kcsan                 | 3 ++-
 scripts/Makefile.kcsan            | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index ce4bbd9..8fa0dd6 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -8,7 +8,8 @@ approach to detect races. KCSAN's primary purpose is to detect `data races`_.
 Usage
 -----
 
-KCSAN requires Clang version 11 or later.
+KCSAN is supported by both GCC and Clang. With GCC we require version 11 or
+later, and with Clang also require version 11 or later.
 
 To enable KCSAN configure the kernel with::
 
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 3f3b5bc..3d282d5 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -4,7 +4,8 @@ config HAVE_ARCH_KCSAN
 	bool
 
 config HAVE_KCSAN_COMPILER
-	def_bool CC_IS_CLANG && $(cc-option,-fsanitize=thread -mllvm -tsan-distinguish-volatile=1)
+	def_bool (CC_IS_CLANG && $(cc-option,-fsanitize=thread -mllvm -tsan-distinguish-volatile=1)) || \
+		 (CC_IS_GCC && $(cc-option,-fsanitize=thread --param tsan-distinguish-volatile=1))
 	help
 	  For the list of compilers that support KCSAN, please see
 	  <file:Documentation/dev-tools/kcsan.rst>.
diff --git a/scripts/Makefile.kcsan b/scripts/Makefile.kcsan
index bd4da1a..dd66206 100644
--- a/scripts/Makefile.kcsan
+++ b/scripts/Makefile.kcsan
@@ -6,7 +6,7 @@ ifdef CONFIG_KCSAN
 ifdef CONFIG_CC_IS_CLANG
 cc-param = -mllvm -$(1)
 else
-cc-param = --param -$(1)
+cc-param = --param $(1)
 endif
 
 # Keep most options here optional, to allow enabling more compilers if absence
-- 
2.9.5

