Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6283EC54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EF3206F8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gqo70M0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgCWPA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:00:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41840 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbgCWPA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:00:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9so17478314wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 08:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0O+vyK5vvC4g3IYlNFFCkLQmqVkoo7LNP5yoPvyfpdE=;
        b=Gqo70M0+HFwbN0MmzQEglDxiBxNm+W+puIXvN+GAICu7lYABiGs/xEsSBxYkvVqpWq
         yuvHsTjP2uH3iw7e9HwaLc+sF2R88a5l3FTi84DjzvNenJ1bYJtO/8w4oFrAaSlWoH5A
         nHX17SgUfcCu7WxxqvaeXnh3WdmESJvdlayLJVRV/R6nsjUtjS4f/NL77xHMCn1qvh/5
         aw9GdJMALGLJVOGlubDV4zdndIR+RYEbMBKHDgthFt9rgHDb1mOW2y+OK4G7mvUlYdpQ
         VSIamwLE6ETJ16ZXObw5XH2naLAVv3aGVUYrzmlfipzhx1t0Vh3kkQcz6UQpo5gGmwJN
         NdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0O+vyK5vvC4g3IYlNFFCkLQmqVkoo7LNP5yoPvyfpdE=;
        b=ld/I+LD/2eIuXDsByib5U9wpNd1RqJB6PhULtDJkiOk3NgdmdHNk9AfrUrkvERJVfh
         1mr+C09A7dU27ePEf4QwOg0zD3BGFV2VydeG2YhjSIaS5N+GVldPeWFxuLJzHuqPISIx
         ODi0kThYBHsD2RPzQz/JZjWhjVRCvh1tcQ+hSK53HYrp+B1TyHbuaKG9FNsgY2tTTYj2
         VXS9IEO9Uc8oeTm4WKDsopeeoNjbQsYtNxEj++fnK0mGsoA/ZeUcvrNfHZTkPqe//tIh
         +voqkshKq5jTy7TdQ7H+7JQ4tTtmJ+hChVeedrSgP34UZMPU651mFNmiLm8/kyrBI2EE
         ORJg==
X-Gm-Message-State: ANhLgQ3+S43UI+6gZpvdPZoAur0ALEsdiRFN/gqvcHqKvkqdt9/+Ogg7
        wQOBKSlDp/eR9SKpn33o9+Vn0g==
X-Google-Smtp-Source: ADFU+vvUw8NlYb8kFG0Q4CTsJDCPmoXn3SIEDR2EUPxgYv4otkwIBqPzpG1jWJPPXmGr3T9mKf3khw==
X-Received: by 2002:adf:dec3:: with SMTP id i3mr4458066wrn.351.1584975623946;
        Mon, 23 Mar 2020 08:00:23 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id k15sm1084196wrm.55.2020.03.23.08.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 08:00:23 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/5] nvmem: sprd: Determine double data programming from device data
Date:   Mon, 23 Mar 2020 15:00:05 +0000
Message-Id: <20200323150007.7487-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200323150007.7487-1-srinivas.kandagatla@linaro.org>
References: <20200323150007.7487-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang7@gmail.com>

We've saved the double data flag in the device data, so we should
use it when programming a block.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sprd-efuse.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
index 43b3f6ef8c20..925feb21d5ad 100644
--- a/drivers/nvmem/sprd-efuse.c
+++ b/drivers/nvmem/sprd-efuse.c
@@ -324,6 +324,7 @@ static int sprd_efuse_read(void *context, u32 offset, void *val, size_t bytes)
 static int sprd_efuse_write(void *context, u32 offset, void *val, size_t bytes)
 {
 	struct sprd_efuse *efuse = context;
+	bool blk_double = efuse->data->blk_double;
 	bool lock;
 	int ret;
 
@@ -348,7 +349,7 @@ static int sprd_efuse_write(void *context, u32 offset, void *val, size_t bytes)
 	else
 		lock = true;
 
-	ret = sprd_efuse_raw_prog(efuse, offset, false, lock, val);
+	ret = sprd_efuse_raw_prog(efuse, offset, blk_double, lock, val);
 
 	clk_disable_unprepare(efuse->clk);
 
-- 
2.21.0

