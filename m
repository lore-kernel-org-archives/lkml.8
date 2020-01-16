Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09042C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39A021D56
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193828;
	bh=2gclll6tXzZYKD51RuoVXGdBGIw4/bnVeEiILD7SeRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xIz40zE/ZbqpeU0jJh/HlRQnaL6XKMJJA/+j4ydTEFXqBHhdlWZ5ELLpJGMUCsNFL
	 /UOy6W3BHUZgxbs1itgJuGHTWXbkAl8R/ytm4LnImOzaKzeeOxp3/XkIHzsIbl93G9
	 RR9610p73m9u7Wbx+FsP3E6eB3r7LsPBETLtU6s0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387434AbgAPQ5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:57:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:43834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387407AbgAPQ5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:57:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 752A32051A;
        Thu, 16 Jan 2020 16:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193822;
        bh=2gclll6tXzZYKD51RuoVXGdBGIw4/bnVeEiILD7SeRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V5RgCB2dce/jW5FJy7yoH8VuN2aFPNsOpwCtnT11ecK4bUmeOW4sAGicS8ozIACKd
         vHdQ/UBiJlSEP5DatATOWRAs5mx62pDWteNagkkU4NN8Cjtw/FV5KGbN1pPjwX0kuY
         M2Nkclvqf2Qi/OJWT5zfM5RxZTiIkb5hCtMi4Gt8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Petr Machata <petrm@mellanox.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 081/671] vxlan: changelink: Fix handling of default remotes
Date:   Thu, 16 Jan 2020 11:45:12 -0500
Message-Id: <20200116165502.8838-81-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165502.8838-1-sashal@kernel.org>
References: <20200116165502.8838-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Machata <petrm@mellanox.com>

[ Upstream commit ce5e098f7a10b4bf8e948c12fa350320c5c3afad ]

Default remotes are stored as FDB entries with an Ethernet address of
00:00:00:00:00:00. When a request is made to change a remote address of
a VXLAN device, vxlan_changelink() first deletes the existing default
remote, and then creates a new FDB entry.

This works well as long as the list of default remotes matches exactly
the configuration of a VXLAN remote address. Thus when the VXLAN device
has a remote of X, there should be exactly one default remote FDB entry
X. If the VXLAN device has no remote address, there should be no such
entry.

Besides using "ip link set", it is possible to manipulate the list of
default remotes by using the "bridge fdb". It is therefore easy to break
the above condition. Under such circumstances, the __vxlan_fdb_delete()
call doesn't delete the FDB entry itself, but just one remote. The
following vxlan_fdb_create() then creates a new FDB entry, leading to a
situation where two entries exist for the address 00:00:00:00:00:00,
each with a different subset of default remotes.

An even more obvious breakage rooted in the same cause can be observed
when a remote address is configured for a VXLAN device that did not have
one before. In that case vxlan_changelink() doesn't remove any remote,
and just creates a new FDB entry for the new address:

$ ip link add name vx up type vxlan id 2000 dstport 4789
$ bridge fdb ap dev vx 00:00:00:00:00:00 dst 192.0.2.20 self permanent
$ bridge fdb ap dev vx 00:00:00:00:00:00 dst 192.0.2.30 self permanent
$ ip link set dev vx type vxlan remote 192.0.2.30
$ bridge fdb sh dev vx | grep 00:00:00:00:00:00
00:00:00:00:00:00 dst 192.0.2.30 self permanent <- new entry, 1 rdst
00:00:00:00:00:00 dst 192.0.2.20 self permanent <- orig. entry, 2 rdsts
00:00:00:00:00:00 dst 192.0.2.30 self permanent

To fix this, instead of calling vxlan_fdb_create() directly, defer to
vxlan_fdb_update(). That has logic to handle the duplicates properly.
Additionally, it also handles notifications, so drop that call from
changelink as well.

Fixes: 0241b836732f ("vxlan: fix default fdb entry netlink notify ordering during netdev create")
Signed-off-by: Petr Machata <petrm@mellanox.com>
Acked-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vxlan.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 613f36681853..df88981e796a 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -3496,7 +3496,6 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct vxlan_rdst *dst = &vxlan->default_dst;
 	struct vxlan_rdst old_dst;
 	struct vxlan_config conf;
-	struct vxlan_fdb *f = NULL;
 	int err;
 
 	err = vxlan_nl2conf(tb, data,
@@ -3522,19 +3521,19 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 					   old_dst.remote_ifindex, 0);
 
 		if (!vxlan_addr_any(&dst->remote_ip)) {
-			err = vxlan_fdb_create(vxlan, all_zeros_mac,
+			err = vxlan_fdb_update(vxlan, all_zeros_mac,
 					       &dst->remote_ip,
 					       NUD_REACHABLE | NUD_PERMANENT,
+					       NLM_F_APPEND | NLM_F_CREATE,
 					       vxlan->cfg.dst_port,
 					       dst->remote_vni,
 					       dst->remote_vni,
 					       dst->remote_ifindex,
-					       NTF_SELF, &f);
+					       NTF_SELF);
 			if (err) {
 				spin_unlock_bh(&vxlan->hash_lock);
 				return err;
 			}
-			vxlan_fdb_notify(vxlan, f, first_remote_rtnl(f), RTM_NEWNEIGH);
 		}
 		spin_unlock_bh(&vxlan->hash_lock);
 	}
-- 
2.20.1

