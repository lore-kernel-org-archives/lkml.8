Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0742C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03302082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgAQL6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 06:58:44 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:28377 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgAQL6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 06:58:43 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: yc1ayAgkLGo9iy/xu8fjy78eHGoqCRKIHuSEbluMLdLmvA9VpukdSsXV7JB/ySxTPvRtFNKMiL
 6qBgXmIRNB62mNlaFY2N3p2neo1f4Hd9DQXyQo+S0H26s++9WYdhEv3nr1AAgSxkjDvdPn9pJg
 u3Nu7IzSqiOFT/Q9+m7rMZwwNyjBm+lRULJb1KJ42aTRRR7ij+WJjIgmmOgoJqHLSr2uunufH+
 mHRvZPAbNZ4oTW4ZgHMRZXixw2Lh/NcDxCas7+pq8JQV15thqQyCujcxwZf3WmFv9PE6qk1OEW
 wqY=
X-IronPort-AV: E=Sophos;i="5.70,330,1574146800"; 
   d="scan'208";a="61130333"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jan 2020 04:58:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 17 Jan 2020 04:58:42 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 17 Jan 2020 04:58:39 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 2/2] dt-bindings: atmel-usart: add microchip,sam9x60-{usart, dbgu}
Date:   Fri, 17 Jan 2020 13:58:29 +0200
Message-ID: <1579262309-6542-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579262309-6542-1-git-send-email-claudiu.beznea@microchip.com>
References: <1579262309-6542-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add microchip,sam9x60-usart and add microchip,sam9x60-dbgu to DT
bindings documentation.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---

Hi Lee,

Between version 3 (that you Acked-for-MFD-by) and this one, there is a
new line introduced in this patch:

+       - "microchip,sam9x60-usart"

I kept your Acked-for-MFD-by in this version (with the extra line).
Tell me if you consider otherwise.

Thank you,
Claudiu Beznea

 Documentation/devicetree/bindings/mfd/atmel-usart.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/atmel-usart.txt b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
index 614a14b5d205..a09133066aff 100644
--- a/Documentation/devicetree/bindings/mfd/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
@@ -4,8 +4,10 @@ Required properties for USART:
 - compatible: Should be one of the following:
 	- "atmel,at91rm9200-usart"
 	- "atmel,at91sam9260-usart"
+	- "microchip,sam9x60-usart"
 	- "atmel,at91rm9200-dbgu", "atmel,at91rm9200-usart"
 	- "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart"
+	- "microchip,sam9x60-dbgu", "microchip,sam9x60-usart"
 - reg: Should contain registers location and length
 - interrupts: Should contain interrupt
 - clock-names: tuple listing input clock names.
-- 
2.7.4

