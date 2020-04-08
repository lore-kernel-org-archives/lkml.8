Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339A0C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127E82076D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgDHPzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:55:07 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:35939 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbgDHPzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:55:06 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MFL8J-1jWtE512Xx-00FjXx; Wed, 08 Apr 2020 17:54:52 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Erin Lo <erin.lo@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remoteproc: mtk_scp: use dma_addr_t for DMA API
Date:   Wed,  8 Apr 2020 17:54:29 +0200
Message-Id: <20200408155450.2186471-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZXUS0WnSgpDrLDUPXUv4WC9aMIcDFvE3FAcQZyRtm4Fcfz/PImX
 YbWkCxd19WeDTGPPYTgd612QtlZrf+VzZzOOCH0pmwqI038hD+0qc+LvVJdMPjMhgM1pVhu
 go5ASoaJNzp5rdg5N+pmgTNW3g41CDoPdsEkpZtV+L3XewxdrTSjHqU22VZ0PWae5Kwq3Pw
 h3o9mR8BPo8jgPE5vh0FA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5giCQrLFcdI=:WP8aJCXVXjHUf1G2MYPuKx
 yJgLARtxvOSu8qnX/bKwmAycVMI9Ku5uj0yyzrVB9nW58PfVRJs65pUuF0H9Qo2W2ZTAEq49k
 3y699LxloIhuwMoS6hVUlgwvGGnSJzmojo9Mf02Mhy3Z+xOEIQguuikvibM7y/s/PCWwZ8spK
 IPwHZh1MMY9ecU2slK/xFv8VpyAzGsc/1Sjg7JstBxpCj02136j2qruVF12gi7icZ9SGMaCeX
 0KX1sJJ3RYI7c2NsBZ3/fuTmMT9temdtJY6QJykBNzjUuelBIzv5uQ57q0kTi5GjZcZ40sos+
 /Prhow+ydB2cQ6XADUXKMdqf7mdWQKxwV6DJnWXnd4uePBWjc/Z6izEFm/qzemKPwMuuKl7/E
 kfvGKCgV2uytBJtiywdWD6YckByPYzdVMoB6NM9rhjF4h7gAAxcsTM1off2NJSezjna6g8wBO
 JFZe//nrHSIdXnsDvQnwAgxoGrg8FsRDQbACxTKdrl2dyUr46J+GjPKfTyshbml4gTpmhFWEj
 fyooy45R9craWPeDTRYesoJojzRqOXKxUEfeNqG8oslev52UPYKWNfq516U34lK624xThg12j
 GCXZi9chpCTIKNkY/yTUtqdpwQA4Cqj+T0WtAStWR8d02WOYb7ddNRZSTYzJJUsBMsG4WCexW
 7dklVzWRJBNxwLvFhT3WBCHwhRJ7YeXv5YaCatUgzDssoQxxCl4kWjlIsHoWE870RHmlFNRdh
 qiYH1+2a1wdf9Ig4cFndjwm+df8zZFPPNKnyZYtbGEl3BUrY85gfILecuR9g5HEvkdtYtGz2e
 8Mkud02TZqOwHPqE1+pvDbza+thSWuOz71bUxIf99neDgi6ZCY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_addr_t and phys_addr_t are distinct types and must not be
mixed, as both the values and the size of the type may be
different depending on what the remote device uses.

In this driver the compiler warns when the two types are different:

drivers/remoteproc/mtk_scp.c: In function 'scp_map_memory_region':
drivers/remoteproc/mtk_scp.c:454:9: error: passing argument 3 of 'dma_alloc_coherent' from incompatible pointer type [-Werror=incompatible-pointer-types]
  454 |         &scp->phys_addr, GFP_KERNEL);
      |         ^~~~~~~~~~~~~~~
      |         |
      |         phys_addr_t * {aka unsigned int *}
In file included from drivers/remoteproc/mtk_scp.c:7:
include/linux/dma-mapping.h:642:15: note: expected 'dma_addr_t *' {aka 'long long unsigned int *'} but argument is of type 'phys_addr_t *' {aka 'unsigned int *'}
  642 |   dma_addr_t *dma_handle, gfp_t gfp)

Change the phys_addr member to be typed and named according
to how it is allocated.

Fixes: 63c13d61eafe ("remoteproc/mediatek: add SCP support for mt8183")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/remoteproc/mtk_common.h | 2 +-
 drivers/remoteproc/mtk_scp.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index deb20096146a..0066c83636d0 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -68,7 +68,7 @@ struct mtk_scp {
 	wait_queue_head_t ack_wq;
 
 	void __iomem *cpu_addr;
-	phys_addr_t phys_addr;
+	dma_addr_t dma_addr;
 	size_t dram_size;
 
 	struct rproc_subdev *rpmsg_subdev;
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index ea3743e7e794..2bead57c9cf9 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -330,7 +330,7 @@ static void *scp_da_to_va(struct rproc *rproc, u64 da, size_t len)
 		if (offset >= 0 && (offset + len) < scp->sram_size)
 			return (void __force *)scp->sram_base + offset;
 	} else {
-		offset = da - scp->phys_addr;
+		offset = da - scp->dma_addr;
 		if (offset >= 0 && (offset + len) < scp->dram_size)
 			return (void __force *)scp->cpu_addr + offset;
 	}
@@ -451,7 +451,7 @@ static int scp_map_memory_region(struct mtk_scp *scp)
 	/* Reserved SCP code size */
 	scp->dram_size = MAX_CODE_SIZE;
 	scp->cpu_addr = dma_alloc_coherent(scp->dev, scp->dram_size,
-					   &scp->phys_addr, GFP_KERNEL);
+					   &scp->dma_addr, GFP_KERNEL);
 	if (!scp->cpu_addr)
 		return -ENOMEM;
 
@@ -461,7 +461,7 @@ static int scp_map_memory_region(struct mtk_scp *scp)
 static void scp_unmap_memory_region(struct mtk_scp *scp)
 {
 	dma_free_coherent(scp->dev, scp->dram_size, scp->cpu_addr,
-			  scp->phys_addr);
+			  scp->dma_addr);
 	of_reserved_mem_device_release(scp->dev);
 }
 
-- 
2.26.0

