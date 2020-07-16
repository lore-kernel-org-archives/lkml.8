Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05632C43445
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCF3420842
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S1ggKKr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgGPOAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbgGPOAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:00:02 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB28BC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:00:01 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so7094910wrj.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bkghzH4FwjGUVQFUZPoQ97cOQabOY+KdLhABNUZLqIk=;
        b=S1ggKKr4PsJt4mnmFy83hI5iE2gJWJql1bB9gOk+PK5KznVZKiv0CzTg8eyKCXNTcP
         Hb0EIspfFfeYzKpt/O41IvcFTDh7L52KazjEkdupAVnk2gJ8bPVCLzw9Ph6/P+/C67Le
         W65BHf1ymoCwyGb+rT7YXibxWdGo4P3Zg3gmUGEMdVwGeb991gHdRaFrLN+cpM6Ni59f
         87Q3djAnHrpsXS14Q5Gm0Lp+kobOspNfNsFZ5emHq5g6uEsULserGcgTBSBvFcOuNdtN
         PnClSEw4/vzH4Z0eS+TjeSTu+aH4FHY1tiBDLOjG6WSO6Gmj9B0R0OtHEK9eW5OJlD54
         fmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bkghzH4FwjGUVQFUZPoQ97cOQabOY+KdLhABNUZLqIk=;
        b=U5QvUJ5P/+SO+nIpiJ/O13t/cATnMmJJgOznBc4AcRUMH7WIZB3UmgMYhO3vbaCskX
         C34+8MYtIwsrFXb3DhQetqBQDJ0HoeXNRl5wX/FfzU8zuf1B+7lU5qsz0NwomyZT52po
         ZgzMEDR9S2Hw0E2QydQ0XXU8PO2nmCfZ9YThwimc+nf78x6FqnTLtJpxuC1XzG16Z6rb
         qMOSCQpaTJEvE2z3cBK3PggFa0I5WEUirWh3vTx/Z+RhdAyYnNysiZ7+LtF4tCliiKph
         HKk6fgFos4qsETwFW0fEcnOtpO/mRUlET7jfOMfjJytt2P+rsVyqQjcILjgegvJhJhly
         nM1A==
X-Gm-Message-State: AOAM5338VzBtR+6jb2Y2LfOzSBK8v6ed0HPVaF39GA+YvJQvIPMTfHjA
        6j2e+FRXJHhq/WheGnw1H2quBg==
X-Google-Smtp-Source: ABdhPJzeVMIR8thnmbqfUj0K3saB+lmylMEVfVpRaOION/gNn16Ry4C428YCMr2eRk7YrRcwvvAk/g==
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr5059867wre.369.1594908000543;
        Thu, 16 Jul 2020 07:00:00 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 07:00:00 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH 23/30] iio: dac: ad5758: Move and fix-up kerneldoc header and demote unworthy kerneldoc
Date:   Thu, 16 Jul 2020 14:59:21 +0100
Message-Id: <20200716135928.1456727-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc headers need to come directly before the function/struct
that they are documenting.  Also fix some missing descriptions and
misspellings.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/dac/ad5758.c:111: warning: Function parameter or member 'reg' not described in 'ad5758_range'
 drivers/iio/dac/ad5758.c:111: warning: Function parameter or member 'min' not described in 'ad5758_range'
 drivers/iio/dac/ad5758.c:111: warning: Function parameter or member 'max' not described in 'ad5758_range'
 drivers/iio/dac/ad5758.c:122: warning: Function parameter or member 'gpio_reset' not described in 'ad5758_state'
 drivers/iio/dac/ad5758.c:122: warning: Function parameter or member 'd32' not described in 'ad5758_state'
 drivers/iio/dac/ad5758.c:137: warning: cannot understand function prototype: 'enum ad5758_output_range '

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Stefan Popa <stefan.popa@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dac/ad5758.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index 475646c82b40e..c34740d2c89a1 100644
--- a/drivers/iio/dac/ad5758.c
+++ b/drivers/iio/dac/ad5758.c
@@ -92,24 +92,24 @@
 
 #define AD5758_FULL_SCALE_MICRO	65535000000ULL
 
+struct ad5758_range {
+	int reg;
+	int min;
+	int max;
+};
+
 /**
  * struct ad5758_state - driver instance specific data
  * @spi:	spi_device
  * @lock:	mutex lock
+ * @gpio_reset:	gpio descriptor for the reset line
  * @out_range:	struct which stores the output range
  * @dc_dc_mode:	variable which stores the mode of operation
  * @dc_dc_ilim:	variable which stores the dc-to-dc converter current limit
  * @slew_time:	variable which stores the target slew time
  * @pwr_down:	variable which contains whether a channel is powered down or not
- * @data:	spi transfer buffers
+ * @d32:	spi transfer buffers
  */
-
-struct ad5758_range {
-	int reg;
-	int min;
-	int max;
-};
-
 struct ad5758_state {
 	struct spi_device *spi;
 	struct mutex lock;
@@ -122,7 +122,7 @@ struct ad5758_state {
 	__be32 d32[3];
 };
 
-/**
+/*
  * Output ranges corresponding to bits [3:0] from DAC_CONFIG register
  * 0000: 0 V to 5 V voltage range
  * 0001: 0 V to 10 V voltage range
-- 
2.25.1

