Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D90C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E33D020578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597689598;
	bh=0vzo1+dfsxzsfhFpidf+D+o54CBDt9UpG9cy1L0J2jU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y7zQY5OsyR52w6W8nRv3y3awcAQs8k09/7gACGf4h+J7lRdj+j1UVxWJvNhIyVvZG
	 oS/5QcerUq4REy8J2NfuiRxo/3dzK4bVpM6h0fgmdCg650+b2/PfXgO9ZjQDJeCeAP
	 kp8pe9amUAtuybwUlP96vODUsaNKn6Dzmk9kHU0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbgHQSjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:39:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388118AbgHQP6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:58:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1317A20888;
        Mon, 17 Aug 2020 15:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679899;
        bh=0vzo1+dfsxzsfhFpidf+D+o54CBDt9UpG9cy1L0J2jU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bs7yZ2U28NGm6Nx9jHF2YWlHu2BDpE1HParDOALaW0Z+TTTu8v0HUKC8U1choCTNY
         uO7EGrrvIycG5bjdlVE8FoXROfelkp0UuOEKRrUU8pST3lEnq6jG1/iIroUm8qOQi1
         CDspVfJrCSWn6AP6aNAqZ/XyrglqX9pg280QM7SE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: [PATCH 5.7 372/393] Revert "parisc: Revert "Release spinlocks using ordered store""
Date:   Mon, 17 Aug 2020 17:17:02 +0200
Message-Id: <20200817143837.652263130@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

commit 157e9afcc4fa25068b0e8743bc254a9b56010e13 upstream.

This reverts commit 86d4d068df573a8c2105554624796c086d6bec3d.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org> # v5.0+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/include/asm/spinlock.h |    4 ++--
 arch/parisc/kernel/syscall.S       |   12 ++++--------
 2 files changed, 6 insertions(+), 10 deletions(-)

--- a/arch/parisc/include/asm/spinlock.h
+++ b/arch/parisc/include/asm/spinlock.h
@@ -37,8 +37,8 @@ static inline void arch_spin_unlock(arch
 	volatile unsigned int *a;
 
 	a = __ldcw_align(x);
-	mb();
-	*a = 1;
+	/* Release with ordered store. */
+	__asm__ __volatile__("stw,ma %0,0(%1)" : : "r"(1), "r"(a) : "memory");
 }
 
 static inline int arch_spin_trylock(arch_spinlock_t *x)
--- a/arch/parisc/kernel/syscall.S
+++ b/arch/parisc/kernel/syscall.S
@@ -640,8 +640,7 @@ cas_action:
 	sub,<>	%r28, %r25, %r0
 2:	stw	%r24, 0(%r26)
 	/* Free lock */
-	sync
-	stw	%r20, 0(%sr2,%r20)
+	stw,ma	%r20, 0(%sr2,%r20)
 #if ENABLE_LWS_DEBUG
 	/* Clear thread register indicator */
 	stw	%r0, 4(%sr2,%r20)
@@ -655,8 +654,7 @@ cas_action:
 3:		
 	/* Error occurred on load or store */
 	/* Free lock */
-	sync
-	stw	%r20, 0(%sr2,%r20)
+	stw,ma	%r20, 0(%sr2,%r20)
 #if ENABLE_LWS_DEBUG
 	stw	%r0, 4(%sr2,%r20)
 #endif
@@ -857,8 +855,7 @@ cas2_action:
 
 cas2_end:
 	/* Free lock */
-	sync
-	stw	%r20, 0(%sr2,%r20)
+	stw,ma	%r20, 0(%sr2,%r20)
 	/* Enable interrupts */
 	ssm	PSW_SM_I, %r0
 	/* Return to userspace, set no error */
@@ -868,8 +865,7 @@ cas2_end:
 22:
 	/* Error occurred on load or store */
 	/* Free lock */
-	sync
-	stw	%r20, 0(%sr2,%r20)
+	stw,ma	%r20, 0(%sr2,%r20)
 	ssm	PSW_SM_I, %r0
 	ldo	1(%r0),%r28
 	b	lws_exit


