Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE493C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36D520716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693481;
	bh=cBJbYSQY8TZQCT0eXnANmfIOvzV3nWmaS0vZYyZEUrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oky6jKMv5qLfqS/PGCReultT1XZVRDo1gDDOmGkgoWfR8aN5k9CCUM/2dqVb5+BwR
	 EnYwqe9afW/iSaUwn0hDUK1oXaLq0AZ6o1wjDosneCHgjd/UZATPtbShsKnP1R7/ov
	 71WOygiaMsfffZhvqxfMxNdCRKGSasOThd0HBYUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732635AbgHQToi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:44:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729466AbgHQPWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:22:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5D5522DBF;
        Mon, 17 Aug 2020 15:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677752;
        bh=cBJbYSQY8TZQCT0eXnANmfIOvzV3nWmaS0vZYyZEUrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d2v42+PS65/WWMFzjKL+yP6M1gaCcjMKt9VbwsMSFGoeolwZ+bSpvFd7b+pObQYan
         YCNqsCMcwPntFSw7OByXOnojkG+I2YoTV9xQuldtbT0tOLNkbl6UUKUlQM5wX0RigH
         uJTJ3N0sn4KO5GFtX8WJs8CBqlDlHW//GA/qZMoc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shannon Nelson <snelson@pensando.io>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 096/464] ionic: rearrange reset and bus-master control
Date:   Mon, 17 Aug 2020 17:10:49 +0200
Message-Id: <20200817143838.390705511@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shannon Nelson <snelson@pensando.io>

[ Upstream commit 6a6014e2fb276753d4dc9b803370e7af7f57e30b ]

We can prevent potential incorrect DMA access attempts from the
NIC by enabling bus-master after the reset, and by disabling
bus-master earlier in cleanup.

Signed-off-by: Shannon Nelson <snelson@pensando.io>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index 2924cde440aa8..85c686c16741f 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -247,12 +247,11 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_pci_disable_device;
 	}
 
-	pci_set_master(pdev);
 	pcie_print_link_status(pdev);
 
 	err = ionic_map_bars(ionic);
 	if (err)
-		goto err_out_pci_clear_master;
+		goto err_out_pci_disable_device;
 
 	/* Configure the device */
 	err = ionic_setup(ionic);
@@ -260,6 +259,7 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_err(dev, "Cannot setup device: %d, aborting\n", err);
 		goto err_out_unmap_bars;
 	}
+	pci_set_master(pdev);
 
 	err = ionic_identify(ionic);
 	if (err) {
@@ -350,6 +350,7 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ionic_reset(ionic);
 err_out_teardown:
 	ionic_dev_teardown(ionic);
+	pci_clear_master(pdev);
 	/* Don't fail the probe for these errors, keep
 	 * the hw interface around for inspection
 	 */
@@ -358,8 +359,6 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_out_unmap_bars:
 	ionic_unmap_bars(ionic);
 	pci_release_regions(pdev);
-err_out_pci_clear_master:
-	pci_clear_master(pdev);
 err_out_pci_disable_device:
 	pci_disable_device(pdev);
 err_out_debugfs_del_dev:
@@ -389,9 +388,9 @@ static void ionic_remove(struct pci_dev *pdev)
 	ionic_port_reset(ionic);
 	ionic_reset(ionic);
 	ionic_dev_teardown(ionic);
+	pci_clear_master(pdev);
 	ionic_unmap_bars(ionic);
 	pci_release_regions(pdev);
-	pci_clear_master(pdev);
 	pci_disable_device(pdev);
 	ionic_debugfs_del_dev(ionic);
 	mutex_destroy(&ionic->dev_cmd_lock);
-- 
2.25.1



