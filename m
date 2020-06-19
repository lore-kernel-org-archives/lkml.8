Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC4EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F4F2208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732399AbgFSK2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 06:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732283AbgFSK2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 06:28:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019C1C0613EE;
        Fri, 19 Jun 2020 03:28:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 23DE72A51F7
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, erwanaliasr1@gmail.com,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Mars Cheng <mars.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/7] arm64: dts: mediatek: Add support for Lenovo IdeaPad Duet Chromebook
Date:   Fri, 19 Jun 2020 12:27:50 +0200
Message-Id: <20200619102757.1358675-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These series adds basic support for the Lenovo IdeaPad Duet Chromebook, a
2-in-1 detachable devices using the MediaTek MT8183 SoC. The first patch
only adds the new compatible names in the mediatek binding. The second
patch, adds the missing compatible to instantiate the PMIC regulators.
The next patch adds missing devices to support better the board and fixes
some warnings found running dtbs_check. And finally, the latest
introduces support for the board itself.

All the patches has been tested on Lenovo IdeaPad Duet Chromebook with
the patches applied on top of 5.8-rc1 and with serial console, booting
without problems and being able to go to the login prompt.

Best regards,
  Enric

Enric Balletbo i Serra (7):
  dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-krane-sku176
  arm64: dts: mt6358: Add the compatible for the regulators
  arm64: dts: mt8183: Add MediaTek's peripheral configuration controller
  arm64: dts: mt8183: Fix unit name warnings
  arm64: dts: mt8183-evb: Fix unit name warnings
  arm64: dts: mt8183: Add USB3.0 support
  arm64: dts: mt8183: Add krane-sku176 board

 .../devicetree/bindings/arm/mediatek.yaml     |   5 +
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 arch/arm64/boot/dts/mediatek/mt6358.dtsi      |   2 +
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |   4 +-
 .../mediatek/mt8183-kukui-krane-sku176.dts    |  18 +
 .../boot/dts/mediatek/mt8183-kukui-krane.dtsi | 343 ++++++++
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 788 ++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  68 +-
 8 files changed, 1225 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi

-- 
2.27.0

