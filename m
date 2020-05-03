Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5ADC47247
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 15:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7BCA24955
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588520549;
	bh=0CnMSeTOMkqPLyIXlkMMbKd1x1o/uhBytgUHSI2Q8IM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=c9UbOV95J5fxSOYOwu+fzmgBeBKpkMGTWwUYR0EYI31QnIAD9bJAtbnPDSLVBxvd8
	 bQSwQRBsshAgHBj4kxkBa9VXVdqnj+24FmzdO8eUnvz64qSFjw1SPGth0Thh6gmbHX
	 Ohl/hIP4f9nyzSgH/7bFU7RF8Cgn7A0WsvaM7ip0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgECPm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 11:42:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728716AbgECPm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 11:42:28 -0400
Received: from localhost.localdomain (unknown [157.51.190.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7612220757;
        Sun,  3 May 2020 15:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588520548;
        bh=0CnMSeTOMkqPLyIXlkMMbKd1x1o/uhBytgUHSI2Q8IM=;
        h=From:To:Cc:Subject:Date:From;
        b=IULHFamipQH5bSodpv0GV3Nx9+FVZaxVXUfnbSU21fv2/JywgTGME+8mLNzI126jP
         oPCbHEba/noEgcFuYPnbljJjxzF/zy7wYT/X4EgfHUHzUMBE6IFUvzRPg1pcd2XoQk
         Z7E5fpcjD+GlJFhjRB92VRRgkAVutW4AZGCddY9M=
From:   mani@kernel.org
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v2 0/6] Add Stinger96 and IoT Box board support
Date:   Sun,  3 May 2020 21:12:09 +0530
Message-Id: <20200503154215.23654-1-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

Hello,

This series adds Stinger96 and IoT Box board support. These boards are
based on STM32MP157A SoC, designed and manufactured by Shiratech solutions.

The Stinger96 is a base board (96Boards IoT Extended edition) while IoT Box
adds one mezzanine on top of it and sold as a gateway device.

This series depends on below patchsets already submitted and gone through
reviews:

[PATCH v3 0/3] Add Reset and Wakeup support for CCS811
[PATCH v3 0/2] Add CTS/RTS gpio support to STM32 UART

More information about these boards can be found in below links:

https://www.shiratech-solutions.com/products/stinger96/
https://www.shiratech-solutions.com/products/iot-box/

Thanks,
Mani

Changes in v2:

* Used "stm32" prefix for all DT commits
* Dropped custom sdmmc2 pinctrl node since existing node itself has pullup
  enabled and works fine.

Manivannan Sadhasivam (6):
  dt-bindings: Add vendor prefix for Shiratech Solutions
  ARM: dts: stm32: Add missing pinctrl entries for STM32MP15
  dt-bindings: arm: stm32: Document Stinger96 compatible
  ARM: dts: stm32: Add Stinger96 board support
  dt-bindings: arm: stm32: Document IoT Box compatible
  ARM: dts: stm32: Add IoT Box board support

 .../devicetree/bindings/arm/stm32/stm32.yaml  |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi      |  64 ++++
 arch/arm/boot/dts/stm32mp157a-iot-box.dts     |  68 ++++
 arch/arm/boot/dts/stm32mp157a-stinger96.dts   |  12 +
 arch/arm/boot/dts/stm32mp157a-stinger96.dtsi  | 342 ++++++++++++++++++
 7 files changed, 492 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32mp157a-iot-box.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157a-stinger96.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157a-stinger96.dtsi

-- 
2.17.1

