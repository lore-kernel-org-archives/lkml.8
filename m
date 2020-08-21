Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B28C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC1A20732
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgHUHTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:19:54 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:46897 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbgHUHTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:19:13 -0400
X-Greylist: delayed 525 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Aug 2020 03:19:11 EDT
Received: from localhost.localdomain (unknown [113.89.244.43])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 15E1248271C;
        Fri, 21 Aug 2020 15:10:22 +0800 (CST)
From:   Ding Hui <dinghui@sangfor.com.cn>
To:     mathias.nyman@intel.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ding Hui <dinghui@sangfor.com.cn>
Subject: [PATCH] xhci: Always restore EP_SOFT_CLEAR_TOGGLE even if ep reset failed
Date:   Fri, 21 Aug 2020 15:06:52 +0800
Message-Id: <20200821070652.27782-1-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTB5MQkkaQhpLGB0dVkpOQkxCQkhDSUlISUxVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nio6NTo4Ez8hSzMaDgxNMx0M
        OAkKC0lVSlVKTkJMQkJIQ0lJQ0tLVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlKSkhVQ0JVSU9PVU9IWVdZCAFZQUlKT0w3Bg++
X-HM-Tid: 0a740fdaa83593bakuws15e1248271c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices driver call libusb_clear_halt when target ep queue
is not empty. (eg. spice client connected to qemu for usb redir)

Before commit f5249461b504 ("xhci: Clear the host side toggle
manually when endpoint is soft reset"), that works well.
But now, we got the error log:

    EP not empty, refuse reset

xhch_endpoint_reset failed and left ep_state's EP_SOFT_CLEAR_TOGGLE
bit is still on

So all the subsequent urb sumbit to the ep will fail with the
warn log:

    Can't enqueue URB while manually clearing toggle

We need restore ep_state EP_SOFT_CLEAR_TOGGLE bit after
xhci_endpoint_reset, even if it is failed.

Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
---
 drivers/usb/host/xhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 3c41b14ecce7..e9884ae9c77d 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3236,10 +3236,11 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 
 	wait_for_completion(cfg_cmd->completion);
 
-	ep->ep_state &= ~EP_SOFT_CLEAR_TOGGLE;
 	xhci_free_command(xhci, cfg_cmd);
 cleanup:
 	xhci_free_command(xhci, stop_cmd);
+	if (ep->ep_state & EP_SOFT_CLEAR_TOGGLE)
+		ep->ep_state &= ~EP_SOFT_CLEAR_TOGGLE;
 }
 
 static int xhci_check_streams_endpoint(struct xhci_hcd *xhci,
-- 
2.17.1

