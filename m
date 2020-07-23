Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CB5C433ED
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5101A20737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WMSgCIq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgGWStX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 14:49:23 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:36026 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgGWStT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 14:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595530159; x=1627066159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JFzmp3IpT2/vSAdFB2tkC7kXSDjHPZkrYg58Jnu3Ns4=;
  b=WMSgCIq036XwXGdubS78r4Djvzsc1VLODDST9l68cPBgU6y9nKfcSY/8
   AS6PghcqhEMX2nQxnBnS8RXSP3m7x7Gw5B13sRIpoQcNlNrf1P6Z2ZHx6
   Z7oKR1BoDEy0pbsGSXgiIgvrNDpt8lP4pWs6Acfiop3QW5BkoKGAE/k4r
   bqhUcsPQt9hzEMmHlw0FD0apdAJVdhq2iacyicxc+Tt4SCV6qMjOHM47M
   kPewJN0tj3NkOxdiolFsoOmwFBZqwOG3aQmdr9A/Bb1OQBbK0BnhpLVSa
   13VOenuAN2cRGRSgBEQ+oVvkod9qN8xSS6w2JCT+TYUjdnruYRTiUDpyL
   w==;
IronPort-SDR: A+az9Wx44VjLI17HbHOrlcPhNWLu6gYHg9TdM5dwHpEc2DVyWnovX+RWQ92p3DHISlm6T/vm0g
 5SObzmxXxew6cyoG+F9XIGumAj+lYuMfVJl2f3NawD5288htptFlX8+UT3y6pWdgCsNJ9j5sbw
 DnJYXCW01SlHvJxcXgYCD/I5+Awb87UjaTYU2wDj097rWOfLXgZ0n30WuKApurXMmM7coqHEYZ
 TK2a5HUz4LpqD2uBIeiPYrkLoMTDvqT3swCWwiA+52b1OhL1SVIsScMQjeB2mSIDL3qO1SkClE
 dpk=
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="83047904"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jul 2020 11:49:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 23 Jul 2020 11:49:18 -0700
Received: from cristi-P53.lan (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 23 Jul 2020 11:48:35 -0700
From:   <cristian.birsan@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Cristian Birsan <cristian.birsan@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/6] dt-bindings: usb: atmel: Update DT bindings documentation for sam9x60
Date:   Thu, 23 Jul 2020 21:48:58 +0300
Message-ID: <20200723184902.416705-3-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723184902.416705-1-cristian.birsan@microchip.com>
References: <20200723184902.416705-1-cristian.birsan@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

Add sam9x60 binding.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/atmel-usb.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Documentation/devicetree/bindings/usb/atmel-usb.txt
index 423b99a8fd97..a4002624ba14 100644
--- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
+++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
@@ -82,6 +82,7 @@ Required properties:
 	       "atmel,at91sam9rl-udc"
 	       "atmel,at91sam9g45-udc"
 	       "atmel,sama5d3-udc"
+	       "microchip,sam9x60-udc"
  - reg: Address and length of the register set for the device
  - interrupts: Should contain usba interrupt
  - clocks: Should reference the peripheral and host clocks
-- 
2.25.1

