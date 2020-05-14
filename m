Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B465CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F2652074A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589482639;
	bh=AaG/Kbi5od21eNCWlwJuZhmK5c2eLLCkNMUr9nuuBg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q2vXuJTO9z4W96gIW/G8iL9xbcdRvifLJB+rRYRPHf8ABNaidRckY7QFedJ0lXMvX
	 MfBAaU4Bj5Y5ij4Of+OBCrOy0PadP8b3QjZjy1enD3VcLoNSoG8rcMOOpHevbpoyib
	 MrH8SJIV6YQTiDMWprz0k72ONZ4kI4xXsr2fItJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgENS5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:57:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729763AbgENS4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:56:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1129E207F7;
        Thu, 14 May 2020 18:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482601;
        bh=AaG/Kbi5od21eNCWlwJuZhmK5c2eLLCkNMUr9nuuBg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0uPZGxAuxuFHQE2BpUU1CBtl97MgYStkot7Xu5Xb8w4R+UiW9uVUBcOHtbUT2UE8o
         nN0hSGXbtHk4jSV6jqytbpceV48iiHLPCjoo5ML//bbrgrVrvat3ReSZdspipIY2cm
         67aiv+JGCMPoafAL8B3CxHwf9GbbtqCb4lsj6rI8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.4 13/14] ARM: futex: Address build warning
Date:   Thu, 14 May 2020 14:56:24 -0400
Message-Id: <20200514185625.21753-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185625.21753-1-sashal@kernel.org>
References: <20200514185625.21753-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 8101b5a1531f3390b3a69fa7934c70a8fd6566ad ]

Stephen reported the following build warning on a ARM multi_v7_defconfig
build with GCC 9.2.1:

kernel/futex.c: In function 'do_futex':
kernel/futex.c:1676:17: warning: 'oldval' may be used uninitialized in this function [-Wmaybe-uninitialized]
 1676 |   return oldval == cmparg;
      |          ~~~~~~~^~~~~~~~~
kernel/futex.c:1652:6: note: 'oldval' was declared here
 1652 |  int oldval, ret;
      |      ^~~~~~

introduced by commit a08971e9488d ("futex: arch_futex_atomic_op_inuser()
calling conventions change").

While that change should not make any difference it confuses GCC which
fails to work out that oldval is not referenced when the return value is
not zero.

GCC fails to properly analyze arch_futex_atomic_op_inuser(). It's not the
early return, the issue is with the assembly macros. GCC fails to detect
that those either set 'ret' to 0 and set oldval or set 'ret' to -EFAULT
which makes oldval uninteresting. The store to the callsite supplied oldval
pointer is conditional on ret == 0.

The straight forward way to solve this is to make the store unconditional.

Aside of addressing the build warning this makes sense anyway because it
removes the conditional from the fastpath. In the error case the stored
value is uninteresting and the extra store does not matter at all.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/87pncao2ph.fsf@nanos.tec.linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/include/asm/futex.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
index cc414382dab4b..561b2ba6bc284 100644
--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -162,8 +162,13 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 	preempt_enable();
 #endif
 
-	if (!ret)
-		*oval = oldval;
+	/*
+	 * Store unconditionally. If ret != 0 the extra store is the least
+	 * of the worries but GCC cannot figure out that __futex_atomic_op()
+	 * is either setting ret to -EFAULT or storing the old value in
+	 * oldval which results in a uninitialized warning at the call site.
+	 */
+	*oval = oldval;
 
 	return ret;
 }
-- 
2.20.1

