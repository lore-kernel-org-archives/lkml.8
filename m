Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BB7C3F36B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9714721D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811686;
	bh=k+XzV/W9UPSf5JZG4LsaLccqrAu0LZ7Ag9WTLrAZBPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I1sll0NSQwzI9spjeJIGR8A7TNMjW47OD2I3MF9RpAzOqZ9Lv88L7qYKge20Y3s35
	 o50B7RqgHXT6vcfWHcsgvf/w2eJCbl27e3XaCHL3hrBCVK9yUNlXON7fA8/BAfXBvP
	 qPNKWB/0oMfRvRWtaQMhxdFsLI0BNwrnz0TU//9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbgB0Nyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:54:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:54658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731851AbgB0Nye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:54:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE63A20578;
        Thu, 27 Feb 2020 13:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811673;
        bh=k+XzV/W9UPSf5JZG4LsaLccqrAu0LZ7Ag9WTLrAZBPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0l8QRQEB3z2Ec1AxKNGuNCtjcvdDlnYmOATLeZYimimbkJdFLKsxeI5ibMDJ9fbbn
         nWC4YSSJCJNKyT8NM/5U64djGANw5Zx+BbfYOuJWlc4jkMVMM/VBOWeAraqonsdLIY
         XuDuSZgq+UBlbzBHuneFRpsVQPdB+06ywSZyX7wM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 057/237] uio: fix a sleep-in-atomic-context bug in uio_dmem_genirq_irqcontrol()
Date:   Thu, 27 Feb 2020 14:34:31 +0100
Message-Id: <20200227132301.094280994@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit b74351287d4bd90636c3f48bc188c2f53824c2d4 ]

The driver may sleep while holding a spinlock.
The function call path (from bottom to top) in Linux 4.19 is:

kernel/irq/manage.c, 523:
	synchronize_irq in disable_irq
drivers/uio/uio_dmem_genirq.c, 140:
	disable_irq in uio_dmem_genirq_irqcontrol
drivers/uio/uio_dmem_genirq.c, 134:
	_raw_spin_lock_irqsave in uio_dmem_genirq_irqcontrol

synchronize_irq() can sleep at runtime.

To fix this bug, disable_irq() is called without holding the spinlock.

This bug is found by a static analysis tool STCheck written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Link: https://lore.kernel.org/r/20191218094405.6009-1-baijiaju1990@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/uio/uio_dmem_genirq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index e1134a4d97f3f..a00b4aee6c799 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -135,11 +135,13 @@ static int uio_dmem_genirq_irqcontrol(struct uio_info *dev_info, s32 irq_on)
 	if (irq_on) {
 		if (test_and_clear_bit(0, &priv->flags))
 			enable_irq(dev_info->irq);
+		spin_unlock_irqrestore(&priv->lock, flags);
 	} else {
-		if (!test_and_set_bit(0, &priv->flags))
+		if (!test_and_set_bit(0, &priv->flags)) {
+			spin_unlock_irqrestore(&priv->lock, flags);
 			disable_irq(dev_info->irq);
+		}
 	}
-	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
 }
-- 
2.20.1



