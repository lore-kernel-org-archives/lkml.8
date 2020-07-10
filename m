Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9020EC433EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BEE72078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594399974;
	bh=33ol2wfww+buJMx3tza0CIjhnMXSbv1JPshM2dQmTHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gG2ncHR5cbOjInlJWe6b7hDxjNUGlI+K+52r6+thrNxMlhzVALU/V1HoI+6DDrebD
	 vXczWpvuNIoJQx3RaiMf/0R/V+aV0/MKGnsoCcbL/cO6zQI9hEwTjVgK86RnJxbogQ
	 z6P7BFDwIaeddyv+Hl1wU0kN1h7VoGtjWoHqYVBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgGJQwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:52:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728459AbgGJQws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:52:48 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE040207FC;
        Fri, 10 Jul 2020 16:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594399968;
        bh=33ol2wfww+buJMx3tza0CIjhnMXSbv1JPshM2dQmTHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zmm4Beup9Cb/cXcX+cFkF3Ys9o4W8ykaffV0B1ywu2WmWxk2m0L6n/aOe+2s19P/P
         KJasSyR2/jQmcHBESwcpm08rw7T3YJ5j1W4OqQj5YlZyMPBPd5Dm5HQf5idVyVBFJY
         6Px+iT08RxLqWmpNFon2pEOMv6R7ANj0ReBB6LnI=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Joel Fernandes <joelaf@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: [PATCH v3 09/19] locking/barriers: Remove definitions for [smp_]read_barrier_depends()
Date:   Fri, 10 Jul 2020 17:51:53 +0100
Message-Id: <20200710165203.31284-10-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200710165203.31284-1-will@kernel.org>
References: <20200710165203.31284-1-will@kernel.org>
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
index 8116744bb82c..fec97dc34de7 100644
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
2.27.0.383.g050319c2ae-goog

