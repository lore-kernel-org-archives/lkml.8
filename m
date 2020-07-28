Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF017C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995DF2075A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgG1CYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:24:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37652 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726839AbgG1CYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:24:43 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9C45A9A8B866B49EC421;
        Tue, 28 Jul 2020 10:24:39 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Jul 2020 10:24:38 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ARM: s3c: fix return value check in s3c_usb_otgphy_init()
Date:   Tue, 28 Jul 2020 10:27:56 +0800
Message-ID: <20200728022756.87687-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the function clk_get() returns ERR_PTR() in case of error and
never returns NULL. So there's no need to test whether xusbxti
is NULL, just remove the redundant part in the return value check.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 arch/arm/mach-s3c64xx/setup-usb-phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c64xx/setup-usb-phy.c b/arch/arm/mach-s3c64xx/setup-usb-phy.c
index d6b0e3b26..99d743884 100644
--- a/arch/arm/mach-s3c64xx/setup-usb-phy.c
+++ b/arch/arm/mach-s3c64xx/setup-usb-phy.c
@@ -31,7 +31,7 @@ static int s3c_usb_otgphy_init(struct platform_device *pdev)
 	phyclk = readl(S3C_PHYCLK) & ~S3C_PHYCLK_CLKSEL_MASK;
 
 	xusbxti = clk_get(&pdev->dev, "xusbxti");
-	if (xusbxti && !IS_ERR(xusbxti)) {
+	if (!IS_ERR(xusbxti)) {
 		switch (clk_get_rate(xusbxti)) {
 		case 12 * MHZ:
 			phyclk |= S3C_PHYCLK_CLKSEL_12M;
-- 
2.25.1

