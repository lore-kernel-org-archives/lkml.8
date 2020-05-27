Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9776EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BE3D20899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="w4AqbP6F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mf09Owfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389808AbgE0Pph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:45:37 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:46111 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730427AbgE0Ppb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:45:31 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1402F581DB5;
        Wed, 27 May 2020 11:45:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Qm04qMuBv7fTr
        3XQL3pQXZGC/epnrC5zo/RIT1dLqig=; b=w4AqbP6Fx3bkqMTIIxC49dmDC1/iE
        cWFsjCA1OPveXcYYVnbrOP+8Oi9aRobj7RSrmm+NIg8i7OCT8bswzlpe+JgUpFaa
        z5gy/b9TDd//QgpoUy01DMuHZ/M3YsgfZTu5Qm2ZgZ5P5Y0+fvSzid7yXZRyj++X
        JoNqfJrhQY6XWNT1dpXjSll0oThTzgQhFtY4B5T11VKcSBwaOgmN9UyZWoWqv2XT
        5JFVmZmKiuaqNE2WOu4RSPj2x4moJj3lE1gjZnHhIEzlEO4US9qGjAJqKOyYnWsM
        uEDDJ1E4XukGgfu5enFFM75N8OdPyR4/xz3sjY01L9gaPvWacy8C/h9dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Qm04qMuBv7fTr3XQL3pQXZGC/epnrC5zo/RIT1dLqig=; b=Mf09Owfc
        KKfh0rDn2rIcDV7vUKI+xDVRezuPkBWV7JIBJTTIMzxkS9cBbTDcqrDCY7H8ypjX
        75OUJDbvTMql0I3TkzXIAq0xiVESBOaPi3ghRi3qFuZY3FbbXUQ7YeUm+3EqwIff
        zZ95rJ2yiefhNbv9RiLNa1xnZ0NzV3e+eZ/czvK7W4oIfR/AhYCy8/ZG/FgIAhBY
        7VOXH3AlluAa5I9IX2p4sU4hi4NJQA62qlDWT7z84WsHScy/VysNqTJv1tYpuLsg
        ZM/oLnpPu4UElbpV4kWcM+47tg0h9J2A9Ywv75UnX1jFlYulwKC5I2clPsXXnFCD
        LVCoJnNR0JVAJg==
X-ME-Sender: <xms:GYvOXge7xsZKTiC23ggjl6y0ZfgG99KD-7IUqd1vV1Z2_3JkbzCDPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:GYvOXiMIEPOip-l58CNC8InHUNvlHf_VkEJrBI-TkfCnsVYBdaBC8g>
    <xmx:GYvOXhhBx7ZtgBBv11j1uj2Mb8F0YUVrqs8YHHI2O7fdjXeSwQPrmg>
    <xmx:GYvOXl-zVe6uNdYCtWoZIxjIsfU9LXmIG5cLjGgMsm75eDNPmYbFHA>
    <xmx:GovOXtkY-vt99xFFopPmMhIXIpL-efiUrLSZ9wrLWut18vV4G3nMLg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A8DC53280066;
        Wed, 27 May 2020 11:45:29 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 02/25] dt-bindings: clock: Add a binding for the RPi Firmware clocks
Date:   Wed, 27 May 2020 17:44:58 +0200
Message-Id: <919e2f2f13583d4d53d0e95b81fc3fb8a7606107.1590594293.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The firmware running on the RPi VideoCore can be used to discover and
change the various clocks running in the BCM2711. Since devices will
need to use them through the DT, let's add a pretty simple binding.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-clk@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
index cec540c052b6..b48ed875eb8e 100644
--- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
@@ -22,6 +22,25 @@ properties:
       Phandle to the firmware device's Mailbox.
       (See: ../mailbox/mailbox.txt for more information)
 
+  clocks:
+    type: object
+
+    properties:
+      compatible:
+        const: raspberrypi,firmware-clocks
+
+      "#clock-cells":
+        const: 1
+        description: >
+          The argument is the ID of the clocks contained by the
+          firmware messages.
+
+    required:
+      - compatible
+      - "#clock-cells"
+
+    additionalProperties: false
+
 required:
   - compatible
   - mboxes
@@ -31,5 +50,10 @@ examples:
     firmware {
         compatible = "raspberrypi,bcm2835-firmware", "simple-bus";
         mboxes = <&mailbox>;
+
+        firmware_clocks: clocks {
+            compatible = "raspberrypi,firmware-clocks";
+            #clock-cells = <1>;
+        };
     };
 ...
-- 
git-series 0.9.1
