Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05505C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4AC9206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbgELOxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729461AbgELOxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:53:00 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EB7C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 07:53:00 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:81a0:190c:7969:2334])
        by baptiste.telenet-ops.be with bizsmtp
        id dqsw220025045R201qswl3; Tue, 12 May 2020 16:52:58 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jYWH9-0001kH-U0; Tue, 12 May 2020 16:52:55 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jYWH9-0001Rl-RC; Tue, 12 May 2020 16:52:55 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] arm64: cpufeature: Add "or" to mitigations for multiple errata
Date:   Tue, 12 May 2020 16:52:55 +0200
Message-Id: <20200512145255.5520-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several actions are not mitigations for a single erratum, but for
multiple errata.  However, printing a line like

    CPU features: detected: ARM errata 1165522, 1530923

may give the false impression that all three listed errata have been
detected.  This can confuse the user, who may think his Cortex-A55 is
suddenly affected by a Cortex-A76 erratum.

Add "or" to all descriptions for mitigations for multiple errata, to
make it clear that only one or more of the errata printed are
applicable, and not necessarily all of them.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Rebased on top of arm64 for-next/kconfig, which required updating the
    example and the explanation.

 arch/arm64/kernel/cpu_errata.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index df56d2295d165a0d..c8cb98a4fa6d5bf5 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -774,7 +774,7 @@ static const struct midr_range erratum_speculative_at_vhe_list[] = {
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
 	{
-		.desc = "ARM errata 826319, 827319, 824069, 819472",
+		.desc = "ARM errata 826319, 827319, 824069, or 819472",
 		.capability = ARM64_WORKAROUND_CLEAN_CACHE,
 		ERRATA_MIDR_RANGE_LIST(workaround_clean_cache),
 		.cpu_enable = cpu_enable_cache_maint_trap,
@@ -856,7 +856,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #endif
 #ifdef CONFIG_ARM64_WORKAROUND_REPEAT_TLBI
 	{
-		.desc = "Qualcomm erratum 1009, ARM erratum 1286807",
+		.desc = "Qualcomm erratum 1009, or ARM erratum 1286807",
 		.capability = ARM64_WORKAROUND_REPEAT_TLBI,
 		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 		.matches = cpucap_multi_entry_cap_matches,
@@ -899,7 +899,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #endif
 #ifdef CONFIG_ARM64_WORKAROUND_SPECULATIVE_AT_VHE
 	{
-		.desc = "ARM errata 1165522, 1530923",
+		.desc = "ARM errata 1165522 or 1530923",
 		.capability = ARM64_WORKAROUND_SPECULATIVE_AT_VHE,
 		ERRATA_MIDR_RANGE_LIST(erratum_speculative_at_vhe_list),
 	},
-- 
2.17.1

