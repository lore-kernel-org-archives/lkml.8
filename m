Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF3BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 22:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FCBE206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 22:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hrf1dQ33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgGHW7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 18:59:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53584 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725903AbgGHW7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 18:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594249142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5273qNZ2G1pvs6o6EmJVKX3kUo6d0ElK4jyei1Dx3qQ=;
        b=Hrf1dQ33Nm98whQufWdd1nyZfEEoq0IV2VmEqFKlmzIgdXD7t2smvqgI6cqVG+FNoLToVN
        wwKwZ0BqH3WSHeAHvpSt41cXc8iGYbaCBSxKTaIbvR+vs7udOCoVqE+mtdqnSjFOM4ZTaE
        e3AHx6mU6M8pvmYb881wG8R+7dYOQz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-GVqzbkf7MEi_x9rvI2YAUA-1; Wed, 08 Jul 2020 18:58:58 -0400
X-MC-Unique: GVqzbkf7MEi_x9rvI2YAUA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7858F108B;
        Wed,  8 Jul 2020 22:58:56 +0000 (UTC)
Received: from hp-dl360pgen8-07.khw2.lab.eng.bos.redhat.com (hp-dl360pgen8-07.khw2.lab.eng.bos.redhat.com [10.16.210.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 865C15D9C9;
        Wed,  8 Jul 2020 22:58:51 +0000 (UTC)
From:   Jarod Wilson <jarod@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarod Wilson <jarod@redhat.com>,
        syzbot+582c98032903dcc04816@syzkaller.appspotmail.com,
        Huy Nguyen <huyn@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: [PATCH net-next] bonding: don't need RTNL for ipsec helpers
Date:   Wed,  8 Jul 2020 18:58:49 -0400
Message-Id: <20200708225849.25198-1-jarod@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bond_ipsec_* helpers don't need RTNL, and can potentially get called
without it being held, so switch from rtnl_dereference() to
rcu_dereference() to access bond struct data.

Lightly tested with xfrm bonding, no problems found, should address the
syzkaller bug referenced below.

Reported-by: syzbot+582c98032903dcc04816@syzkaller.appspotmail.com
CC: Huy Nguyen <huyn@mellanox.com>
CC: Saeed Mahameed <saeedm@mellanox.com>
CC: Jay Vosburgh <j.vosburgh@gmail.com>
CC: Veaceslav Falico <vfalico@gmail.com>
CC: Andy Gospodarek <andy@greyhouse.net>
CC: "David S. Miller" <davem@davemloft.net>
CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: netdev@vger.kernel.org
CC: intel-wired-lan@lists.osuosl.org
Signed-off-by: Jarod Wilson <jarod@redhat.com>
---
 drivers/net/bonding/bond_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index f886d97c4359..e2d491c4378c 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -390,7 +390,7 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs)
 		return -EINVAL;
 
 	bond = netdev_priv(bond_dev);
-	slave = rtnl_dereference(bond->curr_active_slave);
+	slave = rcu_dereference(bond->curr_active_slave);
 	xs->xso.real_dev = slave->dev;
 	bond->xs = xs;
 
@@ -417,7 +417,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 		return;
 
 	bond = netdev_priv(bond_dev);
-	slave = rtnl_dereference(bond->curr_active_slave);
+	slave = rcu_dereference(bond->curr_active_slave);
 
 	if (!slave)
 		return;
@@ -442,7 +442,7 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 {
 	struct net_device *bond_dev = xs->xso.dev;
 	struct bonding *bond = netdev_priv(bond_dev);
-	struct slave *curr_active = rtnl_dereference(bond->curr_active_slave);
+	struct slave *curr_active = rcu_dereference(bond->curr_active_slave);
 	struct net_device *slave_dev = curr_active->dev;
 
 	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
-- 
2.20.1

