Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8150EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 611512078D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fXBsHY5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgFJJF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:05:56 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:10213 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgFJJFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1591779954; x=1623315954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=t6wcLCkFONrUeQcZj7cIgekzRPWxM2ExMIxkdhfwFKk=;
  b=fXBsHY5O9TWl14diWy4IGOnFP4W0m3lqAk6CCr770W3nwJ+9c8EJS1nX
   S2ZI9vodedu8X4SvS0WDyZF9TmUW1yqNyrfT5tchdW68J6eqnknYlvF4z
   5q3agm5/r/cFDMswg1vLQZYzawTDMI5uNy1K2aaxFx2gf3AVkmom9ee+b
   e0pIUsFzdCGGSfWpM72kc6vsbGJdr/WiSynEWsE0sAa+oTwCttBZflFuF
   VoVtwfDmW6ap5NCATf2FdsSMnVe+U0Wx7DT5h1vAz6bUxIWPrwMa++CY8
   tfO+uZckZtTL3nzZzwOas5PADV0WWYL3QljlJAFir7kvwrCKek9lxpo/Z
   g==;
IronPort-SDR: yV7vm0cNTOuE4Z9ccNbQJ/p+I8zCADTrg4r3LcGNtKoCQ8HVkMEGEftRlp5iuoiDUmo7PP3zCw
 VjdD6HByS/f+Dejyq3llWrOcD6V47ROj+FSDYZZSXJjdBymRCn7svBwcTjiPfyvstpqqaw3tCg
 Qmi1+C9bKE9DAcgRHIevi2jYR8dvsdG+5OKpwWgv2g/0cSujiqE3Pge29jfMyVaFFyxrCAP3oh
 r5B99AQhm79rgtBugDQik8BtB1Qz9SB/LXkHEq6EBL8gUFCkdLjp2ldV9tGEEN+rOigKRAxLkh
 x1o=
X-IronPort-AV: E=Sophos;i="5.73,495,1583218800"; 
   d="scan'208";a="82953248"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jun 2020 02:05:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 10 Jun 2020 02:05:52 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1847.3 via Frontend Transport; Wed, 10 Jun 2020 02:05:48 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <ludovic.desroches@microchip.com>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <maz@kernel.org>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 2/3] dt-bindings: rtc: add microchip,sam9x60-rtt
Date:   Wed, 10 Jun 2020 12:05:35 +0300
Message-ID: <1591779936-18577-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591779936-18577-1-git-send-email-claudiu.beznea@microchip.com>
References: <1591779936-18577-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add microchip,sam9x60-rtt to compatible list.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
index 6ae79d1843f3..3f0e2a5950eb 100644
--- a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
@@ -1,7 +1,9 @@
 Atmel AT91SAM9260 Real Time Timer
 
 Required properties:
-- compatible: should be: "atmel,at91sam9260-rtt"
+- compatible: should be one of the following:
+	- "atmel,at91sam9260-rtt"
+	- "microchip,sam9x60-rtt", "atmel,at91sam9260-rtt"
 - reg: should encode the memory region of the RTT controller
 - interrupts: rtt alarm/event interrupt
 - clocks: should contain the 32 KHz slow clk that will drive the RTT block.
-- 
2.7.4

