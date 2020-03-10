Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1399FC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF79120873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846254;
	bh=K31iMwjFwLUoebf/5KGPliRCLwbi/8nGPhXzK8pMlGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pstAchGo8bauOEwr1WDb2NbAYFSY6TOxySHD7NxmotqaDfs7cTGQLCGdJjxfKbVz+
	 h0cTk+Axn1aOXOkVWmOxctSK9S3Me8rGFlXGPf1UHRfroGbOorI94L7yQ9McSMcajD
	 BRhMvORypt5cbTNplcbmglir9aYwXquLyeKCox4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbgCJNLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731062AbgCJNL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:11:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 488FE24649;
        Tue, 10 Mar 2020 13:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845888;
        bh=K31iMwjFwLUoebf/5KGPliRCLwbi/8nGPhXzK8pMlGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UL6gJPY4GQADzWSecpfRvog+0LSPj+S2dtDfUqNl2GEJTNn4VldBYdmjA2TgDmlWh
         JgED68T7n3LeR083Fpdt+OjSWWacE9V0LEdIuPJ4zOEV/9O4Z95YSe/8m0Riy+yzi0
         pxGHp+gy04wRfaXyHIYj81Xw0xpZCvQjVp2hhptk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Nazarewicz <mina86@mina86.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 11/86] usb: gadget: ffs: ffs_aio_cancel(): Save/restore IRQ flags
Date:   Tue, 10 Mar 2020 13:44:35 +0100
Message-Id: <20200310124531.408189789@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124530.808338541@linuxfoundation.org>
References: <20200310124530.808338541@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

[ Upstream commit 43d565727a3a6fd24e37c7c2116475106af71806 ]

ffs_aio_cancel() can be called from both interrupt and thread context. Make
sure that the current IRQ state is saved and restored by using
spin_{un,}lock_irq{save,restore}().

Otherwise undefined behavior might occur.

Acked-by: Michal Nazarewicz <mina86@mina86.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 2050993fb58b7..a9239455eb6d8 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1077,18 +1077,19 @@ static int ffs_aio_cancel(struct kiocb *kiocb)
 {
 	struct ffs_io_data *io_data = kiocb->private;
 	struct ffs_epfile *epfile = kiocb->ki_filp->private_data;
+	unsigned long flags;
 	int value;
 
 	ENTER();
 
-	spin_lock_irq(&epfile->ffs->eps_lock);
+	spin_lock_irqsave(&epfile->ffs->eps_lock, flags);
 
 	if (likely(io_data && io_data->ep && io_data->req))
 		value = usb_ep_dequeue(io_data->ep, io_data->req);
 	else
 		value = -EINVAL;
 
-	spin_unlock_irq(&epfile->ffs->eps_lock);
+	spin_unlock_irqrestore(&epfile->ffs->eps_lock, flags);
 
 	return value;
 }
-- 
2.20.1



