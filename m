Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FBEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6A53207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UuIMApBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405802AbgFXRuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:50:52 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46680 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405783AbgFXRus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:50:48 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05OHo6po045222;
        Wed, 24 Jun 2020 12:50:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593021006;
        bh=nvx312mv4VGvwwIjEoy4EfaLo8OvbsRscw5gPQDVBlY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UuIMApBCFrsUafHq38CHPN33dwMXPgJNpII9lsNB6m/ijyTl7/XrdhB3EO6oviq04
         zDezPyB3xAPVKVjR/PivPaJHGkJU88Y4yOfBCvPL5y5TyVW//ffKkmWPDYN2BJjzGQ
         59XUJNwvW2d/2O4ADpmouXYgrB7o27LJwnT9Qa2o=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05OHo6R6065119
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jun 2020 12:50:06 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 24
 Jun 2020 12:50:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 24 Jun 2020 12:50:05 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OHo5r0120431;
        Wed, 24 Jun 2020 12:50:05 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <devicetree@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v6 5/7] dt-bindings: tas2562: Add voltage sense slot property
Date:   Wed, 24 Jun 2020 12:49:30 -0500
Message-ID: <20200624174932.9604-6-dmurphy@ti.com>
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

Add a property to configure the slot for the voltage sense monitoring of
the device. Vsense data will be sent to the processor via the slot
defined by the property

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/sound/tas2562.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tas2562.txt b/Documentation/devicetree/bindings/sound/tas2562.txt
index fd0ac8636c01..dc6d7362ded7 100644
--- a/Documentation/devicetree/bindings/sound/tas2562.txt
+++ b/Documentation/devicetree/bindings/sound/tas2562.txt
@@ -11,6 +11,8 @@ Required properties:
  - compatible:	   - Should contain "ti,tas2562", "ti,tas2563".
  - reg:		   - The i2c address. Should be 0x4c, 0x4d, 0x4e or 0x4f.
  - ti,imon-slot-no:- TDM TX current sense time slot.
+ - ti,vmon-slot-no:- TDM TX voltage sense time slot. This slot must always be
+		     greater then ti,imon-slot-no.
 
 Optional properties:
 - interrupt-parent: phandle to the interrupt controller which provides
@@ -30,5 +32,6 @@ tas2562@4c {
 
 	shut-down-gpio = <&gpio1 15 0>;
         ti,imon-slot-no = <0>;
+        ti,vmon-slot-no = <1>;
 };
 
-- 
2.26.2

