Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AA7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 13:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D44792078B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 13:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403783AbgEYNJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 09:09:12 -0400
Received: from mail.loongson.cn ([114.242.206.163]:55274 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388757AbgEYNJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 09:09:10 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb2pqw8tegOs4AA--.606S3;
        Mon, 25 May 2020 21:09:00 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH v2 2/2] phy: Remove CONFIG_ARCH_* check for related subdir in Makefile
Date:   Mon, 25 May 2020 21:08:58 +0800
Message-Id: <1590412138-13903-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1590412138-13903-1-git-send-email-yangtiezhu@loongson.cn>
References: <1590412138-13903-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxb2pqw8tegOs4AA--.606S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1DtF13XFWDKryUCrWfZrb_yoW8Ar47pr
        s3trWUGrykGryUWFZFk390kF98tan7trWqgryfJ3W5JFn8CFWYqrnIgFy7JF1xXr4xJFW7
        G3Z3Ga43CF1Yk37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1Y6r17McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUoGQDUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_ARCH_ROCKCHIP is not set but COMPILE_TEST is set, the file in
the subdir rockchip can not be built due to CONFIG_ARCH_ROCKCHIP check
in drivers/phy/Makefile.

Since the related configs in drivers/phy/rockchip/Kconfig depend on
ARCH_ROCKCHIP, so remove CONFIG_ARCH_ROCKCHIP check for subdir rockchip
in drivers/phy/Makefile.

The other CONFIG_ARCH_* about allwinner, amlogic, mediatek, renesas and
tegra have the same situation, so remove them too.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

v2:
  - Remove all the CONFIG_ARCH_* check for related subdir in Makefile
  - Modify the patch subject and update commit message

 drivers/phy/Makefile | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 310c149..16e2622 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -8,24 +8,24 @@ obj-$(CONFIG_GENERIC_PHY_MIPI_DPHY)	+= phy-core-mipi-dphy.o
 obj-$(CONFIG_PHY_LPC18XX_USB_OTG)	+= phy-lpc18xx-usb-otg.o
 obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
 obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
-obj-$(CONFIG_ARCH_SUNXI)		+= allwinner/
-obj-$(CONFIG_ARCH_MESON)		+= amlogic/
-obj-$(CONFIG_ARCH_MEDIATEK)		+= mediatek/
-obj-$(CONFIG_ARCH_RENESAS)		+= renesas/
-obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
-obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
-obj-y					+= broadcom/	\
+obj-y					+= allwinner/	\
+					   amlogic/	\
+					   broadcom/	\
 					   cadence/	\
 					   freescale/	\
 					   hisilicon/	\
 					   intel/	\
 					   lantiq/	\
 					   marvell/	\
+					   mediatek/	\
 					   motorola/	\
 					   mscc/	\
 					   qualcomm/	\
 					   ralink/	\
+					   renesas/	\
+					   rockchip/	\
 					   samsung/	\
 					   socionext/	\
 					   st/		\
+					   tegra/	\
 					   ti/
-- 
2.1.0

