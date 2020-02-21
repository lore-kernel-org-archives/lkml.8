Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DD9C35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 05:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD79222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 05:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NHBlsLvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgBUFic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 00:38:32 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36158 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgBUFib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 00:38:31 -0500
Received: by mail-pj1-f68.google.com with SMTP id gv17so240888pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 21:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CapMNX7pjr8MkESV5PbFvA3nh0aG4lhz0SRP146DeOk=;
        b=NHBlsLvEzhPsV9lVrqrxLfj46dzf+dfvYfal/9H20MGjw4nLWWSVa8v81TGtfCiHGG
         UNImlkJ6xyOWAA6l1H1xA2JqGLXbVDYYjArPqkFMKmwUZffHJaGPMeXaVTJX8lG24W7Z
         1BH97JwtFsJ//+S0hygIEpEECdThBP537UmUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CapMNX7pjr8MkESV5PbFvA3nh0aG4lhz0SRP146DeOk=;
        b=Jud3WHCVnpQs+NCm+KG0MbLb/EWRNncwB48GcfyZqCJy/IOP/gYg7R7TwFuIRE88Us
         Bq+0L8iM7iVLj9JxTkoTib4c0JB5nDTljq8tOnjSxj9YQmBzMQ8UisGVFbCQfmnw9eph
         ayeoeOuCLhz5DWatCanJAkOZea0mXLBtNFpPW+jnewBg0/nFfaj0OHU42Ux+UD6FseUe
         zdtAye6Rdht21SzyqoeCXhTfslfTFN0JauoRieBLBkmKypqRlLezl/lSfhL/nQGfJ5FZ
         kjsusvuohgZW6Y9HPt37WJH2NXV0/r3LC40vuXVIT6OoYvY/GuOoXwwMoYtlxpz5AKYi
         bTHg==
X-Gm-Message-State: APjAAAXm7Gf9AvcfjFpf+H2zG/+bPRK6FUTZ91Ua10FPxn+9Os6hkMdh
        VfNdtg5+e+XDB9rXHjk8788VKKWX6Qrifw==
X-Google-Smtp-Source: APXvYqz+fNCi7RyQICRTNgU9IYDRlA2CBQL0xzTHdNzESzxk/Lp56MofgOU6MTmKnMrgVqSEjK8ojg==
X-Received: by 2002:a17:90a:804a:: with SMTP id e10mr1046782pjw.41.1582263510005;
        Thu, 20 Feb 2020 21:38:30 -0800 (PST)
Received: from localhost ([2401:fa00:9:14:1105:3e8a:838d:e326])
        by smtp.gmail.com with ESMTPSA id m12sm1324157pfh.37.2020.02.20.21.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 21:38:29 -0800 (PST)
From:   Evan Benn <evanbenn@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     jwerner@chromium.org, Evan Benn <evanbenn@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: watchdog: Add mt8173,smc-wdt watchdog
Date:   Fri, 21 Feb 2020 16:38:01 +1100
Message-Id: <20200221163717.v2.1.I02ebc5b8743b1a71e0e15f68ea77e506d4e6f840@changeid>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200221053802.70716-1-evanbenn@chromium.org>
References: <20200221053802.70716-1-evanbenn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This watchdog can be used on ARM systems with a Secure
Monitor firmware to forward watchdog operations to
firmware via a Secure Monitor Call.

Signed-off-by: Evan Benn <evanbenn@chromium.org>
---

Changes in v2:
- Change name arm > mt8173

 .../bindings/watchdog/mt8173,smc-wdt.yaml     | 30 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++++
 2 files changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/mt8173,smc-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/mt8173,smc-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mt8173,smc-wdt.yaml
new file mode 100644
index 0000000000000..ff45e13bc548b
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/mt8173,smc-wdt.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/mt8173,smc-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Secure Monitor Call based watchdog
+
+allOf:
+  - $ref: "watchdog.yaml#"
+
+maintainers:
+  - Julius Werner <jwerner@chromium.org>
+
+properties:
+  compatible:
+    enum:
+      - mt8173,smc-wdt
+
+required:
+  - compatible
+
+examples:
+  - |
+    watchdog {
+      compatible = "mt8173,smc-wdt";
+      timeout-sec = <15>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index e48ab79879ace..59e8779363c12 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1421,6 +1421,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
 F:	drivers/irqchip/irq-al-fic.c
 
+ARM SMC WATCHDOG DRIVER
+M:	Julius Werner <jwerner@chromium.org>
+R:	Evan Benn <evanbenn@chromium.org>
+S:	Maintained
+F:	devicetree/bindings/watchdog/mt8173,smc-wdt.yaml
+
 ARM SMMU DRIVERS
 M:	Will Deacon <will@kernel.org>
 R:	Robin Murphy <robin.murphy@arm.com>
-- 
2.25.0.265.gbab2e86ba0-goog

