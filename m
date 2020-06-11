Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E951C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B5E2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="ps0RS+sf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UUh3cfYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgFKHc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:32:26 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:41999 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726706AbgFKHcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:32:24 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id CCED55800D2;
        Thu, 11 Jun 2020 03:32:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 03:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=Br6jNHTz2Qqeu
        hVMkqvSgmOdnA/EpKz1fVYzAs6ZIJ8=; b=ps0RS+sfRDCBjfGJJi4lth4vMDQ33
        mc7mhLCoAq/CZr24SwyRZHStCZNjov4k36l7Y/RCJt5U2vX8kE2gDe/n9y5vTMaA
        tQUZAkUQXZ2sm5P79GisJSLwwg13Q99O2CJ9HtShNitpfRu+lwBzEE82UUMfOVYE
        1RICM/CaqOExBe754u9pHNVmkClWEKRkBD49A9+i/FMmNj6XpW7PQZj17XFe44uC
        5uhnR+QM365GvozZpBFxDTcMYULdargjvLpn8n+qnkYuvCPbtAlnG3fmhjVih/KA
        OxFTmUMC7morcFBhSP8Qpa6m1rLqjq8FU/AEY5TIeEM0AUkpkDvRpkH2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Br6jNHTz2QqeuhVMkqvSgmOdnA/EpKz1fVYzAs6ZIJ8=; b=UUh3cfYb
        KfntAf1DplVt+Dr82k5iNzl7HmJInXQgRk6pcY3m6c9ywwERxL598sNzVwFFEpLK
        jvOGPwLdCmo0+eVXPb+GdOWpTWAJN584YdgJ2IBtX1wbsOa2o9ZXw84g7yYASgVe
        EMmy0ttIBtbpUgTnjbnC2Qb4jn6/7cWvbb8xnQB/ztighFDPdURdNsXWGzsiHEH5
        MqkqpkPLQaQPJ12MrOKhXGyBuWv/ENdmYBb/nhn2Ju18CiLqvey5jkaalvdwVWyF
        /2piOZt1AefZq35MDE5QkBS7t2XjqUoNjxFXTGxflEW1t5YPfHjCKZxeMfBegfhK
        dFMZWnsyz4nb+A==
X-ME-Sender: <xms:Bt7hXvhR0dMkNhL9zp2ps1_kNx7-EBc5gTydgGdA89Z0hAEWcBl7_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehjedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogevohgrshhtrghlqdfhgeduvddqtddvucdludehtddmnecujfgurhephffvufffkffo
    jghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomh
    grgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrthhtvghrnhepveejieejtdev
    gfffgfejuefggfeutdelteekgeetueeftddutddtgfffhffgueffnecuffhomhgrihhnpe
    guvghvihgtvghtrhgvvgdrohhrghenucfkphepledtrdekledrieekrdejieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestg
    gvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Bt7hXsDSWijE2AlSsaNQNj7O2xx6Wcr0Rx8Es7W__KirMYYoy2_zVg>
    <xmx:Bt7hXvGTZIhOEz3fUjJdUELzOxEu2F_j7BV6foA-yry798OVxjGAww>
    <xmx:Bt7hXsTvzBT3vZ2qrVkyypR4EDZcL2soVLsh-GDi42IZ5H_0dMgTtw>
    <xmx:Bt7hXoeJzSMNtCj5V0FunGTRt-uSoiqHbq-R5neJZPKhm_8HciRBuQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 69A4D30618C1;
        Thu, 11 Jun 2020 03:32:22 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v4 01/27] dt-bindings: arm: bcm: Convert BCM2835 firmware binding to YAML
Date:   Thu, 11 Jun 2020 09:31:50 +0200
Message-Id: <2c7d516ab35742171561088fc376b132ea8ccfa8.1591860665.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
References: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

Convert the Raspberry Pi BCM2835 firmware binding document to YAML.
Verified with dt_binding_check and dtbs_check.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt  | 14 --------------
 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 14 deletions(-)
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
index 000000000000..cec540c052b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
@@ -0,0 +1,35 @@
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
+    items:
+      - const: raspberrypi,bcm2835-firmware
+      - const: simple-bus
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
+        compatible = "raspberrypi,bcm2835-firmware", "simple-bus";
+        mboxes = <&mailbox>;
+    };
+...
-- 
git-series 0.9.1
