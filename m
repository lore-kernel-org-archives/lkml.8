Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42839C2BB54
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176012075E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgDIHwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 03:52:19 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:47143 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgDIHwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 03:52:19 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MmyzH-1iuZbi1qn1-00k3v4; Thu, 09 Apr 2020 09:52:09 +0200
From:   Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: imx8: select SOC_BUS
Date:   Thu,  9 Apr 2020 09:51:48 +0200
Message-Id: <20200409075208.2824062-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LkzNn7xFJ+S4BreVJvd8lRBl/nAYYCjKyUmq0d3leAIueaMM0e+
 jnwqUH1rQ2RRvGZrmlAiN75Qu1m8zKFgZungN2D1qOVM2H38c/7hd7Ze8cj48w7/+EydLoQ
 Hni14QO/E93Q+hTDdjTSJER+Q7OLhXBQx2gORuibgd96D1dH/ouWVxelZEPXB+/Wf9zYBOX
 UrOVTaH/ZMm/iJgbYK37g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dCFo8GyL2i4=:cl9ebRjkrEp1wgV+ImJEzY
 pLPgUBL+krmv8nBO2eEtgQxgFLBXH86R1f3n0nuJmCTTb48Hd+ncCCHzoHGCM9HSv1x55oHtx
 sLgMc+C6/YYp9sQwA12ZdD5IwX+sX5ZtIINHG4wp3UMXz2RkPeC7UX+C3asCftg7vjlIDLY2z
 JgzGnZDbB/QjwyWw2eNf/5NsunhREJN4Wy7beiNcTewNqg7yyWlFf4sZ7zVzWBx3Z8bxzs9PQ
 nqwdaxVU/lpDm2DtWMjCXdCwBUx71jmLjfIsdMQ9+3rGJn1q54kl3GcJYK6DLWE/L/MNBXa7u
 r0EH4fcDt9MLlMyDjlD3BQbw5z+8dYIhNt/j6A8v3tD0C7WvU0IfxuWqQozSMgjpMflrAEGb4
 +aA3ZFP0UELKI6uzGXTSVCgxKogoeRu2FEjk8IsR9Tcm7w0RZnbj0/7PraqBuyWPtBkuDBpDJ
 zPjXLi+pLi4bEDJElddMYUGm800kumKT1yHtpplTr0VPzPToU/4pFfNlc0uKMXT2NMXwPsK7y
 2rK8Vy1xJnn9vdhv6HhGcWQKll1hJU33nHwPMh4AETqp0d3b8TwjJwuJUhUseTp+b1Q1eUgmo
 vcfIXsudmEi05a2AeNuyRPOepn9gUmea9OYtxUy76R/c5q0X4XXPZ8v8Hp1JY6cqQzsMC+PhF
 xeVooou0kBw4qbFhW6v+kh0TUF7PJnTTvSTFJtKgZt7GXpk6L/XsoEzWgyevj8xMTF6YufXpR
 57196LJnRXkGKGpikbA+U3XUO/kphRUXVKVC7eKrTlu2nHlPB+WDwhocb3hxUxOphVksTQJlo
 gtMtOfHxof3L1kXi9QyoT/KkJoB/Kun65ow9o6h6QkhlzJ2ERM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compile-testing the driver can result in a link failure
when CONFIG_SOC_BUS is disabled:

x86_64-linux-ld: drivers/soc/imx/soc-imx8m.o: in function `imx8_soc_init':
soc-imx8m.c:(.init.text+0x28d): undefined reference to `soc_device_register'

Select it from Kconfig, as we do from the other SoC drivers.

Fixes: fc40200ebf82 ("soc: imx: increase build coverage for imx8m soc driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index 67aa94b2481b..d515d2cc20ed 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -21,6 +21,7 @@ config SOC_IMX8M
 	bool "i.MX8M SoC family support"
 	depends on ARCH_MXC || COMPILE_TEST
 	default ARCH_MXC && ARM64
+	select SOC_BUS
 	help
 	  If you say yes here you get support for the NXP i.MX8M family
 	  support, it will provide the SoC info like SoC family,
-- 
2.26.0

