Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDAAC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E5D0206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bU7UCV6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgEFGbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 02:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725882AbgEFGbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 02:31:45 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38486C061A0F;
        Tue,  5 May 2020 23:31:45 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d184so510592pfd.4;
        Tue, 05 May 2020 23:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Kklx6WNLIBEUnlaQW9xoqKKQiAQpc9O2rLkXNwH/Ew=;
        b=bU7UCV6bT4jUeZ7RQOMu3wRGQ+cZ2Cu8ugjmU1y3EAWGuBnm6OpfWbbpm6You3RxiK
         +LNF41UdPSiADhh5JhmW871M4g9IyrtTY1VBBlcdOnXjrbiSLoEC9cw73n94zcbxC/h4
         uTcyuFXuXjfASNKh0szxgXDzYvSFQaxJAVYZs3yeVCNIzfKVS9Js1tAMtPCytYfB9FO2
         GbZGWunwUSAsMp15drDmbitMgBncVnT1rOujQS3EKdwaSx98nrVIOieXLoRGhBPGvOlI
         HBBSfV0L6Y4Ovy8H6VTXXQk7wj31wccLCPh3rMi08OpmJ7Pn1VfItyFPGxlWIZf5+Jxc
         Kn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2Kklx6WNLIBEUnlaQW9xoqKKQiAQpc9O2rLkXNwH/Ew=;
        b=LnncpD0Q3GHYEI72bYq7sbyW+vPUNUXTNZV0bmSmD+YjuGOkT4UhX6Sq3IgavW6pce
         rEIdCNxasWMEb4pXAXoIqBhd2+nER4xlOAMDeJxvuaha5au4R8G7X1bsMEHXwmqwADVM
         XHEMK735VwCWthpTfBZ4QaC96CBatYK05TusFo70FPMNUCM+Rrq1TFh/1yryURA2rW5L
         KfqTBHH95CDiZL5zepX2aOB4Gxc7Hzia1qzSeLi39npZOTga32o8FvLft8bje7Ao4cxd
         j+VpHOj/yqAxXpVwKZX2F5Ztzyk6mR+bUFgpjjedsHuGWHW4YtyNlfbDCCQblS1LEk2p
         R/IA==
X-Gm-Message-State: AGi0PuawJzghjMJNzK/JXATJjq0svWTA96tBthY1HdtWYiT/1ism9Aok
        tSrY8pLcgt4A5tqIQAlJ1iU=
X-Google-Smtp-Source: APiQypJSzYnaLatTQqkl0/D+fk+Akri+ROm11yE/Km6azhEgc2fuE8h7m7GlL200Ebyzf1EpLGYWMg==
X-Received: by 2002:a63:b51b:: with SMTP id y27mr5362061pge.400.1588746704798;
        Tue, 05 May 2020 23:31:44 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id y3sm3771975pjb.41.2020.05.05.23.31.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 23:31:44 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dillon min <dillon.minfei@gmail.com>
Subject: [PATCH 2/4] dt-bindings: display: Add ilitek-9341 binding
Date:   Wed,  6 May 2020 14:31:33 +0800
Message-Id: <1588746693-31078-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588746693-31078-1-git-send-email-dillon.minfei@gmail.com>
References: <1588746693-31078-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

add ili9341 for stm32f429-disco board
some hardware resources can be found here
https://www.st.com/zh/evaluation-tools/32f429idiscovery.html

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 .../bindings/display/panel/ilitek,ili9341.yaml     | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
new file mode 100644
index 0000000..5138f56
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/ilitek,ili9341.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek-9341 Display Panel
+
+maintainers:
+  - Dillon Min <dillon.minfei@gmail.com>
+
+description: |
+  Ilitek ILI9341 TFT panel driver with SPI control bus
+  This is a driver for 320x240 TFT panels, accepting a rgb input
+  streams that get adapted and scaled to the panel.
+  VCOMH outputs.
+
+properties:
+  compatible:
+    items:
+      - const: ilitek,ili9341
+
+  reg:
+    maxItems: 1
+
+  data-mapping:
+    const: stm32f429-disco,ltdc-panel
+
+  dc-gpios: true
+
+  port: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - dc-gpios
+
+examples:
+  - |
+    panel: display@0 {
+        compatible = "stm32f429-disco,ltdc-panel", "ilitek,ili9341";
+        reg = <0>;
+        spi-3wire;
+        spi-max-frequency = <10000000>;
+        dc-gpios = <&gpiod 13 0>;
+        port {
+              panel_in: endpoint {
+                    remote-endpoint = <&display_out>;
+              };
+        };
+    };
+...
+
-- 
2.7.4

