Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9752BC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E5120575
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgEFMs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 08:48:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3823 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728181AbgEFMs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 08:48:58 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C3A5226F2CDBECB1275D;
        Wed,  6 May 2020 20:48:55 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Wed, 6 May 2020 20:48:49 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <gregkh@linuxfoundation.org>, <simon@nikanor.nu>,
        <jeremy@azazel.net>, <dan.carpenter@oracle.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] staging: kpc2000: fix error return code in kp2000_pcie_probe()
Date:   Wed, 6 May 2020 12:52:55 +0000
Message-ID: <20200506125255.90336-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function. Also
removed var 'rv' since we can use 'err' instead.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/staging/kpc2000/kpc2000/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc2000/kpc2000/core.c
index 7b00d7069e21..14e07742dc9d 100644
--- a/drivers/staging/kpc2000/kpc2000/core.c
+++ b/drivers/staging/kpc2000/kpc2000/core.c
@@ -298,7 +298,6 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 {
 	int err = 0;
 	struct kp2000_device *pcard;
-	int rv;
 	unsigned long reg_bar_phys_addr;
 	unsigned long reg_bar_phys_len;
 	unsigned long dma_bar_phys_addr;
@@ -445,11 +444,11 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	if (err < 0)
 		goto err_release_dma;
 
-	rv = request_irq(pcard->pdev->irq, kp2000_irq_handler, IRQF_SHARED,
+	err = request_irq(pcard->pdev->irq, kp2000_irq_handler, IRQF_SHARED,
 			 pcard->name, pcard);
-	if (rv) {
+	if (err) {
 		dev_err(&pcard->pdev->dev,
-			"%s: failed to request_irq: %d\n", __func__, rv);
+			"%s: failed to request_irq: %d\n", __func__, err);
 		goto err_disable_msi;
 	}



