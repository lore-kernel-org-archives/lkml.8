Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F299DC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71BD2082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gW+SLLfP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgBEAH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:07:57 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:43851 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgBEAHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:07:41 -0500
Received: by mail-pf1-f181.google.com with SMTP id s1so186973pfh.10;
        Tue, 04 Feb 2020 16:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CWkZ+hPOQw0CLt3DIMXNZXqIluJmIb2SwavOv+rxo54=;
        b=gW+SLLfP8z3aWyWKk+jfFvgADyBQ0AnrBjjwgje8s7KGIEgrE5fPGKZRU37oxYh+L7
         8qQ+Gy+9cTbJVQpwrvWjAi2YRCFNzeO3lULRFYyoLLuiTjjpzDbbCxWs53qhsSjgERXs
         uqyO1jRppMX1MauyHDYnyXsZxC2hzDP8zr3Pos1qw8YDFzqGxC/jA3whiTiAHlHKd0Af
         qm+oUdzthXzT/DCAOs6AGUV16p85tZQ4m2lmHP8uSRgsFlFxm/uvrAzltOy3fGa7OTWJ
         wJaIJRogqoFNWZB+VXnY3elETVaL9c6lWkokNLSzocYUXTavcxI1ez/vUG5k0OEyO3YS
         N2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CWkZ+hPOQw0CLt3DIMXNZXqIluJmIb2SwavOv+rxo54=;
        b=WGf05H2CZn5ZoqJMS6KtnuSUa2RHn7EyNIUkZzhznpAA5jnrxU2Y2Njt4htXsMgw0n
         A4tPqiFdmQjTiz37DZDwtcpb3+FnknIVfWO2zQQiyxcXBAKr6mfk5Tdowk7Pk1my2+6D
         KJ/StJumJi3M0ZHwa5ue0OPKJgqfjAAa85O7BsXqeSI0r03UzgwhsaA9DvHITaZTiFFV
         Yy+5idzGqWtkKhFySkngY9nE/T0Zor2T6Dx3tbh3a9ZiNn41TbuqMeZnS/rmgHWucVzy
         Q+f1ZePkbQiufKLsHwfQqFf+xMQlkKTAQGuRyXOq4x6KmU44wD0bXP+ntcU2jeMhUXAp
         1tSw==
X-Gm-Message-State: APjAAAUzGCuO2TqRv/pMOQ2ZGB17mLc1g2W0YOCDtpM21FhCon3sCzkD
        vNUnUeM+Vg9WCP6b72ckDmY=
X-Google-Smtp-Source: APXvYqwzuaFZnoTtVrOKEsVT2qZTwaiz5vwrkRG1cX+LtJZGGmTzCfmaY/I6bRFaxWHqaDcaSKVEiQ==
X-Received: by 2002:a63:4525:: with SMTP id s37mr4520697pga.418.1580861260751;
        Tue, 04 Feb 2020 16:07:40 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id g2sm25575468pgn.59.2020.02.04.16.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 16:07:40 -0800 (PST)
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
Subject: [PATCH v2 09/12] dt-bindings: arm: bcm: Convert BCM11351 to YAML
Date:   Tue,  4 Feb 2020 15:55:49 -0800
Message-Id: <20200204235552.7466-10-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200204235552.7466-1-f.fainelli@gmail.com>
References: <20200204235552.7466-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Broadcom BCM11351 SoC family binding document for boards/SoCs
to use YAML. Verified with dt_binding_check and dtbs_check.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/arm/bcm/brcm,bcm11351.txt        | 10 ---------
 .../bindings/arm/bcm/brcm,bcm11351.yaml       | 21 +++++++++++++++++++
 2 files changed, 21 insertions(+), 10 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351.yaml

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351.txt
deleted file mode 100644
index 0ff6560e6094..000000000000
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-Broadcom BCM11351 device tree bindings
--------------------------------------------
-
-Boards with the bcm281xx SoC family (which includes bcm11130, bcm11140,
-bcm11351, bcm28145, bcm28155 SoCs) shall have the following properties:
-
-Required root node property:
-
-compatible = "brcm,bcm11351";
-DEPRECATED: compatible = "bcm,bcm11351";
diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351.yaml
new file mode 100644
index 000000000000..b5ef2666e6b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351.yaml
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/bcm/brcm,bcm11351.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM11351 device tree bindings
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+        - brcm,bcm28155-ap
+      - const: brcm,bcm11351
+
+...
-- 
2.19.1

