Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC27C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BAB5207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594399958;
	bh=gTXZQO1RyYx1KEQLncc7UQSL6etty75iDnDOorylNyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hYXaaT530h+WQNx/uswHXyLa46aLqMN7UcMCeJmXuv+SdPlnVkBmXDLj09BsF0SlG
	 1CE/H8CBtr63E3JhQOyfrbMYVqEVDSwEt3WBRA2sxENieZyxoqtHXSA8hC7DqZwUeo
	 h7lFC1FRjEUNVDVQSMnG/IX236fCA9wnHfXA5JCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgGJQwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:52:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728336AbgGJQwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:52:32 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48FF0207BB;
        Fri, 10 Jul 2020 16:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594399952;
        bh=gTXZQO1RyYx1KEQLncc7UQSL6etty75iDnDOorylNyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qPyTLF3pqs4qb8U2JHB2vHzU3ThHJ3PE1k3ZZAAEPzT80q2DNbs8iyNQFOoFd/cRV
         TdSU3YBe0OXAcoaCD0tdjrKCzw5McHlOyx8HVGl2NHy2tJp2UJHuW9xFuXvHeusZ4O
         518hS8o32/DrYn3LkGZXqBF3E+Vl9slsioyn3KsE=
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
Subject: [PATCH v3 05/19] asm/rwonce: Remove smp_read_barrier_depends() invocation
Date:   Fri, 10 Jul 2020 17:51:49 +0100
Message-Id: <20200710165203.31284-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200710165203.31284-1-will@kernel.org>
References: <20200710165203.31284-1-will@kernel.org>
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
2.27.0.383.g050319c2ae-goog

