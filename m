Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA5DC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420742084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgCFOnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:43:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53832 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgCFOmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:20 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEB6-0006OA-3G; Fri, 06 Mar 2020 15:42:16 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7A7431C21D4;
        Fri,  6 Mar 2020 15:42:10 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:10 -0000
From:   "tip-bot2 for Thara Gopinath" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] arm64/topology: Populate
 arch_scale_thermal_pressure() for arm64 platforms
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200222005213.3873-5-thara.gopinath@linaro.org>
References: <20200222005213.3873-5-thara.gopinath@linaro.org>
MIME-Version: 1.0
Message-ID: <158350573019.28353.350404434656839771.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ae1677c0bbe23fe30d634ac0d9f5c147ee4adbc1
Gitweb:        https://git.kernel.org/tip/ae1677c0bbe23fe30d634ac0d9f5c147ee4adbc1
Author:        Thara Gopinath <thara.gopinath@linaro.org>
AuthorDate:    Fri, 21 Feb 2020 19:52:08 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 12:57:19 +01:00

arm64/topology: Populate arch_scale_thermal_pressure() for arm64 platforms

Hook up topology_get_thermal_pressure to arch_scale_thermal_pressure thus
enabling scheduler to retrieve instantaneous thermal pressure of a CPU.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200222005213.3873-5-thara.gopinath@linaro.org
---
 arch/arm64/include/asm/topology.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index a4d945d..cbd70d7 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -25,6 +25,9 @@ int pcibus_to_node(struct pci_bus *bus);
 /* Enable topology flag updates */
 #define arch_update_cpu_topology topology_update_cpu_topology
 
+/* Replace task scheduler's default thermal pressure retrieve API */
+#define arch_scale_thermal_pressure topology_get_thermal_pressure
+
 #include <asm-generic/topology.h>
 
 #endif /* _ASM_ARM_TOPOLOGY_H */
