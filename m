Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB83C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E34EA20661
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgEDMaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 08:30:20 -0400
Received: from foss.arm.com ([217.140.110.172]:43256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbgEDMaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:30:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56C611FB;
        Mon,  4 May 2020 05:30:19 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.71.79])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 66F253F71F;
        Mon,  4 May 2020 05:30:16 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/cpuinfo: Move device_initcall() near cpuinfo_regs_init()
Date:   Mon,  4 May 2020 17:59:37 +0530
Message-Id: <1588595377-4503-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves device_initcall() near cpuinfo_regs_init() making the calling
sequence clear. Besides it is a standard practice to have device_initcall()
(any __initcall for that matter) just after the function it actually calls.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Based on 5.7-rc4

 arch/arm64/kernel/cpuinfo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 86136075ae41..a515d8f3639e 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -311,6 +311,8 @@ static int __init cpuinfo_regs_init(void)
 	}
 	return 0;
 }
+device_initcall(cpuinfo_regs_init);
+
 static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
 {
 	unsigned int cpu = smp_processor_id();
@@ -403,5 +405,3 @@ void __init cpuinfo_store_boot_cpu(void)
 	boot_cpu_data = *info;
 	init_cpu_features(&boot_cpu_data);
 }
-
-device_initcall(cpuinfo_regs_init);
-- 
2.20.1

