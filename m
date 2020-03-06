Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A2BC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 11:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382CF2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 11:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCFLbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 06:31:39 -0500
Received: from foss.arm.com ([217.140.110.172]:59960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgCFLbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 06:31:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FED431B;
        Fri,  6 Mar 2020 03:31:38 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F6683F6C4;
        Fri,  6 Mar 2020 03:31:37 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] drivers: soc: Fix COMPILE_TEST for IMX SCU
Date:   Fri,  6 Mar 2020 11:31:19 +0000
Message-Id: <20200306113119.56577-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMX SCU SoCs support COMPILE_TEST that allows to compile the driver on a
different platform for development purposes.
These SoCs depend on a firmware interface that is not built on COMPILE_TEST
mode. This results in triggering the following errors at compile time (on
arm64):

aarch64-none-linux-gnu-ld:
drivers/soc/imx/soc-imx-scu.o: in function `imx_scu_soc_probe':
soc-imx-scu.c:(.text+0x24): undefined reference to `imx_scu_get_handle'
aarch64-none-linux-gnu-ld:
soc-imx-scu.c:(.text+0xac): undefined reference to `imx_scu_call_rpc'
aarch64-none-linux-gnu-ld:
soc-imx-scu.c:(.text+0xd8): undefined reference to `imx_scu_call_rpc'
linux/Makefile:1078: recipe for target 'vmlinux' failed
make[1]: *** [vmlinux] Error 1
Makefile:180: recipe for target 'sub-make' failed
make: *** [sub-make] Error 2

Enable the relevant compilation units in the Makefile when the config option
is selected to address the issue.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 drivers/firmware/imx/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 08bc9ddfbdfb..5604adae31d9 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -2,3 +2,5 @@
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o
 obj-$(CONFIG_IMX_SCU_PD)	+= scu-pd.o
+
+obj-$(CONFIG_COMPILE_TEST)	+= imx-scu.o misc.o imx-scu-irq.o
-- 
2.25.1

