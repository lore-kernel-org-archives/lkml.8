Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F40C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 04:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771D9206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 04:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0KKUIxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgCMEH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 00:07:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36870 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgCMEH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 00:07:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id f16so3596503plj.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 21:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=0tp1yOfTBJtTk7/G231IbB/x4IfZsz2lYkWgFKOzAYA=;
        b=D0KKUIxWRC1vEGlakiinbwOPwjQR7/q6REyklE9YYxS7GMsKuqAhO88JySWEPp8GaP
         1eX4IST5+tsNabcvCdi1O0HXRgw7NZm487HuB5/PRZz2FJQPWjIbPMLG7OUSLQlu+U49
         JphwzczpwoKY+qK+FqsLMOxH8lZSfvQ9ZXO9OXS7uOeSHYmDJO36fE8yLbCOXllpbHUQ
         rylxqDPCaTP9SoO+Zkj2/yGT9DXPBjUNJO/AirH2H41HMi2D1/snJEDoC7rQRxWMjUDJ
         0R/RA9B2ONvLNIQw/UxfFE+Ylet6vRAZXUy8SfWfLN7qHW6TWpviPzjdb6MXlGUcvd68
         1rfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=0tp1yOfTBJtTk7/G231IbB/x4IfZsz2lYkWgFKOzAYA=;
        b=qpiu/iFnyPYdn7LIJMcbhx/nCSBxFQ7SPvGKIIpkvqDBX7esOGqyjaVcsP9ass2EBN
         Leg/8/iy2ROumVDibXfEHw3ou2v31MYWPvOXV9OotB3yEF7vp6fciwnOYYlLoo8msQpX
         z9T07/LnUi+zFcykwSg0Xb995fN7i3inDQT3frEBxtpgxQYKHTv8moXKQoFEGc1hB8zF
         Dj04BR8tydTsKSq0Crz1CSafky1O0rOBiz09dVaOUJb+MvPeVXIAsJhbmpvqRMIUR760
         /l7EL9KWXgkieAgkMGJCqg6lonj4m1HAE22y/EiJ6TtGquhIT6m2aoHGS8ayOAO8M8xD
         kTcQ==
X-Gm-Message-State: ANhLgQ3vKT7KPAKkLDYBgDrZYUulygZQhF4sIjybZfd5eO4Rws2DlVlB
        K7QWLhSpjyGUk1nzrggHeJDB6Zz5
X-Google-Smtp-Source: ADFU+vtcZkzrp1eccz/x68q8f1K146qPSggu7u2A2UjmLXP8VDI6q5bzZ0eVaS6HV/6x6e1wFqEdJQ==
X-Received: by 2002:a17:902:bcca:: with SMTP id o10mr11000766pls.160.1584072446143;
        Thu, 12 Mar 2020 21:07:26 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 6sm15576661pfx.69.2020.03.12.21.07.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Mar 2020 21:07:25 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     srinivas.kandagatla@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, freeman.liu@unisoc.com,
        baolin.wang7@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] nvmem: sprd: Optimize the block lock operation
Date:   Fri, 13 Mar 2020 12:07:08 +0800
Message-Id: <e470548794f9aed31185fecead266644dbbe184d.1584072223.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1584072223.git.baolin.wang7@gmail.com>
References: <cover.1584072223.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1584072223.git.baolin.wang7@gmail.com>
References: <cover.1584072223.git.baolin.wang7@gmail.com>
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
---
 drivers/nvmem/sprd-efuse.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
index 7a189ef..43b3f6e 100644
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
1.9.1

