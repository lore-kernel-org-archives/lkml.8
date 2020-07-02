Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7429BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D845206E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yIWlMjN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbgGBOtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729960AbgGBOqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:46:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D236C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:46:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so28744784wrw.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RqM0ErMZXJazCr0lwXFE+4OfLlFHvj7Gkhb7UJelW6s=;
        b=yIWlMjN0w19WzloUJb27YHxd5Lv2apKTHNCXpZAD+f82IlZ3PHXnJHPuKhqY0rS81s
         QhZs+X6iPjFvByqqq7pbk0L53rMGDtKW5FxzOziYz6xeaR8f5G/QXdzGL/5bqnDtJiPL
         sNH3X1dLCSubDr7yM/FA9k24CATuCeAh/iLiL1cX5ux7S1E0GMK8QS8Bt+apIPUWr5vd
         SZ57qUbVbp6Y3pFbnr8TEYhdSOdESv+8q7JOp726Q0hQtCOeKBHPSPTEt5Msd4ErPqsN
         BjNbMI2tqHASmGNzXbMyPz2SSAoKQWZklBkBhEeDGBIYuaaXABebQIPiWIan83aqDdb/
         Ufrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RqM0ErMZXJazCr0lwXFE+4OfLlFHvj7Gkhb7UJelW6s=;
        b=YixzLaI2831+kmUiBu/35GoXcuXP/hxYuFWeFBVM+dmqAvNkYC+Z65V58XLOFykbzZ
         8+LPqW/TwCaloERK3aLZ0TX2CvIdun6WEXrR7wAoGR4jq+NM9schmG43X3ThyaZ0U1yw
         y8JquL6F0zsaJ8PgySCMZCqG56XBLcpZXCG+tQFScLGkIEx46+WvY2TRnEDS0U/mfEgT
         ToX2ZdAhGa1XNaH+x9yISxShy1I1i18HnURdeQ48sF9FEzES93ZRXJOUPb01MYgxlPuP
         MkmM1/5CK4vjNFBYNGUHVnkGC7hxEQUkfWA9Z7Dex2DfOvgwdfRtkdrNzpkS9T0/1638
         8Jyw==
X-Gm-Message-State: AOAM531SfG44hkCQyluUzeYZ5ouGhhB22gzotQ2G6tJpZGapcU+GEa5y
        LiJFVAeDAWOmjnCzDifhYzMSOg==
X-Google-Smtp-Source: ABdhPJyIZmpTdu7PTQVZc5pYnov4rLotdR3wYot7zbkIhZfmSkLmkMIl/bLtH204G49vYqtuSIyZ/A==
X-Received: by 2002:a5d:44c7:: with SMTP id z7mr34212570wrr.226.1593701201196;
        Thu, 02 Jul 2020 07:46:41 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id g14sm7002737wrw.83.2020.07.02.07.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:46:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 07/30] usb: common: ulpi: Fix a few kerneldoc related issues
Date:   Thu,  2 Jul 2020 15:46:02 +0100
Message-Id: <20200702144625.2533530-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702144625.2533530-1-lee.jones@linaro.org>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, demote function header to standard comment block as
they are not suitable for kerneldoc.  Then provide description
for ulpi_register_driver()'s argument 'module'.  Finally rename
description for ulpi_unregister_interface()'s 'ulpi' arg.

Fixes the following W=1 warnings:

 drivers/usb/common/ulpi.c:23: warning: Function parameter or member 'ulpi' not described in 'ulpi_read'
 drivers/usb/common/ulpi.c:23: warning: Function parameter or member 'addr' not described in 'ulpi_read'
 drivers/usb/common/ulpi.c:150: warning: Function parameter or member 'module' not described in '__ulpi_register_driver'
 drivers/usb/common/ulpi.c:299: warning: Function parameter or member 'ulpi' not described in 'ulpi_unregister_interface'
 drivers/usb/common/ulpi.c:299: warning: Excess function parameter 'intrf' description in 'ulpi_unregister_interface'

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/common/ulpi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index 9a2ab6751a23c..a18d7c4222ddf 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * ulpi.c - USB ULPI PHY bus
  *
  * Copyright (C) 2015 Intel Corporation
@@ -143,6 +143,7 @@ static const struct device_type ulpi_dev_type = {
 /**
  * ulpi_register_driver - register a driver with the ULPI bus
  * @drv: driver being registered
+ * @module: ends up being THIS_MODULE
  *
  * Registers a driver with the ULPI bus.
  */
@@ -290,7 +291,7 @@ EXPORT_SYMBOL_GPL(ulpi_register_interface);
 
 /**
  * ulpi_unregister_interface - unregister ULPI interface
- * @intrf: struct ulpi_interface
+ * @ulpi: struct ulpi_interface
  *
  * Unregisters a ULPI device and it's interface that was created with
  * ulpi_create_interface().
-- 
2.25.1

