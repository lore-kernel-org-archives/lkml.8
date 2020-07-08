Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE70C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 05:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD1C42078B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 05:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgGHFoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 01:44:06 -0400
Received: from out28-4.mail.aliyun.com ([115.124.28.4]:52971 "EHLO
        out28-4.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGHFoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 01:44:06 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.577819|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0144316-0.00272735-0.982841;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03294;MF=maochenxi@eswin.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.I-3Y8gn_1594187037;
Received: from localhost.localdomain(mailfrom:maochenxi@eswin.com fp:SMTPD_---.I-3Y8gn_1594187037)
          by smtp.aliyun-inc.com(10.194.97.171);
          Wed, 08 Jul 2020 13:44:01 +0800
From:   Chenxi Mao <maochenxi@eswin.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        chenxi.mao2013@gmail.com, Chenxi Mao <maochenxi@eswin.com>
Subject: [PATCH 1/1] riscv: Enable compiler optimizations
Date:   Wed,  8 Jul 2020 13:43:54 +0800
Message-Id: <20200708054354.25283-1-maochenxi@eswin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable ARCH_HAS_FAST_MULTIPLIER and ARCH_SUPPORTS_INT128 for better
code generation.
These 2 configurations works fine on GCC-9.3 and GCC-10.1

Signed-off-by: Chenxi Mao <maochenxi@eswin.com>
---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 128192e14ff2..f21b7e5188ca 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -26,6 +26,8 @@ config RISCV
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
+	select ARCH_HAS_FAST_MULTIPLIER
+	select ARCH_SUPPORTS_INT128 if GCC_VERSION >= 50000 || CC_IS_CLANG
 	select CLONE_BACKWARDS
 	select COMMON_CLK
 	select EDAC_SUPPORT
-- 
2.25.1

