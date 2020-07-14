Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF0EC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 876992220D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lRnHD6+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgGNLTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbgGNLQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:16:46 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBB5C08C5F5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:15:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so20840938wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xDspo//ZGGv62/k8vhH8b8dLXko1WA1DYqLJUY7Z0pU=;
        b=lRnHD6+n0Kjyezcw88EVB0+8py6DiaAYhCbxlABYw2m8o9Zqwb0e0UYsTQn6UzdoyM
         Ai/Lwf+avt/HMmYhCR2/TG+yz4ONmkQc2lUl56ky4FIDgvtg1bdsR8ab93IYufj3BDun
         i0WFD7NuGJNJDoZQohH34gqSOOdzQKa+D1J8sCzkxCvJV+Jwbn1/J2Scn0vFBzHdFMU4
         yHlh6N9RzslpQaPG35aqpOqxYCtYF2Q9jqYGfdLmmosobj45f6BOMGXsaHWrN8m60dsA
         vBG+Cnm/FE0W+t1lyKdF9znSpMDeukw6cl5PVzqvlV6+4bcIri+v2g7Y5SvFnTWu1qFI
         jtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xDspo//ZGGv62/k8vhH8b8dLXko1WA1DYqLJUY7Z0pU=;
        b=Sq0LUO3DUchmLN2nPe1IWHumCL6139OH4D/0Ro5J6OQOh1zZ3Bc/lqS6385RffrS7b
         AFRCdS5MvI8qaBLH3Y5QdSKUEghUnKdg2X9jj5laKLHrR3w+OVH1HNRdGwoRko1v4lqS
         d/H84/HauqqlS0oSKOCeC3u6dQmfXDmaW3NUGuVgGq4eZbZc/X0RuM5717RROhCqFzUN
         aXOpXP9o1LM6YHidGdtWB2ScWi7BHYFZ4xU+dB5WOJj+R199kLM3Mm15V/dJr06xs3il
         f9bP9DBO1GTAcb2vY4j+HAFG+JKx9hduQYtYoqExUuyWNPCnOhGOHsybs3ra04baBmsS
         ZGyg==
X-Gm-Message-State: AOAM532lleAyTfeqA7aYAEKe0fMkPiSM9640t8AJKq6mLWgPPLdjELy2
        vM1xYyY4NA57kCZ+X28l+FOqdw==
X-Google-Smtp-Source: ABdhPJzIzSvAOB3xgad3Sen6dlJzxBYaenPpru9T4eTefZSfzMtOdkfpSmMn9BuJRx6p9P4nOKO/4A==
X-Received: by 2002:a5d:6a90:: with SMTP id s16mr4580377wru.8.1594725357328;
        Tue, 14 Jul 2020 04:15:57 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:15:56 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Stefan Roese <sr@denx.de>
Subject: [PATCH 07/17] dma: altera-msgdma: Fix struct documentation blocks
Date:   Tue, 14 Jul 2020 12:15:36 +0100
Message-Id: <20200714111546.1755231-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714111546.1755231-1-lee.jones@linaro.org>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some misspelling/description issues, demote non-kerneldoc header
to standard comment block and provide a new description for
msgdma_desc_config()'s 'stride' parameter.

Fixes the following W=1 kernel build warning(s):

 drivers/dma/altera-msgdma.c:163: warning: Function parameter or member 'node' not described in 'msgdma_sw_desc'
 drivers/dma/altera-msgdma.c:163: warning: Function parameter or member 'tx_list' not described in 'msgdma_sw_desc'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'lock' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'dev' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'irq_tasklet' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'pending_list' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'free_list' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'active_list' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'done_list' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'desc_free_cnt' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'idle' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'dmadev' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'dmachan' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'hw_desq' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'sw_desq' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'npendings' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'slave_cfg' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'irq' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'csr' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'desc' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'resp' not described in 'msgdma_device'
 drivers/dma/altera-msgdma.c:265: warning: Function parameter or member 'stride' not described in 'msgdma_desc_config'

Cc: Stefan Roese <sr@denx.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/altera-msgdma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index 539e785039cac..321ac3a7aa418 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -153,7 +153,8 @@ struct msgdma_extended_desc {
  * struct msgdma_sw_desc - implements a sw descriptor
  * @async_tx: support for the async_tx api
  * @hw_desc: assosiated HW descriptor
- * @free_list: node of the free SW descriprots list
+ * @node: node to move from the free list to the tx list
+ * @tx_list: transmit list node
  */
 struct msgdma_sw_desc {
 	struct dma_async_tx_descriptor async_tx;
@@ -162,7 +163,7 @@ struct msgdma_sw_desc {
 	struct list_head tx_list;
 };
 
-/**
+/*
  * struct msgdma_device - DMA device structure
  */
 struct msgdma_device {
@@ -258,6 +259,7 @@ static void msgdma_free_desc_list(struct msgdma_device *mdev,
  * @dst: Destination buffer address
  * @src: Source buffer address
  * @len: Transfer length
+ * @stride: Read/write stride value to set
  */
 static void msgdma_desc_config(struct msgdma_extended_desc *desc,
 			       dma_addr_t dst, dma_addr_t src, size_t len,
-- 
2.25.1

