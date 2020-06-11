Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76511C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F42C2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="r5DVazx4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VVw2ZRu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgFKHcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:32:33 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:39395 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726679AbgFKHcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:32:25 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5E0E35800D3;
        Thu, 11 Jun 2020 03:32:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 11 Jun 2020 03:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=BfQY97l1HsXaR
        odKqHBN4T2fOtec0sfUBI+DC279bkI=; b=r5DVazx4b/zznaw0bm32egqnPoCZd
        9y/X1aY6V2dMm1jZGwXky3C+4YMxH6y8PL//GSB/OnwfPXrJUYG7TP0jt8D3Yo/f
        kaP4WSBXhS4JguKMuL6vMrh7cvT6pRfJOoroVh/3OYuW0cHZYmw/2Ozv1Ua0kFox
        t2y0uRfCbdb0AiLaMggoIiOfKYKZ0+eYgKYVO8DIuXvTQKHJDOapbVpNKMmqIFo6
        H4psYFTqwF6YwuQzrHJtOc/WfCjWLDfnHkaZYhw9OVjqIK0mjSTHthxv9AZCliUC
        xoU+R3FoI03+2kJ03JK5nwrPj6G88Qn8/ztgAwzCwdyj7E5jNBvWs+P0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=BfQY97l1HsXaRodKqHBN4T2fOtec0sfUBI+DC279bkI=; b=VVw2ZRu5
        jZCOCEopZHPvFtuCw2Npoo+1FA0g7Qcu741nTjNlsMH8BSVzEwva5EDWfT+AxDVa
        EfAxMmjgfIsvOr2/221kF4pl8sJ3pgncuaHVfKZcwE0nocmLbSakA7W2I9vMvNJa
        yyjshetZw+S/aTnTRrDU0xcmdBRpHspql7lzuLbDHRBuMJF3xVTlyhAnDs4kQTNB
        ExEzRX28FD0JyxvDYhLTNSRpejnNBPUa6jsRqd4TldMeZlnJlhGc1fmzCK0m76lD
        R1p++lGLDKm6/8xGAxgEzVYhVgmzXbHbG1M/hz+vbzUc1l5hCUqwsDV92Lm0718N
        lqvQZbqjGh57jQ==
X-ME-Sender: <xms:CN7hXraqN86mguhldCkmxU-lSoSMq_OBgsW1V_GYcMZ_pBlW-CJ65w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehjedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:CN7hXqZP0UzqbkDfILyoMETjGP2LQ7JvPjGjoHILKgCd5kWzaQYPMA>
    <xmx:CN7hXt9lFhtOQB8l7dscJ_btXZLLo6a9H0r3W0j--YWYnekxGp7w3w>
    <xmx:CN7hXhomhzgUDMpaZV5O-sq3KUQnBvKD2_mqzIiqihOeZmOL6XtLPw>
    <xmx:CN7hXjgaur-FEMqyCSU_kENEY_1kROJK-qvgS4HMbJQCWw6AfGCDOQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 02C4D3280064;
        Thu, 11 Jun 2020 03:32:23 -0400 (EDT)
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
        Maxime Ripard <maxime@cerno.tech>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 02/27] dt-bindings: clock: Add a binding for the RPi Firmware clocks
Date:   Thu, 11 Jun 2020 09:31:51 +0200
Message-Id: <17ccd4479a13587c372f57420a5901cd1f673809.1591860665.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
References: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
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
Cc: linux-clk@vger.kernel.org
Cc: devicetree@vger.kernel.org
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Rob Herring <robh+dt@kernel.org>
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
