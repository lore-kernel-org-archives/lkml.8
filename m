Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47455C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2424821548
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590667723;
	bh=K7lgPnmnyd9zaQE8Biv09xlGJPFmPcPUvqaqpNNNsKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TnjgqrK+5T8wxUj9+MeQ309WY3U7IW55rOWRDCJ7bAgO+JRkSyYjSc3EX1k/f0vpJ
	 vt01GquTma5NXG473PVg38+pG9AXJgUYwXX/8nCP9XhFhvCDeLF916V9cR0Kfighov
	 hLH80vWbxrJ33NprWk3fVPd/ZDFXyZOyicaN1sNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389419AbgE1MIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:08:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388769AbgE1L4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:56:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FC8020DD4;
        Thu, 28 May 2020 11:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590666995;
        bh=K7lgPnmnyd9zaQE8Biv09xlGJPFmPcPUvqaqpNNNsKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jKT4rEJnVSgVj1rAi1sBSz6+ZavTbFy743Tw0jg/N3SnCu0XHijX+MgHUUucvGTYl
         QGeVN2VwGiDBPQFqOSUm39wcwas4yr/VfcrLWUEmikSzjk/Ea12GllV8TB6H8Ca8Rn
         41BeDr6iIE9IfsoPi+gHsLdU0YbrEApUVcdKPzo8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Valentin Longchamp <valentin@longchamp.me>,
        Matteo Ghidoni <matteo.ghidoni@ch.abb.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.6 30/47] net/ethernet/freescale: rework quiesce/activate for ucc_geth
Date:   Thu, 28 May 2020 07:55:43 -0400
Message-Id: <20200528115600.1405808-30-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528115600.1405808-1-sashal@kernel.org>
References: <20200528115600.1405808-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Longchamp <valentin@longchamp.me>

[ Upstream commit 79dde73cf9bcf1dd317a2667f78b758e9fe139ed ]

ugeth_quiesce/activate are used to halt the controller when there is a
link change that requires to reconfigure the mac.

The previous implementation called netif_device_detach(). This however
causes the initial activation of the netdevice to fail precisely because
it's detached. For details, see [1].

A possible workaround was the revert of commit
net: linkwatch: add check for netdevice being present to linkwatch_do_dev
However, the check introduced in the above commit is correct and shall be
kept.

The netif_device_detach() is thus replaced with
netif_tx_stop_all_queues() that prevents any tranmission. This allows to
perform mac config change required by the link change, without detaching
the corresponding netdevice and thus not preventing its initial
activation.

[1] https://lists.openwall.net/netdev/2020/01/08/201

Signed-off-by: Valentin Longchamp <valentin@longchamp.me>
Acked-by: Matteo Ghidoni <matteo.ghidoni@ch.abb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 0d101c00286f..ab1b4a77b4a3 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -42,6 +42,7 @@
 #include <soc/fsl/qe/ucc.h>
 #include <soc/fsl/qe/ucc_fast.h>
 #include <asm/machdep.h>
+#include <net/sch_generic.h>
 
 #include "ucc_geth.h"
 
@@ -1548,11 +1549,8 @@ static int ugeth_disable(struct ucc_geth_private *ugeth, enum comm_dir mode)
 
 static void ugeth_quiesce(struct ucc_geth_private *ugeth)
 {
-	/* Prevent any further xmits, plus detach the device. */
-	netif_device_detach(ugeth->ndev);
-
-	/* Wait for any current xmits to finish. */
-	netif_tx_disable(ugeth->ndev);
+	/* Prevent any further xmits */
+	netif_tx_stop_all_queues(ugeth->ndev);
 
 	/* Disable the interrupt to avoid NAPI rescheduling. */
 	disable_irq(ugeth->ug_info->uf_info.irq);
@@ -1565,7 +1563,10 @@ static void ugeth_activate(struct ucc_geth_private *ugeth)
 {
 	napi_enable(&ugeth->napi);
 	enable_irq(ugeth->ug_info->uf_info.irq);
-	netif_device_attach(ugeth->ndev);
+
+	/* allow to xmit again  */
+	netif_tx_wake_all_queues(ugeth->ndev);
+	__netdev_watchdog_up(ugeth->ndev);
 }
 
 /* Called every time the controller might need to be made
-- 
2.25.1

