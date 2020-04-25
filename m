Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C9CC55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 08:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BC4A21655
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 08:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgDYIud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 04:50:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40366 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbgDYIuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 04:50:32 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 73750CDE3F05F8D7501A;
        Sat, 25 Apr 2020 16:50:30 +0800 (CST)
Received: from huawei.com (10.67.174.156) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Sat, 25 Apr 2020
 16:50:20 +0800
From:   ChenTao <chentao107@huawei.com>
To:     <f.fainelli@gmail.com>, <hkallweit1@gmail.com>
CC:     <linux@armlinux.org.uk>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <chentao107@huawei.com>
Subject: [PATCH] net: phy: bcm54140: Make a bunch of functions static
Date:   Sat, 25 Apr 2020 16:49:44 +0800
Message-ID: <20200425084944.152130-1-chentao107@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.156]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning:

drivers/net/phy/bcm54140.c:663:5: warning:
symbol 'bcm54140_did_interrupt' was not declared. Should it be static?
drivers/net/phy/bcm54140.c:672:5: warning:
symbol 'bcm54140_ack_intr' was not declared. Should it be static?
drivers/net/phy/bcm54140.c:684:5: warning:
symbol 'bcm54140_config_intr' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: ChenTao <chentao107@huawei.com>
---
 drivers/net/phy/bcm54140.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/bcm54140.c b/drivers/net/phy/bcm54140.c
index 7341f0126cc4..c009ac2856a5 100644
--- a/drivers/net/phy/bcm54140.c
+++ b/drivers/net/phy/bcm54140.c
@@ -660,7 +660,7 @@ static int bcm54140_config_init(struct phy_device *phydev)
 				  BCM54140_RDB_C_PWR_ISOLATE, 0);
 }
 
-int bcm54140_did_interrupt(struct phy_device *phydev)
+static int bcm54140_did_interrupt(struct phy_device *phydev)
 {
 	int ret;
 
@@ -669,7 +669,7 @@ int bcm54140_did_interrupt(struct phy_device *phydev)
 	return (ret < 0) ? 0 : ret;
 }
 
-int bcm54140_ack_intr(struct phy_device *phydev)
+static int bcm54140_ack_intr(struct phy_device *phydev)
 {
 	int reg;
 
@@ -681,7 +681,7 @@ int bcm54140_ack_intr(struct phy_device *phydev)
 	return 0;
 }
 
-int bcm54140_config_intr(struct phy_device *phydev)
+static int bcm54140_config_intr(struct phy_device *phydev)
 {
 	struct bcm54140_priv *priv = phydev->priv;
 	static const u16 port_to_imr_bit[] = {
-- 
2.22.0

