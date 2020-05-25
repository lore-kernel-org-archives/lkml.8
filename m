Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2F2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 13:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A2C42078B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 13:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390688AbgEYNJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 09:09:09 -0400
Received: from mail.loongson.cn ([114.242.206.163]:55272 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388738AbgEYNJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 09:09:08 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb2pqw8tegOs4AA--.606S2;
        Mon, 25 May 2020 21:09:00 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH v2 1/2] phy: rockchip: Fix return value of inno_dsidphy_probe()
Date:   Mon, 25 May 2020 21:08:57 +0800
Message-Id: <1590412138-13903-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxb2pqw8tegOs4AA--.606S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw18Zw1xXFykWFy7ZrW3GFg_yoWkuFXEkw
        47Zwn3Xr18uF1Fva15K34xCrWDAr1qgr48Wa1Iyay3A3Wqqw1SqFWfuws3JFWUAFsxCFWU
        CasF9r17urW3KjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbz8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
        xKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUw6wZUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When call function devm_platform_ioremap_resource(), we should use IS_ERR()
to check the return value and return PTR_ERR() if failed.

Fixes: b7535a3bc0ba ("phy/rockchip: Add support for Innosilicon MIPI/LVDS/TTL PHY")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---

v2:
  - No changes, just add Reviewed-by tag

 drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c b/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
index a7c6c94..8af8c6c 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
@@ -607,8 +607,8 @@ static int inno_dsidphy_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, inno);
 
 	inno->phy_base = devm_platform_ioremap_resource(pdev, 0);
-	if (!inno->phy_base)
-		return -ENOMEM;
+	if (IS_ERR(inno->phy_base))
+		return PTR_ERR(inno->phy_base);
 
 	inno->ref_clk = devm_clk_get(dev, "ref");
 	if (IS_ERR(inno->ref_clk)) {
-- 
2.1.0

