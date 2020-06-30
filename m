Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFB3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB1042083E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593538691;
	bh=KoohMc4oy1OYchUtZSZ/5o8eYoZ+TwF900MK61ip/x8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oNVnw+fzkUM4Lx7d41c8n3apqv98Pk0Wq+x1j96sTdwvO+TNXnLqz3K8PixLKLQkY
	 powCHh74gh7PWlj0reu3ZgMBMbsYh/0nKmH0oVuMTnI6EyfMlcAMrI8J7RxyFJDqzX
	 n1I4JZ/icmlmkXpGARTWB1Tz64FGMWo6B2xjveLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390355AbgF3RiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:38:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731150AbgF3RiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:38:06 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15CD02081A;
        Tue, 30 Jun 2020 17:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593538685;
        bh=KoohMc4oy1OYchUtZSZ/5o8eYoZ+TwF900MK61ip/x8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bOU7umLf3Z1uBZ24e0ZbXikzdqMjGZ7XV3SbHT8TKFMcTTlt1d/f4ORiTl8UzYR7/
         Fw2LCdkMA9w64wei4ys3rJl+HTcDwEFvhhy2IKgPAM8i1Aas9vi9XI8zbU6rrM41su
         yU4JiYBlrHL6Q/tg55fyLpDeVp0PzdtvfIoUktIk=
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
Subject: [PATCH 05/18] asm/rwonce: Remove smp_read_barrier_depends() invocation
Date:   Tue, 30 Jun 2020 18:37:21 +0100
Message-Id: <20200630173734.14057-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200630173734.14057-1-will@kernel.org>
References: <20200630173734.14057-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alpha overrides __READ_ONCE() directly, so there's no need to use
smp_read_barrier_depends() in the core code. This also means that
__READ_ONCE() can be relied upon to provide dependency ordering.

Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/asm-generic/rwonce.h | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index f9dfa88fc04d..cc810f1f18ca 100644
--- a/include/asm-generic/rwonce.h
+++ b/include/asm-generic/rwonce.h
@@ -30,24 +30,16 @@
 
 /*
  * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
- * atomicity or dependency ordering guarantees. Note that this may result
- * in tears!
+ * atomicity. Note that this may result in tears!
  */
 #ifndef __READ_ONCE
 #define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
 #endif
 
-#define __READ_ONCE_SCALAR(x)						\
-({									\
-	__unqual_scalar_typeof(x) __x = __READ_ONCE(x);			\
-	smp_read_barrier_depends();					\
-	(typeof(x))__x;							\
-})
-
 #define READ_ONCE(x)							\
 ({									\
 	compiletime_assert_rwonce_type(x);				\
-	__READ_ONCE_SCALAR(x);						\
+	__READ_ONCE(x);							\
 })
 
 #define __WRITE_ONCE(x, val)						\
@@ -74,12 +66,9 @@ unsigned long __read_once_word_nocheck(const void *addr)
  */
 #define READ_ONCE_NOCHECK(x)						\
 ({									\
-	unsigned long __x;						\
-	compiletime_assert(sizeof(x) == sizeof(__x),			\
+	compiletime_assert(sizeof(x) == sizeof(unsigned long),		\
 		"Unsupported access size for READ_ONCE_NOCHECK().");	\
-	__x = __read_once_word_nocheck(&(x));				\
-	smp_read_barrier_depends();					\
-	(typeof(x))__x;							\
+	(typeof(x))__read_once_word_nocheck(&(x));			\
 })
 
 static __no_kasan_or_inline
-- 
2.27.0.212.ge8ba1cc988-goog

