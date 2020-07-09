Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882A2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 05:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A4A92053B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 05:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgGIFTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 01:19:40 -0400
Received: from out28-171.mail.aliyun.com ([115.124.28.171]:48617 "EHLO
        out28-171.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgGIFTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 01:19:39 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.48121|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0183385-0.00121183-0.98045;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03310;MF=maochenxi@eswin.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.I-jIyZp_1594271970;
Received: from localhost.localdomain(mailfrom:maochenxi@eswin.com fp:SMTPD_---.I-jIyZp_1594271970)
          by smtp.aliyun-inc.com(10.194.97.171);
          Thu, 09 Jul 2020 13:19:34 +0800
From:   Chenxi Mao <maochenxi@eswin.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        chenxi.mao2013@gmail.com, Chenxi Mao <maochenxi@eswin.com>
Subject: [PATCH 1/1] riscv: Enable ARCH_HAS_FAST_MULTIPLIER for RV64I
Date:   Thu,  9 Jul 2020 13:19:22 +0800
Message-Id: <20200709051922.13110-1-maochenxi@eswin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable ARCH_HAS_FAST_MULTIPLIER on RV64I
which works fine on GCC-9.3 and GCC-10.1

PS2: remove ARCH_SUPPORTS_INT128 because of RV64I already enabled.

Signed-off-by: Chenxi Mao <maochenxi@eswin.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 128192e14ff2..84e6777fecad 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -202,6 +202,7 @@ config ARCH_RV64I
 	bool "RV64I"
 	select 64BIT
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && GCC_VERSION >= 50000
+	select ARCH_HAS_FAST_MULTIPLIER
 	select HAVE_DYNAMIC_FTRACE if MMU
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
-- 
2.25.1

