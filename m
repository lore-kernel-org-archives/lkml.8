Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB877C433F1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 885B72065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EzXgoWXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgGOPHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbgGOPGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:06:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF18C08C5DB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:06:50 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z15so3063537wrl.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TZd/W0TpHswu0SuYSG0OcLxLAj8b5WuGZfRv6Lvmmao=;
        b=EzXgoWXVHcblT299CWnFjUwu/qW4z3MCPe2EO1ynFgOADXo0wZ1hvqbPWrfz+tOefw
         VGGaZd5/muef9MzYyk6NIpaostukgfsY74ELsVkuN6ZdvEB4Q+J3btO58zC484dxcoC7
         jdl2m8vMVMOlhrc0xvsq55kzBXJ5aF9Ckq4TuG+MIDJ1ZJj6LFV9hfXvWgNz1PXIwh49
         MUqAgaDi/6eYeqRV8KEZqdndWwgVFN1ZaurPwYdAdUUE+bXE3Muc8Q15gmfSdAC/ponK
         qbDU08/zyrkSq5o8cqOTCtjTrlhrRS3BvWbyXMb9T00Bv3omHZ4gOBBlEwEJwx5mkh5h
         kQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZd/W0TpHswu0SuYSG0OcLxLAj8b5WuGZfRv6Lvmmao=;
        b=lS3TlI8TvbJQ6hjT+zVeb+WeQ+PG3HMT1iE4XSJze8ZegCsOsx/5RBUnDiFzHCv8DB
         iGvSTM+JLYIHNdLqcjeMwM0Vac7oVCA6CjJeZXFxegmJ5CuJ8m6xvLSnkRMrBzNo4X0a
         FYthmW5Ys8TkYrJxVnyzkVtz4oOYWGFdxpPCpPTG1y2fF5Ikedzizk2tM4Yt8weI9tUh
         nDWqpJ232Sq6ZDH2a/azvXAF4eeCIbCrP6spRnvyd/hLSUQeXED6FX7fHspq+K6fCZ8H
         IS/M7zRgvasfXRpNH9zaGBTjNcA8hyWT9C9yt5HGHaoAr3tppi085YP4GIu/UdWrynyz
         IjyA==
X-Gm-Message-State: AOAM533Yy6D4YCJRMDuLL4lay6OJ0nLLo5j359hD5rWnly289Chm2rQd
        eCcwS5lLZdMafIWnghOptxTyuw==
X-Google-Smtp-Source: ABdhPJxCpSAQqlbFgoqFALYbH3qfi5+G5rnYppQXXaOhBDyF/njkKYqkmrszZU89byQS4aLL9AvwtA==
X-Received: by 2002:a5d:4a42:: with SMTP id v2mr11024451wrs.33.1594825609431;
        Wed, 15 Jul 2020 08:06:49 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w2sm3906140wrs.77.2020.07.15.08.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:06:48 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 11/14] spi: spi-topcliff-pch: Add missing descriptions to 'struct pch_spi_data'
Date:   Wed, 15 Jul 2020 16:06:29 +0100
Message-Id: <20200715150632.409077-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715150632.409077-1-lee.jones@linaro.org>
References: <20200715150632.409077-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-topcliff-pch.c:184: warning: Function parameter or member 'io_base_addr' not described in 'pch_spi_data'
 drivers/spi/spi-topcliff-pch.c:184: warning: Function parameter or member 'pkt_tx_buff' not described in 'pch_spi_data'
 drivers/spi/spi-topcliff-pch.c:184: warning: Function parameter or member 'pkt_rx_buff' not described in 'pch_spi_data'
 drivers/spi/spi-topcliff-pch.c:184: warning: Function parameter or member 'dma' not described in 'pch_spi_data'
 drivers/spi/spi-topcliff-pch.c:184: warning: Function parameter or member 'use_dma' not described in 'pch_spi_data'
 drivers/spi/spi-topcliff-pch.c:184: warning: Function parameter or member 'save_total_len' not described in 'pch_spi_data'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-topcliff-pch.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index d7ea6af74743e..baadd380cb297 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -122,6 +122,7 @@ struct pch_spi_dma_ctrl {
 /**
  * struct pch_spi_data - Holds the SPI channel specific details
  * @io_remap_addr:		The remapped PCI base address
+ * @io_base_addr:		Base address
  * @master:			Pointer to the SPI master structure
  * @work:			Reference to work queue handler
  * @wait:			Wait queue for waking up upon receiving an
@@ -138,8 +139,8 @@ struct pch_spi_dma_ctrl {
  *				transfer
  * @rx_index:			Receive data count; for bookkeeping during
  *				transfer
- * @tx_buff:			Buffer for data to be transmitted
- * @rx_index:			Buffer for Received data
+ * @pkt_tx_buff:		Buffer for data to be transmitted
+ * @pkt_rx_buff:		Buffer for received data
  * @n_curnt_chip:		The chip number that this SPI driver currently
  *				operates on
  * @current_chip:		Reference to the current chip that this SPI
@@ -151,7 +152,10 @@ struct pch_spi_dma_ctrl {
  * @board_dat:			Reference to the SPI device data structure
  * @plat_dev:			platform_device structure
  * @ch:				SPI channel number
+ * @dma:			Local DMA information
+ * @use_dma:			True if DMA is to be used
  * @irq_reg_sts:		Status of IRQ registration
+ * @save_total_len:		Save length while data is being transferred
  */
 struct pch_spi_data {
 	void __iomem *io_remap_addr;
-- 
2.25.1

