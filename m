Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DD2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B5062067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgFCIOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 04:14:18 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:47821 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgFCIOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 04:14:17 -0400
Received: from debian.home (lfbn-gre-1-325-105.w90-112.abo.wanadoo.fr [90.112.45.105])
        (Authenticated sender: alex@ghiti.fr)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 14EA020000A;
        Wed,  3 Jun 2020 08:14:13 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v2 3/8] riscv: Simplify MAXPHYSMEM config
Date:   Wed,  3 Jun 2020 04:10:59 -0400
Message-Id: <20200603081104.14004-4-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200603081104.14004-1-alex@ghiti.fr>
References: <20200603081104.14004-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Either the user specifies maximum physical memory size of 2GB or the
user lives with the system constraint which is 1/4th of maximum
addressable memory in Sv39 MMU mode (i.e. 128GB) for now.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/Kconfig | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 64b25a90d60f..e167f16131f4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -106,7 +106,7 @@ config PAGE_OFFSET
 	default 0xC0000000 if 32BIT && MAXPHYSMEM_2GB
 	default 0x80000000 if 64BIT && !MMU
 	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
-	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
+	default 0xffffffe000000000 if 64BIT && !MAXPHYSMEM_2GB
 
 config ARCH_FLATMEM_ENABLE
 	def_bool y
@@ -223,19 +223,11 @@ config MODULE_SECTIONS
 	bool
 	select HAVE_MOD_ARCH_SPECIFIC
 
-choice
-	prompt "Maximum Physical Memory"
-	default MAXPHYSMEM_2GB if 32BIT
-	default MAXPHYSMEM_2GB if 64BIT && CMODEL_MEDLOW
-	default MAXPHYSMEM_128GB if 64BIT && CMODEL_MEDANY
-
-	config MAXPHYSMEM_2GB
-		bool "2GiB"
-	config MAXPHYSMEM_128GB
-		depends on 64BIT && CMODEL_MEDANY
-		bool "128GiB"
-endchoice
-
+config MAXPHYSMEM_2GB
+	bool "Maximum Physical Memory 2GiB"
+	default y if 32BIT
+	default y if 64BIT && CMODEL_MEDLOW
+	default n
 
 config SMP
 	bool "Symmetric Multi-Processing"
-- 
2.20.1

