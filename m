Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B1DC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9AC20684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195292;
	bh=eSzMcQYi0nGtxL8imlw/3iEIcs2mG+60LHYeDMeYRa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t+za2hP5R+XZQqYTmk8Qb9o/GymKps6MVIrcA1GQ7tAYPq112EcS7BwphxMQ96P2U
	 wCjJkmeaf3bpmBtC8/Fks9Us4nBWxmjpTJbJODDLRfL6VTcTN32xwUtyMIpPk10onO
	 rEB9Le5iatIUKfZrIznU8TXj+xq6ZBF4EBMdDGHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391634AbgAPRVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:21:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:43340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391252AbgAPRRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:17:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4798024693;
        Thu, 16 Jan 2020 17:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195061;
        bh=eSzMcQYi0nGtxL8imlw/3iEIcs2mG+60LHYeDMeYRa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uiwISQ4MEDPX688wOcgA/9H45nx/K6YwiKUYnNm7Wi0R4bHnwN8qs9+3Uv1MBiwYg
         PTgFlDynSYl9wF+KzlNZs/jxK3ItEjRsHmvrWw6jZFHle4zeoR1Sigq/ijtZvKhlAx
         +k1rUpmGVhVbNLpJSwRlrFEVhtdIyUGLvG/fl2hg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jon Mason <jdmason@kudzu.us>, Sasha Levin <sashal@kernel.org>,
        linux-ntb@googlegroups.com
Subject: [PATCH AUTOSEL 4.14 016/371] NTB: ntb_hw_idt: replace IS_ERR_OR_NULL with regular NULL checks
Date:   Thu, 16 Jan 2020 12:11:24 -0500
Message-Id: <20200116171719.16965-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116171719.16965-1-sashal@kernel.org>
References: <20200116171719.16965-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

[ Upstream commit 1b7619828d0c341612f58683e73f279c37e70bbc ]

Both devm_kcalloc() and devm_kzalloc() return NULL on error. They
never return error pointers.

The use of IS_ERR_OR_NULL is currently applied to the wrong
context.

Fix this by replacing IS_ERR_OR_NULL with regular NULL checks.

Fixes: bf2a952d31d2 ("NTB: Add IDT 89HPESxNTx PCIe-switches support")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index d44d7ef38fe8..b68e2cad74cc 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -1105,9 +1105,9 @@ static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
 	}
 
 	/* Allocate memory for memory window descriptors */
-	ret_mws = devm_kcalloc(&ndev->ntb.pdev->dev, *mw_cnt,
-				sizeof(*ret_mws), GFP_KERNEL);
-	if (IS_ERR_OR_NULL(ret_mws))
+	ret_mws = devm_kcalloc(&ndev->ntb.pdev->dev, *mw_cnt, sizeof(*ret_mws),
+			       GFP_KERNEL);
+	if (!ret_mws)
 		return ERR_PTR(-ENOMEM);
 
 	/* Copy the info of detected memory windows */
@@ -2393,7 +2393,7 @@ static struct idt_ntb_dev *idt_create_dev(struct pci_dev *pdev,
 
 	/* Allocate memory for the IDT PCIe-device descriptor */
 	ndev = devm_kzalloc(&pdev->dev, sizeof(*ndev), GFP_KERNEL);
-	if (IS_ERR_OR_NULL(ndev)) {
+	if (!ndev) {
 		dev_err(&pdev->dev, "Memory allocation failed for descriptor");
 		return ERR_PTR(-ENOMEM);
 	}
-- 
2.20.1

