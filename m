Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAEDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 749EC20738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gFgcK8MR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405032AbgFXQPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:15:55 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45994 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404802AbgFXQPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:15:51 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05OGF7wQ005227;
        Wed, 24 Jun 2020 11:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593015307;
        bh=kULjw8GNfWNWdNFzaMSzkxUfYNEK2eh4pWXT0B+D/Fs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gFgcK8MRCPE9fct1j+GmNSWiv5ZW9Lz9BoVUj7qVmrDDkUgupFAqxaA1WCV7pLOzR
         4RmwYdMHmq1MK9h4TqBxrwvBnU0juTSVayp861LWpwONn3Mxd//zgQYRtkinOEGbL4
         Ae4Mkvt9chYQi33z2IDC3I1KTMaSU/QHiJvM3QU0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05OGF7se052319
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jun 2020 11:15:07 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 24
 Jun 2020 11:15:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 24 Jun 2020 11:15:06 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OGF6C6079177;
        Wed, 24 Jun 2020 11:15:06 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <devicetree@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v5 1/7] dt-bindings: tas2562: Fix shut-down gpio property
Date:   Wed, 24 Jun 2020 11:14:53 -0500
Message-ID: <20200624161459.19248-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624161459.19248-1-dmurphy@ti.com>
References: <20200624161459.19248-1-dmurphy@ti.com>
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

