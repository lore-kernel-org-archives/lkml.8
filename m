Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7080BC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 05:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431B12075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 05:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SlAEl8CC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgAPFMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 00:12:22 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:50406 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgAPFMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 00:12:21 -0500
Received: by mail-pj1-f67.google.com with SMTP id r67so970425pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 21:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5t137Hgr25MSwppHZChMACb9jtzyL71KI0BNnXvPh60=;
        b=SlAEl8CCKwgk2pji8uvv1hGfQcI6PJDUxs9aUvQwZ4wbz3FxpnRNbdItJGljwTH9St
         X1vIOo4Je0wi019hxRim/DPOCMhcWop4I+Qd1spj0buvLJuzta/aohHVXvCIPxIwLUT8
         SjL1n9SXeTVfpR0O36cgyvyp1clc5sdcfFDT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5t137Hgr25MSwppHZChMACb9jtzyL71KI0BNnXvPh60=;
        b=jr1W3he3A/9iCYH9zFUyXqRPE47896oZ+RhfgUvL3ZbHCvYaSH2bho0i3/uVxJpxkN
         UMvgYKJHhVqHGh2SLE84VURdL1QLMN1ic+ypklBwNGr+l2taREo092aMWQEkyzKcmrai
         psg1o3jTTzxUCN0nb8AfB0uMMevyj3P45ZediOJF+tREOUGK1DTIFFca4x+b3+BHgE2Q
         a++WUet9oyiZNESMcF8u43jWdHYZO01XbFkUxB43A+KTFWq8yS2Tvk9UMJZm0QVAmSx9
         Yp8PuCqGwXN93Ro8BfxnehYCnpCHsX5dSGpHobKqM9TXTDfKKZpAbqyigLJAhIjulMMA
         QFmg==
X-Gm-Message-State: APjAAAXDLmtU7JxRGESULXjaqrB7NGZC4LQ4nahZWb76v4u3997lPVej
        OWqqsbuaFbUwKgMG+dDwFZx8Xw==
X-Google-Smtp-Source: APXvYqwdOjdtFD1Iu7QVZbgDqB198xvL/e/t6J9kYjvjNo8/BuXY1Mw5Y9I4lFqL129beGOoLQukoQ==
X-Received: by 2002:a17:902:a614:: with SMTP id u20mr30227332plq.107.1579151541051;
        Wed, 15 Jan 2020 21:12:21 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id l9sm21540217pgh.34.2020.01.15.21.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 21:12:20 -0800 (PST)
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
Subject: [PATCH v3 1/3] dt-bindings: arm64: dts: mediatek: Add mt8173 elm and hana
Date:   Thu, 16 Jan 2020 13:12:07 +0800
Message-Id: <20200116051209.37970-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
In-Reply-To: <20200116051209.37970-1-hsinyi@chromium.org>
References: <20200116051209.37970-1-hsinyi@chromium.org>
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
2.25.0.rc1.283.g88dfdc4193-goog

