Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE1CC34037
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9696C21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgBRMcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 07:32:25 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:37550 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726549AbgBRMcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 07:32:25 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 01ICVcXO007989;
        Tue, 18 Feb 2020 14:31:39 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id C1E586032E; Tue, 18 Feb 2020 14:31:38 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        avifishman70@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v4 0/3] arm: dts: add and modify device node in NPCM7xx device tree
Date:   Tue, 18 Feb 2020 14:31:25 +0200
Message-Id: <20200218123128.17990-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds and modify device tree nodes in the NPCM7xx
Baseboard Management Controller (BMC) device tree.

The following device node add:
        - NPCM7xx Pin controller and GPIO
        - NPCM7xx PWM and FAN.
        - NPCM7xx EHCI USB.
        - NPCM7xx KCS.
        - NPCM Reset.
        - NPCM Peripheral SPI.
        - NPCM FIU SPI.
        - NPCM HWRNG.
        - NPCM I2C.
        - STMicro STMMAC.

The following device node modified:
        - NPCM7xx timer.
        - NPCM7xx clock constants parameters.

NPCM7xx device tree tested on NPCM750 evaluation board.

Changes since version 3:
 - Tested patches in Linux kernel 5.6.

Changes since version 2:
 - Remove unnecessary ouput-enable flags.

Changes since version 1:
 - Add NPCM reset device node.
 - Add reset parameters to NPCM driver device nodes.

Tomer Maimon (3):
  arm: dts: modify NPCM7xx device tree clock parameter to clock constant
  arm: dts: modify NPCM7xx device tree timer register size
  arm: dts: add new device nodes to NPCM750 device tree

 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 958 +++++++++++++++++-
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts     | 444 +++++++-
 .../boot/dts/nuvoton-npcm750-pincfg-evb.dtsi  | 157 +++
 arch/arm/boot/dts/nuvoton-npcm750.dtsi        |  24 +-
 4 files changed, 1549 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm/boot/dts/nuvoton-npcm750-pincfg-evb.dtsi

-- 
2.22.0

