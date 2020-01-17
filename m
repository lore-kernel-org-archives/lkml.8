Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6AFC33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E784A206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mQcwVJDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbgAQDiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 22:38:04 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:38122 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgAQDiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 22:38:02 -0500
Received: by mail-pf1-f181.google.com with SMTP id x185so11271398pfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 19:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5t137Hgr25MSwppHZChMACb9jtzyL71KI0BNnXvPh60=;
        b=mQcwVJDGKnK0SDcsFxBlyFqk09ppdxI6h15y14y03P7PF6+y+/nFuzCxPPv2xamAmg
         9f1SnyEVfzmq+WI0syd1uuGa2xLJMeO6oxwvTiT4p1daaPWbfSkxNT8xQhoedU2BQ1IW
         aD+OCRq5eDLs7bjHcyv/zf+xeYagRhcADZW/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5t137Hgr25MSwppHZChMACb9jtzyL71KI0BNnXvPh60=;
        b=DNvjomWYynTnA+7b+WPdJ3y3bU0+SNUGZQyp24S9EILGqgK4EP7WpK4LYcYxoiXLR0
         ylBm+nXDPsQ9KqSZYxwZkcY3o0vziC8Hb2gj2Tid0lp0zXTemvJn3sUcu7Ev6WXdcc6M
         rCltJkBWUdphgq4Qrm4yPCc8DrE9n4eodzWEE2jv93SloHEIkiMbGzT3jNZardnTRtsv
         YY5Jam+DIJFGvLBfBqrwusUtMqSQoxXFtLg/tE/2QghjKp0Zo43KxLbph2e2zjSJ/2qU
         /k5OGCSAg0RG14c/BYyyM7UBXzq2Ok8zbnY5HHZgU1dbuQ8w3tGnBNjph/jSKtFCALIs
         RoTQ==
X-Gm-Message-State: APjAAAX0scWjbiNaq4bpE9dfYYQLajqUvJs3WmYHNSmmSC66QDDaujbO
        7iYEPkL2BpfLe31Exvq4Cn45xA==
X-Google-Smtp-Source: APXvYqzy6hYrjE6QOAX5NisMiTl8d4lSUiT1Kk+Lfm0HFpcrBOX/uFVsjFLKOkfbYFQtI0ZIUMMm+Q==
X-Received: by 2002:a62:2cc1:: with SMTP id s184mr911908pfs.111.1579232281428;
        Thu, 16 Jan 2020 19:38:01 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id j38sm25940259pgj.27.2020.01.16.19.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 19:38:01 -0800 (PST)
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
Subject: [PATCH v4 1/3] dt-bindings: arm64: dts: mediatek: Add mt8173 elm and hana
Date:   Fri, 17 Jan 2020 11:37:47 +0800
Message-Id: <20200117033749.137420-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
In-Reply-To: <20200117033749.137420-1-hsinyi@chromium.org>
References: <20200117033749.137420-1-hsinyi@chromium.org>
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

