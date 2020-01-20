Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEECC33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B09208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgATMKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:10:54 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:4347 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgATMKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:10:52 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 5AXjTAIqWelm8ELnJfPdMSS8MebuYPwOKw9UroUtbAsnbZSOICF1xNQebaw6UUrLDtjmhTwKPk
 8hQUKbTeAj3kZd3kYA/C8GXNr81Gs7nWncz7K0KZIZms501zffiqRFx83yJO7iAPMvJrY/1xqq
 n+9SfqhwDFlp2aYsmJ2hKxSK8ykF/DLK0WUEwN3fc8sp55i26zAMGcyC098Rc2Fu8kAPcJ6x95
 1xktUEzsXkeuYPwYvVbYhAu/y6DgA6BVWSIHYfJ8nmfhLI23VUAfU//9BqqnM64713JEgRtzxZ
 BuQ=
X-IronPort-AV: E=Sophos;i="5.70,342,1574146800"; 
   d="scan'208";a="63869254"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2020 05:10:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 Jan 2020 05:10:28 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Mon, 20 Jan 2020 05:10:26 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux@armlinux.org.uk>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 5/8] ARM: at91: pm: s/sfr/sfrbu in pm_suspend.S
Date:   Mon, 20 Jan 2020 14:10:05 +0200
Message-ID: <1579522208-19523-6-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579522208-19523-1-git-send-email-claudiu.beznea@microchip.com>
References: <1579522208-19523-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/sfr/sfrbu in pm_suspend.S.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm_suspend.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 5fa0c2aa10f7..c898071e0c0b 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -103,7 +103,7 @@ ENTRY(at91_pm_suspend_in_sram)
 	cmp	tmp1, #0
 	ldrne	tmp2, [tmp1, #0]
 	ldr	tmp1, [r0, #PM_DATA_SFRBU]
-	str	tmp1, .sfr
+	str	tmp1, .sfrbu
 	cmp	tmp1, #0
 	ldrne	tmp2, [tmp1, #0x10]
 
@@ -150,7 +150,7 @@ ENTRY(at91_backup_mode)
 	wait_mckrdy
 
 	/*BUMEN*/
-	ldr	r0, .sfr
+	ldr	r0, .sfrbu
 	mov	tmp1, #0x1
 	str	tmp1, [r0, #0x10]
 
@@ -536,7 +536,7 @@ ENDPROC(at91_sramc_self_refresh)
 	.word 0
 .shdwc:
 	.word 0
-.sfr:
+.sfrbu:
 	.word 0
 .memtype:
 	.word 0
-- 
2.7.4

