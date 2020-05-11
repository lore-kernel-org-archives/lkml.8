Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4281C54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F0BC218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="q37ckKvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgEKPIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729986AbgEKPIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:08:23 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D2DC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:08:22 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l18so11399773wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sewIQrOfMSMCFki5vvjbKoo8BkZz8WZa7NzooTrVnts=;
        b=q37ckKvI97gdW/9Qf733N08+axobkxxkecqbP8tELu1P7icQxfg3axOfLOYxiFCBwl
         oW05IYZCYgxJNYg+koCtaEP74kUPAP7PvkOTtmB8izDdFoqQ7hUPr6KHdo+QapU5fG+q
         okYraohC8Z+OVy+h3pew0mfKrvkCW5otHVTVv/M3aUqhjbBCgmNhqm0DjbiAtK+BOLLi
         J3u3/fW1XlTDrkKTN/e8xinBIg+wOmpGaGiK4N+T0FY9XJO2tq6hVKqSmb/ITP3KJx0m
         772YiDG8qWBy+CWk7PZaNjByABatlmXAblj8wCORl9qC2OeLAPGB+ni3oUS02zE0ASo0
         jDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sewIQrOfMSMCFki5vvjbKoo8BkZz8WZa7NzooTrVnts=;
        b=W+Nt/L6T12/TKFxoZEumUSJCn6xK4sxPBsaeVSoFvQUGWGmKa32cfK2U1leaRZyByI
         89EIuN3+6x0o6he/lc8uGv9MiHe2fTW4M9j9/OyfYgjWuh/eFouL7B61ffLr9FD1Sxj0
         TZ7hHSvNsl4M9qgeodD7YTCCta+w47+B0WlrL02sZxCReSyxg3QE8ZrX5/pcFE6Xh1WN
         1wtjeQk1pQoA9SLRvYnP6basXKUmP3awasCrGHbaiGZe+T9j0dT3B4MvypRBIi35uUye
         CjXJITKPMdGYuTsDOnNNeBo2q7XmbJMdbnpqJHfRQBMjKraRwujOsaNoyr0Q/7qzN73E
         OPJw==
X-Gm-Message-State: AGi0PuZ7Zwk8pVKmkMRtBvuy/zOFo4vDQr6F0DCQjpOZOHDkpZWYnOP3
        TQ0jcnd0QmzQ7iQ6wNdmYAUPHA==
X-Google-Smtp-Source: APiQypJkabPSlSRTzxm2g+2Pcl2v8TJeYzS/3rcaydFEeD66RCudiytYlqP+kPoPaNBs86GUJFZHvA==
X-Received: by 2002:adf:f605:: with SMTP id t5mr19294913wrp.354.1589209700812;
        Mon, 11 May 2020 08:08:20 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id 94sm3514792wrf.74.2020.05.11.08.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 08:08:20 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabien Parent <fparent@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Edwin Peer <edwin.peer@broadcom.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 01/14] dt-bindings: arm: add a binding document for MediaTek PERICFG controller
Date:   Mon, 11 May 2020 17:07:46 +0200
Message-Id: <20200511150759.18766-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200511150759.18766-1-brgl@bgdev.pl>
References: <20200511150759.18766-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This adds a binding document for the PERICFG controller present on
MediaTek SoCs. For now the only variant supported is 'mt8516-pericfg'.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../arm/mediatek/mediatek,pericfg.yaml        | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
new file mode 100644
index 000000000000..74b2a6173ffb
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,pericfg.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MediaTek Peripheral Configuration Controller
+
+maintainers:
+  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+        - enum:
+          - mediatek,pericfg
+        - const: syscon
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pericfg: pericfg@10003050 {
+        compatible = "mediatek,mt8516-pericfg", "syscon";
+        reg = <0 0x10003050 0 0x1000>;
+    };
-- 
2.25.0

