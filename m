Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A240C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53DE4221EB
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592443117;
	bh=YTPK4gDULgXHgBeBf9fRR92kyb9GbSxulZ74DiQGJ14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LL5IAO6OKebsa5PnD4Pug1oIBKfMFg95Dfn+R+5W3DceOVleDHMBvp0O1fdbypEwy
	 JKYsxoYuaZvJ3gVc3CGPKU1yt2LmpfH2TTVXHexmtz+qivarfB1hMXllLMiEaLfhO2
	 whvOi7MI+nLA3Dr8G5FCHPGE9B+dFFFAmKmPh/10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgFRBSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:18:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbgFRBPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:15:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBD7B221F1;
        Thu, 18 Jun 2020 01:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442938;
        bh=YTPK4gDULgXHgBeBf9fRR92kyb9GbSxulZ74DiQGJ14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OeWPlgqwXguu/UWrZhCyISLAR0itVzmRn78qqLLXxxIqcEX7ey1FBm22/hAlI29yW
         k/G4byxtqecdjMDXwibangRfJDhyE7Yuof4ijnFfLbeNnpndojEpO/Qw9NSR7ZPLjz
         TNJzKZe7NRDHPbKwHE6Q4gcB/mE0VkQabcW39f0U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Alexander Fomichev <fomichev.ru@gmail.com>,
        Jon Mason <jdmason@kudzu.us>, Sasha Levin <sashal@kernel.org>,
        linux-ntb@googlegroups.com
Subject: [PATCH AUTOSEL 5.7 350/388] NTB: Revert the change to use the NTB device dev for DMA allocations
Date:   Wed, 17 Jun 2020 21:07:27 -0400
Message-Id: <20200618010805.600873-350-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Logan Gunthorpe <logang@deltatee.com>

[ Upstream commit 40da7d9a93c8941737ef4a1208d32c13ce017fe1 ]

Commit 417cf39cfea9 ("NTB: Set dma mask and dma coherent mask to NTB
devices") started using the NTB device for DMA allocations which was
turns out was wrong. If the IOMMU is enabled, such alloctanions will
always fail with messages such as:

  DMAR: Allocating domain for 0000:02:00.1 failed

This is because the IOMMU has not setup the device for such use.

Change the tools back to using the PCI device for allocations seeing
it doesn't make sense to add an IOMMU group for the non-physical NTB
device. Also remove the code that sets the DMA mask as it no longer
makes sense to do this.

Fixes: 7f46c8b3a552 ("NTB: ntb_tool: Add full multi-port NTB API support")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Tested-by: Alexander Fomichev <fomichev.ru@gmail.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ntb/core.c b/drivers/ntb/core.c
index c9a0912b175f..f8f75a504a58 100644
--- a/drivers/ntb/core.c
+++ b/drivers/ntb/core.c
@@ -311,4 +311,3 @@ static void __exit ntb_driver_exit(void)
 	bus_unregister(&ntb_bus);
 }
 module_exit(ntb_driver_exit);
-
-- 
2.25.1

