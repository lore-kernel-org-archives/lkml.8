Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C19C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39B682068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FWTE3LOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbgFOJzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:55:45 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:25620 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbgFOJzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592214941; x=1623750941;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EhgQcEHdAJNNogp8ECOYFDSbKYvI+4DJ91LLczqWy04=;
  b=FWTE3LOCNe8dkA+l9ufDkKq+ekYxqlzUbszUeuV3h3ONxdFb/nCGFcyz
   X4ff/+TAK7XgMkf44udOLqNVi1/qWGGv1c7UE4h1c/hJ2boeZZUb43hJd
   SWAgHPzchwMkAgQ6zik5syAKZDae5HfD8SEq1K5lIlOmsktwDqlIr2aXJ
   s+uRyMtg8C8X/fGsAHhSpeR4vehbpHHa2IyWMPzs+r2D6h5wud+ycPM5R
   PcL/0CFTQvZlibDgjQz57IoN5WeUCwvBUPctX71MOQyXWB5i+BLDzK8+b
   P7cRqqlHc54X0vLBAr9Q5+v2OqfD0MzB/Va1Qv/1asFSL/tk0knTYRuXd
   g==;
IronPort-SDR: 3s2PWCYQ6TfpQV3qjczFo20MSKizU76Vihaekzc+/qHm8xTAzxtT3kh+4s+S0oZYGEXetR6Yh7
 OfTBjXknHe7jR+mfKwKGcahtHRVhbVSRLO5zcR/GRQdNaB05IDPbRfnS1Xtf5JfgGSkfHG263Y
 ZrBWFhHPBLCIhyQioV5KNu8CxD1fegoTK2DkpAvTTErXbcW1ka2VixFF60DiKFiup4XUpuNOU7
 ad73hHq2NghakCJmS3kNIiG/1RyLF7u0eB0kGR0l9UtEqcHwI3bmImJjlnFp3ARRwNNZrOqwKJ
 KAU=
X-IronPort-AV: E=Sophos;i="5.73,514,1583218800"; 
   d="scan'208";a="80112721"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2020 02:55:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 15 Jun 2020 02:55:40 -0700
Received: from rob-ult-m19940.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 15 Jun 2020 02:55:37 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <claudiu.beznea@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH 2/3] ARM: dts: at91: sam9x60ek: classd: pull-down the L1 and L3 lines
Date:   Mon, 15 Jun 2020 12:55:24 +0300
Message-ID: <20200615095525.43414-2-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200615095525.43414-1-codrin.ciubotariu@microchip.com>
References: <20200615095525.43414-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The L1 and L3 lines drive NMOS transistors that are OFF with a low level.
On the SAM9X60 EK board, if the pins corresponding to L1 and L3
have pull-ups enabled, there is an extra 2 x 30uA power consumption.
Use pull-downs for these 2 lines to remove the unnecessary power
consumption.

Fixes: 1e5f532c2737 ("ARM: dts: at91: sam9x60: add device tree for soc and board")
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 arch/arm/boot/dts/at91-sam9x60ek.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
index b484745bf2d4..3b9bb29d9e23 100644
--- a/arch/arm/boot/dts/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
@@ -470,9 +470,9 @@ classd {
 		pinctrl_classd_default: classd {
 			atmel,pins =
 				<AT91_PIOA 24 AT91_PERIPH_C AT91_PINCTRL_PULL_UP
-				 AT91_PIOA 25 AT91_PERIPH_C AT91_PINCTRL_PULL_UP
+				 AT91_PIOA 25 AT91_PERIPH_C AT91_PINCTRL_PULL_DOWN
 				 AT91_PIOA 26 AT91_PERIPH_C AT91_PINCTRL_PULL_UP
-				 AT91_PIOA 27 AT91_PERIPH_C AT91_PINCTRL_PULL_UP>;
+				 AT91_PIOA 27 AT91_PERIPH_C AT91_PINCTRL_PULL_DOWN>;
 		};
 	};
 
-- 
2.25.1

