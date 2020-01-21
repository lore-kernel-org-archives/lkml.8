Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F869C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8150C22522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgAUJeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:34:23 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:37228 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbgAUJeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:34:16 -0500
Received: from ramsan ([84.195.182.253])
        by xavier.telenet-ops.be with bizsmtp
        id sxaD2100H5USYZQ01xaDZk; Tue, 21 Jan 2020 10:34:14 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itpvI-0008IS-FH; Tue, 21 Jan 2020 10:34:12 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itpuM-0007Sy-3L; Tue, 21 Jan 2020 10:33:14 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Porter <mporter@konsulko.com>,
        Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 3/3] dmaengine: Move dma_get_{,any_}slave_channel() to private dmaengine.h
Date:   Tue, 21 Jan 2020 10:33:11 +0100
Message-Id: <20200121093311.28639-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200121093311.28639-1-geert+renesas@glider.be>
References: <20200121093311.28639-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions dma_get_slave_channel() and dma_get_any_slave_channel()
are called from DMA engine drivers only.  Hence move their declarations
from the public header file <linux/dmaengine.h> to the private header
file drivers/dma/dmaengine.h.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by,
  - Rebase on top of today's slave-dma/next.
---
 drivers/dma/dmaengine.h   | 3 +++
 drivers/dma/of-dma.c      | 2 ++
 include/linux/dmaengine.h | 2 --
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
index b0b97475707a789f..e8a320c9e57c2d74 100644
--- a/drivers/dma/dmaengine.h
+++ b/drivers/dma/dmaengine.h
@@ -179,4 +179,7 @@ dmaengine_desc_callback_valid(struct dmaengine_desc_callback *cb)
 	return (cb->callback) ? true : false;
 }
 
+struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
+struct dma_chan *dma_get_any_slave_channel(struct dma_device *device);
+
 #endif
diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index c2d779daa4b51ac8..b2c2b5e8093cf0d7 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -15,6 +15,8 @@
 #include <linux/of.h>
 #include <linux/of_dma.h>
 
+#include "dmaengine.h"
+
 static LIST_HEAD(of_dma_list);
 static DEFINE_MUTEX(of_dma_lock);
 
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 230d50ef7360ecee..9cc0e70e7c3543a9 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1522,8 +1522,6 @@ int dma_async_device_register(struct dma_device *device);
 int dmaenginem_async_device_register(struct dma_device *device);
 void dma_async_device_unregister(struct dma_device *device);
 void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
-struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
-struct dma_chan *dma_get_any_slave_channel(struct dma_device *device);
 #define dma_request_channel(mask, x, y) \
 	__dma_request_channel(&(mask), x, y, NULL)
 
-- 
2.17.1

