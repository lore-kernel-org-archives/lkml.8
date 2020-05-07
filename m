Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807F1C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58206208D6
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="THP9sZvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgEGTOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726470AbgEGTOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:14:11 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E0CC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 12:14:11 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id t8so3247794qvw.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 12:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dqXcMmi6x29UrthymMNNxQdDEOmsHbhH0Bj3IzL2aMs=;
        b=THP9sZvJlWOLHisxxV/QpAkHjs0X+vaTKBV8lcHHGTJPibJEmCuYCVeQw7f6ticXBb
         vecXfRkLxGDLpMrzfwAh+rbYW8hWks1GUIYRMVN2+cefaDKtx2+AteGZOq6kvWuRrM9O
         yqNHGY9pD9KyQohiE6TtQ0KJjKHHHSgmbBya1YXF99ZFjfboW1Ikzjk28FTV6Q9sOo2T
         5wDXgHedoEIQBm9db7XA4PmRqzdbFaSvESGhWGL75JaGJDqZ7BwENG2/tVhUT7bOViND
         rGnNRJDPu5fXhzRtRQ0aMcysAY4Kz8+k9GBdrV4xUhymKsmKQp+N2TZgzk5VOHSICcA2
         y/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dqXcMmi6x29UrthymMNNxQdDEOmsHbhH0Bj3IzL2aMs=;
        b=LyYOxksUF6HoHltIMgdcZGZcuq/m2S5b+33G/TjYBOA5N1ZqIIwX9v3UcEEILKp11B
         S8E+dIUZl+np9PFxioICe+oVnJ18MvGphcRlXzTcvMrzwov/JwqUBmgPUUKMi2ClD0mv
         2IkOubv2egPCaLKmBMZCJRU5qTv8rmPyaJyz0Z2HDFN3E7N2j7XT+elK65A4YGxcemLt
         Gdzm4kFW4eGXSncYE+yEz+xh8KyH7P9E5Bs/c6+VtmQvG638BTyClarIRQAVUwZygJ3i
         r/hyvKaoQMX7yPw8WRxuNg7L9Fr4D/E7nh4nWnwVztbiuwh+YvjzkneyIOp6fYS8ysP/
         WsfQ==
X-Gm-Message-State: AGi0Pub6X72bSM/QxvbLknt//5chyTDNZzrjFLnwnEZWzE47W4XiFOVF
        mMpLQQukpYVMziN+pRDo3mVE7A==
X-Google-Smtp-Source: APiQypKzE413WCsr8X3g6xZaR51/YNaRxGh6knaaWQShRkPKDilTFpTf259HoZj76ksWCskLjX4yqw==
X-Received: by 2002:ad4:4c92:: with SMTP id bs18mr15061948qvb.67.1588878850567;
        Thu, 07 May 2020 12:14:10 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id j8sm5094236qtk.85.2020.05.07.12.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 12:14:10 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net
Cc:     evgreen@chromium.org.net, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] net: ipa: set DMA length in gsi_trans_cmd_add()
Date:   Thu,  7 May 2020 14:14:03 -0500
Message-Id: <20200507191404.31626-2-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507191404.31626-1-elder@linaro.org>
References: <20200507191404.31626-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a command gets added to a transaction for the AP->command
channel we set the DMA address of its scatterlist entry, but not
its DMA length.  Fix this bug.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi_trans.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/gsi_trans.c b/drivers/net/ipa/gsi_trans.c
index 2fd21d75367d..bdbfeed359db 100644
--- a/drivers/net/ipa/gsi_trans.c
+++ b/drivers/net/ipa/gsi_trans.c
@@ -399,13 +399,14 @@ void gsi_trans_cmd_add(struct gsi_trans *trans, void *buf, u32 size,
 	/* assert(which < trans->tre_count); */
 
 	/* Set the page information for the buffer.  We also need to fill in
-	 * the DMA address for the buffer (something dma_map_sg() normally
-	 * does).
+	 * the DMA address and length for the buffer (something dma_map_sg()
+	 * normally does).
 	 */
 	sg = &trans->sgl[which];
 
 	sg_set_buf(sg, buf, size);
 	sg_dma_address(sg) = addr;
+	sg_dma_len(sg) = sg->length;
 
 	info = &trans->info[which];
 	info->opcode = opcode;
-- 
2.20.1

