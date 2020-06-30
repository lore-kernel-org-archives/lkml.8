Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C97C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B27F120853
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593538740;
	bh=9ta772X0LhIYPaLbgcx1JUvYo6hXV5XVnuUlAptrUOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xPRfMPK/On7NTauuyVVgdvrqVibIJem9ADfhCr0CL1c+VH25W3slTo8TDMlu9ATT0
	 f224/ugVzafc6Xqea26zoka4XTyGHlU8xh7dXWaBk8snr4EN9tBjL8dYfSmxVk18Ju
	 1sgmY501rwJaf0ZfxTpZTjm8Rn1KB9tXB/+0R3Dk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390479AbgF3Ri5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:38:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388439AbgF3Riz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:38:55 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 218CE208D5;
        Tue, 30 Jun 2020 17:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593538734;
        bh=9ta772X0LhIYPaLbgcx1JUvYo6hXV5XVnuUlAptrUOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0q+Ziga1tPlskSYQCOixoO6Z7LOXNz3B6jLLCGqxp/nOY1c+yQMi4dmX9JM37+9y0
         ZK9XtOGvfQUWp0T7YRsp5zuJSE8D4Xcg5v8WcxEy/7r+jxhV6fRVjnfN6L3KkrZKkU
         ebDLdVemnERh2RnFrQjwFEjyJUmdx4Rab8Jh0TpI=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel-team@android.com
Subject: [PATCH 17/18] arm64: alternatives: Remove READ_ONCE() usage during patch operation
Date:   Tue, 30 Jun 2020 18:37:33 +0100
Message-Id: <20200630173734.14057-18-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200630173734.14057-1-will@kernel.org>
References: <20200630173734.14057-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for patching the internals of READ_ONCE() itself, replace
its usage on the alternatives patching patch with a volatile variable
instead.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/alternative.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index d1757ef1b1e7..87bca8d44084 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -21,7 +21,8 @@
 #define ALT_ORIG_PTR(a)		__ALT_PTR(a, orig_offset)
 #define ALT_REPL_PTR(a)		__ALT_PTR(a, alt_offset)
 
-static int all_alternatives_applied;
+/* Volatile, as we may be patching the guts of READ_ONCE() */
+static volatile int all_alternatives_applied;
 
 static DECLARE_BITMAP(applied_alternatives, ARM64_NCAPS);
 
@@ -217,7 +218,7 @@ static int __apply_alternatives_multi_stop(void *unused)
 
 	/* We always have a CPU 0 at this point (__init) */
 	if (smp_processor_id()) {
-		while (!READ_ONCE(all_alternatives_applied))
+		while (!all_alternatives_applied)
 			cpu_relax();
 		isb();
 	} else {
@@ -229,7 +230,7 @@ static int __apply_alternatives_multi_stop(void *unused)
 		BUG_ON(all_alternatives_applied);
 		__apply_alternatives(&region, false, remaining_capabilities);
 		/* Barriers provided by the cache flushing */
-		WRITE_ONCE(all_alternatives_applied, 1);
+		all_alternatives_applied = 1;
 	}
 
 	return 0;
-- 
2.27.0.212.ge8ba1cc988-goog

