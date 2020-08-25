Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C716C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D8032076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgHYQ2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:28:35 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:29306 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725947AbgHYQ2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:28:31 -0400
X-IronPort-AV: E=Sophos;i="5.76,353,1592838000"; 
   d="scan'208";a="55494874"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 26 Aug 2020 01:28:24 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4C3EB409E769;
        Wed, 26 Aug 2020 01:28:22 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: [PATCH 0/4]  iWave G21D-Q7 enable PCIe, flash, CAN and SD2 LED
Date:   Tue, 25 Aug 2020 17:27:14 +0100
Message-Id: <20200825162718.5838-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series enables PCIe, SPI NOR flash, CAN0 and SD2 LED indication
on iWave G21D-Q7 board.

Patches apply on top of [1] and also dependent on patch [2]
[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/
    renesas-devel.git/log/?h=renesas-arm-dt-for-v5.10
[2] https://patchwork.kernel.org/patch/11712541/

Cheers,
Prabhakar

Lad Prabhakar (4):
  ARM: dts: r8a7742-iwg21d-q7: Enable PCIe Controller
  ARM: dts: r8a7742-iwg21d-q7: Add SPI NOR support
  ARM: dts: r8a7742-iwg21d-q7: Add can0 support to carrier board
  ARM: dts: r8a7742-iwg21d-q7: Enable SD2 LED indication

 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts | 74 +++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

-- 
2.17.1

