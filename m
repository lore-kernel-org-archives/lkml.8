Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEB2C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 06:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F4020838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 06:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YtFvUT8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgBJGg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 01:36:26 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:46097 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgBJGgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 01:36:25 -0500
Received: by mail-pf1-f172.google.com with SMTP id k29so3186787pfp.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 22:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2vermDwahlH6+AsMPUBbXBF+09yfDI0r2EqJfGMtZpw=;
        b=YtFvUT8guVin/0PBil4w8iiXmVupqvP4cXnZ8tEDJ7FZU/4ycOJPKScPVJgBjfG9yD
         iTiZlW+hJu4e/wlq7NP/ZW6rQ+c2Wh/4Ukj8oV4PcJRnax2QlSoHL3fQvXNlYMmwCS7f
         ih7ptXse/+mSB91eRetWgEft4RNOvKV1zZm9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2vermDwahlH6+AsMPUBbXBF+09yfDI0r2EqJfGMtZpw=;
        b=jcSkJ/b0WquYvHn6R7gDdwnXbwn0y4jkotk8feKTjVpDlBJyYUtSPaUkJfd181TCFN
         fJ14gXfWvGDvnTXV3qdgNV/x0W8BQMAvYCb8qDN9haOu3SXY+BtfOlR8Dfmi9WNnquL7
         3RSYiuLgylEYN3u08E3EYi1OMZpXFZoDQzT0mNANWd54Z4XRWvvaD/dUgjJA6ZWIMaR+
         tad0cKk1aeXdmDeTB9Edi8+XVbz6Ao2dpA2cB5eUyzN2RlSduhVHCM1Smy/EwVjVvP5g
         S9m18Ggax8ChX+tVVceZS9SDWUD/wjCql1lfFr1ETMyf0dXTAa+TP/jMNOvJMnPQ4ECq
         c+Zw==
X-Gm-Message-State: APjAAAVRYAgfqq+gOXZazw5STi/RUMdsXcArWFzCIEI1aHvP36PmAflc
        fPkX3qyf/UBZ5oi08PwjnsjfbQ==
X-Google-Smtp-Source: APXvYqy6+uba/QhCCot+FbXrUFE0PymyoKNbEM2DPRucR0W3KIJNqZqs9DPhLAxaubTjHvAvamlnQg==
X-Received: by 2002:a62:e111:: with SMTP id q17mr11322834pfh.242.1581316583666;
        Sun, 09 Feb 2020 22:36:23 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id f15sm11070041pgj.30.2020.02.09.22.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 22:36:23 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH v7 1/5] dt-bindings: arm64: dts: mediatek: Add mt8173 elm and hana
Date:   Mon, 10 Feb 2020 14:35:20 +0800
Message-Id: <20200210063523.133333-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
In-Reply-To: <20200210063523.133333-1-hsinyi@chromium.org>
References: <20200210063523.133333-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Elm is Acer Chromebook R13. Hana is Lenovo Chromebook. Both uses mt8173
SoC.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/mediatek.yaml     | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 4043c5046441..abc544dde692 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -84,6 +84,28 @@ properties:
           - enum:
               - mediatek,mt8135-evbp1
           - const: mediatek,mt8135
+      - description: Google Elm (Acer Chromebook R13)
+        items:
+          - const: google,elm-rev8
+          - const: google,elm-rev7
+          - const: google,elm-rev6
+          - const: google,elm-rev5
+          - const: google,elm-rev4
+          - const: google,elm-rev3
+          - const: google,elm
+          - const: mediatek,mt8173
+      - description: Google Hana (Lenovo Chromebook N23 Yoga, C330, 300e,...)
+        items:
+          - const: google,hana-rev6
+          - const: google,hana-rev5
+          - const: google,hana-rev4
+          - const: google,hana-rev3
+          - const: google,hana
+          - const: mediatek,mt8173
+      - description: Google Hana rev7 (Poin2 Chromebook 11C)
+        items:
+          - const: google,hana-rev7
+          - const: mediatek,mt8173
       - items:
           - enum:
               - mediatek,mt8173-evb
-- 
2.25.0.225.g125e21ebc7-goog

