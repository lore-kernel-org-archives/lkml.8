Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3D8C43446
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED9562082F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sPXdRyUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgGPOAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbgGPN77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:59:59 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF72C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:59 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a6so7195914wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fxti/ROfl2G3M6gtYz5bbB24uIJ/yIrzz6aDgoU+YhY=;
        b=sPXdRyUrAhHuTpuewy5VfCaU8QEjM1NaNAfcP84fpBcu50J3lpb1HY52y8zutzFjFN
         YmTSRpW8jZX5AGVMjqgoEerb2+UU3NqVNXsAsjWipg2eVPj+HGNB1gHrBV4Ec0zkHEIr
         Ak7tX6sy9RzXsd9VjDh+j+5xKbEU59b6nwSPNF4E44nUFe+voE+UfA0Vkn/sdH4XUfta
         N8I0u5FcCE9ARjwwDsGwhdrNgdnXKrhIfxyff6Wu/wv9WqOsfspMeko4vS3BXmUCCMkc
         +V/AWxJ7GsxvErjrTV0s8qlTXYu1ocvWMkvzUzOO3QRbTECQyOc3eizmnKqLv7m1eiBh
         zprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fxti/ROfl2G3M6gtYz5bbB24uIJ/yIrzz6aDgoU+YhY=;
        b=mgRV+v3fNd4gnrz3IroXwts7bA2O+GE5fVRqJ0g9V1acN/ps6DuEZ+SE1YdAacOilK
         WGn47MjaPYKeXJ7UAZaDJKRYCoaqSMdt+KCr7vk/VbSEX23Z0vS/abpuE2j4lTpsulY/
         mqmIJ2HrcHaNXsVsdfQQGbSnLrZTrFe3K/NXiKqjx/YI9+1ikCBC1oHvks98g9BYpmFC
         +ZrT6E6NdMigj4+jTQzLnrA9MtMQPRR/TdnVYvasmSEh2eaQIMKuvicn8PzpitHBSspI
         gIBWSxVPnmiMTkhuqP7wvxinpge5ZeqrUpj2yXCx+tMTAen9qcRbiz2eyUWNAWQKhqN2
         IrVA==
X-Gm-Message-State: AOAM5327B5MdcbynWtvg7Vnl5VC+aXzrVN9k2PSHHAaN13haPDkeYIjX
        gbWpxc/JCGzuio//BdNNyocpstOES40=
X-Google-Smtp-Source: ABdhPJzM/jUx9vNqBhmh4/2ZUSjp3tre1unOwqfSVQ5aaqX4Xt96FB0tgeJaU8jAp7Fs4XGKDQQLWw==
X-Received: by 2002:adf:f452:: with SMTP id f18mr5192867wrp.78.1594907998275;
        Thu, 16 Jul 2020 06:59:58 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 21/30] iio: dac: ad5449: Fix kerneldoc attribute formatting for 'lock'
Date:   Thu, 16 Jul 2020 14:59:19 +0100
Message-Id: <20200716135928.1456727-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects attributes/parameters to be in '@*.: ' format.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/dac/ad5449.c:75: warning: Function parameter or member 'lock' not described in 'ad5449'

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dac/ad5449.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5449.c b/drivers/iio/dac/ad5449.c
index d739b10e52362..e9530835479af 100644
--- a/drivers/iio/dac/ad5449.c
+++ b/drivers/iio/dac/ad5449.c
@@ -56,7 +56,7 @@ struct ad5449_chip_info {
  * @has_sdo:		whether the SDO line is connected
  * @dac_cache:		Cache for the DAC values
  * @data:		spi transfer buffers
- * @lock		lock to protect the data buffer during SPI ops
+ * @lock:		lock to protect the data buffer during SPI ops
  */
 struct ad5449 {
 	struct spi_device		*spi;
-- 
2.25.1

