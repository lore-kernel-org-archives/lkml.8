Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD63C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF9E22B4E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgH0Oxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:53:32 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:3877 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727980AbgH0OxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:53:21 -0400
X-IronPort-AV: E=Sophos;i="5.76,359,1592838000"; 
   d="scan'208";a="55482013"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 27 Aug 2020 23:53:18 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 840DB40065C9;
        Thu, 27 Aug 2020 23:53:16 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: [PATCH 0/2] r8a774e1 add fdp1 and cpuidle support
Date:   Thu, 27 Aug 2020 15:53:13 +0100
Message-Id: <20200827145315.26261-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This series adds support for FDP1 and cpuidle support to R8A774E1
(RZ/G2H) SoC.

Cheers,
Prabhakar

Lad Prabhakar (1):
  arm64: dts: renesas: r8a774e1: Add cpuidle support for CA5x cores

Marian-Cristian Rotariu (1):
  arm64: dts: renesas: r8a774e1: Add FDP1 device nodes

 arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 50 +++++++++++++++++++++++
 1 file changed, 50 insertions(+)

-- 
2.17.1

