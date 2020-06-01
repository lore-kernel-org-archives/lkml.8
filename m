Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA48AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9614206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591037522;
	bh=w5I/bCvhdOOgccWeAkoMqO+L/IVr9RQ8dbnPQfmCt/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WbQL5VDfw2uWwpApjNa3puxxGSz/OfEt7oT7yeP5690PwHO0HPJmy8NRotiC2PXrZ
	 iKsY7b2SUkjThW9FuPqpU2kqn/kIVPnAD/iWCUj0/XTUANv003XnWbYMkQPqjF8291
	 kG1ff7WZkTUzxSEGqUYM9VB+Q0f2n38kvdDV138g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbgFASEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:04:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728439AbgFASEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:04:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD87D206E2;
        Mon,  1 Jun 2020 18:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034651;
        bh=w5I/bCvhdOOgccWeAkoMqO+L/IVr9RQ8dbnPQfmCt/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dz6FugO4/YKjjqGFfTUKyY5DMJBT9k9dHp1Eis+9dV1GiY6NcAXJgs8fPekgD+g90
         eJzVH4lj/d8UfbARLH8QzRlEfV53cn1kxXlviCiZcSPZwjJFVlIL3WRV/POdDCNb1H
         Ap0cpoJBplJlaDXv/28H5pDf9p4E0GWV2fgZdHl8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        kbuild test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 31/95] usb: gadget: legacy: fix redundant initialization warnings
Date:   Mon,  1 Jun 2020 19:53:31 +0200
Message-Id: <20200601174025.725938827@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174020.759151073@linuxfoundation.org>
References: <20200601174020.759151073@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit d13cce757954fa663c69845611957396843ed87a ]

Fix the following cppcheck warnings:

drivers/usb/gadget/legacy/inode.c:1364:8: style: Redundant initialization for 'value'. The initialized value is overwritten$
 value = -EOPNOTSUPP;
       ^
drivers/usb/gadget/legacy/inode.c:1331:15: note: value is initialized
 int    value = -EOPNOTSUPP;
              ^
drivers/usb/gadget/legacy/inode.c:1364:8: note: value is overwritten
 value = -EOPNOTSUPP;
       ^
drivers/usb/gadget/legacy/inode.c:1817:8: style: Redundant initialization for 'value'. The initialized value is overwritten$
 value = -EINVAL;
       ^
drivers/usb/gadget/legacy/inode.c:1787:18: note: value is initialized
 ssize_t   value = len, length = len;
                 ^
drivers/usb/gadget/legacy/inode.c:1817:8: note: value is overwritten
 value = -EINVAL;
       ^
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Felipe Balbi <balbi@kernel.org>

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/legacy/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 37ca0e669bd8..25d417ad9000 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1360,7 +1360,6 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 
 	req->buf = dev->rbuf;
 	req->context = NULL;
-	value = -EOPNOTSUPP;
 	switch (ctrl->bRequest) {
 
 	case USB_REQ_GET_DESCRIPTOR:
@@ -1783,7 +1782,7 @@ static ssize_t
 dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 {
 	struct dev_data		*dev = fd->private_data;
-	ssize_t			value = len, length = len;
+	ssize_t			value, length = len;
 	unsigned		total;
 	u32			tag;
 	char			*kbuf;
-- 
2.25.1



