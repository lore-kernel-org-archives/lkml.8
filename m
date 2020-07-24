Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C99EC433F7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C8BC2074B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="S6Ejr826"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgGXKvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:51:14 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:43033 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgGXKvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595587871; x=1627123871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RNLy3SNdJWGs/dvVv791yY4/covPYOf3+6f/EUHhRqs=;
  b=S6Ejr826mgIxUqHky6f4FBG4MtF3/D46OeyCPhMyijjgq+u6wATCW3MN
   N9zXlM0MXnUotcuMT2UlWcNjbGohfPKn74MsmZCbus+jPfEQItgmQGuBj
   5au3Lbczce8tHtb3UguovzueqzTDA5sdomc4QVpXzEZ5ls1lMdwfwCrDr
   xlRJcE2Advhsk0M/13CsQOvqiE8R+SwZ+K0sotGqqJnk3ZnKYt790+WGg
   PmsSzyLh8knR7SkHYHvX4ejsL8yPVV7SGdyC+CO/L2V70izrP+lZkCayn
   wUDXoa9zEmeQqqiq2mKR2MbyCZzPwT3gBYfCrrvvra0fKbQpLVPDLbp+X
   A==;
IronPort-SDR: cqYyOeTG/ohZsRTIsmjRLxt4zcO69+k+MK8UluWjjdkaVC9JN0+w6vCZAy0MKKaeJNearsNWUc
 Oh6/c803pm1sl64roY5pCMxAkwdXDVJOA6CVE9UJ3bUdj2Soqboux2HLefrNfmQrn/awOJ0zrP
 eA8Tt4XlpwESV3UQsS+wEURSwyHyHOcePPFyWf4PjNBBWWkP/+qqKPkJ3KR00JsTZrU+DFdqHY
 NJmeA51O3u/oIui9VZh7Qm5D8pEhU9iAiIg+n7PCPCknH97QPQynRqrSwdLLKWdCBVAIxel9cH
 Ryw=
X-IronPort-AV: E=Sophos;i="5.75,390,1589266800"; 
   d="scan'208";a="81155781"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jul 2020 03:51:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 24 Jul 2020 03:50:30 -0700
Received: from rob-ult-m19940.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 24 Jul 2020 03:50:25 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <davem@davemloft.net>, <kuba@kernel.org>, <andrew@lunn.ch>,
        <f.fainelli@gmail.com>, <robh+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH net-next v3 6/7] ARM: dts: at91: sama5d4: add an mdio sub-node to macb
Date:   Fri, 24 Jul 2020 13:50:32 +0300
Message-ID: <20200724105033.2124881-7-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724105033.2124881-1-codrin.ciubotariu@microchip.com>
References: <20200724105033.2124881-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new macb bindings and add an mdio sub-node to contain all the
phy nodes.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---

Changes in v3:
 - added tag from Florian

Changes in v2:
 - none

 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
index 924d9491780d..62598d06aead 100644
--- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
@@ -59,10 +59,14 @@ macb0: ethernet@f8020000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_macb0_rmii &pinctrl_macb0_phy_irq>;
 
-				phy0: ethernet-phy@1 {
-					interrupt-parent = <&pioE>;
-					interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
-					reg = <1>;
+				mdio {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					phy0: ethernet-phy@1 {
+						interrupt-parent = <&pioE>;
+						interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+						reg = <1>;
+					};
 				};
 			};
 
-- 
2.25.1

