Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B626C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 00:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3442920734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 00:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgFBAyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 20:54:40 -0400
Received: from out28-122.mail.aliyun.com ([115.124.28.122]:49447 "EHLO
        out28-122.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFBAyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 20:54:40 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4580702|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0143612-0.00041111-0.985228;FP=12664043516937949436|1|1|1|0|-1|-1|-1;HT=e02c03302;MF=maochenxi@eswin.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.HguMbpK_1591059270;
Received: from localhost.localdomain(mailfrom:maochenxi@eswin.com fp:SMTPD_---.HguMbpK_1591059270)
          by smtp.aliyun-inc.com(10.194.97.246);
          Tue, 02 Jun 2020 08:54:36 +0800
From:   Chenxi Mao <maochenxi@eswin.com>
To:     paul.walmsley@sifive.com
Cc:     palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        maochenxi@eswin.com
Subject: [PATCH 1/1] riscv: Select ARCH_SUPPORTS_ATOMIC_RMW by default
Date:   Tue,  2 Jun 2020 08:54:28 +0800
Message-Id: <20200602005428.18087-1-maochenxi@eswin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable ARCH_SUPPORTS_ATOMIC_RMW by default to support
osq_lock in mutex/rwsem locks.
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

