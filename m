Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BD4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1B6C2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404119AbgEYPWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 11:22:25 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:22773 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403976AbgEYPWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 11:22:24 -0400
X-IronPort-AV: E=Sophos;i="5.73,433,1583161200"; 
   d="scan'208";a="47759197"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 26 May 2020 00:22:22 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id EE8694006C6C;
        Tue, 26 May 2020 00:22:20 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/4] iW-RainboW-G21D-Qseven Enable SCIFB2, SDHI2, AVB and RWDT
Date:   Mon, 25 May 2020 16:22:05 +0100
Message-Id: <1590420129-7531-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series enables support for SCIFB2, SDHI2, AVB and
RWDT on iW-RainboW-G21D-Qseven develpoment board.

This patch series is dependent on [1].

[1] https://patchwork.kernel.org/project/linux-renesas-soc/
    list/?series=288491&archive=both&state=*

Cheers,
Prabhakar

Lad Prabhakar (4):
  ARM: dts: r8a7742-iwg21d-q7: Enable scifb2 node
  ARM: dts: r8a7742-iwg21d-q7: Enable SDHI2 controller
  ARM: dts: r8a7742-iwg21d-q7: Enable Ethernet avb
  ARM: dts: r8a7742-iwg21d-q7: Add RWDT support

 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts | 87 +++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

-- 
2.7.4

