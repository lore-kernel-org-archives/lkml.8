Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D66C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 854B82145D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H/Fy23zn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405764AbgFXRuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:50:25 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33032 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405556AbgFXRuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:50:25 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05OHnho6062623;
        Wed, 24 Jun 2020 12:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593020983;
        bh=kULjw8GNfWNWdNFzaMSzkxUfYNEK2eh4pWXT0B+D/Fs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=H/Fy23zn1NqDybmM73ewTSCcoaz0B8fPFUVmsLeSba1Mt2M51JHSZEX86z02VWAFw
         nE6Zv7gmPe+0liXImGeWxlWP5xuYFVefa9eE/oCbP14BMyWm32CbYSyiAYjWdZSgcL
         z2u4s58MoqqRA3Wn07ZH4BtWVH+C/07S+HbwuALE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OHnhXo081997;
        Wed, 24 Jun 2020 12:49:43 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 24
 Jun 2020 12:49:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 24 Jun 2020 12:49:43 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OHnhee035721;
        Wed, 24 Jun 2020 12:49:43 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <devicetree@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v6 1/7] dt-bindings: tas2562: Fix shut-down gpio property
Date:   Wed, 24 Jun 2020 12:49:26 -0500
Message-ID: <20200624174932.9604-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624174932.9604-1-dmurphy@ti.com>
References: <20200624174932.9604-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the shut-down gpio property to be shut-down-gpio and fix the
example.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/sound/tas2562.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tas2562.txt b/Documentation/devicetree/bindings/sound/tas2562.txt
index 94796b547184..fd0ac8636c01 100644
--- a/Documentation/devicetree/bindings/sound/tas2562.txt
+++ b/Documentation/devicetree/bindings/sound/tas2562.txt
@@ -16,7 +16,7 @@ Optional properties:
 - interrupt-parent: phandle to the interrupt controller which provides
                     the interrupt.
 - interrupts: (GPIO) interrupt to which the chip is connected.
-- shut-down: GPIO used to control the state of the device.
+- shut-down-gpio: GPIO used to control the state of the device.
 
 Examples:
 tas2562@4c {
@@ -28,7 +28,7 @@ tas2562@4c {
         interrupt-parent = <&gpio1>;
         interrupts = <14>;
 
-	shut-down = <&gpio1 15 0>;
+	shut-down-gpio = <&gpio1 15 0>;
         ti,imon-slot-no = <0>;
 };
 
-- 
2.26.2

