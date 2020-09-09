Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FDEC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8CD420C09
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cvL1h9nX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbgIIQv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730720AbgIIQFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:05:04 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972DDC0617B1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 09:04:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so3565713wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 09:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vgg0Drz8zo+lQwM7EXGGKvLI+hvN7gZtyPm/VP553No=;
        b=cvL1h9nXfB4PJJq/e8iaVIE0lAtZEUldzYk7G+DOxesgjcyeh3lFoH6VUV5paWo+2f
         zoG9gGGz08+6riwAqPHo/ywfIUNhU4++BcaE+qmrxWeEd0j7g2fegHMwaHzhaDHxjW42
         I4yDbXnXVKRe/0gOMyvit1ZWZJ62T/FavpV8vlp2kiWJ8aBlqfJhHJtEdyn/NHARRKfr
         sKEplMXQD6sQj3j3oqXWGCd2c4/z7NyZL5806d5nPJSsNP6wNvMmVMAIkJJ/3WuX4OH0
         kHhG9xK7XEd8qiS29ZeN4LcrAlS16vwjfDFcb3tU6STTC1W0/9vGCnwX04FZk1n9Rnb7
         mgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vgg0Drz8zo+lQwM7EXGGKvLI+hvN7gZtyPm/VP553No=;
        b=X3NSxM2/KLJnCFjqbX3zGfLytDjk2JjpKwL27epEL1QucfoLiQVG6uR+8Pi8cI4hFd
         AKtigwLpPYaE2RMVYtt4Bzd+r1iY3O5OOJcf6+z5SEfAuOC89QAIvgQo3ufzmix1Y4fK
         OqXpHRqqTavJx5k+C3WLJ93XxdW7KSd84oiLON5/yJf2e8uVQMcTlrEre4Ltj6YP7wOo
         h8Y0K5QdQCu8ivOmyT2Pv1VxdFQp+EcNCl+Grezm6mrxWVgoUsuLPNRlC68Usvr4BVEA
         0GdKYrcblT6gcTDrrETyk+9G7REQRXfcxeyze7FDggLhGLGI0l6IN1j38rPKI31oav01
         HTRg==
X-Gm-Message-State: AOAM531TZrqBBNunynCgVbocqyF8WOv8M80xe62SLP95WFguVyzVkZJy
        0+9WzeHXBMGx8vjHpoO7Rby6WAYu6NPGgGlI
X-Google-Smtp-Source: ABdhPJyhA56ZPn7zhGV+NzrFhVIB0ghngJMEVy9ru3brR2WQ2skP9ky+KN8SoHdCYCH1eesOk/Ra6g==
X-Received: by 2002:adf:fd90:: with SMTP id d16mr4743738wrr.52.1599667463126;
        Wed, 09 Sep 2020 09:04:23 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id y6sm4850700wrn.41.2020.09.09.09.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 09:04:22 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 5/5] arm64: dts: meson-axg-s400: enable USB OTG
Date:   Wed,  9 Sep 2020 18:04:09 +0200
Message-Id: <20200909160409.8678-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200909160409.8678-1-narmstrong@baylibre.com>
References: <20200909160409.8678-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables USB OTG on the S400 board.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index cb1360ae1211..5f131debcbad 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -584,3 +584,13 @@
 	pinctrl-0 = <&uart_ao_a_pins>;
 	pinctrl-names = "default";
 };
+
+&usb {
+	status = "okay";
+	dr_mode = "otg";
+	vbus-supply = <&usb_pwr>;
+};
+
+&usb2_phy1 {
+	phy-supply = <&vcc_5v>;
+};
-- 
2.22.0

