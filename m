Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABA3C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 21:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC23206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 21:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="Q5dJyq9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgHRVim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 17:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgHRViU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 17:38:20 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13FDC061348
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 14:38:18 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k8so279916wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 14:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KGbYgC10yEAQ0N/WNh4ekyP+m4b8XDZy+5vjdPR5yp4=;
        b=Q5dJyq9kIvH/s+LzOxf3acSRtCSjwRnYzmzPenCx+Kfw1xbvH5cXWbrQwhRa7CUTxe
         sJQoq7jg6pEyh++m2GKDyixMuE5tk1xemCoc0XPpnFQkoRsZxOPbJxqw3XTO5flm62uB
         ZoTVmg2M241qfE+HfdvxFB8VyyrYJ6kLRfAzY8BSAzMK4kzaOtR9fFMTZ7mAZ3+q7Bxp
         JBK+NRv0dTxIs/YCfqPS0LNi6fXyYArsfBk18uPdrGqpRoYnty3caLiaV6ahfBeuPkps
         elGRhNfajX5YNnnhgaJxmGLXjavt7GtIPktdH13cP1l4C9sSJvdlXNFbE3VcNskm8Tni
         kDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGbYgC10yEAQ0N/WNh4ekyP+m4b8XDZy+5vjdPR5yp4=;
        b=WEDkBlGFRMaiQlBWGjVfj+4Z6XMe3HC+D0TmeXgYbO+dwor0dW9wYbSg5Oxk96SuYp
         rE8q+/+IMlbPhjdrHaS0764d2CgmfDzCd9GLi9S7ShYE8JoyzARP4r6bzE6WcRLU/1Zv
         i6OWmrgNZxXng0/jj6FgX/VJ92kz5tgtIIsyWy37EwYLJhxRbc6i/FgwHKazUuECZA2Q
         Q8k9AtfqDlyJGz5BuPsxrN9V9XHH/OU9YmbFRx75fDcihgMjqXaHZHWYskFQ9tdsWtKU
         MdJeLquqJSDF4/UbP5eV3jvXKg1mC9nl3yS8K5EmFaJRDFwauplY8UMAB1I1iLp26z9g
         uUXA==
X-Gm-Message-State: AOAM531eU7yD1WR0baLSsllWLLELCZ4StIeQKJ/j3TAqAvr70yAuLskJ
        jQ8oZd06vF+TTFwO8Cg824NCLg==
X-Google-Smtp-Source: ABdhPJx63POYH5gXMHacZ8NmF7VSSR4RXWfPc1Q5bl7FQgmjkhB04gL1Q2InO4pZKZTdbCjIVlBz1Q==
X-Received: by 2002:a1c:dc86:: with SMTP id t128mr1841138wmg.6.1597786697216;
        Tue, 18 Aug 2020 14:38:17 -0700 (PDT)
Received: from localhost.localdomain ([88.116.83.106])
        by smtp.gmail.com with ESMTPSA id z207sm1797860wmc.2.2020.08.18.14.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 14:38:16 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crt Mori <cmo@melexis.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v6 5/5] iio:temperature:mlx90632: Some stylefixing leftovers
Date:   Tue, 18 Aug 2020 23:37:37 +0200
Message-Id: <20200818213737.140613-6-cmo@melexis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200818213737.140613-1-cmo@melexis.com>
References: <20200818213737.140613-1-cmo@melexis.com>
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
index 94bca2b2866a..472a7fb20615 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -112,10 +112,10 @@
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
 
 /**
@@ -889,7 +889,7 @@ static int mlx90632_probe(struct i2c_client *client,
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

