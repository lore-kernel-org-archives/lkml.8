Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71BAC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 12:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8963B20663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 12:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgCSMEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 08:04:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12099 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbgCSMEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 08:04:33 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2BF7BADBA913D66A3E33;
        Thu, 19 Mar 2020 20:04:26 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Mar 2020 20:04:19 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Derek Chickles <dchickles@marvell.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Satanand Burla" <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH net-next] liquidio: remove set but not used variable 's'
Date:   Thu, 19 Mar 2020 12:07:43 +0000
Message-ID: <20200319120743.28056-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306023254.61731-1-yuehaibing@huawei.com>
References: <20200306023254.61731-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/ethernet/cavium/liquidio/lio_main.c: In function 'octeon_chip_specific_setup':
drivers/net/ethernet/cavium/liquidio/lio_main.c:1378:8: warning:
 variable 's' set but not used [-Wunused-but-set-variable]

It's not used since commit b6334be64d6f ("net/liquidio: Delete driver version assignment")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/cavium/liquidio/lio_main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index a8d9ec927627..66d31c018c7e 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -1375,7 +1375,6 @@ static int octeon_chip_specific_setup(struct octeon_device *oct)
 {
 	u32 dev_id, rev_id;
 	int ret = 1;
-	char *s;
 
 	pci_read_config_dword(oct->pci_dev, 0, &dev_id);
 	pci_read_config_dword(oct->pci_dev, 8, &rev_id);
@@ -1385,13 +1384,11 @@ static int octeon_chip_specific_setup(struct octeon_device *oct)
 	case OCTEON_CN68XX_PCIID:
 		oct->chip_id = OCTEON_CN68XX;
 		ret = lio_setup_cn68xx_octeon_device(oct);
-		s = "CN68XX";
 		break;
 
 	case OCTEON_CN66XX_PCIID:
 		oct->chip_id = OCTEON_CN66XX;
 		ret = lio_setup_cn66xx_octeon_device(oct);
-		s = "CN66XX";
 		break;
 
 	case OCTEON_CN23XX_PCIID_PF:
@@ -1404,11 +1401,9 @@ static int octeon_chip_specific_setup(struct octeon_device *oct)
 			pci_sriov_set_totalvfs(oct->pci_dev,
 					       oct->sriov_info.max_vfs);
 #endif
-		s = "CN23XX";
 		break;
 
 	default:
-		s = "?";
 		dev_err(&oct->pci_dev->dev, "Unknown device found (dev_id: %x)\n",
 			dev_id);
 	}



