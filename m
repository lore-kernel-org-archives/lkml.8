Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9A5C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50CF12053B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="pGQqnjKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgHOWBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbgHOVv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:26 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C296BC004581
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 11:22:32 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l23so9193421edv.11
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 11:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PNxAFacUKwWdwrWwNRjQPm6eA7rqMeHXHFvMy8PGQeI=;
        b=pGQqnjKDUeENaCliXue2wmuceXZNuYF8DEHJrz9maxDr/PFQ5ZkiYIf+/fXkjKfN4A
         wb4Kv3lcZhReksZEZcK0rgs47nt9RQKQbyver3PwXutkO2nuF6ECZtPhTPZ/V4bEylEZ
         oaZyuXY/lpSlqqWOmkbH1Bh25UelOEZpXu9R0Ml6yFbYNqRZUf8uWvwagOFN+UPjcMA+
         abwgGxBpuUpfsCRQ/gBrGPYO/RFRSHsfhuOdfX5nXChpyn4FxztqpmbSPa81MSU5LlzR
         2azBralq0rQmKZ54C/fuCwXlVsEeqQcOwW6aytszPg4zDSibKhQdcZj0NaioNr7R6jJ1
         EZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PNxAFacUKwWdwrWwNRjQPm6eA7rqMeHXHFvMy8PGQeI=;
        b=mbbhvBVmjyWM2pWUSEkINxI3XFFzeP5tQ9iUcB8sSeqZAIIHYe8+fq56Wz7jxaZlM3
         Y/BEyc1u3bsKwbccRWdC6oI+AvqnPCzdPb50hGOCIo2meSKqNapPCAPyz3syurwL8ly6
         Y1pXbEg6EP5dWGN4JdvqotTPoSZXJm5OGQ1IDs7RKMJaYIOfAklMPFSJHqO54OLuqOyj
         DdctEtL4wsQxjogmnceKg7UWQr5iAn3l5u/5YqOV8EhZNQ/uZ19DcM1aaLf7WXDh9dKR
         hOWzchTb4vF9LHyc0dIiK9CHb2oPP5VE4xp4qcQX5/5gIGgnpBL8j2jkGjt/wC1Ldsai
         FuWg==
X-Gm-Message-State: AOAM532emB9vj/leOLIqVbTBlaqg95Le/6kmtA8n4of2ej1aVY2ndRi0
        bpgcdm7fEUp559m8oFkhjhE=
X-Google-Smtp-Source: ABdhPJxwzz/gHG95f9PJXIE1eG3PSPWP8hHe6tLSqR8DRPmaZ2QWc94IJddf1E8cfnkvCLYQS5wAKQ==
X-Received: by 2002:aa7:ce98:: with SMTP id y24mr7870004edv.76.1597515751399;
        Sat, 15 Aug 2020 11:22:31 -0700 (PDT)
Received: from localhost.localdomain (p200300f1371a97000000000000000fcc.dip0.t-ipconnect.de. [2003:f1:371a:9700::fcc])
        by smtp.googlemail.com with ESMTPSA id 1sm10265758ejn.50.2020.08.15.11.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 11:22:30 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] ARM: dts: meson: move the L2 cache-controller inside the SoC node
Date:   Sat, 15 Aug 2020 20:22:23 +0200
Message-Id: <20200815182223.408965-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All IO mapped SoC peripherals should be within the "soc" node. Move the
L2 cache-controller there as well since it's the only one not following
this pattern.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index eadb0832bcfc..7649dd1e0b9e 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -11,13 +11,6 @@ / {
 	#size-cells = <1>;
 	interrupt-parent = <&gic>;
 
-	L2: cache-controller@c4200000 {
-		compatible = "arm,pl310-cache";
-		reg = <0xc4200000 0x1000>;
-		cache-unified;
-		cache-level = <2>;
-	};
-
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -172,6 +165,13 @@ timer_abcde: timer@9940 {
 			};
 		};
 
+		L2: cache-controller@c4200000 {
+			compatible = "arm,pl310-cache";
+			reg = <0xc4200000 0x1000>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
 		periph: bus@c4300000 {
 			compatible = "simple-bus";
 			reg = <0xc4300000 0x10000>;
-- 
2.28.0

