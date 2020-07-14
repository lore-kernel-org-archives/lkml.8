Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DD9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB52A22B45
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753229;
	bh=QQPLdQsHm8zskkrD67gBus4xmrYf5opoihyze2dADgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SpmWE15m0hUQHzL9K3Agvxo2NLJidzIIlidHL3OThGIgDKI5RpRJErlGqnxnovv+y
	 5Ckr09J+h4R0OSFngLzf0XMxvh3rHwkoug5sj4kk6DrEKaPLULPoDRkdurPiKi7Huh
	 Udla9iEZSldsI8DzqPrTrlWfR0Ki5C2aIKsITjz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgGNTA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731363AbgGNTAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:00:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41E5B2240B;
        Tue, 14 Jul 2020 19:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594753221;
        bh=QQPLdQsHm8zskkrD67gBus4xmrYf5opoihyze2dADgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HyPRkjm1tUapovJSag/wYAXQe7idOSzrFLtOezPW9uLztLlL1e9hMdFOOO5gWOzt+
         ojY9CElPuHD/7Rw+uijWFimyVYdCmoleMRFETdYLdqkQpRTBVMiGzVePl/Qv5RWVK6
         zFAZL/gReaP1bwRYHLS0dx43RXSmrV1vuSoq7PVM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 5.7 157/166] arm64: Introduce a way to disable the 32bit vdso
Date:   Tue, 14 Jul 2020 20:45:22 +0200
Message-Id: <20200714184123.341424853@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

commit 97884ca8c2925d14c32188e865069f21378b4b4f upstream.

We have a class of errata (grouped under the ARM64_WORKAROUND_1418040
banner) that force the trapping of counter access from 32bit EL0.

We would normally disable the whole vdso for such defect, except that
it would disable it for 64bit userspace as well, which is a shame.

Instead, add a new vdso_clock_mode, which signals that the vdso
isn't usable for compat tasks.  This gets checked in the new
vdso_clocksource_ok() helper, now provided for the 32bit vdso.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200706163802.1836732-2-maz@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/vdso/clocksource.h         |    7 +++++--
 arch/arm64/include/asm/vdso/compat_gettimeofday.h |    8 +++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

--- a/arch/arm64/include/asm/vdso/clocksource.h
+++ b/arch/arm64/include/asm/vdso/clocksource.h
@@ -2,7 +2,10 @@
 #ifndef __ASM_VDSOCLOCKSOURCE_H
 #define __ASM_VDSOCLOCKSOURCE_H
 
-#define VDSO_ARCH_CLOCKMODES	\
-	VDSO_CLOCKMODE_ARCHTIMER
+#define VDSO_ARCH_CLOCKMODES					\
+	/* vdso clocksource for both 32 and 64bit tasks */	\
+	VDSO_CLOCKMODE_ARCHTIMER,				\
+	/* vdso clocksource for 64bit tasks only */		\
+	VDSO_CLOCKMODE_ARCHTIMER_NOCOMPAT
 
 #endif
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -111,7 +111,7 @@ static __always_inline u64 __arch_get_hw
 	 * update. Return something. Core will do another round and then
 	 * see the mode change and fallback to the syscall.
 	 */
-	if (clock_mode == VDSO_CLOCKMODE_NONE)
+	if (clock_mode != VDSO_CLOCKMODE_ARCHTIMER)
 		return 0;
 
 	/*
@@ -152,6 +152,12 @@ static __always_inline const struct vdso
 	return ret;
 }
 
+static inline bool vdso_clocksource_ok(const struct vdso_data *vd)
+{
+	return vd->clock_mode == VDSO_CLOCKMODE_ARCHTIMER;
+}
+#define vdso_clocksource_ok	vdso_clocksource_ok
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */


