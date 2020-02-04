Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE91DC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25912085B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FduV5e7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgBEAHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:07:52 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37362 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbgBEAHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:07:46 -0500
Received: by mail-pl1-f193.google.com with SMTP id c23so89005plz.4;
        Tue, 04 Feb 2020 16:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rNgHMA6kv0sEkVkQCHv5m/SCpI5yps7HvaSz94olJGw=;
        b=FduV5e7HHuIFti5m8veUplRlVddJCO+yldY9RyI4aJLl69t7Q56G9YCzNz/5uK2rqh
         uKV8J0rtb6IsQZpQj95xIZ0wHnhuRqQVM4HjKZ2u/qr0vxDj+isgnnCifl7sg1xzlQWr
         PlJ3X/0IlWdSc99RZlKgYNXmhV2KLNP/JaR3Bs0IkRqbERYO4QdyrhsPfCf7dHO2eeQU
         uQJyJI6YD5YU7LqywP5PA4CYVKAhQpV+7t32Qo4gBLRt8sLQVF9IgkqYZqiwXoncausw
         43fG6VTKvbGo8RYi8IciME75p7KCcnjY1FKx3T6GuRvhxlDM/Q1/f6M58xTQ/zYu+NmW
         cnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rNgHMA6kv0sEkVkQCHv5m/SCpI5yps7HvaSz94olJGw=;
        b=jB/5SgdS2dtW2xAABstsU6Rbi0IcIw8DF9jyU9bHGlwYx6fOKfc+niV52oLFN5XLN4
         f8WToZA25AG4MjFbhIuUpranCpM0+B5AIT+VmXeiAyWH1uTNcGO/hqWvUV5tdagLqEd9
         z3D/pEByTGv/qt4lnzyH36V0V47avpkTBFXz/U0UWO1fNmNxIffdPU6JmlWP5peKYSah
         0VPRZ9gIykuGn6XpLVK3thvNbzKkxZP2tHANynUNOtosH3+rrutzp6bwn30WEGvb9i0s
         T/MmD62Wght8bic3hxU3Q0Y+biaBOn2LunsLdW8AdYGqS3EizNIzARLj3qSheU/1hocO
         yq6w==
X-Gm-Message-State: APjAAAUfofwErPIn5fLUOztRFuLe/dSUK35zSocrfcVEnu4GR+LP54FX
        yTrVZgJTi1IaBxSWgRR58gc=
X-Google-Smtp-Source: APXvYqzHjGGFyqHeoAwdAmsvIQYeZobj3KRq8ev1PClEsjo0BTz7/NwXacj13yx/it/VHATevfm1Lw==
X-Received: by 2002:a17:902:9a42:: with SMTP id x2mr33932389plv.194.1580861265516;
        Tue, 04 Feb 2020 16:07:45 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id g2sm25575468pgn.59.2020.02.04.16.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 16:07:45 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE), Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Maxime Ripard <mripard@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "james.tai" <james.tai@realtek.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH v2 12/12] dt-bindings: arm: bcm: Convert BCM2835 firmware binding to YAML
Date:   Tue,  4 Feb 2020 15:55:52 -0800
Message-Id: <20200204235552.7466-13-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200204235552.7466-1-f.fainelli@gmail.com>
References: <20200204235552.7466-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 000000000000..db355d970f2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/bcm/raspberrypi,bcm2835-firmware.yaml#
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
2.19.1

