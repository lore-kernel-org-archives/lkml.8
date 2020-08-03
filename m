Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF4FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F2A20792
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m9q+Mz9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgHCXm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 19:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbgHCXmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 19:42:03 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F80CC061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 16:42:03 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id a5so25108824ioa.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 16:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=muEpSfoCuV2CQqyvNh+4FTQlFWMtwM8V3UJRLf2lB9Q=;
        b=m9q+Mz9Zsu8ZnwuHZpehZE6IShE0IbrLzW1Vn+8DXk5TP2pk/gxU7X7+NMzSiHcbeg
         46fN75ue3SKcnmNPvdZEQEci9EHf/D+P6RsIGPkdPJ+0JKJ6jmUE8VloSLf61eJi+JU9
         pyRJOFXHmVrORxIwh698s5iWKPvzLtyPQF0So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=muEpSfoCuV2CQqyvNh+4FTQlFWMtwM8V3UJRLf2lB9Q=;
        b=n6YG2OCXouQtDMQbD50e0NloNSbXGDaM2WzG6sZYlXW8V6kbcRSIfXlX36JuzpDDY5
         c/V5N6WZUmQd+ZEPyCtq6pqZvl2F0zY+TpiWKsty08AHcayl7pp15enJHHGpE3asnzEF
         TQM2D3KJSuUqKp0PruHm84RPegafCcx5gPDtOPOpFoNCJfqav+LvBV3E/CMNKsLcm8G7
         Sjk6DSYKn7C/9NxlNSTr723xTKKZdh/Wi6xtXspk02ZIjbgCR86XdFUDnj3+sXTKG0QT
         9dkbOE2HYmDilFMb7ai2xycBJeeY6mY0pH/bPnl8NO+Jo/GoprpQPNeEZK7Jw+eYMcoA
         Fy+Q==
X-Gm-Message-State: AOAM532yo48yHoCZLyORTkk7MSk1w8PABMizVt8zcGAE/rmZz8K/mBLT
        OoI4Bo5y0/HWBz7qV3xqTMzeRxnqMFBB+Q==
X-Google-Smtp-Source: ABdhPJwn0hmIvd4Egmn7+rn8BhEjPhygihmn++xjnF4YCf+dESCDH4zCHMx3CBzwXBwRSEhTi3ldcw==
X-Received: by 2002:a05:6638:130d:: with SMTP id r13mr2417998jad.89.1596498122574;
        Mon, 03 Aug 2020 16:42:02 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id g2sm5468435ioe.4.2020.08.03.16.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:42:02 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v4 03/15] iio: sx9310: Fix irq handling
Date:   Mon,  3 Aug 2020 17:41:42 -0600
Message-Id: <20200803131544.v4.3.Idbfcd2e92d2fd89b6ed2e83211bd3e6c06852c33@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803234154.320400-1-campello@chromium.org>
References: <20200803234154.320400-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes enable/disable irq handling at various points. The driver needs to
only enable/disable irqs if there is an actual irq handler installed.

Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v4:
 - Reverted condition check logic on enable/disable_irq methods.

Changes in v3:
 - Moved irq presence check down to lower methods

Changes in v2:
 - Reordered error handling on sx9310_resume()

 drivers/iio/proximity/sx9310.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 69db4cefe49f2a..3523ee5c8f0d2d 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -322,11 +322,15 @@ static int sx9310_put_event_channel(struct sx9310_data *data, int channel)
 
 static int sx9310_enable_irq(struct sx9310_data *data, unsigned int irq)
 {
+	if (!data->client->irq)
+		return 0;
 	return regmap_update_bits(data->regmap, SX9310_REG_IRQ_MSK, irq, irq);
 }
 
 static int sx9310_disable_irq(struct sx9310_data *data, unsigned int irq)
 {
+	if (!data->client->irq)
+		return 0;
 	return regmap_update_bits(data->regmap, SX9310_REG_IRQ_MSK, irq, 0);
 }
 
@@ -380,7 +384,7 @@ static int sx9310_read_proximity(struct sx9310_data *data,
 
 	mutex_unlock(&data->mutex);
 
-	if (data->client->irq > 0) {
+	if (data->client->irq) {
 		ret = wait_for_completion_interruptible(&data->completion);
 		reinit_completion(&data->completion);
 	} else {
@@ -1009,10 +1013,11 @@ static int __maybe_unused sx9310_resume(struct device *dev)
 
 out:
 	mutex_unlock(&data->mutex);
+	if (ret)
+		return ret;
 
 	enable_irq(data->client->irq);
-
-	return ret;
+	return 0;
 }
 
 static const struct dev_pm_ops sx9310_pm_ops = {
-- 
2.28.0.163.g6104cc2f0b6-goog

