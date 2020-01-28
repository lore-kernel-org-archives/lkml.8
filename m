Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E80CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC51F2469B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220753;
	bh=DmRJo0p4TExwlSUs+a2X+E6ya8Q/AADkX/YVkV2Pce4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Eb4UDq97lHbhngPPAxSo5lFl1TlMK9XzMKToB2nguuvSkPKQvxUe9hRs16uYLEHU+
	 ptluqyqG2wnMOYRF6mFoGa921+vx6S8rDOccL3r7P+Nq75cjpLiciadZp56d/XGAMp
	 K51Nk8LeNNfF/msw1DpaoTSvEH1Lqmej6ZWIeMA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgA1OMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:12:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:33762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729485AbgA1OM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:12:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D02592468D;
        Tue, 28 Jan 2020 14:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220748;
        bh=DmRJo0p4TExwlSUs+a2X+E6ya8Q/AADkX/YVkV2Pce4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UAk+cX+lokXklwfq3bSxuJjDSuTkigxWyrsdDMTpKKcsoRjXrwukN/3Z2YKWMsDOf
         W3JZo7kS0b0MAbgjOkrECWLraECM1W8cteyCYUgeNHgAqyWQWuzb38aKUo1aBJCXCf
         ZeWYZxclKo4efGnzaRbvnldkMnOeprnkp0Q6oxa4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 131/183] bcma: fix incorrect update of BCMA_CORE_PCI_MDIO_DATA
Date:   Tue, 28 Jan 2020 15:05:50 +0100
Message-Id: <20200128135842.930716701@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 420c20be08a4597404d272ae9793b642401146eb ]

An earlier commit re-worked the setting of the bitmask and is now
assigning v with some bit flags rather than bitwise or-ing them
into v, consequently the earlier bit-settings of v are being lost.
Fix this by replacing an assignment with the bitwise or instead.

Addresses-Coverity: ("Unused value")
Fixes: 2be25cac8402 ("bcma: add constants for PCI and use them")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bcma/driver_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bcma/driver_pci.c b/drivers/bcma/driver_pci.c
index f499a469e66d0..12b2cc9a3fbe8 100644
--- a/drivers/bcma/driver_pci.c
+++ b/drivers/bcma/driver_pci.c
@@ -78,7 +78,7 @@ static u16 bcma_pcie_mdio_read(struct bcma_drv_pci *pc, u16 device, u8 address)
 		v |= (address << BCMA_CORE_PCI_MDIODATA_REGADDR_SHF_OLD);
 	}
 
-	v = BCMA_CORE_PCI_MDIODATA_START;
+	v |= BCMA_CORE_PCI_MDIODATA_START;
 	v |= BCMA_CORE_PCI_MDIODATA_READ;
 	v |= BCMA_CORE_PCI_MDIODATA_TA;
 
@@ -121,7 +121,7 @@ static void bcma_pcie_mdio_write(struct bcma_drv_pci *pc, u16 device,
 		v |= (address << BCMA_CORE_PCI_MDIODATA_REGADDR_SHF_OLD);
 	}
 
-	v = BCMA_CORE_PCI_MDIODATA_START;
+	v |= BCMA_CORE_PCI_MDIODATA_START;
 	v |= BCMA_CORE_PCI_MDIODATA_WRITE;
 	v |= BCMA_CORE_PCI_MDIODATA_TA;
 	v |= data;
-- 
2.20.1



