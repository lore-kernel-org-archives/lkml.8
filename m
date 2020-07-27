Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE38C433F8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C02A20838
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595858924;
	bh=xttXnH6x3+HhRrYAa34beiJShJ/kR7G4N4zi+w5MELM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d9n68Rkug9UoqM9X+pHOgS4/Zf6eFKRR+cxj0DSSZhF+rlyGPqOMvF+8fKfw5aQX2
	 fISF0yB4UJbeS5Y4eamosrST9xlU+o0bKt3vOTEPV5WNvcR6JjeDCvupUz2Mz114UV
	 OtZMN1rYi8qdBO7K0gYHI2NK1ZDIGDkXUYEHbhAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgG0OIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:08:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729451AbgG0OIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:08:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEB382083B;
        Mon, 27 Jul 2020 14:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595858919;
        bh=xttXnH6x3+HhRrYAa34beiJShJ/kR7G4N4zi+w5MELM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RIoM31cUINne4HeoDp8ngcWFjBnRjoh5YMXFLTDaOMCDppsymiPcpzyfT2z6Y5lk+
         fmGYXa0mIAWTTyPPBgkXO/4Ws3e2MWDYYBVKMq8oM/66lyY6ilyDVSSNX1mpn5fgMm
         Qn2l6ULzLvYx6OuDYK4MJO6kqP9RVfdnw3MikVDo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Beniamino Galvani <bgalvani@redhat.com>,
        Taehee Yoo <ap420073@gmail.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        syzbot+bbc3a11c4da63c1b74d6@syzkaller.appspotmail.com
Subject: [PATCH 4.14 31/64] bonding: check return value of register_netdevice() in bond_newlink()
Date:   Mon, 27 Jul 2020 16:04:10 +0200
Message-Id: <20200727134912.700178242@linuxfoundation.org>
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

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit c75d1d5248c0c97996051809ad0e9f154ba5d76e ]

Very similar to commit 544f287b8495
("bonding: check error value of register_netdevice() immediately"),
we should immediately check the return value of register_netdevice()
before doing anything else.

Fixes: 005db31d5f5f ("bonding: set carrier off for devices created through netlink")
Reported-and-tested-by: syzbot+bbc3a11c4da63c1b74d6@syzkaller.appspotmail.com
Cc: Beniamino Galvani <bgalvani@redhat.com>
Cc: Taehee Yoo <ap420073@gmail.com>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_netlink.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 77babf1417a7e..0e95eeb822ea5 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -451,11 +451,10 @@ static int bond_newlink(struct net *src_net, struct net_device *bond_dev,
 		return err;
 
 	err = register_netdevice(bond_dev);
-
-	netif_carrier_off(bond_dev);
 	if (!err) {
 		struct bonding *bond = netdev_priv(bond_dev);
 
+		netif_carrier_off(bond_dev);
 		bond_work_init_all(bond);
 	}
 
-- 
2.25.1



