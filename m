Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E618C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5238820838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XMGKpbpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgBGJCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 04:02:51 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54]:51802 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBGJCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:02:50 -0500
Received: by mail-pj1-f54.google.com with SMTP id fa20so646186pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 01:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2vermDwahlH6+AsMPUBbXBF+09yfDI0r2EqJfGMtZpw=;
        b=XMGKpbpt8Bga3bXIsAgR/J6qNAhyzGKLYICevuRaHrFAn8FnoM+QoxHFCtcrjsLjto
         uAkKCLY6HDC6TvKD/K6q7ac+jwfW6wXGLx8FE4XVzJ1hDGFQLPn0U+xps/jB3fHIscbY
         HKogRhnt09yHqNanDzet6hHcNVm895hVdCjEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2vermDwahlH6+AsMPUBbXBF+09yfDI0r2EqJfGMtZpw=;
        b=fMV99m2ZMsg9TsIsZQqvcy2Sf1x+rCvko7lyzeTl2bCyQ5HMEmsTAvfiOs9Lm94POD
         B8n5iJgAlllvYf9m6GuDabSwZCVSxp40lem5UzUXhVhCz14gWDuUlnCQP64H/b0Xmgmq
         hTYRnIl06+XuV6y2ArLKFJmEcvo+z+NIAz/ubRtyJh3C9fO6PcUa4RXvpj+s387StCHM
         Us/ginzASmci9Fbg/gcfE+L1ggsz/Md1iVwoOGQe3vN+9+VvJ4Eh5OVXAn5QK4JbdLfN
         zc6SZZV7O+JVx4w2BkAwP4c5KcXSc2F+6XS+URqIhdA0228Cu56ydHxfHvKBChhgvo15
         wMuA==
X-Gm-Message-State: APjAAAWpJ3YGQcuAz48YytLguL39pYFV85ZZP6aewyIpMKeZAFOl5bO5
        5NJ8XwcWtofBvukqYbKerEw3GQ==
X-Google-Smtp-Source: APXvYqzD6oLxnMRfl4Imna/ocsllrU1pcz/lXtHdflVIf4FHnBWbXczUh92y4s+QcrGUVusDk5DcPw==
X-Received: by 2002:a17:90a:8a12:: with SMTP id w18mr2621068pjn.68.1581066168018;
        Fri, 07 Feb 2020 01:02:48 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id w6sm2309463pfq.99.2020.02.07.01.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 01:02:47 -0800 (PST)
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
Subject: [PATCH v6 1/5] dt-bindings: arm64: dts: mediatek: Add mt8173 elm and hana
Date:   Fri,  7 Feb 2020 17:02:24 +0800
Message-Id: <20200207090227.250720-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
In-Reply-To: <20200207090227.250720-1-hsinyi@chromium.org>
References: <20200207090227.250720-1-hsinyi@chromium.org>
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

