Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E378C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 12:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB14C20759
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 12:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="nmjhCjBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgHHMOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 08:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgHHMLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 08:11:06 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A336FC061A2D
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 05:11:04 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c2so3108976edx.8
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 05:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iwT5dLwqwIktBk8BAuaK5rEPEXEhVNZFccTAy3Fbof4=;
        b=nmjhCjBRc9mxMyseEIB8/TrT6uRxSgmqvU7lsjzBSn9l+mqTkV5yzykZ0W1vi5hLq4
         Lo51w9QKljps5lw8NaHixOkRYaLTcCh7CUboskR2scMCZqOzkVX+1fyrkFE1lkRjLCbc
         LUKsrlrQi+EB/Z7+U2hJQAoWDkw+vLVNnmizolCmnobSU8kbDNAlXivMvNW5vxGKa1gM
         KWGXzHkNwVyUqCb06LXqqQrdBlJX+wW6UPcLZQKNkcqUHyG2zMCz1avYZ2YZ73DAIrlV
         7YE63aY+8HCA6Z5tezExRob9FEUi1DdoKXuqHSaARb7Ahx3jZejeeRVIuJX4BdqY78UM
         CWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iwT5dLwqwIktBk8BAuaK5rEPEXEhVNZFccTAy3Fbof4=;
        b=Zg2eSoP+qfMUVvF4IpJfSE39X4EtAxl216YgyQJKyOn2g07JfHIOCfOFkF6sbS2rl5
         yrn5mkkkfh8k3z37a7pICEcwmaytu3IQVk0gQQc23j+ynQR2MMermClBtitLoxw5jBP+
         gYiMQ2Ulov60XhGqzZOk/MWKFEzsDutB7fJgR+gfCdQMBDW/Cgg4IYBzUhIomo+ASGPM
         rc0hX6WNzZzyl98L/qQSu197l87hVZssl+OTwFMZKgq4tw+iA2hH2Jtvt+jSWRlJghPl
         X3VghD6bASvs9olmiiwthiyQ5pljsxZxm+PfSJ+LTRv2+FG4l76rkBYSjfSPECIlRDD1
         Cstg==
X-Gm-Message-State: AOAM5324gUURmw5UhTv145IGsoY5SOMlxEnk3RNH/S9uoSnS078yEJFd
        puIEeotragitOOQpC1aSSg9MUA==
X-Google-Smtp-Source: ABdhPJxwIPtcD5lqZgbxRX29wdIA7hTdDh3T8+rpEb7WJPXKRxX2wPPSEkQhGDxzi07w08J4v0phHw==
X-Received: by 2002:aa7:dc4f:: with SMTP id g15mr13266140edu.335.1596888663357;
        Sat, 08 Aug 2020 05:11:03 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xajgywt9p1tstfsdfc.18120a2.ip6.access.telenet.be. [2a02:1810:a421:dd00:b0e6:1cd9:30c1:35f8])
        by smtp.gmail.com with ESMTPSA id b2sm8130833ejg.70.2020.08.08.05.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 05:11:02 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v4 3/4] iio:temperature:mlx90632: Add kerneldoc to the internal struct
Date:   Sat,  8 Aug 2020 14:10:25 +0200
Message-Id: <20200808121026.1300375-4-cmo@melexis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808121026.1300375-1-cmo@melexis.com>
References: <20200808121026.1300375-1-cmo@melexis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document internal/private struct for mlx90632 device.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 049c1217a166..4e0131705c11 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -107,12 +107,23 @@
 #define MLX90632_SLEEP_DELAY_MS 3000 /**< Autosleep delay */
 #define MLX90632_EXTENDED_LIMIT 27000 /* Extended mode raw value limit */
 
+/**
+ * struct mlx90632_data - private data for the MLX90632 device
+ * @client: I2C client of the device
+ * @lock: Internal mutex for multiple reads for single measurement
+ * @regmap: Regmap of the device
+ * @emissivity: Object emissivity from 0 to 1000 where 1000 = 1.
+ * @mtyp: Measurement type physical sensor configuration for extended range
+ *        calculations
+ * @object_ambient_temperature: Ambient temperature at object (might differ of
+ *                              the ambient temperature of sensor.
+ */
 struct mlx90632_data {
 	struct i2c_client *client;
-	struct mutex lock; /* Multiple reads for single measurement */
+	struct mutex lock;
 	struct regmap *regmap;
 	u16 emissivity;
-	u8 mtyp; /* measurement type - to enable extended range calculations */
+	u8 mtyp;
 	u32 object_ambient_temperature;
 };
 
-- 
2.25.1

