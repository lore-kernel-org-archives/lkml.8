Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD2EC433EB
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 089DD2065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UyEhMAjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgGOPGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgGOPGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:06:48 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C9EC08C5E2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:06:47 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 17so6166138wmo.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P2yOByTJ584zq87efhS3Vkyk+agE9qVyWq/sL4PYeIk=;
        b=UyEhMAjQjWz7s63ZoKbqZd0he72PbgcQoERVqZzfPDdeHfi76qTF2aqAKxzkw+vs8v
         1ccaVDSAO4pCzQ94UQJrxVt/sheMgiPUXVzxym6vO5O3kTo9gbcNiNZVaVD1plMF0J3k
         z3yGisz15rp6uRZwbOTBwSS7WRG2WW4RYhT3UooUQ1/ByKSkNAp8xkJVJkMzDKEaz/uV
         dY1tnRfjmei2kZiknTPr5tnLNurtxkTSnbU4QVjMd/PG1AQFoIo5f4IX91KQdnkdhecL
         G0V3E7kPOXw89FXa9PIId9kyqYzc/kbEl6QHQn+6MHKgA350J1Dw6gHOjtOneOkfuyyM
         4CgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P2yOByTJ584zq87efhS3Vkyk+agE9qVyWq/sL4PYeIk=;
        b=iShlAbrvTXoiTT6eRhz2+a2VY0Cix3HvpOFXmGI4xAycnwX9i/EgtAurudm2BIJ+jl
         l5eHHYiuHF+8otAJevIbHSKlU9y9Kbvzv8IIZZcaQS+sJ8xyBI0oH1VRi6ey1iZC0sqQ
         qJICo1tf+POadPO6sTFazQYOzS4PE5GwkDDEXuGhqpZIckeY9L3NJBegVj1xW1P16O+S
         NmVtUMolzUkbAIb741HWehudBltYycaDgXdKRfJfsSkWXAu4ezgNvvDmo8n2sVLONtgP
         jmgljZnabJ7ic2DQDiFif9J/E9liVKQtBRkENHU7JsPPRaLV5CAUK6u5XxWGzxiC9m8H
         BWBg==
X-Gm-Message-State: AOAM530M4sbJdW5rOAhyVB1pBcY7B4G8wC3ArmzjnYhPRE5X+zYXsvDp
        xejoVSi53+R802dmlg7VHwTyVjUhz/k=
X-Google-Smtp-Source: ABdhPJx39xtrPHkcaKWFcDV25x4ysJFEnVveAGzGMS6sEEHSQ9JC+ALsZmBUt/eVdulx8vVh0d6eMQ==
X-Received: by 2002:a1c:f609:: with SMTP id w9mr9114757wmc.150.1594825606599;
        Wed, 15 Jul 2020 08:06:46 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w2sm3906140wrs.77.2020.07.15.08.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:06:45 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Sureshkumar Relli <nagasure@xilinx.com>
Subject: [PATCH 09/14] spi: spi-zynq-qspi: Add description for 2 missing attributes/parameters
Date:   Wed, 15 Jul 2020 16:06:27 +0100
Message-Id: <20200715150632.409077-10-lee.jones@linaro.org>
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

 drivers/spi/spi-zynq-qspi.c:143: warning: Function parameter or member 'dev' not described in 'zynq_qspi'
 drivers/spi/spi-zynq-qspi.c:334: warning: Function parameter or member 'spi' not described in 'zynq_qspi_config_op'
 drivers/spi/spi-zynq-qspi.c:334: warning: Excess function parameter 'qspi' description in 'zynq_qspi_config_op'

Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Sureshkumar Relli <nagasure@xilinx.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-zynq-qspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index bbf3d90561f54..5d8a5ee62fa23 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -119,6 +119,7 @@
 
 /**
  * struct zynq_qspi - Defines qspi driver instance
+ * @dev:		Pointer to the this device's information
  * @regs:		Virtual address of the QSPI controller registers
  * @refclk:		Pointer to the peripheral clock
  * @pclk:		Pointer to the APB clock
@@ -316,7 +317,7 @@ static void zynq_qspi_chipselect(struct spi_device *spi, bool assert)
 /**
  * zynq_qspi_config_op - Configure QSPI controller for specified transfer
  * @xqspi:	Pointer to the zynq_qspi structure
- * @qspi:	Pointer to the spi_device structure
+ * @spi:	Pointer to the spi_device structure
  *
  * Sets the operational mode of QSPI controller for the next QSPI transfer and
  * sets the requested clock frequency.
-- 
2.25.1

