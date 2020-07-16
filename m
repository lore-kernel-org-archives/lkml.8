Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7B5C433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB77320663
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgGPCnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 22:43:20 -0400
Received: from mx.socionext.com ([202.248.49.38]:52330 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbgGPCnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 22:43:20 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 16 Jul 2020 11:43:18 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 83250180BC2;
        Thu, 16 Jul 2020 11:43:18 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 16 Jul 2020 11:43:18 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id DB3321A0509;
        Thu, 16 Jul 2020 11:43:17 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 0/2] Add new UniPhier AHCI PHY driver
Date:   Thu, 16 Jul 2020 11:43:00 +0900
Message-Id: <1594867382-27509-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for AHCI PHY interface implemented in Socionext
UniPhier SoCs. This driver supports PXs2 and PXs3 SoCs.

Changes since v2:
- Adjust copyright year
- Add helper for enabling the controller
- Remove redundant .init in uniphier_pxs2_data
- Add comments for dummy read accesses
- Fix return value in uniphier_ahciphy_init
- dt-bindings: Add Reviewed-by line

Changes since v1:
- dt-bindings: Fix items in reset-names

Kunihiko Hayashi (2):
  dt-bindings: phy: Add UniPhier AHCI PHY description
  phy: socionext: Add UniPhier AHCI PHY driver support

 .../bindings/phy/socionext,uniphier-ahci-phy.yaml  |  76 +++++
 drivers/phy/socionext/Kconfig                      |  10 +
 drivers/phy/socionext/Makefile                     |   1 +
 drivers/phy/socionext/phy-uniphier-ahci.c          | 323 +++++++++++++++++++++
 4 files changed, 410 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
 create mode 100644 drivers/phy/socionext/phy-uniphier-ahci.c

-- 
2.7.4

