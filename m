Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E395C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76DC2207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587403903;
	bh=zYTCgzbp//wOmybEQMjzmB97i0Q6qYo7SyIvO8gPoho=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0lSTtNuNRUyP6vmXPd2YXY9zgw34+yaggXIMDicbM4lxc+18PErnTrv50YoGhLGbw
	 r8onWPddJO4bm8oVsRd4T6sdXqBtzTaPWbbAyiG4ZHQbDaTMbnq80rVGqn33T3i63V
	 +vl7a495W3zKUu7nIvTCha1QlwKqxdoFQpSXM40g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgDTRbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:31:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgDTRbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:31:42 -0400
Received: from localhost.localdomain (unknown [157.46.94.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 633A920782;
        Mon, 20 Apr 2020 17:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587403901;
        bh=zYTCgzbp//wOmybEQMjzmB97i0Q6qYo7SyIvO8gPoho=;
        h=From:To:Cc:Subject:Date:From;
        b=c/1Ac+5eIzx9CK3uWozc2qQPpNtXOf1KFaNwjXhXFFBAhgIfobshyhwBRnWsGtYsd
         pK2Xa5F7fKm+lKFCTH8qb1lZGNslUoaHg5bB/Wp5A1ok+bBy0zvhBOCbyw63qBtuv5
         LGBP6duWY35waItnxkAWOxV1F9PKGnjfTVFkn8Qg=
From:   mani@kernel.org
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 0/6] Add Stinger96 and IoT Box board support
Date:   Mon, 20 Apr 2020 23:01:18 +0530
Message-Id: <20200420173124.27416-1-mani@kernel.org>
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

Manivannan Sadhasivam (6):
  dt-bindings: Add vendor prefix for Shiratech Solutions
  ARM: dts: Add missing pinctrl entries for STM32MP15
  dt-bindings: arm: stm32: Document Stinger96 compatible
  ARM: dts: stm32mp1: Add Stinger96 board support
  dt-bindings: arm: stm32: Document IoT Box compatible
  ARM: dts: stm32mp1: Add IoT Box board support

 .../devicetree/bindings/arm/stm32/stm32.yaml  |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi      |  64 ++++
 arch/arm/boot/dts/stm32mp157a-iot-box.dts     |  92 +++++
 arch/arm/boot/dts/stm32mp157a-stinger96.dts   |  12 +
 arch/arm/boot/dts/stm32mp157a-stinger96.dtsi  | 342 ++++++++++++++++++
 7 files changed, 516 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32mp157a-iot-box.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157a-stinger96.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157a-stinger96.dtsi

-- 
2.17.1

