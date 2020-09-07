Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F07C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8C5320757
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eNNLkPaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgIGHeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgIGHeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:34:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA7AC061755
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 00:34:12 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y15so539765wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 00:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HebYhZE7sImd2rEoHNhbJh9aZeuCFQtemX8HZ/zA81Y=;
        b=eNNLkPaz04iEEVXIha8aR4r7KXTo5570l9scgu2U/HeVeZWn3DYtBiCW5/oHoRaBF3
         NXSsGrqG6RRJ/HIU0sPW5RlRgzGDFJhEOY0DuRWbmsHY/3315xp3Lj1aQkCRb5/fOMdO
         a0uF2xzQRjzuvmjggxGLK9HJm6kdRsXsKSgWOqyn0K7+GfgHYqZlZF8/sw88OOoxbn43
         rhnE/hB0eEJXWJbGsGcMya2PqTJst3NTiqBoPzuTTo3ZwR2sb6R5cLzGKh+KfOQb7jzR
         Td2/BmfJWUOe7zn6njN1hK8rwWmG1bLdOAxoYszVLuL2jFWZ9JXrwEfZh1VeiNg/Tlu7
         kIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HebYhZE7sImd2rEoHNhbJh9aZeuCFQtemX8HZ/zA81Y=;
        b=IUjdh6gSKxLPNunQqEsu/XhE6XXyDFOmmqVy8UKtG2MW/sZywfpssOQZQndCABCKfw
         gvo+gtpnXtv8cVOaz12OhVgzIPVOij6XcUxGcGvq8Py8Kv042hhaJReHL/KHtKzOrhyN
         jZeRzF+pImz8tBRTOe3+9+A3gQdWBu3lXxKWdubrnCGzrOzfoMURNrzQgn7WlrgssO6K
         i/iwv4MuUrmOVAsEdUGBaPS0zdToMkJPtwIwr5Y0AodDM1yp03S3o9MazgEtyrJGFm8q
         gmcgAFTJKwOouUnXGsOa7xS6uTt+avuU5vVHXq/uVz2FDm28w5tISEtLBWeR7oA1T23W
         oCsw==
X-Gm-Message-State: AOAM530xjvZ+BO3JNHGQJrsA5NWyeNfRST25B7nnpXDy+EINmSnXqTsn
        kb7O/IBUmZbIuiQEj+AA4x40XA==
X-Google-Smtp-Source: ABdhPJxqUj+4v76RgQgGGFariH4vNyP1mLeIzZDzjKKY2kW9cctnMkgJkxXUDCK/v3rtzQpGZpqI0A==
X-Received: by 2002:a1c:7f8b:: with SMTP id a133mr20660312wmd.155.1599464050504;
        Mon, 07 Sep 2020 00:34:10 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id u66sm527689wme.1.2020.09.07.00.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 00:34:09 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, repk@triplefau.lt, devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/3] dt-bindings: phy: amlogic,meson-axg-mipi-pcie-analog: remove phy cell parameter
Date:   Mon,  7 Sep 2020 09:34:01 +0200
Message-Id: <20200907073402.26674-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200907073402.26674-1-narmstrong@baylibre.com>
References: <20200907073402.26674-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic AXG MIPI + PCIe Analog PHY provides function for both PCIe and
MIPI DSI at the same time, and is not exclusive.

Thus remove the invalid phy cell parameter.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml      | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
index a9040aa387cf..148618b51b24 100644
--- a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
@@ -14,7 +14,7 @@ properties:
     const: amlogic,axg-mipi-pcie-analog-phy
 
   "#phy-cells":
-    const: 1
+    const: 0
 
 required:
   - compatible
@@ -27,5 +27,5 @@ examples:
     mpphy: phy@0 {
           compatible = "amlogic,axg-mipi-pcie-analog-phy";
           reg = <0x0 0xc>;
-          #phy-cells = <1>;
+          #phy-cells = <0>;
     };
-- 
2.22.0

