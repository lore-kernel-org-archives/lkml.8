Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4587FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 21:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B54120855
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 21:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="FM7teyxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgHFVVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 17:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgHFVVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 17:21:53 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FA0C061575
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 14:21:53 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id a14so19220947edx.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 14:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OcwpVwgQkQNfxgUEyAIrT6iYiRpJR57tojaAbnXnMTk=;
        b=FM7teyxpTxUOe7phi0zpIhzptqdrjT7P457yEB3f3qEhWPiwC+VOSHj0CD/LyA2+g3
         v4NrX0spx+2KR19VqzW20Hzb5nu8NIIgB7CcWGp5EPDzT+9ttGMpVZ7QgO66A6q4pPG0
         2r7L0ChFxukpUotnlxF3XewZWZmgpmXYJich74PCevGxlvS0qy5cR88AbAGQPkzFqaDy
         9Ol4jlQV9yxO/fCkYjVIT4OK4U5wS/8EoCI3V7Hd0+q4wKsi9Dx9USDL+UPKLIsO10YV
         5MUivk6lLWsgMiJdGXcgPbB8j5mU1LyDz1QMbdIxFiN1JVzB9frGp4cKpMM7qw2E8l9f
         TLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OcwpVwgQkQNfxgUEyAIrT6iYiRpJR57tojaAbnXnMTk=;
        b=NvFbbs6BnXGL6eWkN5YtYavyEqOdfjKu6VK8/IP5CgU5tQNdtdrt8W/yhiVr3sv4cn
         /VDr8/hZS4XfigV2Y88LK30rBpyr/emRDSAbE7mW/lxB3TaH3yhhyBRv86/vsIf8CMtN
         t3JwcpuHdfo84jBsChOoj9ChtCz18s571xeVnWw3/L1dw0eyvzYVXNi64rthQRDGrNeh
         vIMaODMTPCNwrax1ja1jk860zo+lPV9IlgRd6is/Ovlwt0BHYLUFPW4mfqNQ1VH6SVWm
         3VSvbCy9+SNElN8x1ta9/k+fyAqJ5Ahgr+Yt/qKZe5LOEQUh3tT/8izKLIFVYisYO2Q2
         viLw==
X-Gm-Message-State: AOAM533TLmFSehMy2EEK4rwYeYoUbn2/AbAqLHs8K1xdjpbk+Em3/mST
        tVqZopEzk/Qn3swx70hk+rnAtw==
X-Google-Smtp-Source: ABdhPJzhv+97PAaLM4+R6R5G6izODVOCGNBsSRnMDTvCjqrbnD8kTl6QxQA8T9blP+ogQlMCny3xWw==
X-Received: by 2002:aa7:cd46:: with SMTP id v6mr5680798edw.21.1596748910854;
        Thu, 06 Aug 2020 14:21:50 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xajgyum9863qf6si3v.18120a2.ip6.access.telenet.be. [2a02:1810:a421:dd00:2092:7f6b:4676:cab])
        by smtp.gmail.com with ESMTPSA id k10sm4489300ejj.108.2020.08.06.14.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 14:21:49 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH] iio:temperature:mlx90632: Some stylefixing leftovers
Date:   Thu,  6 Aug 2020 23:21:39 +0200
Message-Id: <20200806212139.923270-1-cmo@melexis.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is some inconsistency and whitespace cleanup performed in this
patch. It was done on top of my other patches, but I can rebase to head
of the togreg branch if it would go in sooner.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index bb35a65bb9f0..d966e5387c48 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -100,10 +100,10 @@
 #define MLX90632_DSP_VERSION	5 /* DSP version */
 #define MLX90632_DSP_MASK	GENMASK(7, 0) /* DSP version in EE_VERSION */
 #define MLX90632_RESET_CMD	0x0006 /* Reset sensor (address or global) */
-#define MLX90632_REF_12		12LL /**< ResCtrlRef value of Ch 1 or Ch 2 */
-#define MLX90632_REF_3		12LL /**< ResCtrlRef value of Channel 3 */
-#define MLX90632_MAX_MEAS_NUM	31 /**< Maximum measurements in list */
-#define MLX90632_SLEEP_DELAY_MS 3000 /**< Autosleep delay */
+#define MLX90632_REF_12 	12LL /* ResCtrlRef value of Ch 1 or Ch 2 */
+#define MLX90632_REF_3		12LL /* ResCtrlRef value of Channel 3 */
+#define MLX90632_MAX_MEAS_NUM	31 /* Maximum measurements in list */
+#define MLX90632_SLEEP_DELAY_MS 3000 /* Autosleep delay */
 #define MLX90632_EXTENDED_LIMIT 27000 /* Extended mode raw value limit */
 
 struct mlx90632_data {
@@ -884,7 +884,7 @@ static int mlx90632_probe(struct i2c_client *client,
 		mlx90632->mtyp = MLX90632_MTYP_EXTENDED;
 	} else if ((read & MLX90632_DSP_MASK) == MLX90632_DSP_VERSION) {
 		dev_dbg(&client->dev,
-			"Detected Unknown EEPROM calibration %x\n", read);	
+			"Detected Unknown EEPROM calibration %x\n", read);
 	} else {
 		dev_err(&client->dev,
 			"Wrong DSP version %x (expected %x)\n",
-- 
2.25.1

