Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC7AC3F2D2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2650924680
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583203678;
	bh=oK3VlKykMd14h0+qC0KHi9ORL2bg4TEb/vdCaZ/mivY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p6XA90V5tgxQsQKTnYVTDAOCQt/t+08XfW5LigToKiUimY5pwIjtaSbB0kyDUkHx1
	 L361t2QlG8FdtZ1+56RcIw0tvEJqRCGPZXdWZAY8Pp3mt/EyCyQTER9APxrMTQXeLo
	 JsXbtEhrbIJe3qrkDQmFKsZIEN5pCTj3u06GtVf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgCCCr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:47:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:42922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbgCCCrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:47:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33B532468D;
        Tue,  3 Mar 2020 02:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203668;
        bh=oK3VlKykMd14h0+qC0KHi9ORL2bg4TEb/vdCaZ/mivY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kq4evKZ/l0cmjKrg9kB8hfIrJxormJRUeoGSKMiSYifX9H4WV0O1MWUBIzzgujJnE
         XCwFAI3s8jrdhocFnUHnBfIsgP4++k/xO3CJczhWtDdRhvxn7voTRxcNbm0MRlXU+R
         NN8T+01abFwx/gpieJUhKYJHmv2Lf3Wj5uZMdBHk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michal Nazarewicz <mina86@mina86.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 06/58] usb: gadget: ffs: ffs_aio_cancel(): Save/restore IRQ flags
Date:   Mon,  2 Mar 2020 21:46:48 -0500
Message-Id: <20200303024740.9511-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303024740.9511-1-sashal@kernel.org>
References: <20200303024740.9511-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index ced2581cf99fe..a9a711e046148 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1162,18 +1162,19 @@ static int ffs_aio_cancel(struct kiocb *kiocb)
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

