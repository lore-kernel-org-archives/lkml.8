Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE99C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE94206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yR7EVA/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388467AbgF2VSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729787AbgF2Swt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:49 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9047C02E2D0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:04:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so16655456wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1S50qko1q+z74H3H0J6W5HtpHbtK1gQwgwBXn9Rlvzc=;
        b=yR7EVA/JfMBOI9U5dnD0dsDVA/IHZqoG8OX+LKynRnDtfmxafybx4Z1ZVUsa0221gw
         xWauzNcM5+cKRdOuF6YTMKPahxAdgN3yCtQ2Uowy2mLLdVxBF0BHoY3LFCD+i00XyFrc
         PkkbwMlKAoH7XAYVQW3PZUvDJdSGvHGDQaUTjVJSTqDj48v/pB2GyvTgRn39wWvEtgZ3
         UfIywRtxHwUjIlNYJ8MwtNNzp+LIKvWmUnesoPvAkV8vDuM3NaVZPWOM4bAVYxOfrwaQ
         Y8/dgvQKIAtTIPTBVuNfuPVJlfZn65WKu1hoX4o20Zi8VRS2aouROf1cs84TMYqlaoM2
         95Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1S50qko1q+z74H3H0J6W5HtpHbtK1gQwgwBXn9Rlvzc=;
        b=WQRgwpsEpAsPwg5Y/FTA0fYoLjBhysNMM3aOSe0ds0E1h+ThV4j2ysTLzmdy3swcLP
         Fq5RgdZzwExHMy355W0ruOF1xf+EwSHUZ+PAjcZLsekHViZwuXd4OUO2hurvYvoUtmnU
         FW/ST2Fj79YLVATvGpfsjnx4gAmu96WdfJkPJaIfyIY4+Ao1a0/OOS5cKXn4vy/9asSz
         ssX3X7srNqnYvfvc/e3Lqeui352A/E9UmvK3HhZKOCOZfHlxJb7muGRTFHKM83wPnHLy
         wqImiOAGkJ4EAp4Y8tJhnE+sPqI66HrpIz9zH23QaC+apAyJDTI99eI8a7HBZl++KfMn
         lTmg==
X-Gm-Message-State: AOAM531zO/1F0yVwJoOV4yzmyPcstIyotXLRyapnvpwja6i1deHE+6XS
        JKOoC6zK/LIebMzxIsXcaSWEqQ==
X-Google-Smtp-Source: ABdhPJw7u+pR3PUUjovhGP29vg+5MVuG3YO6weDsgP3XkESH2uz5kK5iz1fARHNMR2qAFPReAFxLOQ==
X-Received: by 2002:adf:e901:: with SMTP id f1mr17201511wrm.80.1593439495667;
        Mon, 29 Jun 2020 07:04:55 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p14sm15394928wrj.14.2020.06.29.07.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:04:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 08/20] misc: habanalabs: goya: goya_coresight: Remove set but unused variable 'val'
Date:   Mon, 29 Jun 2020 15:04:30 +0100
Message-Id: <20200629140442.1043957-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629140442.1043957-1-lee.jones@linaro.org>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt to check the return value of RREG32() has been made
since the call was introduced a year ago.

Fixes W=1 kernel build warning:

 drivers/misc/habanalabs/goya/goya_coresight.c: In function ‘goya_debug_coresight’:
 drivers/misc/habanalabs/goya/goya_coresight.c:643:6: warning: variable ‘val’ set but not used [-Wunused-but-set-variable]
 643 | u32 val;
 | ^~~

Cc: Oded Gabbay <oded.gabbay@gmail.com>
Cc: Tomer Tayar <ttayar@habana.ai>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/habanalabs/goya/goya_coresight.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya_coresight.c b/drivers/misc/habanalabs/goya/goya_coresight.c
index 1258724ea5106..aa51fc71f0a1f 100644
--- a/drivers/misc/habanalabs/goya/goya_coresight.c
+++ b/drivers/misc/habanalabs/goya/goya_coresight.c
@@ -640,7 +640,6 @@ static int goya_config_spmu(struct hl_device *hdev,
 int goya_debug_coresight(struct hl_device *hdev, void *data)
 {
 	struct hl_debug_params *params = data;
-	u32 val;
 	int rc = 0;
 
 	switch (params->op) {
@@ -672,7 +671,7 @@ int goya_debug_coresight(struct hl_device *hdev, void *data)
 	}
 
 	/* Perform read from the device to flush all configuration */
-	val = RREG32(mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG);
+	RREG32(mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG);
 
 	return rc;
 }
-- 
2.25.1

