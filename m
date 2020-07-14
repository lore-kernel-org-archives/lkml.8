Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA47C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78FE5206F0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r07S7f0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgGNLUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgGNLSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:18:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D51C08E89D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:16:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f18so20907173wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ewSSWUW/45nS/yx3Bple4Rafu63cuthV60wjjsFm31o=;
        b=r07S7f0JSGNo1Nt9IZFRGGvi9Lp2WCC0rUzVkAvOq5O5uuetYvLH26mbxDtnyAveOz
         frcZe2zibwjQUBdEtszl73MgfdEyhSWZPApwvfZbtovOiVCL+WQ62RhmhxnQcZamm8Xu
         3/+y9QgaGUFjp0zbF74w49tY4gMxtfrYEhyvpwi1E5zAnvOXnxeahcfETAjZ8zxWDFQR
         y8d4IbJ64kqiAxtEplpKCvRtSMPMDLwDzaSZYdo7ZjIcV83l6ES2n2CSsfPa7S0tsFm2
         WaARQ9l+CbHGQ1v3IShviPOp0RquLwYS1UYGGtDANowawECxzEayp2QTi3YOTEl+9InD
         KT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ewSSWUW/45nS/yx3Bple4Rafu63cuthV60wjjsFm31o=;
        b=QIXLaCK8i/2DYkS8yeEG5ClVLueaJY8ev1/kM6DasXadPep/cp5015a5T446tqYD6d
         zcjlwx6BWfeSlkP1HIfDSFFnITj+IWpRI9x2oNmtA1Z/yRJgMFnkw3T17hDktiUwX0ib
         VpAYd5rb9S6tITWvbEupClix8HpwBvVRQ+2Dpi65vEhXp45ZDt179i0puRUqXlkeBBYt
         ENY55AnRUXdFAnIFNNoIFXtrOzo6UXTOpTFC1VD4eJRq7GgxqlRXCDWgAvyK1aajlXLI
         0Thi5lbYUOLWNMkk5bm2ckKir5Mk7jrIvXfOJk7xWLblJkeCFpQYgSqw84xNn6YTh2wr
         JRuw==
X-Gm-Message-State: AOAM5318YRQFs19d9m8xpBQwMsDZzdrp+8w2WEQ/lBBHmWcG6eoD5Ewt
        11RDzrBEWxdnmx7XmQIrcCOnYQ==
X-Google-Smtp-Source: ABdhPJwOpZLkCp6n4syZLc9H9p9CNZPkWXr22M9kvz71NJK/JQzp8BLfmFRHWp3bAZgklkl2RAAp0Q==
X-Received: by 2002:a5d:4a42:: with SMTP id v2mr4330551wrs.33.1594725367098;
        Tue, 14 Jul 2020 04:16:07 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:16:06 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 15/17] dma: mv_xor_v2: Supply some missing 'struct mv_xor_v2_device' attribute docs
Date:   Tue, 14 Jul 2020 12:15:44 +0100
Message-Id: <20200714111546.1755231-16-lee.jones@linaro.org>
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

 drivers/dma/mv_xor_v2.c:168: warning: Function parameter or member 'clk' not described in 'mv_xor_v2_device'
 drivers/dma/mv_xor_v2.c:168: warning: Function parameter or member 'reg_clk' not described in 'mv_xor_v2_device'
 drivers/dma/mv_xor_v2.c:168: warning: Function parameter or member 'irq_tasklet' not described in 'mv_xor_v2_device'
 drivers/dma/mv_xor_v2.c:168: warning: Function parameter or member 'hw_queue_idx' not described in 'mv_xor_v2_device'
 drivers/dma/mv_xor_v2.c:168: warning: Function parameter or member 'msi_desc' not described in 'mv_xor_v2_device'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/mv_xor_v2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index 157c959311eaf..9225f08dfee92 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -135,9 +135,11 @@ struct mv_xor_v2_descriptor {
 /**
  * struct mv_xor_v2_device - implements a xor device
  * @lock: lock for the engine
+ * @clk: reference to the 'core' clock
+ * @reg_clk: reference to the 'reg' clock
  * @dma_base: memory mapped DMA register base
  * @glob_base: memory mapped global register base
- * @irq_tasklet:
+ * @irq_tasklet: tasklet used for IRQ handling call-backs
  * @free_sw_desc: linked list of free SW descriptors
  * @dmadev: dma device
  * @dmachan: dma channel
@@ -146,6 +148,8 @@ struct mv_xor_v2_descriptor {
  * @sw_desq: SW descriptors queue
  * @desc_size: HW descriptor size
  * @npendings: number of pending descriptors (for which tx_submit has
+ * @hw_queue_idx: HW queue index
+ * @msi_desc: local interrupt descriptor information
  * been called, but not yet issue_pending)
  */
 struct mv_xor_v2_device {
-- 
2.25.1

