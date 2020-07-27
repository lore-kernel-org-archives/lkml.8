Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDF2C43457
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FCC52173E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859726;
	bh=mosuk51w2WKwugCfuBZtqjV/aSmnJy/uMF70i0hQ1Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pQBUM+N8I7so1lMWkM5/C9y/96JdLUACq8Z6sqKgiCDbeXRrTmPNg/tWRQSmkOP+G
	 i6xUYt+Qmuy4da0cUr97W9UuLJ4hQ7tnsTILG4HGsTS/6zeAKZLDhgVHd4zCVlzaKI
	 4c8KrGzdR5xCaxNzJry+AGz/JIJdJlQJSu8actmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbgG0OWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:22:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731825AbgG0OWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:22:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82D1F2070B;
        Mon, 27 Jul 2020 14:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859722;
        bh=mosuk51w2WKwugCfuBZtqjV/aSmnJy/uMF70i0hQ1Y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Toa3N6hgyARDwKiOvTe49dzkbuW+n7koDcC0gmlZSYabJ/+FvX4ANnALQ3lLyyjzn
         Y4jicqToG8GyO7eXJaelsrXymy+ccPZOmpS6y/ABcnAYpLicC27In+82tNxWBpZ85J
         6AmpxZPUdJXaN+pP2KeCz1QB491S/Zjo+eV964y0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, George Kennedy <george.kennedy@oracle.com>,
        syzbot+4cd84f527bf4a10fc9c1@syzkaller.appspotmail.com,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 052/179] ax88172a: fix ax88172a_unbind() failures
Date:   Mon, 27 Jul 2020 16:03:47 +0200
Message-Id: <20200727134935.202883308@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Kennedy <george.kennedy@oracle.com>

[ Upstream commit c28d9a285668c799eeae2f7f93e929a6028a4d6d ]

If ax88172a_unbind() fails, make sure that the return code is
less than zero so that cleanup is done properly and avoid UAF.

Fixes: a9a51bd727d1 ("ax88172a: fix information leak on short answers")
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
Reported-by: syzbot+4cd84f527bf4a10fc9c1@syzkaller.appspotmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/ax88172a.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/ax88172a.c b/drivers/net/usb/ax88172a.c
index 4e514f5d7c6c7..fd3a04d98dc14 100644
--- a/drivers/net/usb/ax88172a.c
+++ b/drivers/net/usb/ax88172a.c
@@ -187,6 +187,7 @@ static int ax88172a_bind(struct usbnet *dev, struct usb_interface *intf)
 	ret = asix_read_cmd(dev, AX_CMD_READ_NODE_ID, 0, 0, ETH_ALEN, buf, 0);
 	if (ret < ETH_ALEN) {
 		netdev_err(dev->net, "Failed to read MAC address: %d\n", ret);
+		ret = -EIO;
 		goto free;
 	}
 	memcpy(dev->net->dev_addr, buf, ETH_ALEN);
-- 
2.25.1



