Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDB1C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ECE82065D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kqv7FzFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgGUAZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 20:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgGUAZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 20:25:20 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D88C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 17:25:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id md7so772011pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 17:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7cxptc4I/uOK5zTa3+O6Lrt7Z3UnpyH3/NcfeHtxs2k=;
        b=kqv7FzFYlqpP35k6zN5lEaueIoVHx4Ipg0XpEcOUS507nHuC7IasfUG4xSY3fS+4c+
         U97ZTSg7nK0i9ELt24YJchzv8voKn3LYiLQ4QkEFEjSYIimDtPnAgd0hlQInqTQCkVqw
         je1vEb0N7spgKaymso/hwf1GgdqwGG2XYauNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7cxptc4I/uOK5zTa3+O6Lrt7Z3UnpyH3/NcfeHtxs2k=;
        b=LhBwnNZi30CJVhuzPyFwR4yLQaSITeNTzFngJxedZInt8uikfvbBvE5VCVZFjACJG1
         uBrpAtTrnfYzCx58caOa0Le52exDo9T3oat9wcet33Cl7XCg6QkpJIlct7GcdCBcKRwe
         8Fl18W3eEUw7UF8n+r5OHoboK8e/fHXSzV3igGjDy5SW1JafWqSPJUh5dIh50awBYgLz
         SElOikmJ0H9CFNLE5hXiAkA9Yg/o/A07IaIqH2yODZUal5HUYc8zwkVeZGjECE+FSzcb
         T6DTGbjApRqNlUtL8uiQoaPT9+i7ZMd8Aoe8vxmMWa89kpsGarJM+ceU8o4sqmm4PZMi
         +yIA==
X-Gm-Message-State: AOAM532zoLiZXI2p5UPXa2vjytfhrfDwqYt3tegKKJhAzMdZLo3AVVrZ
        i82bhleS8L6YAFGh1wL4WRJIBg==
X-Google-Smtp-Source: ABdhPJxHW7frVmS8V0RoIetzAbs38yiQVoktU5vXv/PCZdocNsbIVSOuKk3PhCURyty5yY8RldMy+w==
X-Received: by 2002:a17:90a:31ce:: with SMTP id j14mr1898552pjf.65.1595291120112;
        Mon, 20 Jul 2020 17:25:20 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id 17sm758669pjl.30.2020.07.20.17.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 17:25:19 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, swboyd@chromium.org,
        Akash Asthana <akashast@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Wolfram Sang <wsa@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: i2c-qcom-geni: Fix DMA transfer race
Date:   Mon, 20 Jul 2020 17:24:53 -0700
Message-Id: <20200720172448.1.I7efdf6efaa6edadbb690196cd4fbe3392a582c89@changeid>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I have KASAN enabled on my kernel and I start stressing the
touchscreen my system tends to hang.  The touchscreen is one of the
only things that does a lot of big i2c transfers and ends up hitting
the DMA paths in the geni i2c driver.  It appears that KASAN adds
enough delay in my system to tickle a race condition in the DMA setup
code.

When the system hangs, I found that it was running the geni_i2c_irq()
over and over again.  It had these:

m_stat   = 0x04000080
rx_st    = 0x30000011
dm_tx_st = 0x00000000
dm_rx_st = 0x00000000
dma      = 0x00000001

Notably we're in DMA mode but are getting M_RX_IRQ_EN and
M_RX_FIFO_WATERMARK_EN over and over again.

Putting some traces in geni_i2c_rx_one_msg() showed that when we
failed we were getting to the start of geni_i2c_rx_one_msg() but were
never executing geni_se_rx_dma_prep().

I believe that the problem here is that we are writing the transfer
length and setting up the geni command before we run
geni_se_rx_dma_prep().  If a transfer makes it far enough before we do
that then we get into the state I have observed.  Let's change the
order, which seems to work fine.

Fixes: 37692de5d523 ("i2c: i2c-qcom-geni: Add bus driver for the Qualcomm GENI I2C controller")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/i2c/busses/i2c-qcom-geni.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 18d1e4fd4cf3..21e27f10510a 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -366,15 +366,15 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	else
 		geni_se_select_mode(se, GENI_SE_FIFO);
 
-	writel_relaxed(len, se->base + SE_I2C_RX_TRANS_LEN);
-	geni_se_setup_m_cmd(se, I2C_READ, m_param);
-
 	if (dma_buf && geni_se_rx_dma_prep(se, dma_buf, len, &rx_dma)) {
 		geni_se_select_mode(se, GENI_SE_FIFO);
 		i2c_put_dma_safe_msg_buf(dma_buf, msg, false);
 		dma_buf = NULL;
 	}
 
+	writel_relaxed(len, se->base + SE_I2C_RX_TRANS_LEN);
+	geni_se_setup_m_cmd(se, I2C_READ, m_param);
+
 	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
 	if (!time_left)
 		geni_i2c_abort_xfer(gi2c);
-- 
2.28.0.rc0.142.g3c755180ce-goog

