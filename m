Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681DFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 19:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44AFB20656
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 19:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f+qaMkkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbgFJTyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 15:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730388AbgFJTxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 15:53:54 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2647DC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 12:53:54 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id x18so3219914ilp.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 12:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qFk1tcTUGEhxvyWsBEGOYLJYcEuf08mLBBeRJsLstbs=;
        b=f+qaMkkgTmEpLeYukJk2jIqUGUwMptIghPDgNeMi79EFCqrEzc7UWd8+rmILNyb2lu
         VpTRXZh7ruwCrvKbtyay4pCk33wMEKqSw7wX2pzq6D8ociuUxJE22S+jvMWTQE8sfwOj
         Q0CsjZT7NFAXIEjZpo0ofsrIJGVdywbr/R3XPvCMWOAKFxBLJdDA5f0qw2Q3sxPjBFUG
         ffu6C7l+z2e/H2q9a2AqhHYLFU/joTUqWu1sLoxuTh9FIRtJ8ijhFXtWE4iFykUiMqCx
         neBMWMXX2tV7RILU8ZdZlAF7zRr1kSe3n9tb6eWJ0TKQBqc65FVw2YexHWWd59hJMKeY
         fJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qFk1tcTUGEhxvyWsBEGOYLJYcEuf08mLBBeRJsLstbs=;
        b=cfShL+wDpWFGf64C5X5DJdbI8YBWgfFCE9X42KTKX0dwuP45GGKRlY78N5OAKX6MFo
         p7PnLOj/QBk2WInjyCzknrB4Lh6nnFL+1GzdCmUVpP4xdZ6pe5VLd7xUysiRbgzRoI66
         2SaHFULtyI8cULN7mDAa6VZLDW0ODzeGE376fvXvnnafq22xZljJxNtfxj7sTldh4uAd
         or/J7DPRLZoJ48N+u6Ne5y1EgkmiNmL0nUZ+iwHkzC8bob3KA8aUxKty/aFL8OoZc4tF
         oPv9EvhUhL2IMLy+RdC2y1v+p4u6n6sXaSYshbpjuIrcISvAO4b8cJunSSdLwNdLoHLE
         7yrQ==
X-Gm-Message-State: AOAM533V9mUxS3n9lrVhZP6BLaWUP+DMes1v0DSJeWuIh5EFX3B/oLiZ
        ZfgoCRWV2HlHqrKncZwefJtZjQ==
X-Google-Smtp-Source: ABdhPJz9FumHIqWEm3GPeCvyEPipjguCrq4qGyzZrr6nb9N6UQDwWumnMZqJeOecK9Z8k6KIddFbEQ==
X-Received: by 2002:a05:6e02:104b:: with SMTP id p11mr3524033ilj.26.1591818833544;
        Wed, 10 Jun 2020 12:53:53 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id r10sm408828ile.36.2020.06.10.12.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 12:53:53 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 5/5] net: ipa: warn if gsi_trans structure is too big
Date:   Wed, 10 Jun 2020 14:53:32 -0500
Message-Id: <20200610195332.2612233-6-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200610195332.2612233-1-elder@linaro.org>
References: <20200610195332.2612233-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the DEBUG_SPINLOCK and DEBUG_LOCK_ALLOC config options are
enabled, sizeof(raw_spinlock_t) grows considerably (from 4 bytes
to 56 bytes currently).  As a consequence the size of the gsi_trans
structure exceeds 128 bytes, and this triggers a BUILD_BUG_ON()
error.

These are useful configuration options to enable, so rather than
causing a build failure, just issue a warning message at run time
if the structure is larger than we'd prefer.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 76d5108b8403..94d9aa0e999b 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -669,9 +669,6 @@ static void ipa_validate_build(void)
 	 */
 	BUILD_BUG_ON(GSI_TLV_MAX > U8_MAX);
 
-	/* Exceeding 128 bytes makes the transaction pool *much* larger */
-	BUILD_BUG_ON(sizeof(struct gsi_trans) > 128);
-
 	/* This is used as a divisor */
 	BUILD_BUG_ON(!IPA_AGGR_GRANULARITY);
 #endif /* IPA_VALIDATE */
@@ -715,6 +712,10 @@ static int ipa_probe(struct platform_device *pdev)
 	int ret;
 
 	ipa_validate_build();
+	/* Exceeding 128 bytes makes the transaction pool *much* larger */
+	if (sizeof(struct gsi_trans) > 128)
+		dev_warn(dev, "WARNING: sizeof(struct gsi_trans) = %zu\n",
+			 sizeof(struct gsi_trans));
 
 	/* If we need Trust Zone, make sure it's available */
 	modem_init = of_property_read_bool(dev->of_node, "modem-init");
-- 
2.25.1

