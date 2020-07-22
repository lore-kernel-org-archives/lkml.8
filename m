Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E34AC433FB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FA2F20771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2mNk1t3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732581AbgGVNpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 09:45:04 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:56885 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732510AbgGVNok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 09:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595425480; x=1626961480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JFzmp3IpT2/vSAdFB2tkC7kXSDjHPZkrYg58Jnu3Ns4=;
  b=2mNk1t3xt2H4Av1TvZ44c3zedYzUEYvkphKPu6JwjL4wydpystUY/3aW
   MS+LbxErt0b8aqJoGpIjvByiJDZNsK8Pu5bGBagZg54qxAc6k+vApRB4B
   wl8jXIzms54IllJVmcB3qZubLAEuH83d7VbTABYVKT9u3ySYXgZ1yQJEr
   ohKpBbzGvvrAUOZJAN9ke8k59t3KRdO7vF7B7l5l910yTMuVLn03D3DtI
   /P7Hu5QP/vlxuvpUxDr1Gf406wsaGOAokX1NarvXU/T6VmP97I+OYBJWJ
   SrmBLal6KQjrk5g9WMRcmswPEICHFXvH4ziu8mC1UucNufEsN87HaBYN0
   A==;
IronPort-SDR: GXI+AelBLfDF4k+vg4jPexQSY4dmsVzVsrIyDtwSkCHaEO9CNQK90IdR5elR1COg+J1keBMh3W
 skM/d1jPPOLqTTn2lUYjFABaaB+eRdeWPZ5sMB+OjsQWB6LkYCGDFzOok/V8Vs982cNp45Sp7Y
 9EfKFLFkx+m40AsUVZ6JyWT1KIlbdLJYVyKBs3XKoaGigFSUVLYSyV845BBbLQv6ath3ow8PD0
 yOl87UkwswFC4KTXLDkFkx2bjb/Uyt04gnEK903G+/Ba0ULMvjHpSpCe7tg5FKAr3PUSOkydMG
 lsk=
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="82819489"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2020 06:44:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 06:44:31 -0700
Received: from cristi-P53.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 22 Jul 2020 06:43:50 -0700
From:   <cristian.birsan@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Cristian Birsan <cristian.birsan@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/6] dt-bindings: usb: atmel: Update DT bindings documentation for sam9x60
Date:   Wed, 22 Jul 2020 16:44:17 +0300
Message-ID: <20200722134421.190741-3-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722134421.190741-1-cristian.birsan@microchip.com>
References: <20200722134421.190741-1-cristian.birsan@microchip.com>
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

