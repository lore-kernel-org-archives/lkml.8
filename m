Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DF5C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EBD02076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S35aXFZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgDQRJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbgDQRJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:09:18 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C8DC061A0C;
        Fri, 17 Apr 2020 10:09:17 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g13so1864558wrb.8;
        Fri, 17 Apr 2020 10:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=57+jtCNNE2Zl02cp6sMoaQUmuTPWgMNTCWO5br3qpgY=;
        b=S35aXFZt9eRVEiuuf2RwYaI1eNkNoCtN91BA32YPyKFah3rLN5ED2sfULvCwfmJy2V
         UMmCLXHfqqW4SOFGSDdEiC13FM/MngyXb3hfZcj2GdTIh3CkUztCvJYdjUSSPg2eUBhO
         H3eldj4lDcJFwVcaxVSUrD7xlb3bdQppIch3xPMu/QyJ4Z+2H2WwYO2kMQ9SEYU8uiy3
         c5I0FvRL/2BH1gmtyfQeD397IWRKvc6rKHAL6RGDga1WkGsUOJwJC4GsiwCjZ241H09y
         zC8Pjce289P5u0M9y9QAKPwPJr2tELKPI9DQfsIG/owniy+lgj6gRsqdVhDmYSA+IwgV
         jarg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=57+jtCNNE2Zl02cp6sMoaQUmuTPWgMNTCWO5br3qpgY=;
        b=GpBta5GpovBYDUODrZWk3WNcFAHilute7Gu7ZdKmm+rNkpSHAsYUF5splWrQpiCusM
         JrAJO0cxFTWI9wl/lf4qEfYmbcg7nP2fAZCPD5+GXAbRxmqUesMUaONeWMQ43ZVPQyDF
         AYURvYSILFDseTDFNLuTkGu1S1siOh5PeNk3je4QGKMxZG8CU4EVq2fixwUEf0Ymkzq2
         bQc6Ec1X3S6khRaFssRZdOLxoS8HllmdBjSbfcCzTH9vhKO2G206nMgTNWCtBkVRJuLh
         LVl0mYks4IKq1YqJLIbEBumn4FV8B/KaMj2SsXLVjLxkBnU7mReiplx0RA0DYnieb0Nr
         Ihbw==
X-Gm-Message-State: AGi0Pub4zDzZsc+bdAJq5Rja1WtH9xYF1RSAAroU8Gd9KU7cyMq0wyv6
        h2LbD7+1BxiDphGr88mKIgU=
X-Google-Smtp-Source: APiQypKFvh513XCTlwTK5AFfQS5m6Z2hLgSWcDw5MCE36/8oXLA9wV6bh7jo/NLzoAjEUxbBcp9qDQ==
X-Received: by 2002:adf:f450:: with SMTP id f16mr4952639wrp.346.1587143356035;
        Fri, 17 Apr 2020 10:09:16 -0700 (PDT)
Received: from localhost (pD9E51D62.dip0.t-ipconnect.de. [217.229.29.98])
        by smtp.gmail.com with ESMTPSA id f8sm10082727wrm.14.2020.04.17.10.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 10:09:14 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: max77620: Use single-byte writes on MAX77620
Date:   Fri, 17 Apr 2020 19:09:13 +0200
Message-Id: <20200417170913.2552327-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The MAX77620 doesn't support bulk writes, so make sure the regmap code
breaks bulk writes into multiple single-byte writes.

Note that this is mostly cosmetic because currently only the RTC sub-
driver uses bulk writes and the RTC driver ends up using a different
regmap on the MAX77620 anyway. However, it seems like a good idea to
make this change now in order to avoid running into issues if bulk
writes are ever used by other sub-drivers sometime down the road.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mfd/max77620.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index c7ed5c353553..fec2096474ad 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -177,6 +177,7 @@ static const struct regmap_config max77620_regmap_config = {
 	.rd_table = &max77620_readable_table,
 	.wr_table = &max77620_writable_table,
 	.volatile_table = &max77620_volatile_table,
+	.use_single_write = true,
 };
 
 static const struct regmap_config max20024_regmap_config = {
-- 
2.24.1

