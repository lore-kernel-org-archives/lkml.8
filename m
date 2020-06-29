Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44218C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 261272065D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593468187;
	bh=VKjYd9w/iLilRizjFkGuP8LDcAOj554owitDPp/Vwjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ltKQ5vW7V6hcCy0ifOb8IgDDo2CrNtg/06ieCFvcLyL/lXXQCaKKUltVKwJgSTPuq
	 T6XQY8c2/L2sxcQ2MvBw5ETwSOSunx8wVX5q3iNpYa8JlbxcaY8rrB4Up5KUgLMyOt
	 R4DGrjnXaDoxHxsg1NOeYsSBgU9BCkGmNMlU8lhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390375AbgF2WDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:03:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbgF2SfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F8842415D;
        Mon, 29 Jun 2020 15:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593443941;
        bh=VKjYd9w/iLilRizjFkGuP8LDcAOj554owitDPp/Vwjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vU1GwDk2lKucC+BicY1dkfua6xeeJUpChT4R2bY+gKsC7eFj6fcl+RthNeumKULvS
         38Jcir+fIq9ALQYaV3rp32qxT+Z+mbT7be3OUycUgnbyWi2/2B1Fupb7kwdaJ1Bijc
         u+FdXMYEy9T6Sku/S2SYfstBQwvxzY8YgKs76E50=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Lobakin <alobakin@pm.me>,
        Michal Kubecek <mkubecek@suse.cz>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.7 043/265] net: ethtool: add missing NETIF_F_GSO_FRAGLIST feature string
Date:   Mon, 29 Jun 2020 11:14:36 -0400
Message-Id: <20200629151818.2493727-44-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <alobakin@pm.me>

[ Upstream commit eddbf5d0204e550ee59de02bdc19fe90d4203dd6 ]

Commit 3b33583265ed ("net: Add fraglist GRO/GSO feature flags") missed
an entry for NETIF_F_GSO_FRAGLIST in netdev_features_strings array. As
a result, fraglist GSO feature is not shown in 'ethtool -k' output and
can't be toggled on/off.
The fix is trivial.

Fixes: 3b33583265ed ("net: Add fraglist GRO/GSO feature flags")
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
Reviewed-by: Michal Kubecek <mkubecek@suse.cz>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ethtool/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 7f7fff88c5d3e..aaecfc916a4db 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -44,6 +44,7 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
 	[NETIF_F_GSO_SCTP_BIT] =	 "tx-sctp-segmentation",
 	[NETIF_F_GSO_ESP_BIT] =		 "tx-esp-segmentation",
 	[NETIF_F_GSO_UDP_L4_BIT] =	 "tx-udp-segmentation",
+	[NETIF_F_GSO_FRAGLIST_BIT] =	 "tx-gso-list",
 
 	[NETIF_F_FCOE_CRC_BIT] =         "tx-checksum-fcoe-crc",
 	[NETIF_F_SCTP_CRC_BIT] =        "tx-checksum-sctp",
-- 
2.25.1

