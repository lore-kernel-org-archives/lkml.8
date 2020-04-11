Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB75C2BBFD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3E1216FD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586646629;
	bh=RrlhpunANxPIE9UFw2a1ywTz5q95Q+l+tT/okGgtOFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GPxRe9avIAvFytP6HN+97GA0N92JPLkBTIY3bXc2knE/nBmO4IxX+I8bSnxCmvMyZ
	 Fok2aUHaMNJRyp8c9C7PkjQ+DT0asPPONvmS7UrTG2j3eACfwHuBTQ7wP7QW+Y6Zk5
	 Mna4bYLliv4ZFQlYISOd/sLWSf4usM/11MD0H/1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgDKXK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbgDKXKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:10:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8C2E20787;
        Sat, 11 Apr 2020 23:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646625;
        bh=RrlhpunANxPIE9UFw2a1ywTz5q95Q+l+tT/okGgtOFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cG9SiPuxMfxMu9ChGimaxkED0QRT7LM6AURiIRcKRr/ihLPPStwxZUoS4QJ/5ZOLO
         /EOvRoJwvz3uGkznOXhBVv+jg5YqP+q7nupX4YrHQLhxqJ4MyBdznBZDNBY0UkJzMB
         ZuzfSYoZIxNuZLknTgeOo/8pGTxm9TM/uZKXJVD8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guangbin Huang <huangguangbin2@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 034/108] net: hns3: modify an unsuitable print when setting unknown duplex to fibre
Date:   Sat, 11 Apr 2020 19:08:29 -0400
Message-Id: <20200411230943.24951-34-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230943.24951-1-sashal@kernel.org>
References: <20200411230943.24951-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guangbin Huang <huangguangbin2@huawei.com>

[ Upstream commit 2d3db26d78805c9e06e26def0081c76e9bb0b7d6 ]

Currently, if device is in link down status and user uses
'ethtool -s' command to set speed but not specify duplex
mode, the duplex mode passed from ethtool to driver is
unknown value(255), and the fibre port will identify this
value as half duplex mode and print "only copper port
supports half duplex!". This message is confusing.

So for fibre port, only the setting duplex is half, prints
error and returns.

Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 52c9d204fe3d9..a1f62e079f15a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -737,7 +737,7 @@ static int hns3_check_ksettings_param(const struct net_device *netdev,
 	if (ops->get_media_type)
 		ops->get_media_type(handle, &media_type, &module_type);
 
-	if (cmd->base.duplex != DUPLEX_FULL &&
+	if (cmd->base.duplex == DUPLEX_HALF &&
 	    media_type != HNAE3_MEDIA_TYPE_COPPER) {
 		netdev_err(netdev,
 			   "only copper port supports half duplex!");
-- 
2.20.1

