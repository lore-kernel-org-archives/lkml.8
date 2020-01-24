Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAB5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8FF20718
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859021;
	bh=5sc1dXdFGuhNAx5DM9UjZg9os1fM7VyBzbB+TYU6nGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z5OUKfDr6xKhy86gfZGLQJhky5JVHXBJN2X92ibMp0+q3tLgHBSkHVcuPcSru1sXg
	 E+QKoKpXW8czxtdlzOSE6nPcy0KgTqBvv4setL2ZN/ll+fnzkDfKrwDVtzEuCJgZbp
	 L1Qk+SN6feK0vENhzysEr4D+ufp284H3oLRIBEWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733235AbgAXJnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:43:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:41738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733222AbgAXJni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:43:38 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FAB9222D9;
        Fri, 24 Jan 2020 09:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859017;
        bh=5sc1dXdFGuhNAx5DM9UjZg9os1fM7VyBzbB+TYU6nGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lv1IgX7B6Fq74RxgZU5Jn7EMsawPaLBEP9py1Eo5LKjUQQfGxtBIIczSmQdqcxljZ
         TehqSBrl9KNyyoq5lxC3KabktBBWXyiGxbwlqV9nVVqT5tZtN8w++vhpThl6xcADFX
         u0757rOsyr1tXFoO2sTE1xf5m2lcb/wEif5Q1bzY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jon Mason <jdmason@kudzu.us>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 023/343] NTB: ntb_hw_idt: replace IS_ERR_OR_NULL with regular NULL checks
Date:   Fri, 24 Jan 2020 10:27:21 +0100
Message-Id: <20200124092922.647523449@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

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
index d44d7ef38fe88..b68e2cad74cc7 100644
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



