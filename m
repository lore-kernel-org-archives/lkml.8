Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6547C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD3E8206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbgF3I7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:59:51 -0400
Received: from mx.socionext.com ([202.248.49.38]:40028 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731749AbgF3I7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:59:45 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 30 Jun 2020 17:59:44 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 6D3DB60060;
        Tue, 30 Jun 2020 17:59:44 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 30 Jun 2020 17:59:44 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 21AB71A0508;
        Tue, 30 Jun 2020 17:59:44 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 0/2] Add new UniPhier AHCI PHY driver
Date:   Tue, 30 Jun 2020 17:59:32 +0900
Message-Id: <1593507574-10007-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for AHCI PHY interface implemented in Socionext
UniPhier SoCs. This driver supports PXs2 and PXs3 SoCs.

Changes since v1:
- dt-bindings: Fix items in reset-names

Kunihiko Hayashi (2):
  dt-bindings: phy: Add UniPhier AHCI PHY description
  phy: socionext: Add UniPhier AHCI PHY driver support

 .../bindings/phy/socionext,uniphier-ahci-phy.yaml  |  76 +++++
 drivers/phy/socionext/Kconfig                      |  10 +
 drivers/phy/socionext/Makefile                     |   1 +
 drivers/phy/socionext/phy-uniphier-ahci.c          | 335 +++++++++++++++++++++
 4 files changed, 422 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
 create mode 100644 drivers/phy/socionext/phy-uniphier-ahci.c

-- 
2.7.4

