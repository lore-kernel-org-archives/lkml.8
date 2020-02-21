Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83ADEC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F2220578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271656;
	bh=tRYepbfaD7Zd5Bn6ptVzfWced5IDJEWaxH48PkLZIew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B7lD31uNNvxkijz0u3nJJpGLs+hi04qzHYO8rl1aQqB9VUltR3rDGsJBJrmrSGWc6
	 152Ntm/V8/T414bl2LSGAcVA0LV7wGDY0UaAYJNF8oCV4gDNUg2CuGSZxdYjTDARpT
	 VUUexPKpXpRxUk3y6+Cw57E5Loy616/H4Yzr696g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbgBUHyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:54:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:52726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730218AbgBUHyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:54:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A88032073A;
        Fri, 21 Feb 2020 07:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271652;
        bh=tRYepbfaD7Zd5Bn6ptVzfWced5IDJEWaxH48PkLZIew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q2J12xDeDR74IiZ+uX0pg1/jPR+kKbZ0MrrIcOYDCh/T2R4l2VYHFpWPJhMuLwOS2
         CWXS3MMbL4rVZtVLq7b7c6FbX/8PlSVf4qN6L+9QU0SQK9rziI1VubRb0qYc6K/XjE
         c9C0/M9XjBhSecjdx8Q/QjdpHM9PRySRisfhb5Cs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 248/399] misc: xilinx_sdfec: fix xsdfec_poll()s return type
Date:   Fri, 21 Feb 2020 08:39:33 +0100
Message-Id: <20200221072426.543012320@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

[ Upstream commit fa4e7fc1386078edcfddd8848cb0374f4af74fe7 ]

xsdfec_poll() is defined as returning 'unsigned int' but the
.poll method is declared as returning '__poll_t', a bitwise type.

Fix this by using the proper return type and using the EPOLL
constants instead of the POLL ones, as required for __poll_t.

CC: Derek Kiernan <derek.kiernan@xilinx.com>
CC: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Acked-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Link: https://lore.kernel.org/r/20191209213655.57985-1-luc.vanoostenryck@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/xilinx_sdfec.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 11835969e9828..48ba7e02bed72 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -1025,25 +1025,25 @@ static long xsdfec_dev_compat_ioctl(struct file *file, unsigned int cmd,
 }
 #endif
 
-static unsigned int xsdfec_poll(struct file *file, poll_table *wait)
+static __poll_t xsdfec_poll(struct file *file, poll_table *wait)
 {
-	unsigned int mask = 0;
+	__poll_t mask = 0;
 	struct xsdfec_dev *xsdfec;
 
 	xsdfec = container_of(file->private_data, struct xsdfec_dev, miscdev);
 
 	if (!xsdfec)
-		return POLLNVAL | POLLHUP;
+		return EPOLLNVAL | EPOLLHUP;
 
 	poll_wait(file, &xsdfec->waitq, wait);
 
 	/* XSDFEC ISR detected an error */
 	spin_lock_irqsave(&xsdfec->error_data_lock, xsdfec->flags);
 	if (xsdfec->state_updated)
-		mask |= POLLIN | POLLPRI;
+		mask |= EPOLLIN | EPOLLPRI;
 
 	if (xsdfec->stats_updated)
-		mask |= POLLIN | POLLRDNORM;
+		mask |= EPOLLIN | EPOLLRDNORM;
 	spin_unlock_irqrestore(&xsdfec->error_data_lock, xsdfec->flags);
 
 	return mask;
-- 
2.20.1



