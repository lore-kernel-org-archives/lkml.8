Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F3AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E9C6206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rViawsa3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgGPOAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729205AbgGPOAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:00:03 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337EAC08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:00:03 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so11699712wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pKASaRWXf6Jrobw8UPiL6AmNdIp32mR3nx4dwq7oKAc=;
        b=rViawsa3WdUpkRJOtl0hbcb351+pPz2u3LYDiLi2tj2Ho8sFnTR0UeVIzIlT4WNSe0
         aWrCkXQTRZuZV62OU0aKoery/BgPcT9Cncw7J80KMSq1DT4pYfbguTpS20woVdRkCD7D
         LfLqYlW1iQt5zc8KOxLJksfLxvlWEH8dZyROEPD2GTgtGFUDbYEELOkcbsrRm1kGDcjn
         xZXAB+bzOKURjqKnKOxTlouXKBGDpyFlNoTtjtzsp3P+VW0y5iqv1PRaCNazUW9qcDjs
         kHKBeqZrBSSh5KF5NhI/pPFsyx5Q+cTaEC/PXB43aKMHlBq5ZtxJON+AIcuZNNtIpiYq
         hhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pKASaRWXf6Jrobw8UPiL6AmNdIp32mR3nx4dwq7oKAc=;
        b=s4nc4ZUtdFNuJs5xO2zMAy543+XfCkD7y15gJzaVRhIziEKa5CFYemBIIF6Wvp7Y85
         GRTEALxr5wTMfjXULA3VPXPbCLRoeAESrSGjLQEmYmSNcfe/Y1EyEmHEWsy2PCWhxqSc
         Bcfg5X5D2pEd+JwhwYRhOlNSwi7hD2yNyTOIELIhgd3InTby+FefwwWLEbJzFdrQpbTG
         NYG2IXGhItZCn+tDhsDUMmuOIrYwQ/OgOh6RFOwrxW5t4R4DR0+XcL3y7V5OGof7PGJM
         NFQdECaX63Go4cIEZA7/oPRp7aXqX2AQMYdYDIex/Ot7eXuQHOBt5tsKgEsxZ9hfcQ3U
         U41A==
X-Gm-Message-State: AOAM530+lCjrQtEu53EUkrtqJzS64fyWWQYRpemgE+/CJ3ebsj8vQErj
        80lLKPFrDtXroqtpuVDJkVL2sw==
X-Google-Smtp-Source: ABdhPJxpaB51Ov3WuPfHAs0mfsQamBGiC60+2uEATqjVFq6kqZxUaJ+4h6Ae7gACMzlfdCrLLD6BHg==
X-Received: by 2002:a1c:2905:: with SMTP id p5mr4712437wmp.91.1594908001865;
        Thu, 16 Jul 2020 07:00:01 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.07.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 07:00:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Ricardo Ribalda <ribalda@kernel.org>
Subject: [PATCH 24/30] iio: dac: ad5761: Fix kerneldoc attribute formatting for 'lock'
Date:   Thu, 16 Jul 2020 14:59:22 +0100
Message-Id: <20200716135928.1456727-25-lee.jones@linaro.org>
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

 drivers/iio/dac/ad5761.c:80: warning: Function parameter or member 'lock' not described in 'ad5761_state'

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Ricardo Ribalda <ribalda@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dac/ad5761.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5761.c b/drivers/iio/dac/ad5761.c
index 67c4fa75c6f13..1d9d0e22d6f44 100644
--- a/drivers/iio/dac/ad5761.c
+++ b/drivers/iio/dac/ad5761.c
@@ -57,7 +57,7 @@ enum ad5761_supported_device_ids {
  * @use_intref:		true when the internal voltage reference is used
  * @vref:		actual voltage reference in mVolts
  * @range:		output range mode used
- * @lock		lock to protect the data buffer during SPI ops
+ * @lock:		lock to protect the data buffer during SPI ops
  * @data:		cache aligned spi buffer
  */
 struct ad5761_state {
-- 
2.25.1

