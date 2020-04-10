Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DBCC2BB86
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2D0212CC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1v/yv6Xu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgDJQn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 12:43:59 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:9933 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgDJQn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 12:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1586537039; x=1618073039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=9JkGRbsYg8+toGigTFajLnO6Iqv3gSiy36yunV6MGXk=;
  b=1v/yv6Xuh2f/hasCpnepUxgfqADwsK2iVVYU7OMEiOgM3O45x/M8Z/50
   jc05xrRDuDmfDf/3+OdY3hIDQSHq1d6QuxSJalpghdiWwjN+FmGdTk7d9
   coHDLFnwvYiTPmlMZDe1DmLAvv8hOGT2bNU/319yKCchtDDfqnoGSEWEB
   PlpezhYiiQd8AfRjP9Qf6Fkd9xbjP3u5BtoJcy7kjYma6DIyVLxLOYdOo
   iuvCBw3cZ/oklo3neuV/kHHukTdeS975ilKFFfHqG8lcpz5b2cEa2T8RJ
   NowXNl48qlVzjptgso4nyA/3FUihfKFsr4Cu8+eAAZxGfzgS55Vu227Qc
   g==;
IronPort-SDR: S3lrHUeKtizTNWra8RBdu462rrubxfkJPQCrTyMgrINmO8RxzE1g+MhdMcKDiOycvSGUVStFXl
 gharLAsCNX/T1LE+mL9RajmFGqyCtXm7gcEYubpm9UWx+QHRDw30nhn+x4tGR5lJ7LwNUol405
 gFMbnjKZyP5MHS+nT0MJvFzQdlIE462v3AEiFcLsL75i6VSJmkbh6U1pJRymMPoc93iOu6rv47
 l7p4IrMK5uLLy8waA6Syv8SyNWEkWfyMBOE7pbYC7b/PBtFPZMVZOSnwfG+mOyJPeGN8Jo3z6e
 m9s=
X-IronPort-AV: E=Sophos;i="5.72,367,1580799600"; 
   d="scan'208";a="75501666"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Apr 2020 09:43:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 10 Apr 2020 09:44:09 -0700
Received: from cristi-P53.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 10 Apr 2020 09:43:51 -0700
From:   <cristian.birsan@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH 1/2] dt-bindings: ARM: Document SAMA5D2-ICP
Date:   Fri, 10 Apr 2020 19:43:19 +0300
Message-ID: <20200410164320.7658-2-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200410164320.7658-1-cristian.birsan@microchip.com>
References: <20200410164320.7658-1-cristian.birsan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

Document device tree binding for SAMA5D2 Industrial Connectivity
Platform(ICP).

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
[cristian.birsan@microchip.com update board name to match silkscreen]
Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 0357314076bc..31b0c54fa2cf 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -82,6 +82,13 @@ properties:
           - const: atmel,sama5d2
           - const: atmel,sama5
 
+      - description: Microchip SAMA5D2 Industrial Connectivity Platform
+        items:
+          - const: microchip,sama5d2-icp
+          - const: atmel,sama5d27
+          - const: atmel,sama5d2
+          - const: atmel,sama5
+
       - description: SAM9X60-EK board
         items:
           - const: microchip,sam9x60ek
-- 
2.17.1

