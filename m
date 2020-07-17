Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E317C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69BF420737
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gax7Woqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgGQQ5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbgGQQ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:56:22 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50510C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:22 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z2so11927826wrp.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rHQ/jO1LhjZqNtelCIEh1tkpMHr7F5JhR3YsKGdMJak=;
        b=gax7WoquXCNWbtQ32PKWdu+p6CINIYPJ64653qBVA7k6sICf8rlMQTpk2nd/sPyRKW
         LzPBfRVamHkdO/sf1vEGjrOjSxv++JfIprn9Igv21SDOyw2b73cXNm/p13aUAO4bPVeG
         WIT5jOcosEKJUAYL0iK5CZDiwYlIKtNdEhpYpzmJXMMaybPSuowQUpX1UDiOOU0fVhXZ
         T0L2WJ7tvFvMmBIaiRVmwnMn2Zq7b7PNO6Ho3bca5LjWdsG0ksj+Wal/Mcu7eJyB4RsF
         6sPolkV1LjvVteKTcBo+aU3tvd18BW7yUcfWp8dJDRcQDrBMvIJnSS6v4mihpd5MjcZI
         cpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rHQ/jO1LhjZqNtelCIEh1tkpMHr7F5JhR3YsKGdMJak=;
        b=l9rzHw6OuzjXic9VCwR+HHrWf1dh9Y/iN2EolPGDi7gQ7g/7fpi3ONAl/8b9vRbGDp
         7kc+UQ/WOCMiDogzUn8TxGAQCbcYko8rdZd5ny+UH1q1yuP6XcbCr3z/2qJRis84rxdc
         Tjq6jT28c7Vz6LdkgVgDfHNyWtM/wUO+X+jMVpm2PoBxvo/V3uEtki4nUq1ch1vG/fI7
         u7j0Tu3qbGLoN+u31QwVSB1iGEvjMDSIPlX8kZwiRoft5n1CxAUIBfNo3jAWkibFmfnk
         uNjT6PlTd5pWqGVoH42PnG/O/J6IC1T6PqP4FvjGOY1nXB7+hNGfbaMJis+tu7bZfQP+
         uBPg==
X-Gm-Message-State: AOAM5325eT8tnHFd9B6e/1jUcPK2UweoCCS+KwX/i+D4/wv4KoasroHx
        g//1eZdxLpfQQjCpG/k5EEp4BA==
X-Google-Smtp-Source: ABdhPJwoHoY99/X6VnON+9Fq/TFQG3iB3igVuAL6ttNu5GBSpTuN7C9MiiUk2XrtnDU7l2HXLI8KqQ==
X-Received: by 2002:adf:efca:: with SMTP id i10mr3678182wrp.278.1595004981099;
        Fri, 17 Jul 2020 09:56:21 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:20 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rohit Sarkar <rohitsarkar5398@gmail.com>
Subject: [PATCH 20/30] iio: adc: max1363: Fix kerneldoc attribute formatting for 'lock'
Date:   Fri, 17 Jul 2020 17:55:28 +0100
Message-Id: <20200717165538.3275050-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects attributes/parameters to be in '@*.: ' format.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/max1363.c:190: warning: Function parameter or member 'lock' not described in 'max1363_state'

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Rohit Sarkar <rohitsarkar5398@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/max1363.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 9d92017c79b2d..0fe348a47fe01 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -150,7 +150,7 @@ struct max1363_chip_info {
  * @current_mode:	the scan mode of this chip
  * @requestedmask:	a valid requested set of channels
  * @reg:		supply regulator
- * @lock		lock to ensure state is consistent
+ * @lock:		lock to ensure state is consistent
  * @monitor_on:		whether monitor mode is enabled
  * @monitor_speed:	parameter corresponding to device monitor speed setting
  * @mask_high:		bitmask for enabled high thresholds
-- 
2.25.1

