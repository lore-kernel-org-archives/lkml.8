Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14B6C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886F120714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oBUu203t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgCZRAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:00:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33940 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgCZRAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:00:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id 65so8774132wrl.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 10:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KH7vfyD8OR+w3xEkJPXyaCwSs0SNGzK6N2bTA161o2Y=;
        b=oBUu203t7RmFgHaWPKfqDoFNZ7qHA8FaJ57IhhRltK+4P7FX4lRZ1KagibzgXmPiS1
         pAbe2ZIo/zd9GzYffqMYqUMCJjGL6Q+W8I4zCSJas0CYRTMQtw8aU3MVv6EbToUzoYnL
         g0x5K1Q2Echb5hvO70B2wRozqQKt5CeRQu3+D81P84GVEL+rFlnRyZF/CCnf5UBvzdZW
         YSsFQo7Jdm3hP0jc/+t2AF1FxDCySn7eFeEGXWZD5mtm8YeKAUvJP3S7YVO0vqdfyGzm
         l575fST3wy2MLaHF072JL8P9brrFrMR8mV38T19U7FpTLFUJPVgsRQSwsBuUfm/hToZz
         mEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KH7vfyD8OR+w3xEkJPXyaCwSs0SNGzK6N2bTA161o2Y=;
        b=Q3Z7a3ZqXY5YfSE6+fbYt58pU42AaiFbrymrf6mvJrIg3aCkBAUAXw5ShbWLz3Et2q
         noi7/ATFSrlusXoq7tTN3bg9Q84mgS3aqj6+dn94a2IY2Uawi0UOI5uU8ka2RAjWmCWm
         zV3A8o4GvJpBzCl+jBr7roZFHVVwj/8pF9Qyc02CvDgu8vdPwWCw6k2GALlVNEmHH5r/
         hqwLn42TQQNfiaBdClwEdgsM12isGoZbjZHWJ3OirNwZj8XVT/Be05EVYFUli4z58KBC
         Fgza40fom6olj1RPRjsxdglSfJuD7AjTb6tDocDrrxKkoL7h5nLzTUun4QwjTIH8FAqQ
         EJoQ==
X-Gm-Message-State: ANhLgQ3bn81LjGoYr+7NJzqEMQjC2FDzEhKxHsLRKQ0tgOwg95Qebxeu
        YIX1ao8pshyn1MYgxxjDQu8YuQ==
X-Google-Smtp-Source: ADFU+vt3O1mUzxJ83ShJE2FwW+mMD0UGCyJFszSd3W0wU5qTnctfhV6RSdjpu+iyF10tx1Nl+pEApQ==
X-Received: by 2002:adf:bbca:: with SMTP id z10mr10326561wrg.34.1585242009350;
        Thu, 26 Mar 2020 10:00:09 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id r15sm4609823wra.19.2020.03.26.10.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 10:00:08 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 4/5] arm64: dts: meson-gxbb-kii-pro: fix board compatible
Date:   Thu, 26 Mar 2020 17:59:57 +0100
Message-Id: <20200326165958.19274-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200326165958.19274-1-narmstrong@baylibre.com>
References: <20200326165958.19274-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the uneeded "amlogic,p201", "amlogic,s905" in the board compatible list.

It fixes:
meson-gxbb-kii-pro.dt.yaml: /: compatible: ['videostrong,kii-pro', 'amlogic,p201', 'amlogic,s905', 'amlogic,meson-gxbb'] is not valid under any of the given schemas

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
index 6c9cc45fb417..e8394a8269ee 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
@@ -11,7 +11,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 / {
-	compatible = "videostrong,kii-pro", "amlogic,p201", "amlogic,s905", "amlogic,meson-gxbb";
+	compatible = "videostrong,kii-pro", "amlogic,meson-gxbb";
 	model = "Videostrong KII Pro";
 
 	leds {
-- 
2.22.0

