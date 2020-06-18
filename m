Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23507C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2131206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dY+RVgnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgFRXkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 19:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbgFRXkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 19:40:02 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAD1C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 16:40:01 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g12so3149661pll.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 16:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rcHTOjx1Q346P9ZsaYW4owKJanYsDyPidI2shLjtOJ0=;
        b=dY+RVgnMbwlyOGl4P//IOxVJvx4Qsckqq5/7RKUlK3B0HNqReZ1iIEAYd/Gdz4XzoZ
         JUOMUSv3Yr6q9tPxAX+XhmV2u8vtcVcwEflJYgP+lEujrAkAgl82N8OhC6huceMDZDQq
         ytrLGOoiUvTIDJ8xyGuEVcRJxs7f0s/eDwhw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rcHTOjx1Q346P9ZsaYW4owKJanYsDyPidI2shLjtOJ0=;
        b=geuvSpoyc62Wh3Xij9T0eBp6FUxZCCKE0LzqzrXTjzkFHwxizVbXjvJhYbqXAWKH8/
         6+y4LC6E14mXDrLZqCmNPCg4Dc8mQUQxfojwjOIB+xsPuj9iN5xf0QN+NEYOU1JiGt3+
         R6BiTjnxgY1AQfsH6PRklWIkdvdm+6BdeDpz88OvsuuteR9xBmkOgSsY7Fo5T1mMgHSx
         mvoNdFBoZr06St/nzELNeujneh9yPGDUKwUspZdaAsQDdh15pcH2Lb9IF67vVrlaJCUH
         SAJQFO9D3Vt/6TsE6BMm/QiHQvKTBQ1Kg64x5d/yzYvQ+/YtiBkk8znNJTDXHY306YOS
         6VIA==
X-Gm-Message-State: AOAM533J/V1B4L808ERCkVfywygNayh0qMRhPas453Lx/aEWciLaJEAj
        +9CdVKyZqo0JSNN2h7hsCPYx0w==
X-Google-Smtp-Source: ABdhPJyi4TrKrINHRr4ksSg7boVpVbJGS2fQzBBNhqgUlekddu3vS2EjX4ceIVFsaPIJfbmrwC/oOQ==
X-Received: by 2002:a17:90a:930f:: with SMTP id p15mr765529pjo.85.1592523600729;
        Thu, 18 Jun 2020 16:40:00 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id r202sm3876993pfr.185.2020.06.18.16.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 16:40:00 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 6/5] spi: spi-geni-qcom: Simplify setup_fifo_xfer()
Date:   Thu, 18 Jun 2020 16:39:58 -0700
Message-Id: <20200618233959.160032-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200618150626.237027-1-dianders@chromium.org>
References: <20200618150626.237027-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definition of SPI_FULL_DUPLEX (3) is really SPI_TX_ONLY (1) ORed
with SPI_RX_ONLY (2). Let's drop the define and simplify the code here a
bit by collapsing the setting of 'm_cmd' into conditions that are the
same.

This is a non-functional change, just cleanup to consolidate code.

Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/spi/spi-geni-qcom.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 636c3da15db0..670f83793aa4 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -51,7 +51,6 @@
 /* M_CMD OP codes for SPI */
 #define SPI_TX_ONLY		1
 #define SPI_RX_ONLY		2
-#define SPI_FULL_DUPLEX		3
 #define SPI_TX_RX		7
 #define SPI_CS_ASSERT		8
 #define SPI_CS_DEASSERT		9
@@ -357,12 +356,6 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 
 	mas->tx_rem_bytes = 0;
 	mas->rx_rem_bytes = 0;
-	if (xfer->tx_buf && xfer->rx_buf)
-		m_cmd = SPI_FULL_DUPLEX;
-	else if (xfer->tx_buf)
-		m_cmd = SPI_TX_ONLY;
-	else if (xfer->rx_buf)
-		m_cmd = SPI_RX_ONLY;
 
 	spi_tx_cfg &= ~CS_TOGGLE;
 
@@ -373,12 +366,14 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 	len &= TRANS_LEN_MSK;
 
 	mas->cur_xfer = xfer;
-	if (m_cmd & SPI_TX_ONLY) {
+	if (xfer->tx_buf) {
+		m_cmd |= SPI_TX_ONLY;
 		mas->tx_rem_bytes = xfer->len;
 		writel(len, se->base + SE_SPI_TX_TRANS_LEN);
 	}
 
-	if (m_cmd & SPI_RX_ONLY) {
+	if (xfer->rx_buf) {
+		m_cmd |= SPI_RX_ONLY;
 		writel(len, se->base + SE_SPI_RX_TRANS_LEN);
 		mas->rx_rem_bytes = xfer->len;
 	}
-- 
Sent by a computer, using git, on the internet

