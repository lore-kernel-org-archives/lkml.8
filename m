Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F44AC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AAC2206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgAJJBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 04:01:11 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:5446 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgAJJBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 04:01:11 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Nicolas.Ferre@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="Nicolas.Ferre@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Nicolas.Ferre@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: OlHI+8CDomYN0cclRuIYBTRZzd7t/OhG8bnMA3JRzOdcLYDhCvsqgfacUkL33LkZxlrsRkLmna
 gA9c028symbv3o45n/NvFJU5BEdPdSPwoUvcBlTTNjkTxkbNJxxn/255az8QpO7VBKPRJerGyn
 nxfEjY3hWzseJQ3dK9qTSbaR5Cx5oqu7/DIG6P3UFgMm1sqs5u7N+e1wwZLBqEHf6wEop16yyn
 Y+tCQuCJlbiLTicFCRfR4sqb023W1FmVtuxfTZH1S06HL0K2FCyaGisCDftLHjvuG243IrqFRc
 qlk=
X-IronPort-AV: E=Sophos;i="5.69,415,1571727600"; 
   d="scan'208";a="61465529"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jan 2020 02:01:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 10 Jan 2020 02:01:09 -0700
Received: from tenerife.corp.atmel.com (10.10.85.251) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 10 Jan 2020 02:01:08 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH] ARM: at91: Documentation: add sam9x60 product and datasheet
Date:   Fri, 10 Jan 2020 10:01:03 +0100
Message-ID: <20200110090103.7728-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the new SAM9X60 ARM926-based SoC from Microchip and its associated
datasheet.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 Documentation/arm/microchip.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/arm/microchip.rst b/Documentation/arm/microchip.rst
index 1adf53dfc494..05e5f2dfb814 100644
--- a/Documentation/arm/microchip.rst
+++ b/Documentation/arm/microchip.rst
@@ -92,6 +92,12 @@ the Microchip website: http://www.microchip.com.
 
           http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001517A.pdf
 
+      - sam9x60
+
+          * Datasheet
+
+          http://ww1.microchip.com/downloads/en/DeviceDoc/SAM9X60-Data-Sheet-DS60001579A.pdf
+
     * ARM Cortex-A5 based SoCs
       - sama5d3 family
 
-- 
2.17.1

