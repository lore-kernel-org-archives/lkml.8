Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2793CC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05C0E2083E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593620316;
	bh=6Y1U4n1w/Mwul+Pj0L0xUzIUgPXcO9Kst+MOvUbSY2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JGcqqoUqqvy5c7E301Uw7nfsvqXgZ4ziB+oDLgDBel3q26KG0AFaOks7Xa5dDeKQL
	 UsKeh3TaCrHZ6t8XSjFIU6pcTIFXIxXtivKcv4pRNknAshf0MzqAC00jKhtbrgIEsW
	 /w6rOnfZrOssU+ISYn+SeE9CHWeiUq5IdIXQ4ids=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbgGAQSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:18:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731123AbgGAQSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:18:32 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4401207F5;
        Wed,  1 Jul 2020 16:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593620311;
        bh=6Y1U4n1w/Mwul+Pj0L0xUzIUgPXcO9Kst+MOvUbSY2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gills0sEgGSYnA+q34nYmpLit39RTi+Prt+qDpWR4ZlkqpF1C+FNsk9gAT0ZJP/v4
         w/uPfTjXGhqnLqh3825vQK7ex/UnRjtmC7BUL3ogov7HJD6e9n54FsLRI1bjZc6s45
         UuBVTUGY92icEUYTK6Iw5ilrzloP5k9E9KqfcW/A=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jqfRO-0087Zf-8O; Wed, 01 Jul 2020 17:18:30 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: [PATCH 1/3] arm64: Introduce a way to disable the 32bit vdso
Date:   Wed,  1 Jul 2020 17:18:22 +0100
Message-Id: <20200701161824.1346732-2-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200701161824.1346732-1-maz@kernel.org>
References: <20200701161824.1346732-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, daniel.lezcano@linaro.org, vincenzo.frascino@arm.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a class of errata (grouped under the ARM64_WORKAROUND_1418040
banner) that force the trapping of counter access from 32bit EL0.

We would normally disable the whole vdso for such defect, except that
it would disable it for 64bit userspace as well, which is a shame.

Instead, add a new vdso_clock_mode, which signals that the vdso
isn't usable for compat tasks.  This gets checked in the new
vdso_clocksource_ok() helper, now provided for the 32bit vdso.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/vdso/clocksource.h         | 7 +++++--
 arch/arm64/include/asm/vdso/compat_gettimeofday.h | 8 +++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/clocksource.h b/arch/arm64/include/asm/vdso/clocksource.h
index df6ea65c1dec..b054d9febfb5 100644
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
diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index b6907ae78e53..9a625e8947ff 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -111,7 +111,7 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
 	 * update. Return something. Core will do another round and then
 	 * see the mode change and fallback to the syscall.
 	 */
-	if (clock_mode == VDSO_CLOCKMODE_NONE)
+	if (clock_mode != VDSO_CLOCKMODE_ARCHTIMER)
 		return 0;
 
 	/*
@@ -152,6 +152,12 @@ static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
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
-- 
2.27.0

