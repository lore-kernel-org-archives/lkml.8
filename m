Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF158C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C9E20774
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593538701;
	bh=dgjRIkkp8leZF72T6rvgJl6ei7/J97036Gp6l/zm8pU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QXOwFaK1+S+FmqeSK8aVFBDxuFZhuXZFM/wpPXIXv0es9kLpVUC0LjAY6Tn0BV4vO
	 ktSSYEYjh4kkKmJ791kzpv/N+4DlQp+NFv5PDiJ4JiTN1VjJSSHPn0ZdCnw5R/4EB/
	 AfFWxFPmUyf0CMkePK22TkPvvqMDSY1eP1hqyAsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390389AbgF3RiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:38:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390353AbgF3RiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:38:18 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C95B20809;
        Tue, 30 Jun 2020 17:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593538697;
        bh=dgjRIkkp8leZF72T6rvgJl6ei7/J97036Gp6l/zm8pU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ri1JGNLGy9S8joDCHe7dCkFFUbzJ7g4b59+cNyargMdLiVWn7pSarW+9MHxj5UU3
         jSlWmEXOQh81NBvBBxES8IzjGvmOMDvb8mn0J0yCdO/jMS06jkWaGk3U6C6MWZVC7U
         54TfRPVYf4EgW0AyAnsawnXX5c7OrpDbwc6XQ6mM=
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
Subject: [PATCH 08/18] locking/barriers: Remove definitions for [smp_]read_barrier_depends()
Date:   Tue, 30 Jun 2020 18:37:24 +0100
Message-Id: <20200630173734.14057-9-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200630173734.14057-1-will@kernel.org>
References: <20200630173734.14057-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no remaining users of [smp_]read_barrier_depends(), so
remove it from the generic implementation of 'barrier.h'.

Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/asm-generic/barrier.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 2eacaf7d62f6..24f3f63f23e7 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -46,10 +46,6 @@
 #define dma_wmb()	wmb()
 #endif
 
-#ifndef read_barrier_depends
-#define read_barrier_depends()		do { } while (0)
-#endif
-
 #ifndef __smp_mb
 #define __smp_mb()	mb()
 #endif
@@ -62,10 +58,6 @@
 #define __smp_wmb()	wmb()
 #endif
 
-#ifndef __smp_read_barrier_depends
-#define __smp_read_barrier_depends()	read_barrier_depends()
-#endif
-
 #ifdef CONFIG_SMP
 
 #ifndef smp_mb
@@ -80,10 +72,6 @@
 #define smp_wmb()	__smp_wmb()
 #endif
 
-#ifndef smp_read_barrier_depends
-#define smp_read_barrier_depends()	__smp_read_barrier_depends()
-#endif
-
 #else	/* !CONFIG_SMP */
 
 #ifndef smp_mb
@@ -98,10 +86,6 @@
 #define smp_wmb()	barrier()
 #endif
 
-#ifndef smp_read_barrier_depends
-#define smp_read_barrier_depends()	do { } while (0)
-#endif
-
 #endif	/* CONFIG_SMP */
 
 #ifndef __smp_store_mb
@@ -196,7 +180,6 @@ do {									\
 #define virt_mb() __smp_mb()
 #define virt_rmb() __smp_rmb()
 #define virt_wmb() __smp_wmb()
-#define virt_read_barrier_depends() __smp_read_barrier_depends()
 #define virt_store_mb(var, value) __smp_store_mb(var, value)
 #define virt_mb__before_atomic() __smp_mb__before_atomic()
 #define virt_mb__after_atomic()	__smp_mb__after_atomic()
-- 
2.27.0.212.ge8ba1cc988-goog

