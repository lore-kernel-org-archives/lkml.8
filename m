Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080CFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCEF2207F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593620322;
	bh=PT78ahc4H7LmUWiLIneFFK3wQQU/fwD0zv8IBHzE/3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MlY01Ft5xefnpQgm+WhTITzUQt6S2Zq90nj31Y1xxG+zZ23blN6Nt/G/MjQARb2tP
	 8X3nvUEE1cFX15KZ8WpxVilUK8LjGFwjIpAGtFWRj+WoYzHnuOdsgKos0HGlpha2vH
	 mUJl3APEh3LpSc6gtaA+PT5Ir1lDK8wgOuz+hF7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732371AbgGAQSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732290AbgGAQSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:18:33 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CFF82082F;
        Wed,  1 Jul 2020 16:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593620312;
        bh=PT78ahc4H7LmUWiLIneFFK3wQQU/fwD0zv8IBHzE/3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uCbpj/TfjJLqlBr7uxh9PAUI5xk26GxTK3BOy/0MbCG+6zv4XdQV+sDGSdIGuo9zv
         hxQn9cflTJ4oyYDFVHZh3oWuveEw7DrQJVQgaBrLZZoVtKJQadXQhLN/okTZcmTfKO
         z9LCxnbUBIHELBw0SKzliRTyocNT/gZapLTuAqtw=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jqfRO-0087Zf-Ru; Wed, 01 Jul 2020 17:18:31 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: [PATCH 2/3] arm64: arch_timer: Allow an workaround descriptor to provide vdso_clock_mode
Date:   Wed,  1 Jul 2020 17:18:23 +0100
Message-Id: <20200701161824.1346732-3-maz@kernel.org>
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

As we are about to disable the vdso for compat tasks in some circumstances,
let's allow a workaround descriptor to provide the vdso_clock_mode that
matches the platform.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/arch_timer.h  | 3 +++
 drivers/clocksource/arm_arch_timer.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 7ae54d7d333a..fb8dfcbf9c01 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -18,6 +18,8 @@
 #include <linux/smp.h>
 #include <linux/types.h>
 
+#include <vdso/clocksource.h>
+
 #include <clocksource/arm_arch_timer.h>
 
 #if IS_ENABLED(CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND)
@@ -58,6 +60,7 @@ struct arch_timer_erratum_workaround {
 	u64 (*read_cntvct_el0)(void);
 	int (*set_next_event_phys)(unsigned long, struct clock_event_device *);
 	int (*set_next_event_virt)(unsigned long, struct clock_event_device *);
+	enum vdso_clock_mode vdso_clock_mode;
 };
 
 DECLARE_PER_CPU(const struct arch_timer_erratum_workaround *,
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index ecf7b7db2d05..f828835c568f 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -566,6 +566,9 @@ void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa
 	if (wa->read_cntvct_el0) {
 		clocksource_counter.vdso_clock_mode = VDSO_CLOCKMODE_NONE;
 		vdso_default = VDSO_CLOCKMODE_NONE;
+	} else {
+		clocksource_counter.vdso_clock_mode = wa->vdso_clock_mode;
+		vdso_default = wa->vdso_clock_mode;
 	}
 }
 
-- 
2.27.0

