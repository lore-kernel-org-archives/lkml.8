Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52068C4332D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A41F20409
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584565574;
	bh=XSZzH2serizN/OLoNX6Yx4oQOhWEP35/FLsLbKITsSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=so83i6osmZJN3TrwNSlhiL2Scrm2CWKWlSDP6eTagyi6GsQ3eATeyW7SNqW/JT0Mf
	 ViQAAKEy+Td6Wo+6RK2gIgISslBUp2sbXXiHr/cSjGrm4+sVQ7jwa7JWPKrBtApaWo
	 7W5IPCTLagfJMLXrvBe8D6qd5APyA4YrdmTyXhuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgCRUyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbgCRUyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:54:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3443208E0;
        Wed, 18 Mar 2020 20:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584564876;
        bh=XSZzH2serizN/OLoNX6Yx4oQOhWEP35/FLsLbKITsSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GCNiay+x7dlipO8oWF4Rbg7gosuv+QhcFDkh2DP2w20Jaeem3t7EaedeOusfOE4Go
         K3Pmn4P1IISyuHV+RbDix8arkwHme/Jt5phK7WQaBF1xScj6omPswJOfYpEVVulzSC
         Bdf/RfQCyGpcEFU7RpEBAIWwISnPbeSwTbYESDRI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 47/73] ipvlan: do not use cond_resched_rcu() in ipvlan_process_multicast()
Date:   Wed, 18 Mar 2020 16:53:11 -0400
Message-Id: <20200318205337.16279-47-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318205337.16279-1-sashal@kernel.org>
References: <20200318205337.16279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit afe207d80a61e4d6e7cfa0611a4af46d0ba95628 ]

Commit e18b353f102e ("ipvlan: add cond_resched_rcu() while
processing muticast backlog") added a cond_resched_rcu() in a loop
using rcu protection to iterate over slaves.

This is breaking rcu rules, so lets instead use cond_resched()
at a point we can reschedule

Fixes: e18b353f102e ("ipvlan: add cond_resched_rcu() while processing muticast backlog")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Mahesh Bandewar <maheshb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ipvlan/ipvlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 5759e91dec710..8801d093135c3 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -277,7 +277,6 @@ void ipvlan_process_multicast(struct work_struct *work)
 			}
 			ipvlan_count_rx(ipvlan, len, ret == NET_RX_SUCCESS, true);
 			local_bh_enable();
-			cond_resched_rcu();
 		}
 		rcu_read_unlock();
 
@@ -294,6 +293,7 @@ void ipvlan_process_multicast(struct work_struct *work)
 		}
 		if (dev)
 			dev_put(dev);
+		cond_resched();
 	}
 }
 
-- 
2.20.1

