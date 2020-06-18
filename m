Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891E7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60F7C2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GVFU8QoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbgFROAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:00:07 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:45970 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgFROAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592488805; x=1624024805;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pf/f1hZ+QC+aV79Jr/mTBD2zhiT2nFLN3XNxZ/7tIXg=;
  b=GVFU8QoW/cI8WqN1263JlPgv60TeMlWMG8x5gpzuq9vOLS696I9Zk/to
   Mr4ks3t9xxG5tct7pjDonNRyE9fbTeoFdsp9Qc+/YQbfKdEI34pwk2Zuj
   epSKzfleh0QhLV6i4An/hdVeWTjlD0o4qNyUBvWfrsaoccU+d4nHy+Fa1
   4UibPIS51Q8LgmFa3/lCmyO0WHiz4QhNTm+xOkiq1UThG56TsTYQA5su1
   hzCUI8kT9aOK5oDKjjXrAK7pz8FbB+6nQERIAn67pMiCTvQOLU7692QWC
   /A1h72FxLwit46f0Vx24zPOf5ZNo2G341uewF/gOY2Hm1QSu1pyGbQgvn
   Q==;
IronPort-SDR: glNIF+jP1Wy9kaiTBXhjwbWxH6h1/pQOiTV9mJ7ozuiN+YesoANspOKr78V30xKI5/Ufx6WdzL
 qheNoTcadLU0YC5NN/4ZnDxs7tvBoHMfrGu5Noy4Sm5snKksZN31ge3wcpxTgJdBeYbYQ0atpK
 mU/DBzMxE8vtKlmDumeA0+cnqJSwG183I+mg84BkBSsB2tfEWhuKxp8T+VwfB93mrKZHWRYQVQ
 SvAAL43D3ImUFGo8pkKaZPj4fHV3xfkJAp6u/QBJ8jVWlSuM0PdnJdh/P5Ex4GnPNaCn8KBIuQ
 Idk=
X-IronPort-AV: E=Sophos;i="5.73,526,1583218800"; 
   d="scan'208";a="80637099"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jun 2020 07:00:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 07:00:03 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 18 Jun 2020 07:00:01 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Jean Delvare <jdelvare@suse.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v4 0/3] hwmon: Adding support for Microchip Sparx5 SoC
Date:   Thu, 18 Jun 2020 15:59:48 +0200
Message-ID: <20200618135951.25441-1-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an add-on series to the main SoC Sparx5 series
(Message-ID: <20200615133242.24911-1-lars.povlsen@microchip.com>

Changes in v4:
- Added sparx5-temp.rst
- Sorted #include lines
- Use AHB clock to derive sensor divider
- Added comments to temperature calculation

Changes in v3:
- Enabled driver for COMPILE_TEST
- Use "bitfield.h"
- Trimmed #includes even more
- Removed unnecessary devm_add_action()
- Maintain sort order in Makefile
- Minor cosmetics

Changes in v2:
- Removed unnecessary #includes
- Statement reordering in s5_read()
- Replaced EINVAL with EIO
- Add 'break' in default: case statement.
- Removed extra ()
- Removed superfluous initialization

Lars Povlsen (3):
  dt-bindings: hwmon: Add Sparx5 temperature sensor
  arm64: dts: sparx5: Add hwmon temperature sensor
  hwmon: sparx5: Add Sparx5 SoC temperature driver

 .../bindings/hwmon/microchip,sparx5-temp.yaml |  44 +++++
 Documentation/hwmon/sparx5-temp.rst           |  33 ++++
 arch/arm64/boot/dts/microchip/sparx5.dtsi     |   7 +
 drivers/hwmon/Kconfig                         |  10 ++
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/sparx5-temp.c                   | 168 ++++++++++++++++++
 6 files changed, 263 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
 create mode 100644 Documentation/hwmon/sparx5-temp.rst
 create mode 100644 drivers/hwmon/sparx5-temp.c

--
2.27.0
