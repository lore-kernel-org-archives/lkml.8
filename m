Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A390AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8311820717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgGQLpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:45:04 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:38979 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725950AbgGQLpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:45:02 -0400
X-IronPort-AV: E=Sophos;i="5.75,362,1589209200"; 
   d="scan'208";a="52406119"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 17 Jul 2020 20:45:01 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0DB2B4267DBB;
        Fri, 17 Jul 2020 20:45:01 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     kishon@ti.com, vkoul@kernel.org
Cc:     wsa+renesas@sang-engineering.com, geert+renesas@glider.be,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v3 0/2] phy: renesas: rcar-gen3-usb2: fix an issue and minor update
Date:   Fri, 17 Jul 2020 20:44:55 +0900
Message-Id: <1594986297-12434-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch 1 can fix an issue which SError happen if CONFIG_DEBUG_SHIRQ
is enabled.
The patch 2 is a incremental patch from patch 1. It's better to avoid
unexpected behaviors if request_irq() failed.

 Changes from v2:
 - [update] Minor fixes in patch 1.
 - [new] Exit if request_irq() failed in patch 2.
 https://patchwork.kernel.org/patch/11659547/

 Changes from v1:
 - Move the irq registration to rcar_gen3_phy_usb2_init() instead of
   add a condition into the irq handler.
 https://patchwork.kernel.org/patch/11654097/


Yoshihiro Shimoda (2):
  phy: renesas: rcar-gen3-usb2: move irq registration to init
  phy: renesas: rcar-gen3-usb2: exit if request_irq() failed

 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 63 ++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 28 deletions(-)

-- 
2.7.4

