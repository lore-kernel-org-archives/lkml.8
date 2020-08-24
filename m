Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571EAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28721206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258916;
	bh=wp8LIuscKuYSAmiPVftb+5sKuyKhkbhHTw8iaVTj5i4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vmbcSJqFwjbCovzc7ldHxr/v+ynyDuXG4ItGFNoh3ifV+cGR9BBWF6dOvNDI7MMpp
	 8gYDuy2yB5AUt+1MOVpwM/q52aUQ0j+BVmdTs0e3WlOCcIUQvg0sm/LKbjahTJOlBl
	 ETdOW5PCZpSjU0+JnERvNDvnBaTstludTtot6y4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbgHXIsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:48:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729528AbgHXIsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:48:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9951204FD;
        Mon, 24 Aug 2020 08:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258889;
        bh=wp8LIuscKuYSAmiPVftb+5sKuyKhkbhHTw8iaVTj5i4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LLQDwEo2lO5wp3bHnA68BsccGixdvqLIrmJSCA5iU8wdWZmofIfw0WEuAflIiWauv
         dAZL5kA76H+OePV7CR1t2G/3+KSvsiRbtqotvpAzMqG7ySPJ79G6o2cXpeLgRazC9c
         fHcyHoYM8DNsV2SlUaLcrWe96Dhvwy1NBPBOt8K4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+af23e7f3e0a7e10c8b67@syzkaller.appspotmail.com,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 081/107] bonding: fix a potential double-unregister
Date:   Mon, 24 Aug 2020 10:30:47 +0200
Message-Id: <20200824082409.130142710@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082405.020301642@linuxfoundation.org>
References: <20200824082405.020301642@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 832707021666411d04795c564a4adea5d6b94f17 ]

When we tear down a network namespace, we unregister all
the netdevices within it. So we may queue a slave device
and a bonding device together in the same unregister queue.

If the only slave device is non-ethernet, it would
automatically unregister the bonding device as well. Thus,
we may end up unregistering the bonding device twice.

Workaround this special case by checking reg_state.

Fixes: 9b5e383c11b0 ("net: Introduce unregister_netdevice_many()")
Reported-by: syzbot+af23e7f3e0a7e10c8b67@syzkaller.appspotmail.com
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Andy Gospodarek <andy@greyhouse.net>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 11c014586d466..ce829a7a92101 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2037,7 +2037,8 @@ static int bond_release_and_destroy(struct net_device *bond_dev,
 	int ret;
 
 	ret = __bond_release_one(bond_dev, slave_dev, false, true);
-	if (ret == 0 && !bond_has_slaves(bond)) {
+	if (ret == 0 && !bond_has_slaves(bond) &&
+	    bond_dev->reg_state != NETREG_UNREGISTERING) {
 		bond_dev->priv_flags |= IFF_DISABLE_NETPOLL;
 		netdev_info(bond_dev, "Destroying bond\n");
 		bond_remove_proc_entry(bond);
-- 
2.25.1



