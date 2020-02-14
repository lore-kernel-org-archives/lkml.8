Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AEDC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECF2222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d69kMwpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgBNG07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:26:59 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38472 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgBNG06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 01:26:58 -0500
Received: by mail-pl1-f195.google.com with SMTP id t6so3341194plj.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 22:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZfNOx9egLbAQLBCqcGowPLvDDsbitGpqyuG8vdVwiMo=;
        b=d69kMwpSmTtFJP/1FqRQEGClRQOMAiQIW8PkbgXbrVM2erzoClA8jtUS1mkxvgC1+1
         pxXWqlW7CeDMLzCHYj0G07DGRgpmJlmj+nkvV4+k6mKCcoRBjhmn+isK6pR/BjXXrG3L
         JWqrVKbRFTtyteHeIgYUFXW5X5evlBbNFrHdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZfNOx9egLbAQLBCqcGowPLvDDsbitGpqyuG8vdVwiMo=;
        b=hGD63mTKPXTsIePRY/6aZp2AECI7fg2zrSRenGwb4ALMdcjTQWrWiZPXRgHh8AV48h
         wfqloLYnXrUeBLDPgmaxTk7Ck93/z3bypzs9pMsJ//5hhWqqEDFivz32J8AIx+TOfTGc
         lpZ2V7mwpRa0xRf4deyTyUwI5p+pl/pdK4N5d/lIhespoMvAzjnfxkL1P1E7Sd16TMyd
         9zg+wQtl3oZJyBYWfAqo6f7CPKEKQr2e7u2/lXjxk05nGU3GSysi30n8XoKWbUPiieY6
         TCx3V89Z5i6aBD2d/4W9O6Lb1Z6LMf27VwKlbY559+CDrhsjKS/SQb9eSTogaKBL5CV+
         kuEA==
X-Gm-Message-State: APjAAAX4bfuyfi2qOvHFoYTxA1ol875kn+0pt30qEoAMxSC0xJzO9GQ/
        svHPz0bhHnpz6ntZew3nTfyZ6NaovJnhyA==
X-Google-Smtp-Source: APXvYqyvc9phth6DVXD9Fm2fhndiDgJIEAfiLXapVfRf8xXPKrjsq6pDOxmhci9u/EHubDa0/Y0eVw==
X-Received: by 2002:a17:902:7046:: with SMTP id h6mr1650483plt.231.1581661616431;
        Thu, 13 Feb 2020 22:26:56 -0800 (PST)
Received: from localhost ([2401:fa00:9:14:1105:3e8a:838d:e326])
        by smtp.gmail.com with ESMTPSA id e16sm5233151pgk.77.2020.02.13.22.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 22:26:56 -0800 (PST)
From:   Evan Benn <evanbenn@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     jwerner@chromium.org, Evan Benn <evanbenn@chromium.org>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: watchdog: Add arm,smc-wdt watchdog arm,smc-wdt compatible
Date:   Fri, 14 Feb 2020 17:26:36 +1100
Message-Id: <20200214172512.1.I02ebc5b8743b1a71e0e15f68ea77e506d4e6f840@changeid>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200214062637.216209-1-evanbenn@chromium.org>
References: <20200214062637.216209-1-evanbenn@chromium.org>
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

 .../bindings/watchdog/arm,smc-wdt.yaml        | 30 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++++
 2 files changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/arm,smc-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/arm,smc-wdt.yaml b/Documentation/devicetree/bindings/watchdog/arm,smc-wdt.yaml
new file mode 100644
index 000000000000..5170225b0c98
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/arm,smc-wdt.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/arm,smc-wdt.yaml#
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
+      - arm,smc-wdt
+
+required:
+  - compatible
+
+examples:
+  - |
+    watchdog {
+      compatible = "arm,smc-wdt";
+      timeout-sec = <15>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index e48ab79879ac..5c45536e1177 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1421,6 +1421,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
 F:	drivers/irqchip/irq-al-fic.c
 
+ARM SMC WATCHDOG DRIVER
+M:	Julius Werner <jwerner@chromium.org>
+R:	Evan Benn <evanbenn@chromium.org>
+S:	Maintained
+F:	devicetree/bindings/watchdog/arm,smc-wdt.yaml
+
 ARM SMMU DRIVERS
 M:	Will Deacon <will@kernel.org>
 R:	Robin Murphy <robin.murphy@arm.com>
-- 
2.25.0.265.gbab2e86ba0-goog

