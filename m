Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7E8C433F7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0976222208
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lnvYu/8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgGNLTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgGNLQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:16:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACB0C08C5F7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:15:59 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j4so20883590wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HLIjy5aQCoym5Mm/hCfDKR0dFhPfvd31LPr0bmAaNkI=;
        b=lnvYu/8jdk95UwX9IoDefntQmNZ+TclIUQ6X2+ECk2EmyNfMBSnJ+i5mPNOqb7kmeM
         fLy4ysPmpsGjO8sriBthSrL7udGqmt9/nuZ5l7zKTopOVTfaks9NXyO0gV74aG5K40sk
         x5bxKd00883pryu8HmCJch6RB7XfgGh5Ne39TcCPPFPZ84VnYZOnl3F9aFfqj45OnhBl
         zh+xG9CZrFaicAU4SyVU3j3xTIGosE7bPvvrO4l7S71upbFK2rurlyQHcVSY14RqCI4Q
         E+qz9npM2rYERwSBflKs0s8CrvBk5r0P8pPmgAnq/cKLuvv/eO8TGROqdG4/raMbpw5k
         hYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HLIjy5aQCoym5Mm/hCfDKR0dFhPfvd31LPr0bmAaNkI=;
        b=ZAhLUfztBY8skZg587aUe/zCnln8N4mCeuDwSlq6yIs7fUU0N+/muUpwxGFDtm/Kpw
         yDhDYK+NdIKxDrJGUmhiMkYrcOwVYEEYFCckm7fO92PrgdLGo4tYRcAgoR1R7eKY//vu
         T863SpQUdXDzGD7mE2OmaGUsK1XCKWyBxxElcF+rPMtyEmvSdzSayMDZF/HzBxCuv7EF
         jQSbTPqbN+AMJOQnGUWRPNNZ2i4MEx01eB/aZI3mQpsTjPDjyFcp7TGQP2dNqD7IR4i3
         nvSjL6b+xnRgYWZ+EASkrTyUgeBpbPgLCNksoz7FTI+K+RGdAnhzrNWW14Y8wYxBeMAm
         81/w==
X-Gm-Message-State: AOAM530VEeT8oULxnTqiJZeN0YgaSytOsvD7T0jpxVwSZqqMuxz61c7v
        1GSgYfcWQgE5ACr7w3pwc/01pA==
X-Google-Smtp-Source: ABdhPJyPj59yNtEMPOQ/nf0KvMrMzW5MAG6d1mHgCW2Smzjhseeu55XTnni31ER4NoiwLyYXa+7vOw==
X-Received: by 2002:adf:b190:: with SMTP id q16mr4666971wra.356.1594725358605;
        Tue, 14 Jul 2020 04:15:58 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:15:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH 08/17] dma: at_hdmac: Repair parameter misspelling and demote non-kerneldoc headers
Date:   Tue, 14 Jul 2020 12:15:37 +0100
Message-Id: <20200714111546.1755231-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714111546.1755231-1-lee.jones@linaro.org>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/dma/at_hdmac.c:666: warning: Function parameter or member 'tx' not described in 'atc_tx_submit'
 drivers/dma/at_hdmac.c:666: warning: Excess function parameter 'desc' description in 'atc_tx_submit'
 drivers/dma/at_hdmac.c:1206: warning: Function parameter or member 'reg_width' not described in 'atc_dma_cyclic_check_values'
 drivers/dma/at_hdmac.c:1206: warning: Function parameter or member 'buf_addr' not described in 'atc_dma_cyclic_check_values'
 drivers/dma/at_hdmac.c:1206: warning: Function parameter or member 'period_len' not described in 'atc_dma_cyclic_check_values'
 drivers/dma/at_hdmac.c:1228: warning: Function parameter or member 'chan' not described in 'atc_dma_cyclic_fill_desc'
 drivers/dma/at_hdmac.c:1228: warning: Function parameter or member 'desc' not described in 'atc_dma_cyclic_fill_desc'
 drivers/dma/at_hdmac.c:1228: warning: Function parameter or member 'period_index' not described in 'atc_dma_cyclic_fill_desc'
 drivers/dma/at_hdmac.c:1228: warning: Function parameter or member 'buf_addr' not described in 'atc_dma_cyclic_fill_desc'
 drivers/dma/at_hdmac.c:1228: warning: Function parameter or member 'reg_width' not described in 'atc_dma_cyclic_fill_desc'
 drivers/dma/at_hdmac.c:1228: warning: Function parameter or member 'period_len' not described in 'atc_dma_cyclic_fill_desc'
 drivers/dma/at_hdmac.c:1228: warning: Function parameter or member 'direction' not described in 'atc_dma_cyclic_fill_desc'

Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/at_hdmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 73a20780744bf..45bbcd6146fd2 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -656,7 +656,7 @@ static irqreturn_t at_dma_interrupt(int irq, void *dev_id)
 
 /**
  * atc_tx_submit - set the prepared descriptor(s) to be executed by the engine
- * @desc: descriptor at the head of the transaction chain
+ * @tx: descriptor at the head of the transaction chain
  *
  * Queue chain if DMA engine is working already
  *
@@ -1196,7 +1196,7 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	return NULL;
 }
 
-/**
+/*
  * atc_dma_cyclic_check_values
  * Check for too big/unaligned periods and unaligned DMA buffer
  */
@@ -1217,7 +1217,7 @@ atc_dma_cyclic_check_values(unsigned int reg_width, dma_addr_t buf_addr,
 	return -EINVAL;
 }
 
-/**
+/*
  * atc_dma_cyclic_fill_desc - Fill one period descriptor
  */
 static int
-- 
2.25.1

