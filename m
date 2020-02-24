Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688E3C38BFA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403BE21D7E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgBXXIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:08:31 -0500
Received: from inva020.nxp.com ([92.121.34.13]:44882 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbgBXXIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:08:31 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EE9C81B0791;
        Tue, 25 Feb 2020 00:08:29 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B5D011A4BBB;
        Tue, 25 Feb 2020 00:08:29 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 09CBA40A63;
        Mon, 24 Feb 2020 16:08:29 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 00/15] Enable drivers for NXP/FSL QorIQ arm64 boards
Date:   Mon, 24 Feb 2020 17:07:55 -0600
Message-Id: <1582585690-463-1-git-send-email-leoyang.li@nxp.com>
X-Mailer: git-send-email 1.9.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series enables necessary drivers for the QorIQ reference boards
supported in mainline.

Li Yang (15):
  arm64: defconfig: run through savedefconfig for ordering
  arm64: defconfig: Enable NXP flexcan driver
  arm64: defconfig: Enable QorIQ DPAA1 drivers
  arm64: defconfig: Enable QorIQ DPAA2 drivers
  arm64: defconfig: Enable ENETC Ethernet controller and FELIX switch
  arm64: defconfig: Enable NXP/FSL SPI controller drivers
  arm64: defconfig: Enable QorIQ cpufreq driver
  arm64: defconfig: Enable ARM SBSA watchdog driver
  arm64: defconfig: Enable QorIQ IFC NAND controller driver
  arm64: defconfig: Enable QorIQ GPIO driver
  arm64: defconfig: Enable ARM Mali display driver
  arm64: defconfig: Enable flash device drivers for QorIQ boards
  arm64: defconfig: Enable RTC devices for QorIQ boards
  arm64: defconfig: Enable PHY devices used on QorIQ boards
  arm64: defconfig: Enable e1000 device

 arch/arm64/configs/defconfig | 57 +++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 11 deletions(-)

-- 
2.17.1

