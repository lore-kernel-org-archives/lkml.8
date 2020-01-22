Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BACC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C303724688
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699423;
	bh=kn1xqeotbC/h612r6WLpR4VyIxOLd3ZFQEoq32Ro7Os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BIMWxQvPnb6PwiZtbpuOCJu/ECzWDWzKKUND40XJGQmcro1QQbKj1fXI+qFSnyf6o
	 FB6La0O0qcYsiIDPqfs8OxBywL2emTgipKuC9dZLf07RKQSjinjVPQVlt7ih3TrWwX
	 f9nt+ZUTxJHK5FY/+njeFAZZzAv10+9nF2ZdCq1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbgAVNXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:23:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:41978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730415AbgAVNXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:23:38 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5CA9205F4;
        Wed, 22 Jan 2020 13:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699417;
        bh=kn1xqeotbC/h612r6WLpR4VyIxOLd3ZFQEoq32Ro7Os=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mvjqqwSiTlfuECPaAfzAku2lJiNlV8oCFFIAy0E7oomdVPDFWjOGD8kctoBpzkVRU
         Dxblq5BJcXOnWgnGFMtvHEdMwLylDok2fKGP5UNpcEBVxBmOY/BdO5WL1pwguzLbqF
         5dIKAa8zogLQEdSippLbT61AVll/K89COU8W2XLM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+4ec99438ed7450da6272@syzkaller.appspotmail.com,
        Taehee Yoo <ap420073@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 138/222] net: avoid updating qdisc_xmit_lock_key in netdev_update_lockdep_key()
Date:   Wed, 22 Jan 2020 10:28:44 +0100
Message-Id: <20200122092843.619836106@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 53d374979ef147ab51f5d632dfe20b14aebeccd0 ]

syzbot reported some bogus lockdep warnings, for example bad unlock
balance in sch_direct_xmit(). They are due to a race condition between
slow path and fast path, that is qdisc_xmit_lock_key gets re-registered
in netdev_update_lockdep_key() on slow path, while we could still
acquire the queue->_xmit_lock on fast path in this small window:

CPU A						CPU B
						__netif_tx_lock();
lockdep_unregister_key(qdisc_xmit_lock_key);
						__netif_tx_unlock();
lockdep_register_key(qdisc_xmit_lock_key);

In fact, unlike the addr_list_lock which has to be reordered when
the master/slave device relationship changes, queue->_xmit_lock is
only acquired on fast path and only when NETIF_F_LLTX is not set,
so there is likely no nested locking for it.

Therefore, we can just get rid of re-registration of
qdisc_xmit_lock_key.

Reported-by: syzbot+4ec99438ed7450da6272@syzkaller.appspotmail.com
Fixes: ab92d68fc22f ("net: core: add generic lockdep keys")
Cc: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/dev.c |   12 ------------
 1 file changed, 12 deletions(-)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8953,22 +8953,10 @@ static void netdev_unregister_lockdep_ke
 
 void netdev_update_lockdep_key(struct net_device *dev)
 {
-	struct netdev_queue *queue;
-	int i;
-
-	lockdep_unregister_key(&dev->qdisc_xmit_lock_key);
 	lockdep_unregister_key(&dev->addr_list_lock_key);
-
-	lockdep_register_key(&dev->qdisc_xmit_lock_key);
 	lockdep_register_key(&dev->addr_list_lock_key);
 
 	lockdep_set_class(&dev->addr_list_lock, &dev->addr_list_lock_key);
-	for (i = 0; i < dev->num_tx_queues; i++) {
-		queue = netdev_get_tx_queue(dev, i);
-
-		lockdep_set_class(&queue->_xmit_lock,
-				  &dev->qdisc_xmit_lock_key);
-	}
 }
 EXPORT_SYMBOL(netdev_update_lockdep_key);
 


