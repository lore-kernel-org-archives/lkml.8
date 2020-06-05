Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D001C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 03:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 706ED207D5
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 03:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgFEDeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 23:34:24 -0400
Received: from out28-53.mail.aliyun.com ([115.124.28.53]:47881 "EHLO
        out28-53.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbgFEDeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 23:34:23 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4069149|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0499898-0.00367699-0.946333;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03294;MF=maochenxi@eswin.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.HiN1LfG_1591328056;
Received: from localhost.localdomain(mailfrom:maochenxi@eswin.com fp:SMTPD_---.HiN1LfG_1591328056)
          by smtp.aliyun-inc.com(10.194.98.253);
          Fri, 05 Jun 2020 11:34:21 +0800
From:   Chenxi Mao <maochenxi@eswin.com>
To:     paul.walmsley@sifive.com
Cc:     palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        maochenxi@eswin.com
Subject: [PATCH 1/1] riscv: Select ARCH_SUPPORTS_ATOMIC_RMW by default
Date:   Fri,  5 Jun 2020 11:34:14 +0800
Message-Id: <20200605033414.10383-1-maochenxi@eswin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select ARCH_SUPPORTS_ATOMIC_RMW by default to enabel osqlocks.

PS2: Add signed off info.

Signed-off-by: Chenxi Mao <maochenxi@eswin.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a31e1a41913a..cbdc605d20d9 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -68,6 +68,7 @@ config RISCV
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_ARCH_KASAN if MMU && 64BIT
+	select ARCH_SUPPORTS_ATOMIC_RMW
 
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
-- 
2.25.1

