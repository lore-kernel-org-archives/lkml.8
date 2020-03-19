Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98569C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 09:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DE220722
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 09:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgCSJOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 05:14:11 -0400
Received: from poy.remlab.net ([94.23.215.26]:55526 "EHLO
        ns207790.ip-94-23-215.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgCSJOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 05:14:10 -0400
Received: from basile.remlab.net (ip6-localhost [IPv6:::1])
        by ns207790.ip-94-23-215.eu (Postfix) with ESMTP id D7FC85FD2D;
        Thu, 19 Mar 2020 10:14:07 +0100 (CET)
From:   =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
To:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     mark.rutland@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64/sdei: gather trampolines' .rodata
Date:   Thu, 19 Mar 2020 11:14:06 +0200
Message-Id: <20200319091407.51449-2-remi@remlab.net>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <1938400.7m7sAWtiY1@basile.remlab.net>
References: <1938400.7m7sAWtiY1@basile.remlab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>

This gathers the two bits of data together for clarity.

Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
---
 arch/arm64/kernel/entry.S | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 24f828739696..c36733d8cd75 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -862,6 +862,11 @@ SYM_CODE_END(tramp_exit_compat)
 SYM_DATA_START(__entry_tramp_data_start)
 	.quad	vectors
 SYM_DATA_END(__entry_tramp_data_start)
+#ifdef CONFIG_ARM_SDE_INTERFACE
+SYM_DATA_START(__sdei_asm_trampoline_next_handler)
+	.quad	__sdei_asm_handler
+SYM_DATA_END(__sdei_asm_trampoline_next_handler)
+#endif /* CONFIG_ARM_SDE_INTERFACE */
 	.popsection				// .rodata
 #endif /* CONFIG_RANDOMIZE_BASE */
 #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
@@ -980,13 +985,6 @@ SYM_CODE_END(__sdei_asm_exit_trampoline)
 NOKPROBE(__sdei_asm_exit_trampoline)
 	.ltorg
 .popsection		// .entry.tramp.text
-#ifdef CONFIG_RANDOMIZE_BASE
-.pushsection ".rodata", "a"
-SYM_DATA_START(__sdei_asm_trampoline_next_handler)
-	.quad	__sdei_asm_handler
-SYM_DATA_END(__sdei_asm_trampoline_next_handler)
-.popsection		// .rodata
-#endif /* CONFIG_RANDOMIZE_BASE */
 #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
 
 /*
-- 
2.26.0.rc2

