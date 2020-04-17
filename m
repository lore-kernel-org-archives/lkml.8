Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4ABBC38A2D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C4D72223C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=b1c1l1.com header.i=@b1c1l1.com header.b="njX+6R2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbgDQSyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:54:09 -0400
Received: from vip1.b1c1l1.com ([64.57.102.218]:25934 "EHLO vip1.b1c1l1.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbgDQSyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:54:09 -0400
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Apr 2020 14:54:08 EDT
Received: by vip1.b1c1l1.com (Postfix) with ESMTPSA id A87BB2736E;
        Fri, 17 Apr 2020 18:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b1c1l1.com; s=alpha;
        t=1587149211; bh=21Z3XZpk5doVQ7kvJjQwghYdVAHE9CLZRZ7gAMPbpEs=;
        h=From:To:Cc:Subject:Date;
        b=njX+6R2n2qQaGQZkVFPai/Q7+U1sUK2OFxcjHcPXIr0BWt7WhOo6Ght71tRsaoUG8
         +GbvZ9x/cp0vgaDcogTwKGo2vyK3zsSxtbqsTHbDAUO3L3f2ebKOEPo3PfCzr3gx3c
         T4tKLpTB23Qyoehsn8+xB3xSxGmz+BgbF6zeGvVKq7anIOPZjNwyjF5YkGLmE1UnoL
         opdDcvSN9ktHI3G+MSENg7U2I+6stXxajknPQ9wZvcwEXPo9zA0zWBVOBuzieUvuHu
         rPMVRjV6GnZJyvvxU3UaJeF3aaEyAShsBvqNDMTRLYTftKUQTUKk5XWhCYb09ypOwA
         jGO6GCiKZKSug==
From:   Benjamin Lee <ben@b1c1l1.com>
To:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Benjamin Lee <ben@b1c1l1.com>
Subject: [PATCH] mei: me: fix irq number stored in hw struct
Date:   Fri, 17 Apr 2020 11:45:38 -0700
Message-Id: <20200417184538.349550-1-ben@b1c1l1.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 261b3e1f2a01 ("mei: me: store irq number in the hw struct.")
stores the irq number in the hw struct before MSI is enabled.  This
caused a regression for mei_me_synchronize_irq() waiting for the wrong
irq number.  On my laptop this causes a hang on shutdown.  Fix the issue
by storing the irq number after enabling MSI.

Fixes: 261b3e1f2a01 ("mei: me: store irq number in the hw struct.")
Signed-off-by: Benjamin Lee <ben@b1c1l1.com>
---
 drivers/misc/mei/pci-me.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 3d21c38e2dbb..0c390fe421ad 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -203,11 +203,12 @@ static int mei_me_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	hw = to_me_hw(dev);
 	hw->mem_addr = pcim_iomap_table(pdev)[0];
-	hw->irq = pdev->irq;
 	hw->read_fws = mei_me_read_fws;
 
 	pci_enable_msi(pdev);
 
+	hw->irq = pdev->irq;
+
 	 /* request and enable interrupt */
 	irqflags = pci_dev_msi_enabled(pdev) ? IRQF_ONESHOT : IRQF_SHARED;
 
-- 
2.26.1

