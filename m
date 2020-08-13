Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765A5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 510D020716
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgHMHtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 03:49:23 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39081 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgHMHtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:49:23 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 07D7n8FD1028958, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 07D7n8FD1028958
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 13 Aug 2020 15:49:08 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 13 Aug 2020 15:49:08 +0800
Received: from RTEXMB05.realtek.com.tw (172.21.6.98) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 13 Aug 2020 15:49:08 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXMB01.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server id
 15.1.1779.2 via Frontend Transport; Thu, 13 Aug 2020 15:49:08 +0800
From:   TY Chang <tychang@realtek.com>
To:     <linux-realtek-soc@lists.infradead.org>, <afaerber@suse.de>
CC:     <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/9] pinctrl: update realtek DHC pinctrl driver
Date:   Thu, 13 Aug 2020 15:48:59 +0800
Message-ID: <20200813074908.889-1-tychang@realtek.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

This series update Realtek DHC pinctrl driver with the following details:

* add missed pins
* add pin configuration feature
* add realtek DHC pinctrl documentation
* fix the warnings checked by running scripts/checkpatch.pl
* move realtek DHC pinctrl driver to realtek directory
* add suspend/resume callback function

Changelog:
v3
-add specific pin configurations for specific pins of rtd1295
-descibe specific pin configurations in rtd1295 documentation
-describe pins property in rtd1195 and rtd1295 documentation
-fix pinmux function name in device tree

v2
-remove realtek,rtd-pinctrl.yaml documentation
-add device tree binding rtd1195 documentation
-add deivce tree binding rtd1295 documentation
-fix the errors running 'make dt_binding_check'
-document the pin settings

Cc: Andreas Färber <afaerber@suse.de>


TY Chang (9):
  pinctrl: realtek: rtd1295: Add missed pins.
  pinctrl: realtek: rtd1295: Add pin configs.
  pinctrl: realtek: rtd1195: Add missed pins and pin configs.
  dt-bindings: pinctrl: realtek: Add Realtek DHC SoC rtd1195
  dt-bindings: pinctrl: realtek: Add Realtek DHC SoC rtd1295
  arm64: dts: realtek: rtd129x: fix SDIO pinctrl node
  pinctrl: realtek: DHC: Fix pinctrl driver coding style according to
    checkpatch.pl.
  pinctrl: realtek: DHC: Move pinctrl drivers to realtek directory and
    rename.
  pinctrl: realtek: DHC: Add suspend/resume callback function.

 .../pinctrl/realtek,rtd1195-pinctrl.yaml      | 133 +++
 .../pinctrl/realtek,rtd1295-pinctrl.yaml      | 192 ++++
 arch/arm64/boot/dts/realtek/rtd129x.dtsi      |   2 +-
 drivers/pinctrl/Kconfig                       |  10 +-
 drivers/pinctrl/Makefile                      |   2 +-
 drivers/pinctrl/pinctrl-rtd119x.c             | 383 --------
 drivers/pinctrl/realtek/Kconfig               |  14 +
 drivers/pinctrl/realtek/Makefile              |   3 +
 drivers/pinctrl/realtek/pinctrl-rtd.c         | 694 +++++++++++++++
 .../pinctrl/{ => realtek}/pinctrl-rtd1195.h   | 490 +++++++---
 .../pinctrl/{ => realtek}/pinctrl-rtd1295.h   | 840 +++++++++++++++---
 11 files changed, 2129 insertions(+), 634 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/realtek,rtd1195-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/realtek,rtd1295-pinctrl.yaml
 delete mode 100644 drivers/pinctrl/pinctrl-rtd119x.c
 create mode 100644 drivers/pinctrl/realtek/Kconfig
 create mode 100644 drivers/pinctrl/realtek/Makefile
 create mode 100644 drivers/pinctrl/realtek/pinctrl-rtd.c
 rename drivers/pinctrl/{ => realtek}/pinctrl-rtd1195.h (64%)
 rename drivers/pinctrl/{ => realtek}/pinctrl-rtd1295.h (61%)

-- 
2.28.0

