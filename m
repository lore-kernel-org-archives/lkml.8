Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CB8C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 12:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C97A1206EB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 12:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgICMkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 08:40:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57448 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728843AbgICM2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 08:28:40 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AFCE63F9BEBA75A3CE5D;
        Thu,  3 Sep 2020 20:28:32 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Sep 2020 20:28:24 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/3] ARM: debug: add UART early console support for SD5203
Date:   Thu, 3 Sep 2020 20:27:33 +0800
Message-ID: <20200903122734.2369-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200903122734.2369-1-thunder.leizhen@huawei.com>
References: <20200903122734.2369-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

Add support of early console for SD5203.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/Kconfig.debug | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 80000a66a4e3..d27a7764c3bf 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1086,6 +1086,14 @@ choice
 		  on SA-11x0 UART ports. The kernel will check for the first
 		  enabled UART in a sequence 3-1-2.
 
+	config DEBUG_SD5203_UART
+		bool "Hisilicon SD5203 Debug UART"
+		depends on ARCH_SD5203
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on SD5203 UART.
+
 	config DEBUG_SOCFPGA_UART0
 		depends on ARCH_SOCFPGA
 		bool "Use SOCFPGA UART0 for low-level debug"
@@ -1639,6 +1647,7 @@ config DEBUG_UART_PHYS
 	default 0x11006000 if DEBUG_MT6589_UART0
 	default 0x11009000 if DEBUG_MT8135_UART3
 	default 0x16000000 if DEBUG_INTEGRATOR
+	default 0x1600d000 if DEBUG_SD5203_UART
 	default 0x18000300 if DEBUG_BCM_5301X
 	default 0x18000400 if DEBUG_BCM_HR2
 	default 0x18010000 if DEBUG_SIRFATLAS7_UART0
@@ -1841,7 +1850,7 @@ config DEBUG_UART_VIRT
 	default 0xfec60000 if DEBUG_SIRFPRIMA2_UART1
 	default 0xfec90000 if DEBUG_RK32_UART2
 	default 0xfed0c000 if DEBUG_DAVINCI_DA8XX_UART1
-	default 0xfed0d000 if DEBUG_DAVINCI_DA8XX_UART2
+	default 0xfed0d000 if DEBUG_DAVINCI_DA8XX_UART2 || DEBUG_SD5203_UART
 	default 0xfed60000 if DEBUG_RK29_UART0
 	default 0xfed64000 if DEBUG_RK29_UART1 || DEBUG_RK3X_UART2
 	default 0xfed68000 if DEBUG_RK29_UART2 || DEBUG_RK3X_UART3
-- 
2.26.0.106.g9fadedd


