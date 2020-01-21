Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0E0C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CB122522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgAUJeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:34:19 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:46844 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729191AbgAUJeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:34:16 -0500
Received: from ramsan ([84.195.182.253])
        by albert.telenet-ops.be with bizsmtp
        id sxaD2100M5USYZQ06xaDCK; Tue, 21 Jan 2020 10:34:14 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itpvI-0008IS-KR; Tue, 21 Jan 2020 10:34:12 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itpuM-0007Ss-21; Tue, 21 Jan 2020 10:33:14 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Porter <mporter@konsulko.com>,
        Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/3] dmaengine: Remove dma_device_satisfies_mask() wrapper
Date:   Tue, 21 Jan 2020 10:33:09 +0100
Message-Id: <20200121093311.28639-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200121093311.28639-1-geert+renesas@glider.be>
References: <20200121093311.28639-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit aa1e6f1a385eb2b0 ("dmaengine: kill struct dma_client and
supporting infrastructure") removed the last user of the
dma_device_satisfies_mask() wrapper.

Remove the wrapper, and rename __dma_device_satisfies_mask() to
dma_device_satisfies_mask(), to get rid of one more function starting
with a double underscore.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by,
  - Rebase on top of today's slave-dma/next.
---
 drivers/dma/dmaengine.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 158aeb1b6a8abd7f..7550dbdf548833ed 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -308,11 +308,8 @@ static void dma_channel_rebalance(void)
 		}
 }
 
-#define dma_device_satisfies_mask(device, mask) \
-	__dma_device_satisfies_mask((device), &(mask))
-static int
-__dma_device_satisfies_mask(struct dma_device *device,
-			    const dma_cap_mask_t *want)
+static int dma_device_satisfies_mask(struct dma_device *device,
+				     const dma_cap_mask_t *want)
 {
 	dma_cap_mask_t has;
 
@@ -531,7 +528,7 @@ static struct dma_chan *private_candidate(const dma_cap_mask_t *mask,
 {
 	struct dma_chan *chan;
 
-	if (mask && !__dma_device_satisfies_mask(dev, mask)) {
+	if (mask && !dma_device_satisfies_mask(dev, mask)) {
 		dev_dbg(dev->dev, "%s: wrong capabilities\n", __func__);
 		return NULL;
 	}
-- 
2.17.1

