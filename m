Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C2BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F2824653
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDIpZhKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgAULg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:36:57 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44038 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgAULg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 06:36:56 -0500
Received: by mail-pl1-f196.google.com with SMTP id d9so1212168plo.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 03:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mSKpRLLmbCG6NNfebkoa+LCU9XJGFgAItRsjHqAjc1o=;
        b=SDIpZhKQNyx4xuef9Gkz5k0dDHQ8mQBmax4z8lK8mYTkm/PzS4JtLMfCgPsR87nNwp
         /TiTYHJOymsTuXIbLHcuc9VifK9a1JZBRYMAeLUE9gVO8T6d4ivMlwOslF8DSP86KxuG
         QfaT18YZ5oml6I467FIO92SmiEbsgUXXrNBgyzeihf+wcKCzB2yS4STqWj7PPyJ2uAzT
         Mxo9Fxk0SEI4kOPXyfhTBclYWQhTxSCqzzgQgmmgjVTjumQXCv0d9rs9f/2Y8I7HFmCA
         CA+OF+BOfOS/LHAFTzHPFv7puRU4yDvGpIg2uWR9tzB8VYE1AUEGol/MQrJkpILRtX+/
         Uwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mSKpRLLmbCG6NNfebkoa+LCU9XJGFgAItRsjHqAjc1o=;
        b=lWk6L2TacmP4ORwZKa/BWLQCXjMTFY0n6qQtjWy1U+TnCGkq+Tc6JTnvXaGoaQVF4H
         NsyewLViWDyVcWiSV27BmCzn/FcaO+VB0vNCigFaPcVyq1v9u0TZTtcBhkcjKAg9cbgG
         j9tyZZBAEdjzTQw1qm9QoKoxQqW3NVuLD+m+7MmPPDoZAtEYOfJFiTIaIltD2Apr4DVK
         Mwzy9GfmmeQeEBtP6gmJDo7ZeMg/VSWNGWysEYTTttN+YXNo1I/gsjM/8ws1QMNWFZ4l
         ZGx/SzSEwCy6wz5tdGghmpe/CHCZLeWz6N+XFNGVJQ0bH9nuAHYwNs+kDx4Ll16eeQWO
         o6/w==
X-Gm-Message-State: APjAAAVvMwilxtfxMNUOIV31ri5R1kN9pOz4Cx/IaE2TDn1Otwn+MYqX
        bVUOmssqO7yqD0EpKN45uxycRitB
X-Google-Smtp-Source: APXvYqwGP9+tBT7zQvy1Ma71uI4Uyo6azGWeXHha8tYl+uCoAHxIuHwMnVT/y8uMGG0bxcivo4KBQA==
X-Received: by 2002:a17:90a:200d:: with SMTP id n13mr5038407pjc.16.1579606616331;
        Tue, 21 Jan 2020 03:36:56 -0800 (PST)
Received: from huyue2.ccdomain.com ([103.29.143.67])
        by smtp.gmail.com with ESMTPSA id z29sm42971824pge.21.2020.01.21.03.36.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jan 2020 03:36:55 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Cc:     linux-kernel@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH] zram: do not set ZRAM_IDLE bit for idlepage writeback in writeback_store()
Date:   Tue, 21 Jan 2020 19:35:57 +0800
Message-Id: <20200121113557.11608-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Currently, we will call zram_set_flag() to set ZRAM_IDLE bit even for
idlepage writeback. That is pointless. Let's set it only for hugepage mode.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/block/zram/zram_drv.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 4285e75..eef5767 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -689,16 +689,18 @@ static ssize_t writeback_store(struct device *dev,
 		if (mode == IDLE_WRITEBACK &&
 			  !zram_test_flag(zram, index, ZRAM_IDLE))
 			goto next;
-		if (mode == HUGE_WRITEBACK &&
-			  !zram_test_flag(zram, index, ZRAM_HUGE))
-			goto next;
+		if (mode == HUGE_WRITEBACK) {
+			if (!zram_test_flag(zram, index, ZRAM_HUGE))
+				goto next;
+			/* Need for hugepage writeback racing */
+			zram_set_flag(zram, index, ZRAM_IDLE);
+		}
+
 		/*
 		 * Clearing ZRAM_UNDER_WB is duty of caller.
 		 * IOW, zram_free_page never clear it.
 		 */
 		zram_set_flag(zram, index, ZRAM_UNDER_WB);
-		/* Need for hugepage writeback racing */
-		zram_set_flag(zram, index, ZRAM_IDLE);
 		zram_slot_unlock(zram, index);
 		if (zram_bvec_read(zram, &bvec, index, 0, NULL)) {
 			zram_slot_lock(zram, index);
-- 
1.9.1

