Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822CBC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C1B20882
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737069;
	bh=zzWo/VpO3F0hQ1irh1MATqWf6Naq9PBHIWWuISSMs5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N0YqYOXxFo0l6Jxlt9ZqFOcKdPu8vzBF7Z2PxzxACL+/L/4gnzwt+PfIvkGN3VyjM
	 zyKfylDEAKp6QzB5S/T7mslwi4IJq8mi3q5Z3pdFDMKtkFs6mcbNEdhBDcMX2Aio64
	 r3gm6ZbREnFs0/KF0oMae37AiaFsLHmWjPa+kQ5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgAKKE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:04:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:36626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729517AbgAKKEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:04:25 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF58920848;
        Sat, 11 Jan 2020 10:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737064;
        bh=zzWo/VpO3F0hQ1irh1MATqWf6Naq9PBHIWWuISSMs5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D5uJAc+6T+DnPxwl4gBPtBhVUNGV9TQF//t0QY2L/uSGtmsDHKjVAYekklKwu6KbP
         sbjikCmfioKmbmYak1lXJDGFvnRy8Mzf4mY6Qm/w/G2MdKXyRxAQS/M9T9I1dH2VJB
         T87CckR43csRhZzaV6ST0KB5rEuJKrpVQ8eIDYc0=
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
Subject: [PATCH 4.9 55/91] locking/x86: Remove the unused atomic_inc_short() methd
Date:   Sat, 11 Jan 2020 10:49:48 +0100
Message-Id: <20200111094905.611021015@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094844.748507863@linuxfoundation.org>
References: <20200111094844.748507863@linuxfoundation.org>
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
@@ -249,19 +249,6 @@ static __always_inline int __atomic_add_
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


