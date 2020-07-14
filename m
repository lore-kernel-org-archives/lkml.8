Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B749C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F6E2220D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SdnZRHxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgGNLQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgGNLQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:16:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F86C08C5DF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:15:54 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l2so5008878wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1JX6Y3K2cqUwU/GGZOaVZUng81gC2+PNbg79UPVm7pA=;
        b=SdnZRHxrdki/679eF7FPi+/jeTt1n4vu5QCRmxeDf6qNUzYvM7bS2wL2e0ozSfTlDM
         tARtuX6tX/rbJL0nOjGxOz1EtxEWgSJNBrFZwRThgWXp5Kl5a6eD/wFnCjhIw+jzzB7/
         pa4ZdykY/E568sV/yKFbCQxdcbcvMthgP72Nu27IdlPvdnWn5ftPWOFl2iZSTN1CLks5
         jCbJHl6gQERwh+F3BClZBDXiW2ATsNlEyVQiw6QRQl3Zs4s0/giQC73/rqp6wSLML6mF
         zYRMnkFtGmDat2lWvacTNArmkiOZWN/S+hRGD0VkR7xu8KkSelzdOD+GdqTV8/pI3av1
         6uAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1JX6Y3K2cqUwU/GGZOaVZUng81gC2+PNbg79UPVm7pA=;
        b=uhIEFxDEJFYFniZ2jTe+n++9Cww+PPRWQdA+IJrEYS8woXZSy3qIIk9UAzTTYYM5jl
         bKzkznHi19L4U2yn33wqnlOOuN09Tf0/0hGk/BcfgiEOwGIf0+d1OQib54vC5rtRIgiP
         PuhfmQJdgNhZ7DA5tBE9+XrOkTObjGaVTozEQt6qUG75ay85kjadFw1T6WHYX6aTavg3
         ruO/81a+q33MMIsU8W9/sLNmBKkPElQO9x3SGArNyBmzOI8kgu4D4MaqJGUL5dXoNeKC
         byhSKkiiMg0TCapmiGBZe1HfsJITKXKCfCsOPmDqQWALjGPdg+kgC+ylpKjRoNS56GjO
         L7mg==
X-Gm-Message-State: AOAM533LMYqgJOM2RRK7MUYiMoSx8ZKBgjp/gTaqNBlMc/n/oKGUuXl0
        Dc/DaFpTIvHVrjqYe0x9hqY0mg==
X-Google-Smtp-Source: ABdhPJzIAm8WUFOAz5PhBWJ+LR0cHqt9Te+7GSve6DdRDT8JFwjK99lQq5ArJTTuSWYWI8WtVeWu0w==
X-Received: by 2002:a1c:a4c6:: with SMTP id n189mr3714749wme.173.1594725352930;
        Tue, 14 Jul 2020 04:15:52 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:15:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Lennert Buytenhek <buytenh@wantstofly.org>,
        Ryan Mallon <rmallon@gmail.com>,
        Mika Westerberg <mika.westerberg@iki.fi>
Subject: [PATCH 03/17] dma: ep93xx_dma: Provide some missing struct attribute documentation
Date:   Tue, 14 Jul 2020 12:15:32 +0100
Message-Id: <20200714111546.1755231-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714111546.1755231-1-lee.jones@linaro.org>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of entries were missed, causing kerneldoc to complain.

Fixes the following W=1 kernel build warning(s):

 drivers/dma/ep93xx_dma.c:183: warning: Function parameter or member 'slave_config' not described in 'ep93xx_dma_chan'
 drivers/dma/ep93xx_dma.c:215: warning: Function parameter or member 'hw_synchronize' not described in 'ep93xx_dma_engine'

Cc: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Ryan Mallon <rmallon@gmail.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/ep93xx_dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index 9c8b4d35cf03d..87a246012629f 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -147,6 +147,7 @@ struct ep93xx_dma_desc {
  *                is set via .device_config before slave operation is
  *                prepared
  * @runtime_ctrl: M2M runtime values for the control register.
+ * @slave_config: slave configuration
  *
  * As EP93xx DMA controller doesn't support real chained DMA descriptors we
  * will have slightly different scheme here: @active points to a head of
@@ -187,6 +188,7 @@ struct ep93xx_dma_chan {
  * @dma_dev: holds the dmaengine device
  * @m2m: is this an M2M or M2P device
  * @hw_setup: method which sets the channel up for operation
+ * @hw_synchronize: synchronizes DMA channel termination to current context
  * @hw_shutdown: shuts the channel down and flushes whatever is left
  * @hw_submit: pushes active descriptor(s) to the hardware
  * @hw_interrupt: handle the interrupt
-- 
2.25.1

