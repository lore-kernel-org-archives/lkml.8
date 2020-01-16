Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A2BC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D7E20748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579218509;
	bh=mxaea8o3Ja4Y+YrENoXQ3bG8W0GENK/kDHY+RA6NYKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BcAgqywlGvqE3WnzMhi0RMFm7912FVBam0F60GK1RiDBHj4ABOLr8vOodvazPBhyy
	 Y49yN5rNg6JSaaGb5PKU0NFpdZD0dpc6F87ITsexnZDFMxSAXTiifOXRJFVobMqCnM
	 lPQQ82CJ4vQ44I+mYmRRbisjkBbUcs2HF7ZxnaX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392020AbgAPXs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:48:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:45890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390453AbgAPXTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:19:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47CD92072B;
        Thu, 16 Jan 2020 23:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579216787;
        bh=mxaea8o3Ja4Y+YrENoXQ3bG8W0GENK/kDHY+RA6NYKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mhY9SM01trdcTNjIhEjbNblYNx9eLb5SWLqQMVlcRIX/Vh4LbldQyR1wXl8ZnPKUl
         Hy1YElsJ5qHkPF5UFW/afflinZ6IeUAUw9HjPy4rGIoH1hVZ3qfXFFjooW5XO39KGO
         ZBeTPAiuCckI5Gz/+rIUIkAe6nS1FJCU0QfjRZyk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olivier Moysan <olivier.moysan@st.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.4 011/203] ASoC: stm32: spdifrx: fix inconsistent lock state
Date:   Fri, 17 Jan 2020 00:15:28 +0100
Message-Id: <20200116231745.890414946@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olivier Moysan <olivier.moysan@st.com>

commit 2859b1784031b5709446af8f6039c467f136e67d upstream.

In current spdifrx driver locks may be requested as follows:
- request lock on iec capture control, when starting synchronization.
- request lock in interrupt context, when spdifrx stop is called
from IRQ handler.

Take lock with IRQs disabled, to avoid the possible deadlock.

Lockdep report:
[   74.278059] ================================
[   74.282306] WARNING: inconsistent lock state
[   74.290120] --------------------------------
...
[   74.314373]        CPU0
[   74.314377]        ----
[   74.314381]   lock(&(&spdifrx->lock)->rlock);
[   74.314396]   <Interrupt>
[   74.314400]     lock(&(&spdifrx->lock)->rlock);

Fixes: 03e4d5d56fa5 ("ASoC: stm32: Add SPDIFRX support")

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Link: https://lore.kernel.org/r/20191204154333.7152-2-olivier.moysan@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/stm/stm32_spdifrx.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -320,6 +320,7 @@ static void stm32_spdifrx_dma_ctrl_stop(
 static int stm32_spdifrx_start_sync(struct stm32_spdifrx_data *spdifrx)
 {
 	int cr, cr_mask, imr, ret;
+	unsigned long flags;
 
 	/* Enable IRQs */
 	imr = SPDIFRX_IMR_IFEIE | SPDIFRX_IMR_SYNCDIE | SPDIFRX_IMR_PERRIE;
@@ -327,7 +328,7 @@ static int stm32_spdifrx_start_sync(stru
 	if (ret)
 		return ret;
 
-	spin_lock(&spdifrx->lock);
+	spin_lock_irqsave(&spdifrx->lock, flags);
 
 	spdifrx->refcount++;
 
@@ -360,7 +361,7 @@ static int stm32_spdifrx_start_sync(stru
 				"Failed to start synchronization\n");
 	}
 
-	spin_unlock(&spdifrx->lock);
+	spin_unlock_irqrestore(&spdifrx->lock, flags);
 
 	return ret;
 }
@@ -368,11 +369,12 @@ static int stm32_spdifrx_start_sync(stru
 static void stm32_spdifrx_stop(struct stm32_spdifrx_data *spdifrx)
 {
 	int cr, cr_mask, reg;
+	unsigned long flags;
 
-	spin_lock(&spdifrx->lock);
+	spin_lock_irqsave(&spdifrx->lock, flags);
 
 	if (--spdifrx->refcount) {
-		spin_unlock(&spdifrx->lock);
+		spin_unlock_irqrestore(&spdifrx->lock, flags);
 		return;
 	}
 
@@ -391,7 +393,7 @@ static void stm32_spdifrx_stop(struct st
 	regmap_read(spdifrx->regmap, STM32_SPDIFRX_DR, &reg);
 	regmap_read(spdifrx->regmap, STM32_SPDIFRX_CSR, &reg);
 
-	spin_unlock(&spdifrx->lock);
+	spin_unlock_irqrestore(&spdifrx->lock, flags);
 }
 
 static int stm32_spdifrx_dma_ctrl_register(struct device *dev,


