Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7769CC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 02:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58ADF22D75
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 02:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lot0pPrz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbgFTCWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 22:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731713AbgFTCWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 22:22:37 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DAAC061794
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 19:22:36 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id n9so4753292plk.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 19:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jYMqxDbYGVsmzfyOoyUgQX25c2OVSiaityK3R4E49i0=;
        b=lot0pPrzjqlyDxv/SuV8XI7m9aTybBuOj1YqRPlx678kbiLzlnzGAjqq4CDeiA7ivp
         AL9UQXicMdxZNhF2FlHGrtMSgojN3TX06x2mWcseGXicmI1+hH/rgHQ70vWJizdA/X2U
         EKwwKyj5basYb7+AS5nUox1ZMLD/BTJeWPglc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jYMqxDbYGVsmzfyOoyUgQX25c2OVSiaityK3R4E49i0=;
        b=i3uplImWPQDEAJhsdmaAlqDSrh8sHTVX9tVACxqNpSgKn5u5UASlbEnB9yMb42+qjt
         BMWG47Obbf89Fve5GKTejpr/iXwIQ1bWwXk54jHKf5wvQwHVzHtRsl6lRx2juBQfhmZM
         EHolvYt/9M/UdVq2KuybeMNCxGS/M3TFW5Oxa1WKSkoJwf1WnpXtYnZjPbvOxC2sI1M2
         j/AJK95jafhCPS3guz/1xlKNq/ph6xRuV9dsu+g1wE8GmiDiCMw2s2mm+TT9Usjg8+PI
         rJ6ENjlSV74ryi41A1/2cW6dQZkhVoRNpDobmqOZ68CCm4R9hOpjQFYvGGZ0pDX880Bg
         MRHQ==
X-Gm-Message-State: AOAM530dPjv5fwBzROsy81GldXoN/u8mHflICj7cGgCyJMXTvUic3iaP
        J10XMgVBK+ydNV/Kdb+Sv4X8fg==
X-Google-Smtp-Source: ABdhPJwV7Cpi88hQLo8D8HNN2earezSETvGWeKRiYxB+TMAW7r/NxE9wqpd6OZ9QAGCgnCahxPkjtA==
X-Received: by 2002:a17:902:7d89:: with SMTP id a9mr10289321plm.309.1592619755935;
        Fri, 19 Jun 2020 19:22:35 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id m14sm6241911pjv.12.2020.06.19.19.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 19:22:35 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v1 1/2] spi: spi-geni-qcom: Simplify setup_fifo_xfer()
Date:   Fri, 19 Jun 2020 19:22:32 -0700
Message-Id: <20200620022233.64716-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200620022233.64716-1-swboyd@chromium.org>
References: <20200620022233.64716-1-swboyd@chromium.org>
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

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/spi/spi-geni-qcom.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 0c534d151370..d8f03ffb8594 100644
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
@@ -353,12 +352,6 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 
 	mas->tx_rem_bytes = 0;
 	mas->rx_rem_bytes = 0;
-	if (xfer->tx_buf && xfer->rx_buf)
-		m_cmd = SPI_FULL_DUPLEX;
-	else if (xfer->tx_buf)
-		m_cmd = SPI_TX_ONLY;
-	else if (xfer->rx_buf)
-		m_cmd = SPI_RX_ONLY;
 
 	spi_tx_cfg &= ~CS_TOGGLE;
 
@@ -369,12 +362,14 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
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

