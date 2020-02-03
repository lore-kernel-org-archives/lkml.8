Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE5DC33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21D12082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CJ30/B5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgBCKyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:54:41 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:47052 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbgBCKyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:54:41 -0500
Received: by mail-pl1-f195.google.com with SMTP id y8so5693977pll.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 02:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qdcfeO5K2S+Cod2DP3bBm/qVK9+LuyFJKPE+ozmP7N8=;
        b=CJ30/B5L99FeE/8A8MlJ8DKGA/bta/8h/RXH+V8BikycRyW6Yu+QA7vFAQN3U3pLTo
         KWBN8bUINxvs3p44qFmDDTyQuR/eB/f4BDttHZSdz1sjXGOrZGsd92NDm6Dxzk1c/EXZ
         fIY75n5HfljIQ/uFciOU2qzHNptH5QNJR/JNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qdcfeO5K2S+Cod2DP3bBm/qVK9+LuyFJKPE+ozmP7N8=;
        b=tYxWQeN0a+dl2A5nSBKfCBf0DvUQmTgtmrKuUC/SxKR2w6wQGKkkGjparK6PYdLAss
         Hjf8LGjDeFEsPu/Ul7ppyBqUCYZZnvq79VzYrZFP7FpPp4tCobLhAkL2xhIw49h/z+PB
         /Od4Blg5RZADDhv0i/8n2mnAWwBQC57T6NJoOc618+ErUCX2l9qb7CWn2yETG26p8NiY
         snqqmVrVLwYSn9xt8higYoaOPueDB/jpva4EEL01QRCunCXM6xLkhDMNGrO5UQplgUyr
         wU0mysJ7Bo+6NWExXAtyDIMT2iQZt/Kqm59TPiAk6g6KJkehvMvjam6jjMrs6e+OaYSq
         Y3dQ==
X-Gm-Message-State: APjAAAXCt7xMWKPoMfcaFpSLhPBTDvKpTiA9kNtLjN7TzkZpQY3n0+fh
        tuZU6OaIWiIT6EV1VYo5ST+HiA==
X-Google-Smtp-Source: APXvYqwhhb++S662UhMMPJRvXKnxOT2X6ORVM0UluIGDGNCr/JKKEYwit/FK0LXKsLF0cA0obcgWSQ==
X-Received: by 2002:a17:902:8546:: with SMTP id d6mr23392335plo.193.1580727280661;
        Mon, 03 Feb 2020 02:54:40 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id 11sm20923835pfz.25.2020.02.03.02.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 02:54:40 -0800 (PST)
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
Subject: [PATCH v5 1/3] dt-bindings: arm64: dts: mediatek: Add mt8173 elm and hana
Date:   Mon,  3 Feb 2020 18:53:47 +0800
Message-Id: <20200203105345.118294-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200203105345.118294-1-hsinyi@chromium.org>
References: <20200203105345.118294-1-hsinyi@chromium.org>
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
2.25.0.341.g760bfbb309-goog

