Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD84C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CE0A20737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YeTlFGlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgGWStM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 14:49:12 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:57893 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgGWStM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 14:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595530152; x=1627066152;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rOfZiTKlOiTMXtkPiJ4sia8QYSro0nSiFyXXBuqWpiw=;
  b=YeTlFGlK8aBPghK80iqx2SqGujBmoANPjVf1SKUbg2mxcD4upAlcyYyr
   UdmWcmFI83ZeJCzb14vR6uLcCbuG2reit2wC8c+F7mvoTuKFsogOi17Uw
   2lb/3vvwVZJFHNWWMZYx2GMmbzZ2xa07mzQfmWt70akg22xoURywLbZ3h
   oDtjDp5c0Ygs1SlIoJO9bPJW4ZsoGo947kz1WPXSbEf1Y4/4JWm5lVbgH
   2gkgr7O1l963khV75+61XNVqSISK7HNNpqzNLf9BPh23IycoIsuLwp/IX
   SBVsewBxkGsZBY54wWmSa6uhkktMkkmmvSNv+Qg20EtG4ANa91XmNB5jM
   A==;
IronPort-SDR: rPmmgBacQNRffjywLrPLQpxZHMs8POFBcGKcT+um8sd8DqPF7pHK1eJa9fM98VTW4f916KGlwB
 TudAaM+LYxgTXVOD2Mh6yr9rU3q1PTYj+hb9tMy6LsnlFua0vfG9oQMkePpAOXDfoi9MHhpIzt
 BQ6Xr1iBjpvMiWP/RNI/ZJVHCNgxioWyCIw+6nhhtKEdTToDR/qY24OtWo5Q1OJJ26+kmsL52G
 ++m4FfAmmHnp2qjQCnIWHX8c6WgXkKdJzxoSXYGGHH0lviDCwAA9IsUI8SKdogZslolvmQ2XNL
 p7E=
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="85153632"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jul 2020 11:49:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 23 Jul 2020 11:48:29 -0700
Received: from cristi-P53.lan (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 23 Jul 2020 11:48:28 -0700
From:   <cristian.birsan@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH v4 0/6] usb: gadget: udc: atmel: add usb device support for SAM9x60 SoC
Date:   Thu, 23 Jul 2020 21:48:56 +0300
Message-ID: <20200723184902.416705-1-cristian.birsan@microchip.com>
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

Changes in v4:
- rebase on top of testing/next
- add pp variable to access pmc

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
 drivers/usb/gadget/udc/atmel_usba_udc.c       | 68 ++++++++++++-------
 drivers/usb/gadget/udc/atmel_usba_udc.h       |  3 +-
 5 files changed, 75 insertions(+), 24 deletions(-)

-- 
2.25.1

