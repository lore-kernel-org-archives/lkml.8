Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC62C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0D82073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgAQP3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:29:46 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:45348 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbgAQP3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:29:41 -0500
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id rTVe210025USYZQ01TVeB5; Fri, 17 Jan 2020 16:29:38 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1isTZ3-0002FC-Va; Fri, 17 Jan 2020 16:29:37 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1isTZ3-00087f-Uc; Fri, 17 Jan 2020 16:29:37 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Matt Porter <mporter@konsulko.com>,
        Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] dmaengine: Remove dma_request_slave_channel_compat() wrapper
Date:   Fri, 17 Jan 2020 16:29:32 +0100
Message-Id: <20200117152933.31175-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200117152933.31175-1-geert+renesas@glider.be>
References: <20200117152933.31175-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At its original introduction, dma_request_slave_channel_compat() used a
wrapper, to accommodate filter functions that modify the mask passed.
Filter functions can no longer modify masks, and the mask parameter was
made const in commit a53e28da574a40bc ("dma: Make the 'mask' parameter
of __dma_request_channel const") consecutively.

Hence remove the wrapper, and rename __dma_request_slave_channel_compat()
to dma_request_slave_channel_compat(), to get rid of one more function
name starting with a double underscore.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/dmaengine.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 0e486bb224c5e6ce..8318645ddc1289c9 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1415,11 +1415,9 @@ struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
 struct dma_chan *dma_get_any_slave_channel(struct dma_device *device);
 #define dma_request_channel(mask, x, y) \
 	__dma_request_channel(&(mask), x, y, NULL)
-#define dma_request_slave_channel_compat(mask, x, y, dev, name) \
-	__dma_request_slave_channel_compat(&(mask), x, y, dev, name)
 
 static inline struct dma_chan
-*__dma_request_slave_channel_compat(const dma_cap_mask_t *mask,
+*dma_request_slave_channel_compat(const dma_cap_mask_t mask,
 				  dma_filter_fn fn, void *fn_param,
 				  struct device *dev, const char *name)
 {
@@ -1432,6 +1430,6 @@ static inline struct dma_chan
 	if (!fn || !fn_param)
 		return NULL;
 
-	return __dma_request_channel(mask, fn, fn_param, NULL);
+	return __dma_request_channel(&mask, fn, fn_param, NULL);
 }
 #endif /* DMAENGINE_H */
-- 
2.17.1

