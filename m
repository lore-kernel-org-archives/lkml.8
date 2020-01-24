Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D73EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723332087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864413;
	bh=XY215XUO9c8E57PJyQfFKHKFTaPma3O7mFZV3Xb8Z9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kOKaczaF64B0bIZLwDrGVdXyldSe/BzHGFuyfNJxjMgyAB5XHw32njkSdyFSqjYyv
	 0vPdZ+I5SN91ESDNFsyt0Z7YO7uCQ1X70sU5IOdw+ixh7h4p45w63MXIuoNQ3FJq0l
	 /mrkVzZWgHBoQSGnCd5ILhpUNd27Sv9Fgjd1vOCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390059AbgAXLNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:13:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:49782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389042AbgAXLN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:13:28 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9ECF2071A;
        Fri, 24 Jan 2020 11:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864407;
        bh=XY215XUO9c8E57PJyQfFKHKFTaPma3O7mFZV3Xb8Z9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fbXgazzjliWKFffF2D+PMuMMVRZjdLrgjLG+V5QBJdyxYxIAHv/X+EbVUYd5gqVb6
         WXHzRtWso9wgy7TBeRhBMCCttLH3/8up9AJgysAFfNKPz8C7W46YuZbjYVhdDLapxm
         4WaDk68wegYWiAqPEYNSM6mYLjZigINAL3cgU6NY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikita Danilov <nikita.danilov@aquantia.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 248/639] net: aquantia: fixed instack structure overflow
Date:   Fri, 24 Jan 2020 10:26:58 +0100
Message-Id: <20200124093117.825342615@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Russkikh <Igor.Russkikh@aquantia.com>

[ Upstream commit 8006e3730b6e900319411e35cee85b4513d298df ]

This is a real stack undercorruption found by kasan build.

The issue did no harm normally because it only overflowed
2 bytes after `bitary` array which on most architectures
were mapped into `err` local.

Fixes: bab6de8fd180 ("net: ethernet: aquantia: Atlantic A0 and B0 specific functions.")
Signed-off-by: Nikita Danilov <nikita.danilov@aquantia.com>
Signed-off-by: Igor Russkikh <igor.russkikh@aquantia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c | 4 ++--
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c
index 97addfa6f8956..dab5891b97145 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c
@@ -207,8 +207,8 @@ static int hw_atl_a0_hw_rss_set(struct aq_hw_s *self,
 	u32 i = 0U;
 	u32 num_rss_queues = max(1U, self->aq_nic_cfg->num_rss_queues);
 	int err = 0;
-	u16 bitary[(HW_ATL_A0_RSS_REDIRECTION_MAX *
-					HW_ATL_A0_RSS_REDIRECTION_BITS / 16U)];
+	u16 bitary[1 + (HW_ATL_A0_RSS_REDIRECTION_MAX *
+		   HW_ATL_A0_RSS_REDIRECTION_BITS / 16U)];
 
 	memset(bitary, 0, sizeof(bitary));
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
index 51cd1f98bcf07..c4f914a29c385 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
@@ -192,8 +192,8 @@ static int hw_atl_b0_hw_rss_set(struct aq_hw_s *self,
 	u32 i = 0U;
 	u32 num_rss_queues = max(1U, self->aq_nic_cfg->num_rss_queues);
 	int err = 0;
-	u16 bitary[(HW_ATL_B0_RSS_REDIRECTION_MAX *
-					HW_ATL_B0_RSS_REDIRECTION_BITS / 16U)];
+	u16 bitary[1 + (HW_ATL_B0_RSS_REDIRECTION_MAX *
+		   HW_ATL_B0_RSS_REDIRECTION_BITS / 16U)];
 
 	memset(bitary, 0, sizeof(bitary));
 
-- 
2.20.1



