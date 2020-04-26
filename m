Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70610C55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5536D206A2
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J6yKsPTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgDZS6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726230AbgDZS6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:58:12 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C44C061A10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 11:58:11 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t11so7545676pgg.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 11:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=78YVO845GHtM9k/EV5ps+BQFILd3wygw5mUyH2gxrzc=;
        b=J6yKsPTdcbwo6aeshqFM2fAYsDMjgIQoQY8MwtukCyc4TyT2VnzLqAzlU/0CsbKoW0
         jtWf8aRzBoPBaJZJBm1Lg+ZwGPOLaTZucHMHdK9h0RYCvOGpspXp0ASBXuEkVePJptFa
         iDwfjCbDMnNVvSzMf9JR3S9E1iv5lWAGje84A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=78YVO845GHtM9k/EV5ps+BQFILd3wygw5mUyH2gxrzc=;
        b=NAlSFI+4XmvlbnP6rxmoxp/Rv2VIzFESwL9HpU9qg4lkDrDdX5maTUBesE/9jGFPYd
         7Ytv7pP4gUZXLTyXnOdNoGjiKHY6QqnYZnqctRh2zwoDG66jai/bXTHqnRjexYoEP+hl
         Y5PoMYnwH/KwoybNEkrUzcAL8cLFEQj9XGx5ngOShRTNDiBRkQs4E68UzYO5/WShSvn0
         MjCH9gUvQxJIzZo7a5cL/Bq+ttsIB7dfnZ/vHhrh4jgkBgP1P6B3KBs+vUuhfik8BfFN
         J9JDgbBMVlE1/SkNPAfSzok6eUU0haVmFdvxEqUJiZnWOMajoaiW5+cQ238c2Whr329j
         ePqQ==
X-Gm-Message-State: AGi0Pub8jtbo5tzkDyOegB5vAW522wwQ8CZYtXNUChrWjk/uadwKsUkw
        8pHy8mwghKpBN9/RPhmP3KU5HA==
X-Google-Smtp-Source: APiQypLIflSfGaQ/fc5lB1P41nB7JmBS+mGiXUpgYwets4rk7M766rmw/tGYvSbMSRiW/JEWTQ+P2w==
X-Received: by 2002:a63:cf10:: with SMTP id j16mr19176908pgg.201.1587927491023;
        Sun, 26 Apr 2020 11:58:11 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h27sm9425153pgb.90.2020.04.26.11.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 11:58:10 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH 5/5] coresight: Avoid casting void pointers
Date:   Sun, 26 Apr 2020 11:58:05 -0700
Message-Id: <20200426185805.14923-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200426185805.14923-1-swboyd@chromium.org>
References: <20200426185805.14923-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to cast void pointers, such as the amba_id data. Assign to
a local variable to make the code prettier and also return NULL instead
of 0 to make sparse happy.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/hwtracing/coresight/coresight-priv.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 890f9a5c97c6..09ca9d824cee 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -206,9 +206,12 @@ cti_remove_assoc_from_csdev(struct coresight_device *csdev) {}
 /* extract the data value from a UCI structure given amba_id pointer. */
 static inline void *coresight_get_uci_data(const struct amba_id *id)
 {
-	if (id->data)
-		return ((struct amba_cs_uci_id *)(id->data))->data;
-	return 0;
+	struct amba_cs_uci_id *uci_id = id->data;
+
+	if (uci_id)
+		return id->data;
+
+	return NULL;
 }
 
 void coresight_release_platform_data(struct coresight_platform_data *pdata);
-- 
Sent by a computer, using git, on the internet

