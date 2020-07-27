Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94BEC43458
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F30B2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595858825;
	bh=ZlkBZRpRZouPucAK8to0nNZMYP7bbrHIinNn677J9D8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ns3bjTz/mmZGcsIXiNjne1wzglSaKnwv2DAlHaB7//nJwkd+bB0ZzD1YHsIMctRXG
	 cX48Qf5DMutUq2qFjzVL0uOOGXvUkAnwsX8Q2ChqFv8B8Rt0300yl2yvqnIDzVka/S
	 roJZdDkrYTMjWqoc5rTQQSuqXo+oeCwTaC3bN1n0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgG0OHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:07:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729111AbgG0OHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:07:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96731207FC;
        Mon, 27 Jul 2020 14:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595858821;
        bh=ZlkBZRpRZouPucAK8to0nNZMYP7bbrHIinNn677J9D8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kIGpeZW9+LgWBChtlIeAkcJ7LGUJBEE5jhVhXxpLuECXpZwGyRuY4MEXwN68Q20Po
         SPmUr3wC58aq2FpFyBGzmpIxqvKdx5sw8BNFV6bL7Viawf1jxjFhv0aXlR+2Tu8N8e
         g07Gk6ZfasW09Xxzj67wsQjwHi3TsftAGd45Bch4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, George Kennedy <george.kennedy@oracle.com>,
        syzbot+4cd84f527bf4a10fc9c1@syzkaller.appspotmail.com,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 23/64] ax88172a: fix ax88172a_unbind() failures
Date:   Mon, 27 Jul 2020 16:04:02 +0200
Message-Id: <20200727134912.290183202@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134911.020675249@linuxfoundation.org>
References: <20200727134911.020675249@linuxfoundation.org>
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
index 914cac55a7ae7..909755ef71ac3 100644
--- a/drivers/net/usb/ax88172a.c
+++ b/drivers/net/usb/ax88172a.c
@@ -210,6 +210,7 @@ static int ax88172a_bind(struct usbnet *dev, struct usb_interface *intf)
 	ret = asix_read_cmd(dev, AX_CMD_READ_NODE_ID, 0, 0, ETH_ALEN, buf, 0);
 	if (ret < ETH_ALEN) {
 		netdev_err(dev->net, "Failed to read MAC address: %d\n", ret);
+		ret = -EIO;
 		goto free;
 	}
 	memcpy(dev->net->dev_addr, buf, ETH_ALEN);
-- 
2.25.1



