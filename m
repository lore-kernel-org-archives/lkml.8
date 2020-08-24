Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004E9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C24CE204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598259258;
	bh=DEIzWlFMX1UkBVELWIqCP0YzQoXxsQ9mYQ+glvAl7CE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lLVbMnf9priqGTgLEfaDGOM6hpH3jCgQVhoxQ8vkUzwOT5wZjOfnyfwcHBcO5KCCh
	 y42Xg3dWJjYV18lkivpAS9fMg9r/imUEmEKMwhe13D2yWgwwrws3XtgR2KXuFGGN1t
	 cv+uN1POuWo3QoN8uZH5W+nv4pWcvG1Xn5xFCQAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbgHXIyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730280AbgHXIyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:54:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25E1F207D3;
        Mon, 24 Aug 2020 08:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259247;
        bh=DEIzWlFMX1UkBVELWIqCP0YzQoXxsQ9mYQ+glvAl7CE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r67yrToZLpLjQAA01fqk7x4TRl0UE+3rlN3Y3OlXYvfl3K09b2GmRZDHH4t5IRWuz
         7Acul8Vsc5MaMux00AariPrvW1uAaEwdLsHBr+zyUdRsPmgXbUyr5olIU98rHHKUEb
         FfZ7DaTpBnBSrnDTtnSCRln7KLXlhXJ/rgI/KPeQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 36/50] net: fec: correct the error path for regulator disable in probe
Date:   Mon, 24 Aug 2020 10:31:37 +0200
Message-Id: <20200824082353.877001900@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082351.823243923@linuxfoundation.org>
References: <20200824082351.823243923@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

[ Upstream commit c6165cf0dbb82ded90163dce3ac183fc7a913dc4 ]

Correct the error path for regulator disable.

Fixes: 9269e5560b26 ("net: fec: add phy-reset-gpios PROBE_DEFER check")
Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fec_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 8ba915cc4c2e4..22f964ef859e5 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3536,11 +3536,11 @@ fec_probe(struct platform_device *pdev)
 failed_irq:
 failed_init:
 	fec_ptp_stop(pdev);
-	if (fep->reg_phy)
-		regulator_disable(fep->reg_phy);
 failed_reset:
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	if (fep->reg_phy)
+		regulator_disable(fep->reg_phy);
 failed_regulator:
 	clk_disable_unprepare(fep->clk_ahb);
 failed_clk_ahb:
-- 
2.25.1



