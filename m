Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCD5C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD61020787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WF0S3HdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732522AbgGVNom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 09:44:42 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:56875 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgGVNok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 09:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595425479; x=1626961479;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x67atpIPPy7ehWiPrLyZwKmSAKD5xBofNyNuEjmdwpE=;
  b=WF0S3HdBy0/3Xepi/MpZcvNhc5ZII/0m4AEMHYUsvXcxdb7KpvQ8vWTa
   BhhO8jDHdflr7Zuywy2GWEs9oA8BJwATjLsSjMKPXESmXXsGCVlK/Lnc3
   jEEZsJPQmdYg9p0qzZ0XTzf6vn7GHsFrrGZAVce3OSwNiEZy1RA9HEFAS
   l+8qlNNRozmvpSz0Tng54r3cvzyN0SEbuLY5GwRCQMpV+hGrl3fmZe8BL
   sFBKNP9Az/smkgdspzQ9Py3LcrvUhAnoYAdXw+v+GXTTV/VPN2ZqxMt6I
   ak4ZOHm2fhgbIR1AFNv18OvyfeRl6edAlKMCiEF/cX2Fs2al9oNXk7O5G
   w==;
IronPort-SDR: XeGwUtETrr1LnBtY7gfFqS/EOwXn7H7vb+QjWX4iGr+F5ghYj1OsgdZZXMwgn/IwI4ci2GxPrO
 SHv1LYKAWgIFw5e3dOzBMM/QxXvwnTuZLZqTcJ2mk8KltxnlmgF17t6cAz8rGPJxSefdHj/plt
 1a/dSFlS7mvhEgjgjOCoT563uSuSjM8YMtyhRC+oXuQMRG6I5v/l0th6q0asP8gnecW7++L5c8
 XHN8mzSbjoanTEfK0y6Zrog21hjgwB2BcqUR+zIk91CdvDGmZZM133No7uwlyu4/yntJtVPKLl
 Bjo=
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="82819476"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2020 06:44:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 06:44:25 -0700
Received: from cristi-P53.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 22 Jul 2020 06:43:43 -0700
From:   <cristian.birsan@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH v3 0/6] usb: gadget: udc: atmel: add usb device support for SAM9x60 SoC
Date:   Wed, 22 Jul 2020 16:44:15 +0300
Message-ID: <20200722134421.190741-1-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

This patch set adds usb device support for SAM9x60 SoC.
The DPRAM memory for the USB High Speed Device Port (UDPHS) hardware
block was increased and the allocation method is changed. This patch
series simplifies the endpoint allocation scheme to acomodate this SoC
and the old ones.

Changes in v3:
- rebase on top of testing/next
- depends on https://lore.kernel.org/linux-arm-kernel/cover.1594231056.git.mirq-linux@rere.qmqm.pl/
- extend usba_udc_config structure with endpoint preallocaion flag
- collect acked-by tags

Changes in v2:
- drop the patch that adds reference to pmc for sam9x60
- use dt-bindings: usb prefix
- enable usb device in device tree

Claudiu Beznea (1):
  usb: gadget: udc: atmel: use of_find_matching_node_and_match

Cristian Birsan (5):
  dt-bindings: usb: atmel: Update DT bindings documentation for sam9x60
  usb: gadget: udc: atmel: simplify endpoint allocation
  usb: gadget: udc: atmel: use 1 bank endpoints for control transfers
  usb: gadget: udc: atmel: update endpoint allocation for sam9x60
  ARM: dts: at91: sam9x60ek: enable usb device

 .../devicetree/bindings/usb/atmel-usb.txt     |  1 +
 arch/arm/boot/dts/at91-sam9x60ek.dts          | 13 ++++
 arch/arm/boot/dts/sam9x60.dtsi                | 14 ++++
 drivers/usb/gadget/udc/atmel_usba_udc.c       | 67 ++++++++++++-------
 drivers/usb/gadget/udc/atmel_usba_udc.h       |  3 +-
 5 files changed, 74 insertions(+), 24 deletions(-)

-- 
2.25.1

