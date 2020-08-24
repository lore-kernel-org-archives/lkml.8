Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8F8C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2941A2087D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598259266;
	bh=O/Nhrn08tkjaaarUDJU/ZrxBjQpZs+AwE15ZpuJ6Ak0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=khMJkW3I8RuJUqmf9/xAtD+o9uLEwjEgebEIm30M7sCHbCIaGxe0wMrk2BdzVPVCB
	 fIJ3nusZ/+bFFOhA5CP2o9o5rvoGevvSDHU6aRfoZhYXrFCB7zAUE1V1RgmJrCZX1/
	 Z61egH3OaqWBF+hacV3732BMgH0KN5EBppFq5gfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbgHXIyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:54:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730291AbgHXIyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:54:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E765F207D3;
        Mon, 24 Aug 2020 08:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259255;
        bh=O/Nhrn08tkjaaarUDJU/ZrxBjQpZs+AwE15ZpuJ6Ak0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JJ3PVHxC50CFR3pJsileGCCn4r4py4pfEzuc/dbefF9vcvau6a5q4j3uN+9ujKORL
         fhjejGzY9FotAKi4IoMTteH6ISii/FXMuODE4jazYmiq9xTA9ssNg7PeSCSOZ5+Oqh
         MX63gYEBHUGalyluLknVBIzLv9k5sCzhAq+BXZ8k=
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
Subject: [PATCH 4.14 38/50] bonding: fix a potential double-unregister
Date:   Mon, 24 Aug 2020 10:31:39 +0200
Message-Id: <20200824082353.981385413@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082351.823243923@linuxfoundation.org>
References: <20200824082351.823243923@linuxfoundation.org>
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
index 9ddbafdca3b05..a6d8d3b3c903d 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2010,7 +2010,8 @@ static int  bond_release_and_destroy(struct net_device *bond_dev,
 	int ret;
 
 	ret = __bond_release_one(bond_dev, slave_dev, false, true);
-	if (ret == 0 && !bond_has_slaves(bond)) {
+	if (ret == 0 && !bond_has_slaves(bond) &&
+	    bond_dev->reg_state != NETREG_UNREGISTERING) {
 		bond_dev->priv_flags |= IFF_DISABLE_NETPOLL;
 		netdev_info(bond_dev, "Destroying bond %s\n",
 			    bond_dev->name);
-- 
2.25.1



