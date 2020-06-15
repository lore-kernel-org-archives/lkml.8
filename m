Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83ABC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 975CD2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="HgHswBun";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="leTiVQkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgFOIlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:41:25 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:40995 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728593AbgFOIlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:41:24 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id A8281580152;
        Mon, 15 Jun 2020 04:41:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 15 Jun 2020 04:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=ahwKxryje7yYY
        JgNWO5F+i8OgzYhgmjWgkqak5/geXk=; b=HgHswBuntG9g6N2TV/djTiR4LPhfg
        QtZlJ4FXQRZbTRGdWcBenTvZDFNVSpHubUISRkW0i2aHxYWu/2F5O9muEng6hT5t
        U4veHv3Q01VrVfvPi6ljeVUSHr04HLNbGgz8IhzAKbPXLTWFDBqow7UQEaway8/V
        AJ6pcS3MQBxaofL9Mh4E9RorFTdTdzPy5LG2C0OdSYO3rRxJT5O2QheyjAK7T1CH
        51Mj4RFt3B1xvMSokDuVpSi+p5QCUKv+bwr1ercvaGJ4mCYhCRJtlQ9bYONsoxp+
        AUHZ/9g3SNB52i2FmS6yGLzqKlOammVKZDIgPFmIbc7e2HjoOq2wC6f1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ahwKxryje7yYYJgNWO5F+i8OgzYhgmjWgkqak5/geXk=; b=leTiVQkd
        xEScMXIxp0yiJnxzcsHBf0ztX9tTzQfasomtNnWv2AdeQHcbp+TIzMkRky9VvrBr
        pRmNkeuYWtb+17sbnV4m+WAYBcL1cinLvbaeGVnV8qGLempx5BPzIz97mNh6mqfC
        7XEp1HDs2x3cL9Dd0V03nK8qPvYE6fpC++tpUgWr63lWTqSZk2AllLTroVvZ3xF8
        z4mrai9zglmu/KViUPpVZvT4qQRhlpSRYWGZFTBklV8SN5atHX93YR9x7Zx+du02
        FOm3pvjwhceDCZN8RpIblpnX2pUMEhF6wUKHLniltqDrzMgVPndKVPfRTwxGNT7z
        E+BojTp61F9+sA==
X-ME-Sender: <xms:MjTnXsx1H_uh_-I7UjuZJTo2JraW0bRZcUmJ2H1JcYoawI5lNSggmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    govehorghsthgrlhdqhfeguddvqddtvdculdduhedtmdenucfjughrpefhvffufffkofgj
    fhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrg
    igihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtthgvrhhnpeevjeeijedtvefg
    fffgjeeugffguedtleetkeegteeufedtuddttdfgfffhgfeuffenucffohhmrghinhepug
    gvvhhitggvthhrvggvrdhorhhgnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvg
    hrnhhordhtvggthh
X-ME-Proxy: <xmx:MjTnXgSMQPhQko92Vko8E0GdNWk8AwJYGUEUKh3l7ASwya00DWaqCg>
    <xmx:MjTnXuWNVzTnz39zFri7EIUlLodxMSnJm8QrBdX595XHYb491fQmyQ>
    <xmx:MjTnXqiUwpyVIq_tTU7vjUQ9bVu5Ek04iRq5DcdaaMTyQdnrlsWy7w>
    <xmx:MjTnXi5KcgSF2wnUI-z5wmuGE2eb6t_BLfUU8DIJyvzgOfA9Ss5icw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C26CD30614FA;
        Mon, 15 Jun 2020 04:41:21 -0400 (EDT)
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
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v5 01/27] dt-bindings: arm: bcm: Convert BCM2835 firmware binding to YAML
Date:   Mon, 15 Jun 2020 10:40:41 +0200
Message-Id: <5bc0b9be8544b07300fccab4d4f26e5e5d8e62b2.1592210452.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
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
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
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
