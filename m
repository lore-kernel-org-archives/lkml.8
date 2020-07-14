Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FFEC433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18E4E22208
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sySJajNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgGNLQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgGNLQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:16:40 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492D7C08C5E1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:15:55 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j4so20883243wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLpJm3mzK+V3kK3HZ3SJH1x+Limv7E45WQQkbSJWTls=;
        b=sySJajNwSAkugA5Z9nBjxFfu7QwyjdADzjqsQa+cpQZcqSV/GK1YAGZtjBZdEpOIRE
         qhCguOnqhDMtdxsnHovaMlrvZzXMWD5TcFatVeJdFeyTVUOWefKhY7XbB145tlHGi1Sa
         i5sJsZbefS0ktjmmcgPcl/LDtOjjQMtojC6g+wfYnjIa/R4ugyx5mgQ4wibAdDdYhjYu
         e86uZNax1MWGcDvMTk23+uZ2idMAUq1LtyDlpomNfpBpKwFqZvW3Pga1yvWiu0YsXzJv
         1ZLwatEwBAdHWtyhwagGUyovYUxFBUaO0W2WqFy1660sqs0wHOmpOMorBt26JdBjkFXd
         P0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLpJm3mzK+V3kK3HZ3SJH1x+Limv7E45WQQkbSJWTls=;
        b=TbICurLBQxwrbzNV5fwMz6oEkyE2hl+YxGo5QysAlM4LDJY1/MtpMigzdBf9Ge9CDl
         p/HPpXicc11C3b8+aCv3vHgy/DlK3m9Ofj4DlgJJgrKnstDofAoN5ZzZUYCkgCWUU7EI
         p4JJ4Zs6UGXzTW0wATAPyRi3xtIatEm/IhURGB2lELoIBe+2joFmxosOzrHRS64oNbJM
         3clKkCx52Rld2Bbv3elpaoZ+/UMZytdF4JGpaWNe+KHrtnlHbAbEj7usrfUOupCbT2qr
         sTjBR+TNkf7THQg1mu9bjNg12fyQIjjoXGw6uwSyuNbDmU1qHOchB6uYhboNR0KYvmWk
         t/ZQ==
X-Gm-Message-State: AOAM533WrzC1CpKbtcyGs0H/suZ0beHSilFlgmcZ2rlJTuqGEf4MYZRW
        WKzlmQORFZ277OAUivF0TkUemw==
X-Google-Smtp-Source: ABdhPJyDRC1BL2tn7X/XOxKF+nUyGiv0k9S/8IxjJcKJE2YoRqCxMojY/XU+Yg+IRUHzvp+gWFIq6w==
X-Received: by 2002:adf:fe85:: with SMTP id l5mr4392632wrr.333.1594725354068;
        Tue, 14 Jul 2020 04:15:54 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:15:53 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 04/17] dma: mmp_pdma: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Tue, 14 Jul 2020 12:15:33 +0100
Message-Id: <20200714111546.1755231-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714111546.1755231-1-lee.jones@linaro.org>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document any of the demoted functions here.

Fixes the following W=1 kernel build warning(s):

 drivers/dma/mmp_pdma.c:298: warning: Function parameter or member 'chan' not described in 'start_pending_queue'
 drivers/dma/mmp_pdma.c:393: warning: Function parameter or member 'dchan' not described in 'mmp_pdma_alloc_chan_resources'
 drivers/dma/mmp_pdma.c:862: warning: Function parameter or member 'dchan' not described in 'mmp_pdma_issue_pending'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/mmp_pdma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 41c542eaa23a5..f42f792db277e 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -290,7 +290,7 @@ static void mmp_pdma_free_phy(struct mmp_pdma_chan *pchan)
 	spin_unlock_irqrestore(&pdev->phy_lock, flags);
 }
 
-/**
+/*
  * start_pending_queue - transfer any pending transactions
  * pending list ==> running list
  */
@@ -381,7 +381,7 @@ mmp_pdma_alloc_descriptor(struct mmp_pdma_chan *chan)
 	return desc;
 }
 
-/**
+/*
  * mmp_pdma_alloc_chan_resources - Allocate resources for DMA channel.
  *
  * This function will create a dma pool for descriptor allocation.
@@ -854,7 +854,7 @@ static enum dma_status mmp_pdma_tx_status(struct dma_chan *dchan,
 	return ret;
 }
 
-/**
+/*
  * mmp_pdma_issue_pending - Issue the DMA start command
  * pending list ==> running list
  */
-- 
2.25.1

