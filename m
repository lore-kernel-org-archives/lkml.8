Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92550C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E30206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388575AbgDBNYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:24:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36858 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387752AbgDBNYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:24:32 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CB7631D94BBBEF6722B3;
        Thu,  2 Apr 2020 21:23:58 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Apr 2020
 21:23:48 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <yuehaibing@huawei.com>,
        <nishadkamdar@gmail.com>, <nico@fluxnic.net>,
        <masahiroy@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gakula@marvell.com>
Subject: [PATCH net] net: cavium: Fix build errors due to 'imply CAVIUM_PTP'
Date:   Thu, 2 Apr 2020 21:23:44 +0800
Message-ID: <20200402132344.37864-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CAVIUM_PTP is m and THUNDER_NIC_VF is y, build fails:

drivers/net/ethernet/cavium/thunder/nicvf_main.o: In function 'nicvf_remove':
nicvf_main.c:(.text+0x1f0): undefined reference to 'cavium_ptp_put'
drivers/net/ethernet/cavium/thunder/nicvf_main.o: In function `nicvf_probe':
nicvf_main.c:(.text+0x557c): undefined reference to 'cavium_ptp_get'

THUNDER_NIC_VF imply CAVIUM_PTP, which allow the config now,
Use IS_REACHABLE() to avoid the vmlinux link error for this case.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: def2fbffe62c ("kconfig: allow symbols implied by y to become m")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/cavium/common/cavium_ptp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/common/cavium_ptp.h b/drivers/net/ethernet/cavium/common/cavium_ptp.h
index a04eccbc78e8..1e0ffe8f4152 100644
--- a/drivers/net/ethernet/cavium/common/cavium_ptp.h
+++ b/drivers/net/ethernet/cavium/common/cavium_ptp.h
@@ -24,7 +24,7 @@ struct cavium_ptp {
 	struct ptp_clock *ptp_clock;
 };
 
-#if IS_ENABLED(CONFIG_CAVIUM_PTP)
+#if IS_REACHABLE(CONFIG_CAVIUM_PTP)
 
 struct cavium_ptp *cavium_ptp_get(void);
 void cavium_ptp_put(struct cavium_ptp *ptp);
-- 
2.17.1


