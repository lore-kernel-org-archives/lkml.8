Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B27C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 734342063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593456027;
	bh=Fu4hmcKPJbjvLpgyOOO6j+b6QwUhVvN5cGmQQ/V6jnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MJAUzcOur87RUF2r4EpxtrFmIIGwPbymbDvYjIZWAjRcK7FylZDaS064MwkdIn1By
	 FW+OlgfrHzxzV+V3h0fQosuBmayhbn6qqMf5GnEuRYiDZTFrCPL2VhlWo8Ja/uQ2Oe
	 pYNxlwSV9J+927j1UPhNQKdtehPqSspHsr4WWA5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgF2SkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgF2SkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BF1D23F36;
        Mon, 29 Jun 2020 15:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593443913;
        bh=Fu4hmcKPJbjvLpgyOOO6j+b6QwUhVvN5cGmQQ/V6jnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aDbix2nrhX7+q+dyahnlQUTqkSsj6HBq1Thjy9WajrE1XEy25uojFesCS3opDL6KC
         4ZOiLxBGvGJ2bkBu20wcBRPyeAkVZmpFKMc720f07KZAvnSy2SsOn0mRXBmxlJJ9/T
         lvdfkyR8ohMP+1bC7eWzh0VLDAJiD1wxcljAzTAk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Lobakin <alobakin@pm.me>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.7 013/265] net: ethtool: add missing string for NETIF_F_GSO_TUNNEL_REMCSUM
Date:   Mon, 29 Jun 2020 11:14:06 -0400
Message-Id: <20200629151818.2493727-14-sashal@kernel.org>
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

[ Upstream commit b4730ae6a443afe611afb4fb651c885c51003c15 ]

Commit e585f2363637 ("udp: Changes to udp_offload to support remote
checksum offload") added new GSO type and a corresponding netdev
feature, but missed Ethtool's 'netdev_features_strings' table.
Give it a name so it will be exposed to userspace and become available
for manual configuration.

v3:
 - decouple from "netdev_features_strings[] cleanup" series;
 - no functional changes.

v2:
 - don't split the "Fixes:" tag across lines;
 - no functional changes.

Fixes: e585f2363637 ("udp: Changes to udp_offload to support remote checksum offload")
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ethtool/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 423e640e3876d..7f7fff88c5d3e 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -40,6 +40,7 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
 	[NETIF_F_GSO_UDP_TUNNEL_BIT] =	 "tx-udp_tnl-segmentation",
 	[NETIF_F_GSO_UDP_TUNNEL_CSUM_BIT] = "tx-udp_tnl-csum-segmentation",
 	[NETIF_F_GSO_PARTIAL_BIT] =	 "tx-gso-partial",
+	[NETIF_F_GSO_TUNNEL_REMCSUM_BIT] = "tx-tunnel-remcsum-segmentation",
 	[NETIF_F_GSO_SCTP_BIT] =	 "tx-sctp-segmentation",
 	[NETIF_F_GSO_ESP_BIT] =		 "tx-esp-segmentation",
 	[NETIF_F_GSO_UDP_L4_BIT] =	 "tx-udp-segmentation",
-- 
2.25.1

