Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E031DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5918206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GDnU2+Ca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731439AbgFRPLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730950AbgFRPKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:10:51 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E4DC0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 08:10:51 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id b5so3029574pgm.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 08:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EgswRRarbAngjEcfcdO7vzU1X69Dnu5N0WEEYS8N17E=;
        b=GDnU2+CaEI6iO1FX18aBPuHJlLAXyHMvQn8RC61SQb2CvOFmgQWPfbcual4cPk934X
         sA0sjnBzrS6IZu2mx3Yj26le/et18tojNvJpgNQHujueWEvey7C4obNY7U2CIl4myHAz
         mcjeD1MBLt/CARfSmNysfkIDQLJS4fUXzJr6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EgswRRarbAngjEcfcdO7vzU1X69Dnu5N0WEEYS8N17E=;
        b=uMoWLn5RNTNX5VEkBQHRN1JdbUO6+xqTPghTvF7cQabAfa8PZfkV6MchUclrNcg93m
         QRB4/9ml2exUmz9X74/1MQC2FNVjKev8hI49tVRWirVOBJZykrZzEpxLAYZzKkYqjn+e
         Tkmjso1y7u5ERH6ZpoI0VZux/yQ9cOMY4RnbvCrMVy4mBzPAwgqJmt/nqo1u3x1SiN0s
         5OPKcDZSF8RsnYrYXTgEpv9OyPUyQ4HOofwysrzq7cXlTRxDtLqH0kFh2MFuEwIHqq5v
         Qmp9JzIojvr0ljIsGSDVFlLEqZmxM6tvIKqc+R6CfDGiJQRNI8aIBKuKP3IF7owa8y94
         XCaw==
X-Gm-Message-State: AOAM532OOyStGZ1Mf4NqUO8WSoX1CdY36ep3x47kg5wKqo82Gu+TLA6Y
        kEo1N01RcrmA4eSny2yjXN2xOw==
X-Google-Smtp-Source: ABdhPJxWP5h6GqAJBOvQkYlENccfoLscwWKOsJ5bOnlei9cHfBy1KvAoZrC0RykDVJAKLwA2KbbfAw==
X-Received: by 2002:a63:a558:: with SMTP id r24mr3845460pgu.70.1592493051091;
        Thu, 18 Jun 2020 08:10:51 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id b14sm3171510pft.23.2020.06.18.08.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 08:10:50 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     swboyd@chromium.org, Alok Chauhan <alokc@codeaurora.org>,
        skakit@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v4 3/5] spi: spi-geni-qcom: Check for error IRQs
Date:   Thu, 18 Jun 2020 08:06:24 -0700
Message-Id: <20200618080459.v4.3.Id8bebdbdb4d2ed9468634343a7e6207d6cffff8a@changeid>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
In-Reply-To: <20200618150626.237027-1-dianders@chromium.org>
References: <20200618150626.237027-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From reading the #defines it seems like we should shout if we ever see
one of these error bits.  Let's do so.  This doesn't do anything
functional except print a yell in the log if the error bits are seen.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v4: None
Changes in v3:
- ("spi: spi-geni-qcom: Check for error IRQs") new in v3.

Changes in v2: None

 drivers/spi/spi-geni-qcom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 7d022ccb1b6c..11f36d237c77 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -506,6 +506,11 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 	if (!m_irq)
 		return IRQ_NONE;
 
+	if (m_irq & (M_CMD_OVERRUN_EN | M_ILLEGAL_CMD_EN | M_CMD_FAILURE_EN |
+		     M_RX_FIFO_RD_ERR_EN | M_RX_FIFO_WR_ERR_EN |
+		     M_TX_FIFO_RD_ERR_EN | M_TX_FIFO_WR_ERR_EN))
+		dev_warn(mas->dev, "Unexpected IRQ err status %#010x\n", m_irq);
+
 	spin_lock(&mas->lock);
 
 	if ((m_irq & M_RX_FIFO_WATERMARK_EN) || (m_irq & M_RX_FIFO_LAST_EN))
-- 
2.27.0.290.gba653c62da-goog

