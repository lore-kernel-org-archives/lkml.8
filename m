Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587D5C2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC8720678
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tjv4I0tT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733035AbgDAWTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:19:55 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:60114 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732385AbgDAWTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 18:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1585779594; x=1617315594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BPjNOnkGc0WibCjCNo7i6GUfzGFIqq0ztMrxOHNDZwQ=;
  b=tjv4I0tTb7+AkNHMr34G4igS48jdklqpLCkJjIsNfL7FyTIxmmWfvGoH
   znrLyZMpGjA/nqUOISk9CTWUda/soO0Gw0fu+w69yoK0XNOQgKJImYW5z
   LqfHDoi9LLIQ9wkv4yfd1+oCKPevo0Ux8e2X6XJ42JmF+0HyswGzVob2k
   yuL2uhdEHtg2qj7uxt5hr2JKWohAeG7p7Sqfl/rASPk7DG8NZPHwHUK3+
   EIjnVsBSot7urGRERirMCycLw2xijS2NjDJN8kbMog5eIfKURRqQvuVn0
   JvhgVs3ADs/e+g5/nJFqaLqWTTQ2PsKhUzG1nwt+kqEevRKRpZ/Xo0j3U
   g==;
IronPort-SDR: E38uwSDiXzIp38bHPdN0cFgpbIsfXGgCKcIMl8IchKCQ2R6QxytPDUgpf3ndS7QPcQw20eX/JX
 sXjzZ2edkIYukkCp0VGp1a/4a/cKvyzTiVRsgVRDv80c4Zm+0qFZn9SWU3fpDsuXRhVHLfx1+0
 8Es+diZtT2pfxqdiQsjNhp6GWKS2DNkAsPrbyBCZeZWFo9x76Je/QsQh2OjfUHihyoh7AhtCHk
 8u1xVWDIt3LtOayQINBa3lqhvfl/a64V3tyfBzwrt1KR8Rmi4JOcB5xWCnMG6TZiOIRLrepZaw
 zVQ=
X-IronPort-AV: E=Sophos;i="5.72,333,1580799600"; 
   d="scan'208";a="70956797"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Apr 2020 15:19:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 1 Apr 2020 15:19:53 -0700
Received: from sekiro.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 1 Apr 2020 15:19:56 -0700
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>, <Cristian.Birsan@microchip.com>,
        <Codrin.Ciubotariu@microchip.com>,
        "Ludovic Desroches" <ludovic.desroches@microchip.com>,
        <stable@vger.kernel.org>
Subject: [RESEND PATCH 2/5] ARM: dts: at91: sama5d2_ptc_ek: fix vbus pin
Date:   Thu, 2 Apr 2020 00:19:47 +0200
Message-ID: <20200401221947.41502-1-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401221504.41196-2-ludovic.desroches@microchip.com>
References: <20200401221504.41196-2-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gpio property for the vbus pin doesn't match the pinctrl and is
not correct.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Fixes: 42ed535595ec "ARM: dts: at91: introduce the sama5d2 ptc ek board"
Cc: stable@vger.kernel.org # 4.19 and later
---

s/watch/match

 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
index 772809c54c1f3..b803fa1f20391 100644
--- a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
@@ -40,7 +40,7 @@ main_xtal {
 
 	ahb {
 		usb0: gadget@300000 {
-			atmel,vbus-gpio = <&pioA PIN_PA27 GPIO_ACTIVE_HIGH>;
+			atmel,vbus-gpio = <&pioA PIN_PB11 GPIO_ACTIVE_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usba_vbus>;
 			status = "okay";
-- 
2.26.0

