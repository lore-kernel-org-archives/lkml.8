Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F4EC35249
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A0E20658
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqlUNlkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgBBVT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 16:19:29 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:45162 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbgBBVTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 16:19:18 -0500
Received: by mail-pl1-f172.google.com with SMTP id b22so5007061pls.12;
        Sun, 02 Feb 2020 13:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ipAhlw5WrsUU5opUi6Qmf1XgM2Fq+bPWZGrkUnEi1PQ=;
        b=jqlUNlkwxxWhM/E6FJwjoqn00hnGheJApKd3G3+IRHM2eTahOI3CAScHOb2kDB+3Ak
         aeEiR6zOkAlIqpG4ZROtszwHLfARNMD2bY/5M16B5hRHb0Svkuw3/loLSaWAZiV/gOM7
         aGzJQrQgGmc8dNQLpxltgheHhJQAEhHcZsAR0qjZXEGRLSOFVIhejChQaGgjt3p29oaQ
         PKikzKKUHAcdJj/buattmAQ/SNCSUvC2TflHD0IzbC7jPwrnE4EHW4CCfCyOTdK/9ybr
         Fat0CcweqkaKbdDcHwo6hWs1NYjyshBqzt7NcgWnt0cq3IyubvJOEobHt3AHmVE742NZ
         uJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ipAhlw5WrsUU5opUi6Qmf1XgM2Fq+bPWZGrkUnEi1PQ=;
        b=s01beADt2qqSnp2//0xG5Dn9HBwMbx+4mXwrgiz157G4moD85+s2eOiyDZFmI/YPE1
         IhhIPhguGvnC4RHieTWuvVKXa9zR0xWFoNEK4sRJ3t5lLIIAHLaF9/S5QZd35juRcRI2
         R73/1FFsc0p15LvG+fX4GzI+IJWbAaAal6QYxz//xA781Judca5cc5keu9clPQ5bkKuL
         tLMrk9DUswg0Yi7UaJpsHA0nT+6NPHRUpfugPSldJy8549vkGn//t+dzHMI/OtuHYdPX
         sFpiahE78lDjvS6UUnWC7PY2Zn2At+kMmJSVZ5Mn1iISmG/5y3d4eSfKcQM0VYkWQyux
         iZbQ==
X-Gm-Message-State: APjAAAWteGQh/NKBPGHMBWTLVvUgws4YpNbNQtASB9gFZW2b0tO/V0D5
        vLvRn+7cSMKjnTqw89imVEAvFO3K
X-Google-Smtp-Source: APXvYqzleHkzLuuK6EbthbsR8W7Ckozvij4yX5QVnZMianpMTeoYoP7+KcICZDn/XgokllSTiDsNzw==
X-Received: by 2002:a17:902:9a08:: with SMTP id v8mr19262721plp.251.1580678357623;
        Sun, 02 Feb 2020 13:19:17 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id y24sm8755639pge.72.2020.02.02.13.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 13:19:17 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE), Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Jeffery <andrew@aj.id.au>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH 12/12] dt-bindings: arm: bcm: Convert BCM2835 firmware binding to YAML
Date:   Sun,  2 Feb 2020 13:18:27 -0800
Message-Id: <20200202211827.27682-13-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200202211827.27682-1-f.fainelli@gmail.com>
References: <20200202211827.27682-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Raspberry Pi BCM2835 firmware binding document to YAML.
Verified with dt_binding_check and dtbs_check.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../arm/bcm/raspberrypi,bcm2835-firmware.txt  | 14 --------
 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 33 +++++++++++++++++++
 2 files changed, 33 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml

diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
deleted file mode 100644
index 6824b3180ffb..000000000000
--- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-Raspberry Pi VideoCore firmware driver
-
-Required properties:
-
-- compatible:		Should be "raspberrypi,bcm2835-firmware"
-- mboxes:		Phandle to the firmware device's Mailbox.
-			  (See: ../mailbox/mailbox.txt for more information)
-
-Example:
-
-firmware {
-	compatible = "raspberrypi,bcm2835-firmware";
-	mboxes = <&mailbox>;
-};
diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
new file mode 100644
index 000000000000..4ccbe3bf616c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/bcm/raspberrypi,bcm2835.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Raspberry Pi VideoCore firmware driver
+
+maintainers:
+  - Eric Anholt <eric@anholt.net>
+  - Stefan Wahren <wahrenst@gmx.net>
+
+properties:
+  compatible:
+    const: raspberrypi,bcm2835-firmware simple-bus
+
+  mboxes:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: |
+      Phandle to the firmware device's Mailbox.
+      (See: ../mailbox/mailbox.txt for more information)
+
+required:
+  - compatible
+  - mboxes
+
+examples:
+  - |
+    firmware {
+        compatible = "raspberrypi,bcm2835-firmware";
+        mboxes = <&mailbox>;
+    };
+...
-- 
2.17.1

