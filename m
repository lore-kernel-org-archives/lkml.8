Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65683C43459
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C9AF2074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PKIGtM3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgGQQ54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgGQQ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:56:06 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B09C0619D5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:06 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f2so11872363wrp.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nb/tQ5HxMJdwcZU2zmj2JX73dDo4qPaNgdilk8WGn+Q=;
        b=PKIGtM3D2mbpyKmn3TKhhnoylY/9SJkUrY4ltLFIvfTnvtK22ZcRqj+nCxV7ManVNH
         PM6fCgKXbO3du9XZekl35+F/HNFxILIuNr89nGvO8ZykWn3ZxeCXbyz16VaOu4wO2s0A
         Q9DcmJ2djcG9N6cZJyM9u6x9govSwTDegiSXdbmxvOQIY1Z878AgbNMG0RuKNv+rnemV
         EzgMJbROJp64FD8fLqBQ5/x6fMR5DUBqrLlF4wjYn+UEH7VnSn6FdaexPbS8sXcwCEOv
         E0U3cqvHiAiXh07wKOKILeRvzBXnnw1GarLo4j//BBH50lLMEkNNCJKmnH4XQX149h+t
         Qyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nb/tQ5HxMJdwcZU2zmj2JX73dDo4qPaNgdilk8WGn+Q=;
        b=ebySEhHpo1szE4cJr3siJyPmBonK0Rnp2IxHPfoFz9ezTX5L2UBlRMIWiJzThGTSdB
         SGEqTK1Rt6OGLGpybe69moFXt/FJL+EtdSFULbYFYaWG+iLuTw4V9KnlZrluu4jbIUKr
         nPepeVZ0E75Zd7Ihy5RUe2Hwbs333UzEpxwUUoF1A54P53h58DhxHbsQzvK91Kk2CWvs
         LwM6P7wymoDtDp5mgMSYf6+DIYWuuNS6aqE6F4n3HuMTGPRjR9pLI7T7BaZI/HS097ih
         xNj0zcRttIsui/4XTyVmOv5KpSebMBjSANn6oVVTJ4TXbhBVVO97zuWIMa9UR5ZtBQX8
         cOvQ==
X-Gm-Message-State: AOAM530Hcr6m4DnGsrW+ePKOtCwOZZ16iSO1VZ3siAAjbHaIe0JIRjew
        uc5Z4GMO5bJGHIUKF3fESMieSA==
X-Google-Smtp-Source: ABdhPJztkgQ/mGf0gxIVfj/VajfXJbHIhm8tYxqIPUW3TqJw+AzgcxbVjtmnL0yYGvZxxCqshqRMsg==
X-Received: by 2002:a5d:6452:: with SMTP id d18mr11020033wrw.284.1595004965111;
        Fri, 17 Jul 2020 09:56:05 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:04 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Silvan Murer <silvan.murer@gmail.com>,
        Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
Subject: [PATCH 06/30] iio: dac: ltc2632: Fix formatting in kerneldoc struct header
Date:   Fri, 17 Jul 2020 17:55:14 +0100
Message-Id: <20200717165538.3275050-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects attributes/parameters to be in '@*.: ' format.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/dac/ltc2632.c:50: warning: Function parameter or member 'powerdown_cache_mask' not described in 'ltc2632_state'
 drivers/iio/dac/ltc2632.c:50: warning: Function parameter or member 'vref_mv' not described in 'ltc2632_state'
 drivers/iio/dac/ltc2632.c:50: warning: Function parameter or member 'vref_reg' not described in 'ltc2632_state'

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Silvan Murer <silvan.murer@gmail.com>
Cc: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dac/ltc2632.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index f891311f05cfe..733f13d3e5df4 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -38,9 +38,9 @@ struct ltc2632_chip_info {
 /**
  * struct ltc2632_state - driver instance specific data
  * @spi_dev:			pointer to the spi_device struct
- * @powerdown_cache_mask	used to show current channel powerdown state
- * @vref_mv			used reference voltage (internal or external)
- * @vref_reg		regulator for the reference voltage
+ * @powerdown_cache_mask:	used to show current channel powerdown state
+ * @vref_mv:			used reference voltage (internal or external)
+ * @vref_reg:		regulator for the reference voltage
  */
 struct ltc2632_state {
 	struct spi_device *spi_dev;
-- 
2.25.1

