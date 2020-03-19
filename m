Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C670C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 09:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6955E20740
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 09:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgCSJOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 05:14:14 -0400
Received: from poy.remlab.net ([94.23.215.26]:55534 "EHLO
        ns207790.ip-94-23-215.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgCSJOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 05:14:10 -0400
Received: from basile.remlab.net (ip6-localhost [IPv6:::1])
        by ns207790.ip-94-23-215.eu (Postfix) with ESMTP id 6534E5FDA2;
        Thu, 19 Mar 2020 10:14:08 +0100 (CET)
From:   =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
To:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     mark.rutland@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: reduce trampoline data alignment
Date:   Thu, 19 Mar 2020 11:14:07 +0200
Message-Id: <20200319091407.51449-3-remi@remlab.net>
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

The trampoline data, currently consisting of two relocated pointers,
must be within a single page. However, there are no needs for it to
start a page.

This reduces the alignment to 16 bytes, which is sufficient to ensure
that the data is entirely within a single page of the fixmap.

Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
---
 arch/arm64/kernel/entry.S | 2 +-
 arch/arm64/mm/mmu.c       | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index c36733d8cd75..ecad15443655 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -858,7 +858,7 @@ SYM_CODE_END(tramp_exit_compat)
 	.popsection				// .entry.tramp.text
 #ifdef CONFIG_RANDOMIZE_BASE
 	.pushsection ".rodata", "a"
-	.align PAGE_SHIFT
+	.align	4	// all .rodata must be in a single fixmap page
 SYM_DATA_START(__entry_tramp_data_start)
 	.quad	vectors
 SYM_DATA_END(__entry_tramp_data_start)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 9b08f7c7e6f0..6a0e75f48e7b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -599,9 +599,8 @@ static int __init map_entry_trampoline(void)
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
 		extern char __entry_tramp_data_start[];
 
-		__set_fixmap(FIX_ENTRY_TRAMP_DATA,
-			     __pa_symbol(__entry_tramp_data_start),
-			     PAGE_KERNEL_RO);
+		pa_start = __pa_symbol(__entry_tramp_data_start) & PAGE_MASK;
+		__set_fixmap(FIX_ENTRY_TRAMP_DATA, pa_start, PAGE_KERNEL_RO);
 	}
 
 	return 0;
-- 
2.26.0.rc2

