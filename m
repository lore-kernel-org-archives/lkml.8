Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41FDC2D0FC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3E372065D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wgfMihJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387994AbgEMNlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:41:49 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:46432 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgEMNls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589377308; x=1620913308;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ljm8FnjZM8LY8xetHtTmei+qyvIsUSSDg5bKQj+0eQ0=;
  b=wgfMihJE7uQWMJeESA3BI0u9CY5WRvS/0mQO6oi6o5Eg9DE6/yz/Z8dw
   sFYu0eVwtcrCfDYVtosXO/eAkNYz1OJ3qZgmCpBueqjoY7m5yc68NGNI/
   LMJ2rhtrpEHllVPbU9NXEgCE4COOcK3tJL6rI70wJe+d1mx3P9DGoAbX+
   N8TrvZtMfwJ1e/k0DYf+2jJIsYIAAXmqejti4Xf91/+mXFJ7OpcrKxXqD
   6SUhJypCrJ1QYEF6+L+y6P95WCHmTkan8XTOKs9iCdPjduq1Adjmh7qJm
   tvTY3ma683hXwbSjGxD6CtoEvvOQqOvRrYpk7fUtVCto219wySmUbqzji
   g==;
IronPort-SDR: 2uLuxLcwbwuCg9ZVdYVZrouOLP901++0WbRqO6zMCR7luuHQE7Q5QuEc5Mo7b7xPMeLj8sL3sh
 Nn3NzBQ7Hw5atCOsK68D3mDKxUKS1Mo7xIChiyL9W4eLAnxI6JIYxSFBu/NaeIV7Q5LIJpT3kf
 6Bd6KthtC7PUkKRXoKY/Qgliva20tyHHnAE/ES7ZeZvSdthJBsP4cW/TqudgAytiH7IVH3CLlT
 E7tjkCJ0CevPJ52DUAajhHAMV/mMDBCt/F7bTBjXPSFCe/ztmq7ZYRhiRgls84pZ5xcwk/aW+9
 i9U=
X-IronPort-AV: E=Sophos;i="5.73,387,1583218800"; 
   d="scan'208";a="79444197"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 06:41:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 06:41:50 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 13 May 2020 06:41:48 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
List-Id: <soc.lore.kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>, SoC Team <soc@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Jean Delvare <jdelvare@suse.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] hwmon: Adding support for Microchip Sparx5 SoC
Date:   Wed, 13 May 2020 15:41:37 +0200
Message-ID: <20200513134140.25357-1-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an add-on series to the main SoC Sparx5 series
(Message-ID: <20200513125532.24585-1-lars.povlsen@microchip.com>).

It is expected that the DT patches are to be taken directly by the arm-soc
maintainers.

Lars Povlsen (3):
  dt-bindings: hwmon: Add Sparx5 temperature sensor
  arm64: dts: sparx5: Add hwmon temperature sensor
  hwmon: sparx5: Add Sparx5 SoC temperature driver

 .../bindings/hwmon/microchip,sparx5-temp.yaml |  39 +++++
 arch/arm64/boot/dts/microchip/sparx5.dtsi     |   6 +
 drivers/hwmon/Kconfig                         |  10 ++
 drivers/hwmon/Makefile                        |   2 +-
 drivers/hwmon/sparx5-temp.c                   | 154 ++++++++++++++++++
 5 files changed, 210 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
 create mode 100644 drivers/hwmon/sparx5-temp.c

--
2.26.2
