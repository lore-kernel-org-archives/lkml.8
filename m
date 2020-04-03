Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06290C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE68520CC7
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oTC8E0fO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgDCTux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:50:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39692 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbgDCTuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 15:50:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id e9so9020654wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JPGH//guNKXE+zw41mQiI9K56gZGeqLsPljirbPkDWA=;
        b=oTC8E0fOGssBxycTlFxGc5xx1oGSLXbNDvBvKosjDidLGr48hSossWLYM0KZigOptZ
         YAAtgwVJT3V6AW3KvWpvdSLfBe2WYYiAQ4pm3tqJNDw4SsjmCdubD2xam8FVAP2eSjrR
         byJESroXjDP2Sj9enh9tZm/Je857QdVz6kJkA5qsFOhjIcGDtTAanvVWudXfqe9yIuB9
         eB9SLG4ado0P2ITngZHDhfKb2ghxqlfk3m7sSlOO+CEpL/pSPsbIu+eSaBhWt6hWYoS6
         JgqyDOhQvWYJU7Zj35xuD9AJCJ9qJREu0wA1ugn+NMW5Uo9e5Uj9Ti7YEQ/keW1fScl/
         IuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JPGH//guNKXE+zw41mQiI9K56gZGeqLsPljirbPkDWA=;
        b=bDLPOE4ItAvKE40BPcN74AhgmQQtyczTNbN8EP6P29s6qYoo4EGK5s6wH1cZ06A8Qo
         fG2xLHKkQG2l8npvvmYaJBRhvsw/NKx+AEM/nvoLWq4oCGmD+9KuWdw1RJF2Wy5NQpcb
         T8EgGFxC4G+dRqdnNIv8xojGuUxLYva2WJ83YS1ZcM0XB2FBfw9WAM/GC9iSJHzN6W5W
         Sw+MAzXSNCWWrY5+A5KDYSPAdtHvfjItF03TJhX9HKoDm0jGCfcC9tcufVlCYde7MbS3
         Qf5lu5F8V3s8OLL+BHW4zRD1l96rKmz64qu2GGut97jvbJZttTFKE14X7bk8PGa1GWcC
         6jZA==
X-Gm-Message-State: AGi0PuYN4iEYx/WCgtoWok00y08PUAcbPbAdmWfe90HGGssp2e9tLW86
        FFMKyA0vqA5Y/Db2/6jxYjJ/hXDeP/E=
X-Google-Smtp-Source: APiQypJEbUNkRzvYEwZksUdMc+GOiGb1oOeidTkof3qLE2rcJOLmNJKIfsDxMpHa2IfgnELMwfr6uQ==
X-Received: by 2002:a05:600c:2c06:: with SMTP id q6mr10472251wmg.42.1585943448931;
        Fri, 03 Apr 2020 12:50:48 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id c17sm8102448wrp.28.2020.04.03.12.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Apr 2020 12:50:48 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 2/7] crypto: sun8i-ss: Add SS_START define
Date:   Fri,  3 Apr 2020 19:50:33 +0000
Message-Id: <1585943438-862-3-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585943438-862-1-git-send-email-clabbe@baylibre.com>
References: <1585943438-862-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using an hardcoded value, let's use a defined value for
SS_START.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 2 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h      | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
index 6b301afffd11..a5cea855e7d8 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -61,7 +61,7 @@ int sun8i_ss_run_task(struct sun8i_ss_dev *ss, struct sun8i_cipher_req_ctx *rctx
 		      const char *name)
 {
 	int flow = rctx->flow;
-	u32 v = 1;
+	u32 v = SS_START;
 	int i;
 
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_SS_DEBUG
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
index 29c44f279112..f7a64033fc03 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
@@ -13,6 +13,8 @@
 #include <linux/debugfs.h>
 #include <linux/crypto.h>
 
+#define SS_START	1
+
 #define SS_ENCRYPTION		0
 #define SS_DECRYPTION		BIT(6)
 
-- 
2.24.1

