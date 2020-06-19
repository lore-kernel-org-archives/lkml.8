Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1D4C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F2B2080C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732782AbgFSNDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:03:36 -0400
Received: from foss.arm.com ([217.140.110.172]:57540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732887AbgFSNCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:02:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA63D101E;
        Fri, 19 Jun 2020 06:02:19 -0700 (PDT)
Received: from entos-d05.shanghai.arm.com (entos-d05.shanghai.arm.com [10.169.40.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BCD523F6CF;
        Fri, 19 Jun 2020 06:02:13 -0700 (PDT)
From:   Jianyong Wu <jianyong.wu@arm.com>
To:     netdev@vger.kernel.org, yangbo.lu@nxp.com, john.stultz@linaro.org,
        tglx@linutronix.de, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, maz@kernel.org,
        richardcochran@gmail.com, Mark.Rutland@arm.com, will@kernel.org,
        suzuki.poulose@arm.com, steven.price@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        Steve.Capper@arm.com, Kaly.Xin@arm.com, justin.he@arm.com,
        Wei.Chen@arm.com, jianyong.wu@arm.com, nd@arm.com
Subject: [PATCH v13 6/9] clocksource: Add clocksource id for arm arch counter
Date:   Fri, 19 Jun 2020 21:01:17 +0800
Message-Id: <20200619130120.40556-7-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619130120.40556-1-jianyong.wu@arm.com>
References: <20200619130120.40556-1-jianyong.wu@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clocksource id for arm arch counter to let it be identified easily and
elegantly in ptp_kvm implementation for arm.

Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 2 ++
 include/linux/clocksource_ids.h      | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index ecf7b7db2d05..edc5be0ae324 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -16,6 +16,7 @@
 #include <linux/cpu_pm.h>
 #include <linux/clockchips.h>
 #include <linux/clocksource.h>
+#include <linux/clocksource_ids.h>
 #include <linux/interrupt.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
@@ -191,6 +192,7 @@ static u64 arch_counter_read_cc(const struct cyclecounter *cc)
 
 static struct clocksource clocksource_counter = {
 	.name	= "arch_sys_counter",
+	.id	= CSID_ARM_ARCH_COUNTER,
 	.rating	= 400,
 	.read	= arch_counter_read,
 	.mask	= CLOCKSOURCE_MASK(56),
diff --git a/include/linux/clocksource_ids.h b/include/linux/clocksource_ids.h
index 4d8e19e05328..16775d7d8f8d 100644
--- a/include/linux/clocksource_ids.h
+++ b/include/linux/clocksource_ids.h
@@ -5,6 +5,7 @@
 /* Enum to give clocksources a unique identifier */
 enum clocksource_ids {
 	CSID_GENERIC		= 0,
+	CSID_ARM_ARCH_COUNTER,
 	CSID_MAX,
 };
 
-- 
2.17.1

