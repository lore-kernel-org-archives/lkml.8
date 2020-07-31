Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA81C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 894D321744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GdIxWKBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387602AbgGaQt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733051AbgGaQtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:49:01 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B40C061756
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 09:49:00 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id g19so20211529ioh.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 09:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fYfRtRWNJl9Yn2hyI+uBsjOjqoFWT79cyClOPwpH2dg=;
        b=GdIxWKBq8Nx+RFYfACUl5CdLRHgJ6yNDGaMOR99XLu1RRGcn+vTrIQHXoXHfT+jB4M
         LKMiZicp1+wFftkxIX7jZ7mmdXgJS/u0/P9hH4kdlLf3bPzyjSdttsBlwv5U1gphcgEm
         ydtGzFYm7eWucSJ12u01u+mFTDkKbrkwA+cL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fYfRtRWNJl9Yn2hyI+uBsjOjqoFWT79cyClOPwpH2dg=;
        b=WLMJJ0/KRqw1fFDieJcSUWi4DgvQ8iqUioivoZdQiIOQtmsVIWoPo56yZooHXuPxFS
         trf/LC3wS0/iWaLO5eTPdczdzCU28fPZH4GsnzOESGVBh7Oj9WlVtper/LiaiJJSbje2
         ViTROf/AiFTXBDxFpxWvEmsrTSunJPrcZM1uqMNtU3PYEunHGJ9uGlWJvlxucae63Hat
         ig10EdEcJDIukjbNGy08GrTSjrb2dGHS2w8NFA+FJctwl/T51+x4TC365k9KY4mbuuSt
         bQAjt30CHK2EKXJGey5o66YPT51tV70vJj/EU+Ysv8WvdA2iV4ct5Jzm8oxQPu+rVf16
         JbQQ==
X-Gm-Message-State: AOAM530KRf89NeEaL9eTBymaVD9a4D1ZflD+x6MAUtbU1wz3H0rLXxgK
        8VZh12RyO04cFNZH9myEKja8EQ==
X-Google-Smtp-Source: ABdhPJzwwlzQZYE4CzsXOSXHfiJmZOY3GnLWv89mBk6yUE97mxpy9XhELrZ/P6leUhKFdeIKJCsR3w==
X-Received: by 2002:a6b:f911:: with SMTP id j17mr4297683iog.96.1596214140314;
        Fri, 31 Jul 2020 09:49:00 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id e84sm5122083ill.60.2020.07.31.09.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:48:59 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: [PATCH v3 03/15] iio: sx9310: Fix irq handling
Date:   Fri, 31 Jul 2020 10:48:40 -0600
Message-Id: <20200731104555.v3.3.Idbfcd2e92d2fd89b6ed2e83211bd3e6c06852c33@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200731164853.3020946-1-campello@chromium.org>
References: <20200731164853.3020946-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes enable/disable irq handling at various points. The driver needs to
only enable/disable irqs if there is an actual irq handler installed.

Signed-off-by: Daniel Campello <campello@chromium.org>
---

Changes in v3:
 - Moved irq presence check down to lower methods

Changes in v2:
 - Reordered error handling on sx9310_resume()

 drivers/iio/proximity/sx9310.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 07895d4b935d12..c7a27c21c20cd1 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -323,12 +323,18 @@ static int sx9310_put_event_channel(struct sx9310_data *data, int channel)
 
 static int sx9310_enable_irq(struct sx9310_data *data, unsigned int irq)
 {
-	return regmap_update_bits(data->regmap, SX9310_REG_IRQ_MSK, irq, irq);
+	if (data->client->irq)
+		return regmap_update_bits(data->regmap, SX9310_REG_IRQ_MSK, irq,
+					  irq);
+	return 0;
 }
 
 static int sx9310_disable_irq(struct sx9310_data *data, unsigned int irq)
 {
-	return regmap_update_bits(data->regmap, SX9310_REG_IRQ_MSK, irq, 0);
+	if (data->client->irq)
+		return regmap_update_bits(data->regmap, SX9310_REG_IRQ_MSK, irq,
+					  0);
+	return 0;
 }
 
 static int sx9310_read_prox_data(struct sx9310_data *data,
@@ -382,7 +388,7 @@ static int sx9310_read_proximity(struct sx9310_data *data,
 
 	mutex_unlock(&data->mutex);
 
-	if (data->client->irq > 0) {
+	if (data->client->irq) {
 		ret = wait_for_completion_interruptible(&data->completion);
 		reinit_completion(&data->completion);
 	} else {
@@ -1011,10 +1017,11 @@ static int __maybe_unused sx9310_resume(struct device *dev)
 
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

