Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07B1C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7ABF20780
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UIvFNBqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgCWPA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:00:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35597 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgCWPAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:00:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id m3so15176972wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 08:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2YB83cTZZ+dkKwZqeNn0IusybULPWIXDl0NIQtgjxNE=;
        b=UIvFNBqBk7iR+4GmBLSv5tLbSq0g9hNsuFOdmXzf8SB+1Vono/LaQ8UrZfI99c4VuB
         m8XLCjmpRK8sz+6LGB2NS5X+4c91SyPHGjGUyAD5EfQcglQLa/AwWWunxvr8Dnup2qqw
         3iatTkbzC4mHtAXHUEDyGS8mdBA6MlbuZsfLn+wOHDaDpawS2BMuTsnrCMjYaNPDH2Wd
         /7cyjAsZhxbY9LUjuvHbW4wZNPoa+hkT/fae4sJ+jlXLyf7630wsjmhl7cRY2E3XQHWG
         je5DNo4Os5zBtI1QbBsShoZqbp58Wv7RBOslsVDunXpzfeDQF8xDVi1yWfBEkvmQE7bg
         kwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2YB83cTZZ+dkKwZqeNn0IusybULPWIXDl0NIQtgjxNE=;
        b=o9vT3vxGNagB+l1xrs+V7UFg2M+WgrMo2gw0f/k3GcEwWrvsdaLE7oTS6tGDG+ES/D
         A43/9rGALtPwoGet57dqbNr16DWCbeFBtTP0U3Y2FLJYJmPWjhYq4rEBpVRhEdOnDHSF
         mfWuv0FBwQHLpCGw7woCKLVkUqeuIGbov2yb3y1GsBquYCgYcfpztBhKMhJqenriesGT
         hT0X7ef/rVPWSWPNzCR0AHbR0Rq1KownasBWvZyuhmXhWhweA2lb81JLNNaT2GJxtsdB
         4yPyGckeDfsEXxfAOkKScu5Yi4LI0uywC4twa3AsrMRrrZAvBeBkbHVwhc+PMCezOHPv
         DiKw==
X-Gm-Message-State: ANhLgQ0HI9UwoeljPIltiH69xsLqcE0cVIcI87o48+ZDunBw0G4frhh6
        z5wiF0kyEVaI6DF0SERBIhjLAPRGvcc=
X-Google-Smtp-Source: ADFU+vuqvU5MNHtON+6hYZfmrYY4jiC3SNzkcUelz9medrmAfPETSSE5BQKe44c24aNdRviCQK5OaQ==
X-Received: by 2002:a05:600c:2a42:: with SMTP id x2mr1524441wme.77.1584975623017;
        Mon, 23 Mar 2020 08:00:23 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id k15sm1084196wrm.55.2020.03.23.08.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 08:00:22 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Freeman Liu <freeman.liu@unisoc.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/5] nvmem: sprd: Optimize the block lock operation
Date:   Mon, 23 Mar 2020 15:00:04 +0000
Message-Id: <20200323150007.7487-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200323150007.7487-1-srinivas.kandagatla@linaro.org>
References: <20200323150007.7487-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Freeman Liu <freeman.liu@unisoc.com>

We have some cases that will programme the eFuse block partially multiple
times, so we should allow the block to be programmed again if it was
programmed partially. But we should lock the block if the whole block
was programmed. Thus add a condition to validate if we need lock the
block or not.

Moreover we only enable the auto-check function when locking the block.

Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sprd-efuse.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
index 7a189ef52333..43b3f6ef8c20 100644
--- a/drivers/nvmem/sprd-efuse.c
+++ b/drivers/nvmem/sprd-efuse.c
@@ -217,12 +217,14 @@ static int sprd_efuse_raw_prog(struct sprd_efuse *efuse, u32 blk, bool doub,
 	 * Enable the auto-check function to validate if the programming is
 	 * successful.
 	 */
-	sprd_efuse_set_auto_check(efuse, true);
+	if (lock)
+		sprd_efuse_set_auto_check(efuse, true);
 
 	writel(*data, efuse->base + SPRD_EFUSE_MEM(blk));
 
 	/* Disable auto-check and data double after programming */
-	sprd_efuse_set_auto_check(efuse, false);
+	if (lock)
+		sprd_efuse_set_auto_check(efuse, false);
 	sprd_efuse_set_data_double(efuse, false);
 
 	/*
@@ -237,7 +239,7 @@ static int sprd_efuse_raw_prog(struct sprd_efuse *efuse, u32 blk, bool doub,
 		writel(SPRD_EFUSE_ERR_CLR_MASK,
 		       efuse->base + SPRD_EFUSE_ERR_CLR);
 		ret = -EBUSY;
-	} else {
+	} else if (lock) {
 		sprd_efuse_set_prog_lock(efuse, lock);
 		writel(0, efuse->base + SPRD_EFUSE_MEM(blk));
 		sprd_efuse_set_prog_lock(efuse, false);
@@ -322,6 +324,7 @@ static int sprd_efuse_read(void *context, u32 offset, void *val, size_t bytes)
 static int sprd_efuse_write(void *context, u32 offset, void *val, size_t bytes)
 {
 	struct sprd_efuse *efuse = context;
+	bool lock;
 	int ret;
 
 	ret = sprd_efuse_lock(efuse);
@@ -332,7 +335,20 @@ static int sprd_efuse_write(void *context, u32 offset, void *val, size_t bytes)
 	if (ret)
 		goto unlock;
 
-	ret = sprd_efuse_raw_prog(efuse, offset, false, false, val);
+	/*
+	 * If the writing bytes are equal with the block width, which means the
+	 * whole block will be programmed. For this case, we should not allow
+	 * this block to be programmed again by locking this block.
+	 *
+	 * If the block was programmed partially, we should allow this block to
+	 * be programmed again.
+	 */
+	if (bytes < SPRD_EFUSE_BLOCK_WIDTH)
+		lock = false;
+	else
+		lock = true;
+
+	ret = sprd_efuse_raw_prog(efuse, offset, false, lock, val);
 
 	clk_disable_unprepare(efuse->clk);
 
-- 
2.21.0

