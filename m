Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0ACC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 419A220B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="odBlKV08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgD1SKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgD1SKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:10:14 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D03C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 11:10:14 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id q124so605269pgq.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 11:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=feeBoZmiNK+PqfmUZIUHdcZ4oBKPOjHptWecqjvhfI4=;
        b=odBlKV081b57bKb3sexaYhZ/qqcstSbg/s2iZYJthN7dEiR/vQ+YpQrlo3lkUvQWy3
         MjiNjirFDo5mutK+0rE9HWjSjOD4HkEqLHDaGUt7AE2b3OBugG1Ww3EkGpdGis00LY6Q
         gjCU62klhAJN2mXBhEgl2s/FwKD1XU8iv0xLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=feeBoZmiNK+PqfmUZIUHdcZ4oBKPOjHptWecqjvhfI4=;
        b=V4ppgnIXxfEVLqzDi4gTx3Lgma1Rwe6dsLz9UZE7Gq/WWudEO9eVUEo5yPvJnzlCvr
         sfP2ovWElb/I6YF2YbzxVhx8bEtFdW1UTvoqzFyetM+0jHyNABpksBbyGrl/nfsVw2gs
         CAcFslIBUXPkjR6bkxNFjuBZpnc/NtupbNU26heneFQFys33a/pdEwFDoIbxBVLzRtYT
         cevcVgMQ6y9vdsU0mwS8kyM6ITJcrf9weFwf4hYYATDt3KZwZ07lzkKPNAYiJnkX8sRZ
         XJ07aU74AB+qOwBGzkjdhPGo0FSqX6KJ31E3/C3hsAY8tvCDe8KRPXHyLlfemEN/L7py
         qkHA==
X-Gm-Message-State: AGi0PuZl7cMkS9Dcqrl0zeMDMXu2b7C/lC3epY8VW0dd51XglxAWHvnb
        r7/2jjpxLjCo5FWds6J5A2mTjQ==
X-Google-Smtp-Source: APiQypIL/096cicyoZjsKpAn19BhU3sgp026+T4Ap3M/8jcviaZEa8JyagUmCZZBtGmw0suU4VD5Xg==
X-Received: by 2002:a63:3814:: with SMTP id f20mr27969431pga.283.1588097413701;
        Tue, 28 Apr 2020 11:10:13 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h197sm16260910pfe.208.2020.04.28.11.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 11:10:13 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2 2/2] coresight: Avoid casting void pointers
Date:   Tue, 28 Apr 2020 11:10:10 -0700
Message-Id: <20200428181010.170568-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200428181010.170568-1-swboyd@chromium.org>
References: <20200428181010.170568-1-swboyd@chromium.org>
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
Reviewed-by: Joe Perches <joe@perches.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Thanks Joe for finding my thinko!

 drivers/hwtracing/coresight/coresight-priv.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 5a36f0f50899..36c943ae94d5 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -215,9 +215,12 @@ cti_remove_assoc_from_csdev(struct coresight_device *csdev) {}
 /* extract the data value from a UCI structure given amba_id pointer. */
 static inline void *coresight_get_uci_data(const struct amba_id *id)
 {
-	if (id->data)
-		return ((struct amba_cs_uci_id *)(id->data))->data;
-	return 0;
+	struct amba_cs_uci_id *uci_id = id->data;
+
+	if (!uci_id)
+		return NULL;
+
+	return uci_id->data;
 }
 
 void coresight_release_platform_data(struct coresight_device *csdev,
-- 
Sent by a computer, using git, on the internet

