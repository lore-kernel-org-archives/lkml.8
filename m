Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC841C433FC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B945A207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="laIysYMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgGPOA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbgGPN7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:59:54 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE356C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:53 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z2so7211327wrp.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HmsMpTwfL7pGfzUHY+3b/NowLtKwAcX5ohfQKTrGvPA=;
        b=laIysYMMocgn89Hv3NkjP1Jq0QAhgj4ZVjNxfrrMJwCnUv/WsLO4F2Nkr/wHPuNIUg
         mP+NeoGVihsczpizzfCPJKw6wPE1V3cKXk5EpzHoeJ1HkZIaOS8M1t1xog85/GqpcNLf
         WexHvrrAju7qfYLVBi1PbvzLB9kTTalqx47jC7JWPXtX7GskIYX4SkzKYNXvrXxTSg66
         6NeHZk/b09GWq23D5NuCfI/3AdMEZnxvbXGwWmnihzJjUR5U5YqbxYeswhqywylnmJeS
         C2zHSDSrJsXvxTwdsS0MrWavEpFi2BTcNF9FhUmK2BtFH+nJwzguJQM4Edwc9txNVjvf
         O6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HmsMpTwfL7pGfzUHY+3b/NowLtKwAcX5ohfQKTrGvPA=;
        b=F/g89T7Ys/oNeVGXBVWp4WsPse/0Ue9WHuIOSa7cNr6MWaO6MV3qcvI/vKXgkvTSE0
         ZIXQ0xXvGoauULdEjK6tVkUYdK2nS+/AdKyaTyV8GQ3b9WhI4OImgGtLKOJxCli759cW
         EERDrkC8Y/eUTdqcMOPx1f+uqi6g05KhmBN7Y8sIscymjFlLoE/Hk2cUS0v4PN6/OFZm
         S4bPSAT2GuhxFBLzyrJJFco/pSk3e6XWds2gFZNLFGKt+DN5hRzXUY+YJVTFk9UQzzh0
         EQjAoc73X8aRwpEQrRKgUdS513AQcax0v2ooJ+5r5ldsLH9V7ySmJL8c8DsDeqtM7xOd
         MG6w==
X-Gm-Message-State: AOAM530GK20SGAVhIELwjy5gtjw030/zaczWsn6WLpT7/WO2tC5AoiqR
        aZ1X6fqmgMZC+BbyZBCg3XkkxA==
X-Google-Smtp-Source: ABdhPJx3xo8ont4fyIRFtPaHaTq3DoVh4R/yBthdWhJ+fV6UOuEkvSnBzCLHALtNNJeLVQx1vYiUdA==
X-Received: by 2002:a05:6000:1190:: with SMTP id g16mr5000111wrx.286.1594907992627;
        Thu, 16 Jul 2020 06:59:52 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:51 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Subject: [PATCH 17/30] iio: adc: ad7949: Fix misspelling issue and compiler attribute ordering
Date:   Thu, 16 Jul 2020 14:59:15 +0100
Message-Id: <20200716135928.1456727-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc gets confused if the variable does not follow the
type/attribute definitions.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/ad7949.c:58: warning: Function parameter or member 'indio_dev' not described in 'ad7949_adc_chip'
 drivers/iio/adc/ad7949.c:58: warning: Function parameter or member '____cacheline_aligned' not described in 'ad7949_adc_chip'

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/ad7949.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 2c6f60edb7ced..a3fc42617feb9 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -39,7 +39,7 @@ static const struct ad7949_adc_spec ad7949_adc_spec[] = {
  * struct ad7949_adc_chip - AD ADC chip
  * @lock: protects write sequences
  * @vref: regulator generating Vref
- * @iio_dev: reference to iio structure
+ * @indio_dev: reference to iio structure
  * @spi: reference to spi structure
  * @resolution: resolution of the chip
  * @cfg: copy of the configuration register
@@ -54,7 +54,7 @@ struct ad7949_adc_chip {
 	u8 resolution;
 	u16 cfg;
 	unsigned int current_channel;
-	u16 buffer ____cacheline_aligned;
+	u16 ____cacheline_aligned buffer;
 };
 
 static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
-- 
2.25.1

