Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F131C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27606206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592934038;
	bh=LFcgnPZDwiKQtMWFFtgLw9vW/3moNMK4L7nJadX0foI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V+GMTHuObImDCyxQyrx754zp2TCjGoMka6MWHB+hwJQz5IBouq/mqXSQq3nBBZiOi
	 2UtL9N4zboQh/kXL/poE1wVc1NahJZut9B/5cW8257tCH65SqRsS4G0QtxHVGc2ptA
	 b0Nw7zK8/tyOhh2ArVTbZwlbCoY/GVLpELWOmzZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387901AbgFWRkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:40:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387489AbgFWRgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:36:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E843920780;
        Tue, 23 Jun 2020 17:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592933769;
        bh=LFcgnPZDwiKQtMWFFtgLw9vW/3moNMK4L7nJadX0foI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h7EQgea45v/I49sentiSdIczRMVabmf0c4414RmSNsp37esASr7zg8nDf14sZCSr6
         eMZIbgI35LFv1TZ1fmGMFZtZUrAGvov+vTc0TELWAzpRJMSimaP6H3XQIZ5dP03mPU
         PLKny0LYzasOIG2CYpo3EGsMpGsFRGzm//u27ck4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zekun Shen <bruceshenzk@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 08/24] net: alx: fix race condition in alx_remove
Date:   Tue, 23 Jun 2020 13:35:43 -0400
Message-Id: <20200623173559.1355728-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623173559.1355728-1-sashal@kernel.org>
References: <20200623173559.1355728-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zekun Shen <bruceshenzk@gmail.com>

[ Upstream commit e89df5c4322c1bf495f62d74745895b5fd2a4393 ]

There is a race condition exist during termination. The path is
alx_stop and then alx_remove. An alx_schedule_link_check could be called
before alx_stop by interrupt handler and invoke alx_link_check later.
Alx_stop frees the napis, and alx_remove cancels any pending works.
If any of the work is scheduled before termination and invoked before
alx_remove, a null-ptr-deref occurs because both expect alx->napis[i].

This patch fix the race condition by moving cancel_work_sync functions
before alx_free_napis inside alx_stop. Because interrupt handler can call
alx_schedule_link_check again, alx_free_irq is moved before
cancel_work_sync calls too.

Signed-off-by: Zekun Shen <bruceshenzk@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/atheros/alx/main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/atheros/alx/main.c b/drivers/net/ethernet/atheros/alx/main.c
index d4bbcdfd691af..aa693c8e285ab 100644
--- a/drivers/net/ethernet/atheros/alx/main.c
+++ b/drivers/net/ethernet/atheros/alx/main.c
@@ -1249,8 +1249,12 @@ static int __alx_open(struct alx_priv *alx, bool resume)
 
 static void __alx_stop(struct alx_priv *alx)
 {
-	alx_halt(alx);
 	alx_free_irq(alx);
+
+	cancel_work_sync(&alx->link_check_wk);
+	cancel_work_sync(&alx->reset_wk);
+
+	alx_halt(alx);
 	alx_free_rings(alx);
 	alx_free_napis(alx);
 }
@@ -1858,9 +1862,6 @@ static void alx_remove(struct pci_dev *pdev)
 	struct alx_priv *alx = pci_get_drvdata(pdev);
 	struct alx_hw *hw = &alx->hw;
 
-	cancel_work_sync(&alx->link_check_wk);
-	cancel_work_sync(&alx->reset_wk);
-
 	/* restore permanent mac address */
 	alx_set_macaddr(hw, hw->perm_addr);
 
-- 
2.25.1

