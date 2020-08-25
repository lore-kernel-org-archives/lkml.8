Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BD3C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FA252071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgHYISA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:18:00 -0400
Received: from out28-125.mail.aliyun.com ([115.124.28.125]:59614 "EHLO
        out28-125.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgHYIR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:17:56 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.104732|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00882627-0.000303889-0.99087;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03275;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.INYD1yr_1598343458;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.INYD1yr_1598343458)
          by smtp.aliyun-inc.com(10.147.41.158);
          Tue, 25 Aug 2020 16:17:53 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhenwenjin@gmail.com, sernia.zhou@foxmail.com,
        yanfei.li@ingenic.com, rick.tyliu@ingenic.com,
        aric.pzqi@ingenic.com, dongsheng.qiu@ingenic.com
Subject: [PATCH 1/1] USB: PHY: JZ4770: Fix static checker warning.
Date:   Tue, 25 Aug 2020 16:16:54 +0800
Message-Id: <20200825081654.18186-2-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200825081654.18186-1-zhouyanjie@wanyeetech.com>
References: <20200825081654.18186-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 2a6c0b82e651 ("USB: PHY: JZ4770: Add support for new
Ingenic SoCs.") introduced the initialization function for different
chips, but left the relevant code involved in the resetting process
in the original function, resulting in uninitialized variable calls.

Fixes: 2a6c0b82e651 ("USB: PHY: JZ4770: Add support for new
Ingenic SoCs.").

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 drivers/usb/phy/phy-jz4770.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/phy/phy-jz4770.c b/drivers/usb/phy/phy-jz4770.c
index d4ee3cb721ea..f6d3731581eb 100644
--- a/drivers/usb/phy/phy-jz4770.c
+++ b/drivers/usb/phy/phy-jz4770.c
@@ -176,6 +176,7 @@ static int ingenic_usb_phy_init(struct usb_phy *phy)
 
 	/* Wait for PHY to reset */
 	usleep_range(30, 300);
+	reg = readl(priv->base + REG_USBPCR_OFFSET);
 	writel(reg & ~USBPCR_POR, priv->base + REG_USBPCR_OFFSET);
 	usleep_range(300, 1000);
 
-- 
2.11.0

