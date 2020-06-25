Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2991EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2BC820773
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L3gPi0V6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390341AbgFYGrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 02:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390111AbgFYGq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 02:46:26 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DD6C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:46:26 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g18so4626491wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gpZUopdNGKoMuokzA38cWTWHt4qMbyx0+mhPHuM+Znc=;
        b=L3gPi0V6eWwUbjc0a7NWVYNxvmyjxoCjIHRVwhhbx3/PgBUBX1nYVYjjVo442aXOq1
         6X+Rxq4jGsIwLTCBZApP2Rl/SureSgHXIaYxg9LovDj+bhfSXt3hSv90MX1xjfcHLEbP
         pizWIa2VTBVMWI6eNMnPoO4qath3LnLnEPgrrJ4dAIBvozmxRyuEBNn35Sv9RQVY/0Lg
         hVqcXYlSA2h6mWAEMsGoEiG/cyjNbXgHy0dMkxXGJQjFqwHHP6PZSwCZU5izFBVnfokC
         WU1eXhZiZYr6t2/pu9Ce3tAAE6tpfZME71ChHW0a72v/TfEzY4id8vKP2OrKnEGANJQQ
         3D8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gpZUopdNGKoMuokzA38cWTWHt4qMbyx0+mhPHuM+Znc=;
        b=o5yv8Nouy9xCUdsGk+cLvEo8Xz/mJYDcsy2ZYk4acJiXkB7eHwW4e5yYYM4IO8TtLb
         fjbQoJVxHcpccTaShFr7aTNPekFFOI3v2gn1jMu8NKs9pPwdDGB7ORdOJcQCTwxDlYI0
         sXZpTBBhztB2McGBDjmwcN375aNA0Ul9FjCtz1GpFoZ3P3bNQTNllFgBDheJ8AE2iReX
         RGHsSR5RX3lH1AkVIZoQ301AQJBa/y3jbA5uD8jrpDMw+0CBV4NXTBmlQE1N4I50UU2Z
         b0xn3NDikAUcoMauX42LAKRQonB1L8BOV+a7zjTvtxVOwUdQGLLNhkZpguMm2SyX2TWC
         A2vQ==
X-Gm-Message-State: AOAM5313rJaUxUaFCCIMx9uRF3RZw4ObDbeRC4QqxEvdUOLW7rt2F3L8
        qMbcu84qkIrbuXFNFaZOjSLvCQ==
X-Google-Smtp-Source: ABdhPJzMnG23PTfD5iHcY4F5ksyIND4PVZ3+d2rvuDhBikSUcprsL4BwlP+KBch0OuudWQn4B9nZfA==
X-Received: by 2002:a5d:62cd:: with SMTP id o13mr23631593wrv.272.1593067584905;
        Wed, 24 Jun 2020 23:46:24 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id c20sm27235363wrb.65.2020.06.24.23.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 23:46:24 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 02/10] mfd: mfd-core: Complete kerneldoc header for devm_mfd_add_devices()
Date:   Thu, 25 Jun 2020 07:46:11 +0100
Message-Id: <20200625064619.2775707-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625064619.2775707-1-lee.jones@linaro.org>
References: <20200625064619.2775707-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each function parameter should be documented in kerneldoc format.

Squashes the following W=1 warnings:

 drivers/mfd/mfd-core.c:326: warning: Function parameter or member 'dev' not described in 'devm_mfd_add_devices'
 drivers/mfd/mfd-core.c:326: warning: Function parameter or member 'id' not described in 'devm_mfd_add_devices'
 drivers/mfd/mfd-core.c:326: warning: Function parameter or member 'cells' not described in 'devm_mfd_add_devices'
 drivers/mfd/mfd-core.c:326: warning: Function parameter or member 'n_devs' not described in 'devm_mfd_add_devices'
 drivers/mfd/mfd-core.c:326: warning: Function parameter or member 'mem_base' not described in 'devm_mfd_add_devices'
 drivers/mfd/mfd-core.c:326: warning: Function parameter or member 'irq_base' not described in 'devm_mfd_add_devices'
 drivers/mfd/mfd-core.c:326: warning: Function parameter or member 'domain' not described in 'devm_mfd_add_devices'

Cc: <stable@vger.kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mfd-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index f5a73af60dd40..720e5c8b1588c 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -318,6 +318,16 @@ static void devm_mfd_dev_release(struct device *dev, void *res)
  * Returns 0 on success or an appropriate negative error number on failure.
  * All child-devices of the MFD will automatically be removed when it gets
  * unbinded.
+ *
+ * @dev:	Pointer to parent device.
+ * @id:		Can be PLATFORM_DEVID_AUTO to let the Platform API take care
+ *		of device numbering, or will be added to a device's cell_id.
+ * @cells:	Array of (struct mfd_cell)s describing child devices.
+ * @n_devs:	Number of child devices to register.
+ * @mem_base:	Parent register range resource for child devices.
+ * @irq_base:	Base of the range of virtual interrupt numbers allocated for
+ *		this MFD device. Unused if @domain is specified.
+ * @domain:	Interrupt domain to create mappings for hardware interrupts.
  */
 int devm_mfd_add_devices(struct device *dev, int id,
 			 const struct mfd_cell *cells, int n_devs,
-- 
2.25.1

