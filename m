Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F16C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C0320684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199364;
	bh=0+8Nn4d6fkT38bReOZ0tZD+AXtiad866uuMNsOV/iTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E+feBjJjwKdKSBQtMBJZMxHlM9wEmT94C9zMg/MWIfvnLZtTCfoR4Fm26hfADH68E
	 RLFePXRkG05mrCbBzu802wiLxEp2FnTDrgQSXiXFNY+ON0SB9RjZow8ZYyq5lM6ty+
	 mXYUayIEx7xGthh2S/37NPMRF6MJJ9Be3YzDBuI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392181AbgAPRZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:25:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:33356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392077AbgAPRZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:25:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8398246DA;
        Thu, 16 Jan 2020 17:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195533;
        bh=0+8Nn4d6fkT38bReOZ0tZD+AXtiad866uuMNsOV/iTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1MaOyooxPI8WciK4u2FSZIipXVH60YHeUryIKo2thDNtZ5cEmy+Xe4K43aPkfUSQ5
         b0VPYCxlRxBfX6hUK3WpWLD6RhX35ccHhkL4ZJ86Fl8kWJtoduyTu62oQ7wUzJik0Q
         lkVmh7seJuy2CWk811GkIcgPs5e9Kxt2P28fJF5U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Igor Russkikh <Igor.Russkikh@aquantia.com>,
        Nikita Danilov <nikita.danilov@aquantia.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 128/371] net: aquantia: fixed instack structure overflow
Date:   Thu, 16 Jan 2020 12:20:00 -0500
Message-Id: <20200116172403.18149-71-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index b0abd187cead..b83ee74d2839 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c
@@ -182,8 +182,8 @@ static int hw_atl_a0_hw_rss_set(struct aq_hw_s *self,
 	u32 i = 0U;
 	u32 num_rss_queues = max(1U, self->aq_nic_cfg->num_rss_queues);
 	int err = 0;
-	u16 bitary[(HW_ATL_A0_RSS_REDIRECTION_MAX *
-					HW_ATL_A0_RSS_REDIRECTION_BITS / 16U)];
+	u16 bitary[1 + (HW_ATL_A0_RSS_REDIRECTION_MAX *
+		   HW_ATL_A0_RSS_REDIRECTION_BITS / 16U)];
 
 	memset(bitary, 0, sizeof(bitary));
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
index 236325f48ec9..1c1bb074f664 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
@@ -183,8 +183,8 @@ static int hw_atl_b0_hw_rss_set(struct aq_hw_s *self,
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

