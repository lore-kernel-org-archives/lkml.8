Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9480C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3662073E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgEDMak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 08:30:40 -0400
Received: from foss.arm.com ([217.140.110.172]:43276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbgEDMak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:30:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D84F31FB;
        Mon,  4 May 2020 05:30:39 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.71.79])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 02DE73F71F;
        Mon,  4 May 2020 05:30:36 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/cpuinfo: Drop boot_cpu_data
Date:   Mon,  4 May 2020 18:00:00 +0530
Message-Id: <1588595400-4560-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A global boot_cpu_data is not really required. Lets drop this. While
here, rename the local variable as boot_cpu_info when it is fetched
for the boot cpu.

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

 arch/arm64/kernel/cpuinfo.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index a515d8f3639e..dabcdc132e56 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -31,7 +31,6 @@
  * values depending on configuration at or after reset.
  */
 DEFINE_PER_CPU(struct cpuinfo_arm64, cpu_data);
-static struct cpuinfo_arm64 boot_cpu_data;
 
 static const char *icache_policy_str[] = {
 	[0 ... ICACHE_POLICY_PIPT]	= "RESERVED/UNKNOWN",
@@ -393,15 +392,16 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 void cpuinfo_store_cpu(void)
 {
 	struct cpuinfo_arm64 *info = this_cpu_ptr(&cpu_data);
+	struct cpuinfo_arm64 *boot_cpu_info = &per_cpu(cpu_data, 0);
+
 	__cpuinfo_store_cpu(info);
-	update_cpu_features(smp_processor_id(), info, &boot_cpu_data);
+	update_cpu_features(smp_processor_id(), info, boot_cpu_info);
 }
 
 void __init cpuinfo_store_boot_cpu(void)
 {
-	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, 0);
-	__cpuinfo_store_cpu(info);
+	struct cpuinfo_arm64 *boot_cpu_info = &per_cpu(cpu_data, 0);
 
-	boot_cpu_data = *info;
-	init_cpu_features(&boot_cpu_data);
+	__cpuinfo_store_cpu(boot_cpu_info);
+	init_cpu_features(boot_cpu_info);
 }
-- 
2.20.1

