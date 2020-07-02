Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82ADC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83B6C206BE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593653492;
	bh=jcT4x3sOkEfC37eVwUQ/OPxOH2St/0use41/zQWHQvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1902U0lP5q2PnQRcUmrm9jeKsk6mvcLKbGnZN9/CrcSG3qGb4m5rfCEMTeDldOCWm
	 JKOJSR+z6Lv6H9cmzM5RFFGrsRmn38323BltGVvFArkgMP7bm+OPXx6hD4OTPuU+qV
	 V+VJO0LZ0LCs/h5Ntk9FnnkN8UsdD7mzr+4KuDIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgGBBba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729199AbgGBB0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:26:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2511720874;
        Thu,  2 Jul 2020 01:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593653192;
        bh=jcT4x3sOkEfC37eVwUQ/OPxOH2St/0use41/zQWHQvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vzVNEV46tm2KQsu0HdAUJetg5kKqrZHXJbPdnnwF9zbtOE+QrNxSH0A8LTb1cv209
         hXKHS9IjvF/qFZO6PUW14/zTk4TPvF22Qu4SVxAbHnENMzenTTYxVEjHcMki0I7J2/
         uOZHmZ6Orqc1ujmVjYNsoHOY08Z5Me+jFApATwdA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
        syzbot+29dc7d4ae19b703ff947@syzkaller.appspotmail.com,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 13/27] usbnet: smsc95xx: Fix use-after-free after removal
Date:   Wed,  1 Jul 2020 21:26:01 -0400
Message-Id: <20200702012615.2701532-13-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702012615.2701532-1-sashal@kernel.org>
References: <20200702012615.2701532-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>

[ Upstream commit b835a71ef64a61383c414d6bf2896d2c0161deca ]

Syzbot reports an use-after-free in workqueue context:

BUG: KASAN: use-after-free in mutex_unlock+0x19/0x40 kernel/locking/mutex.c:737
 mutex_unlock+0x19/0x40 kernel/locking/mutex.c:737
 __smsc95xx_mdio_read drivers/net/usb/smsc95xx.c:217 [inline]
 smsc95xx_mdio_read+0x583/0x870 drivers/net/usb/smsc95xx.c:278
 check_carrier+0xd1/0x2e0 drivers/net/usb/smsc95xx.c:644
 process_one_work+0x777/0xf90 kernel/workqueue.c:2274
 worker_thread+0xa8f/0x1430 kernel/workqueue.c:2420
 kthread+0x2df/0x300 kernel/kthread.c:255

It looks like that smsc95xx_unbind() is freeing the structures that are
still in use by the concurrently running workqueue callback. Thus switch
to using cancel_delayed_work_sync() to ensure the work callback really
is no longer active.

Reported-by: syzbot+29dc7d4ae19b703ff947@syzkaller.appspotmail.com
Signed-off-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/smsc95xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 6e971628bb50a..c3389bd87c654 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1338,7 +1338,7 @@ static void smsc95xx_unbind(struct usbnet *dev, struct usb_interface *intf)
 	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)(dev->data[0]);
 
 	if (pdata) {
-		cancel_delayed_work(&pdata->carrier_check);
+		cancel_delayed_work_sync(&pdata->carrier_check);
 		netif_dbg(dev, ifdown, dev->net, "free pdata\n");
 		kfree(pdata);
 		pdata = NULL;
-- 
2.25.1

