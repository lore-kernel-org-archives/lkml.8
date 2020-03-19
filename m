Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3FBC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 09:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEDA20722
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 09:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgCSJOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 05:14:09 -0400
Received: from poy.remlab.net ([94.23.215.26]:55514 "EHLO
        ns207790.ip-94-23-215.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgCSJOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 05:14:08 -0400
Received: from basile.remlab.net (ip6-localhost [IPv6:::1])
        by ns207790.ip-94-23-215.eu (Postfix) with ESMTP id 437B75FB07;
        Thu, 19 Mar 2020 10:14:07 +0100 (CET)
From:   =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
To:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     mark.rutland@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: clean up trampoline vector loads
Date:   Thu, 19 Mar 2020 11:14:05 +0200
Message-Id: <20200319091407.51449-1-remi@remlab.net>
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

This switches from custom instruction patterns to the regular large
memory model sequence with ADRP and LDR. In doing so, the ADD
instruction can be eliminated in the SDEI handler, and the code no
longer assumes that the trampoline vectors and the vectors address both
start on a page boundary.

Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
---
 arch/arm64/kernel/entry.S | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index e5d4e30ee242..24f828739696 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -805,9 +805,9 @@ alternative_else_nop_endif
 2:
 	tramp_map_kernel	x30
 #ifdef CONFIG_RANDOMIZE_BASE
-	adr	x30, tramp_vectors + PAGE_SIZE
+	adrp	x30, tramp_vectors + PAGE_SIZE
 alternative_insn isb, nop, ARM64_WORKAROUND_QCOM_FALKOR_E1003
-	ldr	x30, [x30]
+	ldr	x30, [x30, #:lo12:__entry_tramp_data_start]
 #else
 	ldr	x30, =vectors
 #endif
@@ -953,9 +953,8 @@ SYM_CODE_START(__sdei_asm_entry_trampoline)
 1:	str	x4, [x1, #(SDEI_EVENT_INTREGS + S_ORIG_ADDR_LIMIT)]
 
 #ifdef CONFIG_RANDOMIZE_BASE
-	adr	x4, tramp_vectors + PAGE_SIZE
-	add	x4, x4, #:lo12:__sdei_asm_trampoline_next_handler
-	ldr	x4, [x4]
+	adrp	x4, tramp_vectors + PAGE_SIZE
+	ldr	x4, [x4, #:lo12:__sdei_asm_trampoline_next_handler]
 #else
 	ldr	x4, =__sdei_asm_handler
 #endif
-- 
2.26.0.rc2

