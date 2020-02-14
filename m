Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B43BC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C723A24705
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697591;
	bh=k+XzV/W9UPSf5JZG4LsaLccqrAu0LZ7Ag9WTLrAZBPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kaIKFCp0dVXyKT8wyI2O4iti2lCMgLe9Xdlidu95pZseapl8nj6wkxxoZYSQhWTEL
	 hKg0vtCAaalhLvrD+KwPWHpEk/Q79rp/F29BGDZ/w8ENb5Zbs4jTJLgE5X6K7b1Acq
	 LUxsLoi1YBW5lhB9zWGtMNJstWasAH7D41kGKn8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406449AbgBNQ0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:26:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:33326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405931AbgBNQYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:24:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CECA424790;
        Fri, 14 Feb 2020 16:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697478;
        bh=k+XzV/W9UPSf5JZG4LsaLccqrAu0LZ7Ag9WTLrAZBPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wOX9Xk52fGKVa+Kk9u9N6tM5NZLt8paakjTtEclMdyoyV4AW2aBqHn6YCHIidBIRY
         k3BatvVA4ilpObxE9d6zTRibq+wj/39Zj462EUArYEP7Ac5AVS8h6UylNmaVeZvOnV
         I50fHLqAYjv+TIejXIB9t9KAfxFDl5OsUnQzdRx0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 010/100] uio: fix a sleep-in-atomic-context bug in uio_dmem_genirq_irqcontrol()
Date:   Fri, 14 Feb 2020 11:22:54 -0500
Message-Id: <20200214162425.21071-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162425.21071-1-sashal@kernel.org>
References: <20200214162425.21071-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

