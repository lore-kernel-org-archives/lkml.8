Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8630BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D12622228
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590159048;
	bh=EttFuyWUsVA2+0so7dutokKTLb7us68VFKlExgm5ag4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g6RSo2RnpAQsMno4AY+8uVOucHh12IZNyR05xlQstl8cD157Ttm75bYocPD97ixr/
	 yTsOyKd8WQpvxagyGQLOAt/b1RX5bseGsbbMGiZmhRezrNIgZiBhcz9KI8lvWcuvNT
	 8i5lKvgQ6ArtdPY8ODvmxrZmWYO1ZTuWmXnlSjd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbgEVOur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:50:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730789AbgEVOuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:50:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DAD522257;
        Fri, 22 May 2020 14:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590159044;
        bh=EttFuyWUsVA2+0so7dutokKTLb7us68VFKlExgm5ag4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TkBI0hfwRTwrp2FOBsZqCJAM5+ntnWo4MbvErzr0WbhmuXJ52XH8yz2vTs4KaVc4Z
         VUlrUjYLKPs0cBI1PP46TeOBsvz0rBmSyUz1O97/NZZ4ATvDKIkc9hZqfS9NeYoWKo
         HQrfkWiIH9T4XUaMdym6Gb5ncd0guMRGymrFWqiA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        syzbot+bb82cafc737c002d11ca@syzkaller.appspotmail.com,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 41/41] drivers: net: hamradio: Fix suspicious RCU usage warning in bpqether.c
Date:   Fri, 22 May 2020 10:49:58 -0400
Message-Id: <20200522144959.434379-41-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522144959.434379-1-sashal@kernel.org>
References: <20200522144959.434379-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

[ Upstream commit 95f59bf88bb75281cc626e283ecefdd5d5641427 ]

This patch fixes the following warning:
=============================
WARNING: suspicious RCU usage
5.7.0-rc5-next-20200514-syzkaller #0 Not tainted
-----------------------------
drivers/net/hamradio/bpqether.c:149 RCU-list traversed in non-reader section!!

Since rtnl lock is held, pass this cond in list_for_each_entry_rcu().

Reported-by: syzbot+bb82cafc737c002d11ca@syzkaller.appspotmail.com
Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hamradio/bpqether.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hamradio/bpqether.c b/drivers/net/hamradio/bpqether.c
index fbea6f232819..e2ad3c2e8df5 100644
--- a/drivers/net/hamradio/bpqether.c
+++ b/drivers/net/hamradio/bpqether.c
@@ -127,7 +127,8 @@ static inline struct net_device *bpq_get_ax25_dev(struct net_device *dev)
 {
 	struct bpqdev *bpq;
 
-	list_for_each_entry_rcu(bpq, &bpq_devices, bpq_list) {
+	list_for_each_entry_rcu(bpq, &bpq_devices, bpq_list,
+				lockdep_rtnl_is_held()) {
 		if (bpq->ethdev == dev)
 			return bpq->axdev;
 	}
-- 
2.25.1

