Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEBEC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EBA92083B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LNz53P4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgGQNyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgGQNy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:54:28 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E758C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:54:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z15so11192473wrl.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KGFwubHFzcLZa75OH2QfePfgNHp1yNFJ+5dMrYJqOBc=;
        b=LNz53P4vPM8KOT6MgDZZt6XHv/VQQGMQknAGIrbSBeKWG/DqcokivbaP+KPiPKngn7
         wyZfusiKq6wHj1H3NRXBVRRgwn92OZuXpoHoB4COPu/LYEEaBWueviYAs+8vaToPfiIX
         +5mKXjsrA8Qsw9IgpOUyw9iRWhM+Pqy3/ulzSZ+J/rN5QrKtA3MWoVTDBIrTzip58nzf
         78MvBYGi9ddoCLEP8NDJ/ry3KnnDNBWD0fJPc1A6756DJjCdCAN9/A1eh/zaUnKZmG3t
         JvKl6C0QsjM25XYiStS/XegGKvdBvzcCc4VK+mXGcUrzHGlergl5K2K3pcv73mIL85xQ
         Grzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGFwubHFzcLZa75OH2QfePfgNHp1yNFJ+5dMrYJqOBc=;
        b=jdYBkWX7jFZQ8wu+Ax62jDOXCuU9Zt891CvhV1LS6vW3GJtA3m8+xk2tv/KhUNk3CU
         /+Qy2/MN/tM+WFohQjYWlpJgPZ+r6BeRluWoFunv4d6ccBQ+TdJWRk1fxvS5HnoGR9+d
         01Y8FMOueP0xZ0Rvu+dHeL+a0ZRv//ezt6/6RZIUrnQsGfBWTKh8FRyazvDp/ucJ2c5m
         b9MBZWDsxdpJMEZY+GTj7Acqy2oSzr960xypbABbGD9h8XUe/S02W1Tct6xN0U3TfMMn
         r/w3lntgwVWE0P6FjbC7aeDRJyMt2CADc4l3rZoAO2MFk2BCEUgXbHx2g4AJMainz9Iy
         9Meg==
X-Gm-Message-State: AOAM5310XKmW5halQ7ArPGOZE7uwpUwF0eCTkKzwC6IjcBC23btk6khN
        i4/itsO0Ob6zDW0lSKhYBCZ5S3KvGj2+UA==
X-Google-Smtp-Source: ABdhPJyRBdalYFJ2SqW1AzaxyMFU8anZRL1EGLZqqUNS1odMSvESXDDxeCbz5xSprj+I0pStJ0HyWQ==
X-Received: by 2002:adf:ee4d:: with SMTP id w13mr10311012wro.245.1594994068030;
        Fri, 17 Jul 2020 06:54:28 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id w128sm16118356wmb.19.2020.07.17.06.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:54:27 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Martin Sperl <kernel@martin.sperl.org>
Subject: [PATCH v2 01/14] spi: spi-loopback-test: Fix formatting issues in function header blocks
Date:   Fri, 17 Jul 2020 14:54:11 +0100
Message-Id: <20200717135424.2442271-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717135424.2442271-1-lee.jones@linaro.org>
References: <20200717135424.2442271-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc function parameter descriptions must be in '@.*: ' format.

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-loopback-test.c:897: warning: Function parameter or member 'spi' not described in 'spi_test_execute_msg'
 drivers/spi/spi-loopback-test.c:897: warning: Function parameter or member 'test' not described in 'spi_test_execute_msg'
 drivers/spi/spi-loopback-test.c:897: warning: Function parameter or member 'tx' not described in 'spi_test_execute_msg'
 drivers/spi/spi-loopback-test.c:897: warning: Function parameter or member 'rx' not described in 'spi_test_execute_msg'
 drivers/spi/spi-loopback-test.c:970: warning: Function parameter or member 'spi' not described in 'spi_test_run_test'
 drivers/spi/spi-loopback-test.c:970: warning: Function parameter or member 'test' not described in 'spi_test_run_test'
 drivers/spi/spi-loopback-test.c:970: warning: Function parameter or member 'tx' not described in 'spi_test_run_test'
 drivers/spi/spi-loopback-test.c:970: warning: Function parameter or member 'rx' not described in 'spi_test_run_test'

Cc: Mark Brown <broonie@kernel.org>
Cc: Martin Sperl <kernel@martin.sperl.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-loopback-test.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index b6d79cd156fb5..9522d1b5786d5 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -885,10 +885,10 @@ static int spi_test_run_iter(struct spi_device *spi,
 /**
  * spi_test_execute_msg - default implementation to run a test
  *
- * spi: @spi_device on which to run the @spi_message
- * test: the test to execute, which already contains @msg
- * tx:   the tx buffer allocated for the test sequence
- * rx:   the rx buffer allocated for the test sequence
+ * @spi: @spi_device on which to run the @spi_message
+ * @test: the test to execute, which already contains @msg
+ * @tx:   the tx buffer allocated for the test sequence
+ * @rx:   the rx buffer allocated for the test sequence
  *
  * Returns: error code of spi_sync as well as basic error checking
  */
@@ -957,10 +957,10 @@ EXPORT_SYMBOL_GPL(spi_test_execute_msg);
  *                     including all the relevant iterations on:
  *                     length and buffer alignment
  *
- * spi:  the spi_device to send the messages to
- * test: the test which we need to execute
- * tx:   the tx buffer allocated for the test sequence
- * rx:   the rx buffer allocated for the test sequence
+ * @spi:  the spi_device to send the messages to
+ * @test: the test which we need to execute
+ * @tx:   the tx buffer allocated for the test sequence
+ * @rx:   the rx buffer allocated for the test sequence
  *
  * Returns: status code of spi_sync or other failures
  */
-- 
2.25.1

