Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C5AC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94B3206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581703261;
	bh=tRYepbfaD7Zd5Bn6ptVzfWced5IDJEWaxH48PkLZIew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lkH85REuQ+uCFKoHK7UxdaviHxi0r23PAWQAshsaK22/COEHEsYlrFMGbC8VzxWez
	 c6d3MTNNirA/NRnCIwIdvfVAriaF+pCHXeSzY/GaGLa0FBKtxsPDaFoThjMqwoqD0q
	 o4IzLJs6D2DI19PljRSPhxjM9kdc69Wcc8EGJTPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388414AbgBNSBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:01:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387675AbgBNP4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:56:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2369F24649;
        Fri, 14 Feb 2020 15:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695780;
        bh=tRYepbfaD7Zd5Bn6ptVzfWced5IDJEWaxH48PkLZIew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/d7FSyHqaUSenp6/KQkZsUAyG1tB8EoFDvPkdqQ+L4u68Hv3MnSZte2NSMWf5Knk
         mV4Xv0ClFIzEHlcXBNnKVlHgeov/gbO2WUTUlGTMllTy4RGmRNOzfEMhTLv/Z+W+p/
         2aickbq/MNfaqkhrfVaIyMP+ZiiqZjMldxd5P2zQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 344/542] misc: xilinx_sdfec: fix xsdfec_poll()'s return type
Date:   Fri, 14 Feb 2020 10:45:36 -0500
Message-Id: <20200214154854.6746-344-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

