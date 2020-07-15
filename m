Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6ADC433EC
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01AF220720
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rtO/R+gF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgGOPGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgGOPGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:06:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9065CC08C5E0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:06:46 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b6so3039741wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bjh7OhojJcRmD5KkKwacJpyMf8L6Fg+f9kXKvvMc3JQ=;
        b=rtO/R+gF9zsxdsObRHLZjii928eu9P6U4fV47qT04PDZqfN1Aq+9wmYpIrjcPldh7T
         yP1DLy0eimKSKjz+BYeWPwFsrz3w33TZgBqvD+zngaL580tLU7cwgnteXFXEa2cVb63a
         C3hCJVfmWgf8lgOF6706sYiBVu2V51RlGIqpapFdC5++3X0ambcY9JvZQCYe85kYOmw7
         bSpz8d0j/QI47062tJVsowpUDTU7eNVnWs3lPdNm2HUsKNOkvlscGCVf3IgWF57B7ma/
         SicBianzkJtzdwiwzI2qiNr5ecy2Jif9S6uDJm1um/jUNYgDmdZ52yFNt5ixduLTT+cK
         f0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bjh7OhojJcRmD5KkKwacJpyMf8L6Fg+f9kXKvvMc3JQ=;
        b=JzAd7k0n2P97rOv+RVZnP5idtBW6aTb3X4t89Jt/brcNH4o4gT5KFJtW0WPJ4XmJxO
         6b1WFUs0qTBuW1QohgWDjTtYVoLbzbqpm1UIbrMdxjlGufSmH6xpap04fOB2u32bR4HE
         AzZNFPYI091iTVfGsFyBEitBZxa5G+FJiCJQsWb09q0en2f8+ygpcBO/QzAlJ0qaN6jt
         ANSy2xIpK0S7vT48AKWafv2ZVIx1d9c7pj9CIs6STOXMmumVbcRFC5zHnHa8WJ+MtUob
         G4a7GFxbtY/IvN8J5QGaTCAljU5BjKdh1FJcfDU/R4T4aI6ZGrktsxTUPSKjdT4Mkw/b
         qVMg==
X-Gm-Message-State: AOAM533mdod5Q8M6/+MS9tIz+tfZKHliU2Nrgu9gVF0x1Mv/mSsfND3t
        dz6nEQckWGf3IVXmVBrbvrhC9w==
X-Google-Smtp-Source: ABdhPJz/qORqv4SB3JCQPZLx2YoBeuFRtlxnr/5oEScOZOZu+WtAdMW0hpudATx8mM94Ld2/ZEFr8w==
X-Received: by 2002:adf:fa10:: with SMTP id m16mr7456479wrr.134.1594825605304;
        Wed, 15 Jul 2020 08:06:45 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w2sm3906140wrs.77.2020.07.15.08.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:06:44 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sachin Verma <sachin.verma@st.com>
Subject: [PATCH 08/14] spi: spi-pl022: Provide missing struct attribute/function param docs
Date:   Wed, 15 Jul 2020 16:06:26 +0100
Message-Id: <20200715150632.409077-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715150632.409077-1-lee.jones@linaro.org>
References: <20200715150632.409077-1-lee.jones@linaro.org>
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

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Sachin Verma <sachin.verma@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
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

