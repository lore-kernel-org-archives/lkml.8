Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C436C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07E46207EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z6e2Az59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGQNyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgGQNyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:54:36 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843AEC0619D6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:54:36 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 22so14950926wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BdU11UOQFuXyCSynzxRXM0IT1vARtgrxd2bUOuqypjo=;
        b=Z6e2Az599CouQ+hjKJ3fh171GrmBXuuQYoyxs21YgHQXcnooWtd0d4qYE1hp7Fwp5Z
         SM8M9boXYBJvn8lwPVCVxW6+FNHJUOfLDJ52Mrw0pvO9wEGLC8olytK/rYr01bgfpIRX
         NfOd0UXXmOtLeEZgF7joBx8fm4hIDMZDinwqPn3IXqLfsoAW+pE3JeoJdYkxDJ+rSeGm
         zl3LNaO8Iip6w5A2lPOWUgmwjQqpCN61R357z3ZYuT4myLa+74zeRFOI1eyXwWOm8FDM
         ISnduGtoskDm+LkUDeOMHuTItePm8NNoAdICqcjQFMk/XhvtEoz3VYA6B7hUX6aUJ1V1
         XjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BdU11UOQFuXyCSynzxRXM0IT1vARtgrxd2bUOuqypjo=;
        b=RfGH2/lkn0MUGWJMiLi0y+AXJZ7FrE705UFcLjEjZY3yh3kicK0tzbginAKpwFdZ4E
         JRN6Z4WKZpl6NF7kAtDhsyw5+vDJzE0MQXyDDZ7FRtngt/SUvaa/vxGsxomdXBN2n+Kg
         YI+0GZtlwb7z8QJmhd3aRJDUzlj64W+f/hNvmHw3Vc7al+ib5/sqHSbhU3VdLFIV0vK/
         yZ7rIKWc84D8dp1sRM/vXuami8dYag2Xo44LuQ+03J6y4ZMQzZw0zjR6bvw+Y3MfI+hO
         IYtm8WEcE2cQtE9XXMg8JaopJFdDsDsV8DJHgMuHR6tlBPZQnhbhNvtXx3iLeGAjKH2f
         MgEQ==
X-Gm-Message-State: AOAM531lJRBrQZWlzacPB9RiFVZfrBW28czbdGxYCSQYr5yDC+9pTfeK
        crf76ZptoMCJ0e1joQ71EJk3zA==
X-Google-Smtp-Source: ABdhPJw7B9TDI0XMbwrUhXUY/EXKQH5gIkMZxaFo6XtGIcaYGVLxDNa64CokR+smlhl5Hzf6a9aXJQ==
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr9305717wmj.105.1594994075163;
        Fri, 17 Jul 2020 06:54:35 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id w128sm16118356wmb.19.2020.07.17.06.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:54:34 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Sachin Verma <sachin.verma@st.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 08/14] spi: spi-pl022: Provide missing struct attribute/function param docs
Date:   Fri, 17 Jul 2020 14:54:18 +0100
Message-Id: <20200717135424.2442271-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717135424.2442271-1-lee.jones@linaro.org>
References: <20200717135424.2442271-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also demote non-worthy kerneldoc headers to standard comment blocks.

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-pl022.c:304: warning: cannot understand function prototype: 'enum ssp_writing '
 drivers/spi/spi-pl022.c:330: warning: Function parameter or member 'loopback' not described in 'vendor_data'
 drivers/spi/spi-pl022.c:398: warning: Function parameter or member 'rx_lev_trig' not described in 'pl022'
 drivers/spi/spi-pl022.c:398: warning: Function parameter or member 'tx_lev_trig' not described in 'pl022'
 drivers/spi/spi-pl022.c:398: warning: Function parameter or member 'dma_running' not described in 'pl022'
 drivers/spi/spi-pl022.c:670: warning: Function parameter or member 'pl022' not described in 'readwriter'
 drivers/spi/spi-pl022.c:1250: warning: Function parameter or member 'irq' not described in 'pl022_interrupt_handler'
 drivers/spi/spi-pl022.c:1250: warning: Function parameter or member 'dev_id' not described in 'pl022_interrupt_handler'
 drivers/spi/spi-pl022.c:1343: warning: Function parameter or member 'pl022' not described in 'set_up_next_transfer'
 drivers/spi/spi-pl022.c:1343: warning: Function parameter or member 'transfer' not described in 'set_up_next_transfer'

Cc: Sachin Verma <sachin.verma@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-pl022.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 66028ebbc336d..d1776fea287e5 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -298,7 +298,7 @@ enum ssp_reading {
 	READING_U32
 };
 
-/**
+/*
  * The type of writing going on on this chip
  */
 enum ssp_writing {
@@ -317,6 +317,7 @@ enum ssp_writing {
  * @extended_cr: 32 bit wide control register 0 with extra
  * features and extra features in CR1 as found in the ST variants
  * @pl023: supports a subset of the ST extensions called "PL023"
+ * @loopback: supports loopback mode
  * @internal_cs_ctrl: supports chip select control register
  */
 struct vendor_data {
@@ -353,11 +354,14 @@ struct vendor_data {
  * @read: the type of read currently going on
  * @write: the type of write currently going on
  * @exp_fifo_level: expected FIFO level
+ * @rx_lev_trig: receive FIFO watermark level which triggers IRQ
+ * @tx_lev_trig: transmit FIFO watermark level which triggers IRQ
  * @dma_rx_channel: optional channel for RX DMA
  * @dma_tx_channel: optional channel for TX DMA
  * @sgt_rx: scattertable for the RX transfer
  * @sgt_tx: scattertable for the TX transfer
  * @dummypage: a dummy page used for driving data on the bus with DMA
+ * @dma_running: indicates whether DMA is in operation
  * @cur_cs: current chip select (gpio)
  * @chipselects: list of chipselects (gpios)
  */
@@ -662,7 +666,7 @@ static void load_ssp_default_config(struct pl022 *pl022)
 	writew(CLEAR_ALL_INTERRUPTS, SSP_ICR(pl022->virtbase));
 }
 
-/**
+/*
  * This will write to TX and read from RX according to the parameters
  * set in pl022.
  */
@@ -1237,6 +1241,8 @@ static inline void pl022_dma_remove(struct pl022 *pl022)
 
 /**
  * pl022_interrupt_handler - Interrupt handler for SSP controller
+ * @irq: IRQ number
+ * @dev_id: Local device data
  *
  * This function handles interrupts generated for an interrupt based transfer.
  * If a receive overrun (ROR) interrupt is there then we disable SSP, flag the
@@ -1334,7 +1340,7 @@ static irqreturn_t pl022_interrupt_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/**
+/*
  * This sets up the pointers to memory for the next message to
  * send out on the SPI bus.
  */
-- 
2.25.1

