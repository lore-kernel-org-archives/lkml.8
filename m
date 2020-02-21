Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76376C3565B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5437E222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgBUSTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 13:19:06 -0500
Received: from foss.arm.com ([217.140.110.172]:45354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729397AbgBUSTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:19:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A300FEC;
        Fri, 21 Feb 2020 10:19:03 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 068653F6CF;
        Fri, 21 Feb 2020 10:19:01 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        linux@armlinux.org.uk, tglx@linutronix.de, luto@kernel.org,
        m.szyprowski@samsung.com, Mark.Rutland@arm.com, maz@kernel.org,
        vincenzo.frascino@arm.com
Subject: [PATCH v2 2/3] arm64: clocksource: Add VDSO default clockmode
Date:   Fri, 21 Feb 2020 18:18:48 +0000
Message-Id: <20200221181849.40351-3-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221181849.40351-1-vincenzo.frascino@arm.com>
References: <20200221181849.40351-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define VDSO_CLOCKMODE_ARCH_DEFAULT to represent the default vDSO
clockmode for arm_arch_timer.

The change to arm_arch_timer will be in the next patch of this
series.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/clocksource.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/clocksource.h b/arch/arm64/include/asm/clocksource.h
index eb82e9d95c5d..36a2cca213ae 100644
--- a/arch/arm64/include/asm/clocksource.h
+++ b/arch/arm64/include/asm/clocksource.h
@@ -4,5 +4,6 @@
 
 #define VDSO_ARCH_CLOCKMODES	\
 	VDSO_CLOCKMODE_ARCHTIMER
+#define VDSO_CLOCKMODE_ARCH_DEFAULT	VDSO_CLOCKMODE_ARCHTIMER
 
 #endif
-- 
2.25.0

