Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E1BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88B6208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbgFPPcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:32:11 -0400
Received: from lists.gateworks.com ([108.161.130.12]:40557 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbgFPPcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:32:08 -0400
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <tharvey@gateworks.com>)
        id 1jlDcP-0004Zg-Ft; Tue, 16 Jun 2020 15:35:21 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Bryan Whitehead <bryan.whitehead@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] lan743x: add MODULE_DEVICE_TABLE for module loading alias
Date:   Tue, 16 Jun 2020 08:31:58 -0700
Message-Id: <1592321518-28464-1-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without a MODULE_DEVICE_TABLE the attributes are missing that create
an alias for auto-loading the module in userspace via hotplug.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index c5c5c68..f1711ac 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -3091,6 +3091,8 @@ static const struct pci_device_id lan743x_pcidev_tbl[] = {
 	{ 0, }
 };
 
+MODULE_DEVICE_TABLE(pci, lan743x_pcidev_tbl);
+
 static struct pci_driver lan743x_pcidev_driver = {
 	.name     = DRIVER_NAME,
 	.id_table = lan743x_pcidev_tbl,
-- 
2.7.4

