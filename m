Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05BFC3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76892082E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578736674;
	bh=PlIafMZBo8Mwk2jZIYXatKhI+E4AfG6SYJgcW9+Cu58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Azd08pZrLt+fEZMqr8K204lDVvOnne/ZhfZ0GfifPXr2OXW5gqchemoDOv4d4dDRt
	 t6i6Q1srsK14/dfBeT5GD6Udt1rMOX7ZyZMT5Epc7agHwwEcP6I2aXx0AgyLd7WDgi
	 lpduANH2qwq12lZ43hJoXzfgiohgVcIOS3lBMKWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgAKJ5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 04:57:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:50556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728825AbgAKJ5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 04:57:53 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 811612077C;
        Sat, 11 Jan 2020 09:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578736673;
        bh=PlIafMZBo8Mwk2jZIYXatKhI+E4AfG6SYJgcW9+Cu58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PA457pU90wKv3ui5O63UQqtBPKaruOmpTtpWkqSaFFS2eQYHKJwKzy+bHxYCjVOIU
         Zp9KFB/6axuM3kk8sX+7SF8ByBC8qqlyxnNd4Halyc/6TTN0DlZNR9rdLx+AM/5HRr
         E3F9pMXKqyfYyy70KulZ4q0j8W+MqQIL2wQtN6fQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.4 32/59] locking/x86: Remove the unused atomic_inc_short() methd
Date:   Sat, 11 Jan 2020 10:49:41 +0100
Message-Id: <20200111094844.781299931@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094835.417654274@linuxfoundation.org>
References: <20200111094835.417654274@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Vyukov <dvyukov@google.com>

commit 31b35f6b4d5285a311e10753f4eb17304326b211 upstream.

It is completely unused and implemented only on x86.
Remove it.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20170526172900.91058-1-dvyukov@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/tile/lib/atomic_asm_32.S |    3 +--
 arch/x86/include/asm/atomic.h |   13 -------------
 2 files changed, 1 insertion(+), 15 deletions(-)

--- a/arch/tile/lib/atomic_asm_32.S
+++ b/arch/tile/lib/atomic_asm_32.S
@@ -24,8 +24,7 @@
  * has an opportunity to return -EFAULT to the user if needed.
  * The 64-bit routines just return a "long long" with the value,
  * since they are only used from kernel space and don't expect to fault.
- * Support for 16-bit ops is included in the framework but we don't provide
- * any (x86_64 has an atomic_inc_short(), so we might want to some day).
+ * Support for 16-bit ops is included in the framework but we don't provide any.
  *
  * Note that the caller is advised to issue a suitable L1 or L2
  * prefetch on the address being manipulated to avoid extra stalls.
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -220,19 +220,6 @@ static __always_inline int __atomic_add_
 	return c;
 }
 
-/**
- * atomic_inc_short - increment of a short integer
- * @v: pointer to type int
- *
- * Atomically adds 1 to @v
- * Returns the new value of @u
- */
-static __always_inline short int atomic_inc_short(short int *v)
-{
-	asm(LOCK_PREFIX "addw $1, %0" : "+m" (*v));
-	return *v;
-}
-
 #ifdef CONFIG_X86_32
 # include <asm/atomic64_32.h>
 #else


