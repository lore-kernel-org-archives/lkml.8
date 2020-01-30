Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6541C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E4E20CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580412267;
	bh=TrRaQthK8m6BtxdyCaj4wWJC5pDJNP5lkAkWdi0Y8WI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=e2OUN5ho58YHm1OKYkdrFfPZEMQclOq/g7jqkxKJz8V9GIGZVjYN82ik/W6k8KXbs
	 WNhPNte0jp5678XD7+zZtaflMyZxzVjKNolleUyoMYz2NhIdCsyY5J2bZwVKHLOf9X
	 4Kdb9SaYu2Oh5Mqdq65tylPHcS/Zhwp8l3ztTg5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgA3TY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:24:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:47170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbgA3TY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:24:26 -0500
Received: from localhost.localdomain (unknown [194.230.155.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0FC2205F4;
        Thu, 30 Jan 2020 19:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580412265;
        bh=TrRaQthK8m6BtxdyCaj4wWJC5pDJNP5lkAkWdi0Y8WI=;
        h=From:To:Cc:Subject:Date:From;
        b=CCTtQpjfPQYptKjS06ibuc8TgZgCC3OAT/n1+qVF4PQldzKUye/mcIm7/I4zuadMk
         lykAWk5JhvzxmJd1ti8DEgNuCoRNwLDQzBJDfUp80+uTfUYGZRng7Qo6lFD8PlEz/v
         ccN6MAI3a1dd7yytzg2LSIMKwymsA6nxHBSae1EA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] ARC: Cleanup old Kconfig IO scheduler options
Date:   Thu, 30 Jan 2020 20:24:03 +0100
Message-Id: <20200130192403.2982-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_IOSCHED_DEADLINE and CONFIG_IOSCHED_CFQ are gone since
commit f382fb0bcef4 ("block: remove legacy IO schedulers").

The IOSCHED_DEADLINE was replaced by MQ_IOSCHED_DEADLINE and it will be
now enabled by default (along with MQ_IOSCHED_KYBER).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arc/configs/nps_defconfig             | 2 --
 arch/arc/configs/nsimosci_defconfig        | 2 --
 arch/arc/configs/nsimosci_hs_defconfig     | 2 --
 arch/arc/configs/nsimosci_hs_smp_defconfig | 2 --
 4 files changed, 8 deletions(-)

diff --git a/arch/arc/configs/nps_defconfig b/arch/arc/configs/nps_defconfig
index 07f26ed39f02..f7a978dfdf1d 100644
--- a/arch/arc/configs/nps_defconfig
+++ b/arch/arc/configs/nps_defconfig
@@ -21,8 +21,6 @@ CONFIG_MODULES=y
 CONFIG_MODULE_FORCE_LOAD=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARC_PLAT_EZNPS=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=4096
diff --git a/arch/arc/configs/nsimosci_defconfig b/arch/arc/configs/nsimosci_defconfig
index 5dd470b6609e..bf39a0091679 100644
--- a/arch/arc/configs/nsimosci_defconfig
+++ b/arch/arc/configs/nsimosci_defconfig
@@ -20,8 +20,6 @@ CONFIG_ISA_ARCOMPACT=y
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARC_BUILTIN_DTB_NAME="nsimosci"
 # CONFIG_COMPACTION is not set
 CONFIG_NET=y
diff --git a/arch/arc/configs/nsimosci_hs_defconfig b/arch/arc/configs/nsimosci_hs_defconfig
index 3532e86f7bff..7121bd71c543 100644
--- a/arch/arc/configs/nsimosci_hs_defconfig
+++ b/arch/arc/configs/nsimosci_hs_defconfig
@@ -19,8 +19,6 @@ CONFIG_PERF_EVENTS=y
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_ISA_ARCV2=y
 CONFIG_ARC_BUILTIN_DTB_NAME="nsimosci_hs"
 # CONFIG_COMPACTION is not set
diff --git a/arch/arc/configs/nsimosci_hs_smp_defconfig b/arch/arc/configs/nsimosci_hs_smp_defconfig
index d90448bee064..f9863b294a70 100644
--- a/arch/arc/configs/nsimosci_hs_smp_defconfig
+++ b/arch/arc/configs/nsimosci_hs_smp_defconfig
@@ -14,8 +14,6 @@ CONFIG_PERF_EVENTS=y
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_ISA_ARCV2=y
 CONFIG_SMP=y
 # CONFIG_ARC_TIMERS_64BIT is not set
-- 
2.17.1

