Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE4AC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55D32071C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgCLJuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:50:05 -0400
Received: from poy.remlab.net ([94.23.215.26]:50956 "EHLO
        ns207790.ip-94-23-215.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCLJuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:50:05 -0400
Received: from basile.remlab.net (ip6-localhost [IPv6:::1])
        by ns207790.ip-94-23-215.eu (Postfix) with ESMTP id 983595FD7F;
        Thu, 12 Mar 2020 10:40:02 +0100 (CET)
From:   =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        kvmarm@lists.cs.columbia.edu, will@kernel.org,
        catalin.marinas@arm.com
Subject: [PATCH] arm64: move kimage_vaddr to .rodata
Date:   Thu, 12 Mar 2020 11:40:02 +0200
Message-Id: <20200312094002.153302-1-remi@remlab.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Remi Denis-Courmont <remi.denis.courmont@huawei.com>

This datum is not referenced from .idmap.text: it does not need to be
mapped in idmap. Lets move it to .rodata as it is never written to after
early boot of the primary CPU.
(Maybe .data.ro_after_init would be cleaner though?)

Signed-off-by: Rémi Denis-Courmont <remi@remlab.net>
---
 arch/arm64/kernel/head.S | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 6e08ee2b4d55..8e5c0e0040e4 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -457,17 +457,19 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 	b	start_kernel
 SYM_FUNC_END(__primary_switched)
 
+	.pushsection ".rodata", "a"
+SYM_DATA_START(kimage_vaddr)
+	.quad		_text - TEXT_OFFSET
+SYM_DATA_END(kimage_vaddr)
+EXPORT_SYMBOL(kimage_vaddr)
+	.popsection
+
 /*
  * end early head section, begin head code that is also used for
  * hotplug and needs to have the same protections as the text region
  */
 	.section ".idmap.text","awx"
 
-SYM_DATA_START(kimage_vaddr)
-	.quad		_text - TEXT_OFFSET
-SYM_DATA_END(kimage_vaddr)
-EXPORT_SYMBOL(kimage_vaddr)
-
 /*
  * If we're fortunate enough to boot at EL2, ensure that the world is
  * sane before dropping to EL1.
-- 
2.25.1

