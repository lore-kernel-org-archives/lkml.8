Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED92AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA6D820776
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yjDXen20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733038AbgFSOTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:19:46 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:61027 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgFSOTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592576378; x=1624112378;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ros1udrNYa0R2yOGLKL28tb4ZWwAiFbhELcD5GmGfWE=;
  b=yjDXen20OXBWKc7tF8sZSdfLIc9BFGGTBlmMG4mNHcb4RZOuQkBXdshy
   yGBKrUOIX5dVXgzYjIFTchpN54BVUuCaR7q3vxs7oAKpIR1agToWvRR05
   B8pQuM24Fa4oQ9QJ49Dg8hOSdg2wYZ1uOObijHesU8GAFO37ik/pQEf70
   PGElfowDkt5uXYI+vLb1LhkNosWBVJadcwjMTZPhPI9JsuNZ7wpGKa4Up
   A+Bg1DFLb456X2+EVO/hXFbkr5DEm2tyFIQE+KWTEg3fdyc0ViZ6zFdQB
   IW0enrb3uzPejpBH7Oi3G3wReAwP5vyY74G9nS0+pGfK8Xe5ovFYpZDYS
   Q==;
IronPort-SDR: ttCeUGkYrT5A6qXqYkzgvjaXNmyeSXotP+seJRIRHv6vitXQAeCdnf8aed2SxV1GglISnQLQz0
 k+Q/g1ImcJ5izfZ7NWlTuZMCWlg33tXhghqh+COpF74n/5IeIIRjq4idz9FEVd0rVLNbvZP0TE
 eHaIil9LhzxeUNJVkG5bg/JnIvCxa/HY00nY8xdpc/gVd3nvmiLIhfmYvEoNh452lQpEX0nLGO
 mpKByhimmbiCJxz+K03d4SGiVsTC8JN2p2RCZvNDaKaRUlfcgw/dm+a7k1xMT5F8DVeNZCxZW7
 sVs=
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="79100746"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jun 2020 07:19:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 07:19:32 -0700
Received: from rob-ult-m19940.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 19 Jun 2020 07:19:05 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <wsa@kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux@armlinux.org.uk>,
        <kamel.bouhara@bootlin.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [RFC PATCH 0/4] i2c: core: add generic GPIO bus recovery
Date:   Fri, 19 Jun 2020 17:19:00 +0300
Message-ID: <20200619141904.910889-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO recovery has been added already for some I2C bus drivers, such as
imx, pxa and at91. These drivers use similar bindings and have more or
less the same code for recovery. For this reason, we aim to move the
GPIO bus recovery implementation to the I2C core so that other drivers
can benefit from it, with small modifications.
This implementation initializes the pinctrl states and the SDA/SCL
GPIOs based on common bindings. The I2C bus drivers can still use
different bindings or other particular recovery steps if needed.
The ugly part with this patch series is the handle of PROBE_DEFER
which could be returned by devm_gpiod_get(). This changes things a
little for i2c_register_adapter() and for this reason this step is
implemented in a sperate patch.
The at91 Microchip driver is the first to use this implementation,
with an AI to move the rest of the drivers in the following steps.

Codrin Ciubotariu (4):
  dt-binding: i2c: add generic properties for GPIO bus recovery
  i2c: core: add generic I2C GPIO recovery
  i2c: core: treat EPROBE_DEFER when acquiring SCL/SDA GPIOs
  i2c: at91: Move to generic GPIO bus recovery

 Documentation/devicetree/bindings/i2c/i2c.txt |  10 ++
 drivers/i2c/busses/i2c-at91-master.c          |  69 +--------
 drivers/i2c/i2c-core-base.c                   | 139 +++++++++++++++++-
 include/linux/i2c.h                           |  11 ++
 4 files changed, 158 insertions(+), 71 deletions(-)

-- 
2.25.1

