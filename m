Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C34FC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1460208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGlphvp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgEHJOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 05:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgEHJOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 05:14:52 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830E4C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 02:14:52 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b6so464613plz.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 02:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nMxBmOmA0pSsTRUw0Y2HDt6KguOgwVLNatcARhBcWek=;
        b=UGlphvp8K38wllfNZo25/p/gee62yCv5K/mw3jjK3Izj2ivGn5sOvxfchz/UekfLxM
         7AzyMfBhLd17KQ5VSr+hVb/EDNVHaiOPIDHAO9c8zRofVoTPsWcvEn2wTBVB1MW8YCwE
         91pVouyKwC9xq8xMRHi8bmWyuoeSDJx8OiP1Z2eF4S3SSsC2HRpKZR8Og5MJCMG4uX5w
         kiZqibm2up6Lc8YqI5ca8YeU5j17Ko8tYj+cQOgD78B81i0kof72vstUjCFhG6V3nazw
         PQRYe7jR3aBBi8hkS1JFym6cHMvdW1Bd73+M+qftJ7SxwJpx4XPFe/uFCUSRAGDn5JX9
         hZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nMxBmOmA0pSsTRUw0Y2HDt6KguOgwVLNatcARhBcWek=;
        b=o9Fr1G/K0lyxCITmQZXwGyDl9zRqnAUr8Dvnkd6lbVvW9NF2yR+L3UBHxdAG3jvk2S
         9+ZjMzyj8C+I9iPOO+Dat65zHksyKMveWBinDS6gtyoLfqLzk8IpuYvUfkGzW/MhlU9d
         q8sqBhM7eusgA2hDMnJTLtwOAKJjpapjv7eAbo6peX6vHIG5H2bWjgNRmyKPN74eONDl
         BvbHGG+ai2n+wO9xRDVvSSeeD1t/T6lI6PewdXQgO45d9Lpw9CdONNKpsdNvz9Odi1aO
         4Mivo11OaonRnsR6+qE79TXOl+y1pLByAu3u9oIJm4h5CZf42aUdrt3J/J2rePxHgsXn
         Pl2Q==
X-Gm-Message-State: AGi0PubkXJJuiACUPyQ9/uejlhiGmPiXSZQI1zTzz+81oJzB8XWlOM3g
        zNsbZwyVZo/pL2+S60qV/iCOcO9y
X-Google-Smtp-Source: APiQypKo6zNGflFBY1FjZ8IG226PaDyITAYqx8t3A183iI8TJ+zQm04mg/0MSIZE/ZJFbHA17z6j3Q==
X-Received: by 2002:a17:90a:d307:: with SMTP id p7mr4977045pju.207.1588929292004;
        Fri, 08 May 2020 02:14:52 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id u188sm1187292pfu.33.2020.05.08.02.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 02:14:51 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH] coresight: tmc: mark coresight_tmc_groups with static
Date:   Fri,  8 May 2020 17:13:40 +0800
Message-Id: <20200508091340.11711-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Sparse reports a warning like:
drivers/hwtracing/coresight/coresight-tmc.c:364:30: warning: symbol
'coresight_tmc_groups' was not declared. Should it be static? [sparse]

coresight_tmc_groups is used in the local file only, so it should be
marked with static.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 1cf82fa..39fba1d 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -361,7 +361,7 @@ static ssize_t buffer_size_store(struct device *dev,
 	.name = "mgmt",
 };
 
-const struct attribute_group *coresight_tmc_groups[] = {
+static const struct attribute_group *coresight_tmc_groups[] = {
 	&coresight_tmc_group,
 	&coresight_tmc_mgmt_group,
 	NULL,
-- 
1.9.1

