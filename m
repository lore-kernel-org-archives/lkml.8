Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51749C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A98C206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="R4YGlhCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbgFRPmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:42:03 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:50726 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731506AbgFRPl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592494917; x=1624030917;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/xPz/XUkWYQ+/6NSvaaOEEb50Wks9JYr5YDDXFtRas0=;
  b=R4YGlhCq2OJrPnrx2vfrgRw2d8OywyAsb365DBN1Jih3N++eXh9WR2Xo
   nzCOMhcmTqFyHEddYR2e3zMDEzjjBeTU184deKwbjJnvrZk/E5pqj5BCu
   D3ISSc6HmouKD3rmxQv75I3r9UP5H9DkjyMMlxPUsiPinjxcvFynRtjr3
   /mzLzKJ5LLUSxe+4UU78fMNShdMtIVdlXMC0viYr2eNUKLMeFq81UVwru
   /huNlOL27l0RqvFUrLbgbFxqL8q+S6pjOyedMV1a1H1xsz273HqZezjtn
   cjVbRoaOWrPemu0abxf/3pSJlX75ib9ey17JkmWJWicBndqqv57iTXZnU
   w==;
IronPort-SDR: E2EVEbmoB+k9vNfuRVb4TC/r1xLs5eNFWooUjCtOVDwuTIeMhurjvIlZ6cRHGpJUYf/s5WjebJ
 y83z/8whG5O7zm0FIM16nmGMaLDGRxMZUzejqcTXvvTibw0inqRmKpgUhcyg8tjEL6mGGYqycj
 43io/Nmr5coJ0xAZk6ytCZFpDd/limNeZgPSO2n0N3G9CU3mAoH9eSbSo7lsqBCgIw6y76VibB
 Cn+HaNe+AMIl04cJCr2G5/KrfuqLxXzu88k5d/hiv8kOATt2YBQlQV7ux+Gb4ho+zt7IhsQQ2m
 +aM=
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="84149583"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jun 2020 08:41:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 08:41:56 -0700
Received: from rob-ult-m19940.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 18 Jun 2020 08:41:43 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux@armlinux.org.uk>, <olof@lixom.net>,
        <alexandre.belloni@bootlin.com>, <krzk@kernel.org>,
        <sudeep.holla@arm.com>, <nicolas.ferre@microchip.com>,
        <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH] ARM: configs: at91: sama5: Enable CLASSD
Date:   Thu, 18 Jun 2020 18:41:47 +0300
Message-ID: <20200618154147.687878-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CLASSD is present on SAMA5d2 SoCs.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 arch/arm/configs/sama5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 8e1f78c19920..f688443fe7bf 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -165,6 +165,7 @@ CONFIG_SND_SOC=y
 CONFIG_SND_ATMEL_SOC=y
 CONFIG_SND_ATMEL_SOC_WM8904=y
 # CONFIG_HID_GENERIC is not set
+CONFIG_SND_ATMEL_SOC_CLASSD=y
 CONFIG_SND_ATMEL_SOC_PDMIC=y
 CONFIG_SND_ATMEL_SOC_TSE850_PCM5142=m
 CONFIG_SND_ATMEL_SOC_I2S=y
-- 
2.25.1

