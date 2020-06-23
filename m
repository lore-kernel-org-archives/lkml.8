Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022E1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C198620781
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947684;
	bh=Z5+iae7O1IBaXzbp31Bv+xjUPxPHGzZmO/+WtcNA0ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wUk4cc+u2VGIhbcb3I24HIdAZ9zdydvNTpqto1aC2cETM+m1sF83GreY0QdwmQu1G
	 f+easAWIK7MNgZQQHoUeJge5KfEw/mIb8FcERRc1PzeeGZ+E5gKKkP9jsQF73+RUAo
	 0VkkCypVicCCCQ/zwO2FMwhrOcx+uzn6mCru5SK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392845AbgFWV2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:28:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389424AbgFWUQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:16:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BBFC20702;
        Tue, 23 Jun 2020 20:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943388;
        bh=Z5+iae7O1IBaXzbp31Bv+xjUPxPHGzZmO/+WtcNA0ZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jptofElDuJb7mH0nRCizUorY4fixdRVIiS9RxVvFglmmbk1fh4Rl/T2/yD2J5Bogu
         ngBKJ8+hzFRdcznr2KebmLDBFgFx2QqflN+mIzpWQxkzeu8afy0/zS4/62Mir/0rTO
         ShkKNDD36XfjeuKD4LEPXnU3Q5SzpgPtikfeD5vQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>,
        Alexander Fomichev <fomichev.ru@gmail.com>,
        Jon Mason <jdmason@kudzu.us>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 342/477] NTB: Revert the change to use the NTB device dev for DMA allocations
Date:   Tue, 23 Jun 2020 21:55:39 +0200
Message-Id: <20200623195423.706814702@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index c9a0912b175fa..f8f75a504a581 100644
--- a/drivers/ntb/core.c
+++ b/drivers/ntb/core.c
@@ -311,4 +311,3 @@ static void __exit ntb_driver_exit(void)
 	bus_unregister(&ntb_bus);
 }
 module_exit(ntb_driver_exit);
-
-- 
2.25.1



