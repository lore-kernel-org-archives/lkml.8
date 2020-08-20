Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCFEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84651207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597925495;
	bh=6GgWqj3LT+d5Tkae12SGbQ9VypauZBetoPg5ltCgd1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nVt2hs8Swyl03DdqYtBbkYsIdqJA995QinIaeQmJ79eLtuDRc6J2gw+yk6wGYf+Pu
	 bqeOOXODL6dXnLHzTYn3+Rbasg0niUW66F/lt6ARtfnjgSk4Jt/lCj/onzvBqpbvQ+
	 BxQ4WTB3+95naKpzz1Jn3wLloFfQtMnF91Wl3LhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbgHTMLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:11:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729571AbgHTJ5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:57:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51612207FB;
        Thu, 20 Aug 2020 09:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917464;
        bh=6GgWqj3LT+d5Tkae12SGbQ9VypauZBetoPg5ltCgd1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2pKkAQeBwU9OF05M0t68zuQ7pcoRWjEtzRy0aMcI8fbLc48gbs42LQ4d69vkRsPw8
         HOjScNRs9ircJt6msgRgd66lsC0Y2/c6QHbWw6s6/H8H7ifXf+bvaTWz1QMth8gR3V
         bycwZE1Q0jxMnCWFJYGtDwE3YTSUgV127rb1L6mk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 033/212] mac80211: mesh: Free ie data when leaving mesh
Date:   Thu, 20 Aug 2020 11:20:06 +0200
Message-Id: <20200820091604.036555043@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Remi Pommarel <repk@triplefau.lt>

[ Upstream commit 6a01afcf8468d3ca2bd8bbb27503f60dcf643b20 ]

At ieee80211_join_mesh() some ie data could have been allocated (see
copy_mesh_setup()) and need to be cleaned up when leaving the mesh.

This fixes the following kmemleak report:

unreferenced object 0xffff0000116bc600 (size 128):
  comm "wpa_supplicant", pid 608, jiffies 4294898983 (age 293.484s)
  hex dump (first 32 bytes):
    30 14 01 00 00 0f ac 04 01 00 00 0f ac 04 01 00  0...............
    00 0f ac 08 00 00 00 00 c4 65 40 00 00 00 00 00  .........e@.....
  backtrace:
    [<00000000bebe439d>] __kmalloc_track_caller+0x1c0/0x330
    [<00000000a349dbe1>] kmemdup+0x28/0x50
    [<0000000075d69baa>] ieee80211_join_mesh+0x6c/0x3b8 [mac80211]
    [<00000000683bb98b>] __cfg80211_join_mesh+0x1e8/0x4f0 [cfg80211]
    [<0000000072cb507f>] nl80211_join_mesh+0x520/0x6b8 [cfg80211]
    [<0000000077e9bcf9>] genl_family_rcv_msg+0x374/0x680
    [<00000000b1bd936d>] genl_rcv_msg+0x78/0x108
    [<0000000022c53788>] netlink_rcv_skb+0xb0/0x1c0
    [<0000000011af8ec9>] genl_rcv+0x34/0x48
    [<0000000069e41f53>] netlink_unicast+0x268/0x2e8
    [<00000000a7517316>] netlink_sendmsg+0x320/0x4c0
    [<0000000069cba205>] ____sys_sendmsg+0x354/0x3a0
    [<00000000e06bab0f>] ___sys_sendmsg+0xd8/0x120
    [<0000000037340728>] __sys_sendmsg+0xa4/0xf8
    [<000000004fed9776>] __arm64_sys_sendmsg+0x44/0x58
    [<000000001c1e5647>] el0_svc_handler+0xd0/0x1a0

Fixes: c80d545da3f7 (mac80211: Let userspace enable and configure vendor specific path selection.)
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Link: https://lore.kernel.org/r/20200704135007.27292-1-repk@triplefau.lt
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 88dd5d218fe30..1a13715b9a591 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1964,6 +1964,7 @@ static int ieee80211_leave_mesh(struct wiphy *wiphy, struct net_device *dev)
 	ieee80211_stop_mesh(sdata);
 	mutex_lock(&sdata->local->mtx);
 	ieee80211_vif_release_channel(sdata);
+	kfree(sdata->u.mesh.ie);
 	mutex_unlock(&sdata->local->mtx);
 
 	return 0;
-- 
2.25.1



