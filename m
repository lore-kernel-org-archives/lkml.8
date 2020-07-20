Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F62C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDFE5206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260336;
	bh=8zZTNXY8pmrk4LecvshwRC08JghCAfeXzBD9W5Vuuxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rA3Ji/5ytAnbISSr829lhowvBSXjiXXWefyLfUhBMcf7nLKz2qdxieFFRdZKLIUl7
	 VhsxgwCs6ruyZWZtswbbUbaKjSNfxyu/W6Q/RALRR3qfDvJLO873hw314xXfw+HVNW
	 0pxnXeF3chIlOqkxldyDVk6DFfF2fGfFabyRJmZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbgGTPwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:52:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731331AbgGTPwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:52:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAA7622482;
        Mon, 20 Jul 2020 15:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260330;
        bh=8zZTNXY8pmrk4LecvshwRC08JghCAfeXzBD9W5Vuuxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WsS3tvtx2ixDofop+viW5moX2ocFg+oeujnDVZXn7bCmzBfzfj9gm+4TVCpuRZ77i
         q3AJd8U/l2t2TkfTLqtYfplr0Q/ggq0PDQEuAZV0zmdfJ9F98P26KqdjNWipHL41RP
         fZtU4yh8obD83wT2haBK5iXCsiPrJNKFzkxSrHNI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 062/133] usb: gadget: udc: atmel: fix uninitialized read in debug printk
Date:   Mon, 20 Jul 2020 17:36:49 +0200
Message-Id: <20200720152806.729562549@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

[ Upstream commit 30517ffeb3bff842e1355cbc32f1959d9dbb5414 ]

Fixed commit moved the assignment of 'req', but did not update a
reference in the DBG() call. Use the argument as it was renamed.

Fixes: 5fb694f96e7c ("usb: gadget: udc: atmel: fix possible oops when unloading module")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index a4ab230335786..23691a32759fe 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -860,7 +860,7 @@ static int usba_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	u32 status;
 
 	DBG(DBG_GADGET | DBG_QUEUE, "ep_dequeue: %s, req %p\n",
-			ep->ep.name, req);
+			ep->ep.name, _req);
 
 	spin_lock_irqsave(&udc->lock, flags);
 
-- 
2.25.1



