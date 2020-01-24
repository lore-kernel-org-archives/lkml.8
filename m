Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA67C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5632720663
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864021;
	bh=c6U/JIrK3Ekc7vaXVoG/6dCJxmh0ToY57l/T0xPPbgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bDgYransNdavKJylOHpwGvIozTjGZlzcBU+yaDVLT4noxUPCfLaVFgQygIOSwGu2N
	 6iwquQplYDhsQJcZwz1dsivwlsdjsjaL5oU6aLitjd8CKpNDt9Y9+iarfwRSa6bX8P
	 EFG33CKeJ5OXLx2sEaGuTAr/8tk7y1AaQP/HVPOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389380AbgAXLHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:07:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:41912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387790AbgAXLG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:06:56 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A274620663;
        Fri, 24 Jan 2020 11:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864016;
        bh=c6U/JIrK3Ekc7vaXVoG/6dCJxmh0ToY57l/T0xPPbgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q2pcgHUhe9E5H8hYumJn6Iph8pguJYtF5GzCMQD2gxet65icgmQrPj2LbOvAld+VE
         B2gjZ3ZYeaq+w2vkhThmQWgKhuzaH5XzR6R8Mqe/lGAy32aIQWw4rVjvDv0pL7UJCk
         tEWHxppT5QS32nbLhOF8KBqnyALa5Ih/ZxGFf8kU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huazhong Tan <tanhuazhong@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 140/639] net: hns3: fix wrong combined count returned by ethtool -l
Date:   Fri, 24 Jan 2020 10:25:10 +0100
Message-Id: <20200124093104.801679637@linuxfoundation.org>
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

From: Huazhong Tan <tanhuazhong@huawei.com>

[ Upstream commit c3b9c50d1567aa12be4448fe85b09626eba2499c ]

The current code returns the number of all queues that can be used and
the number of queues that have been allocated, which is incorrect.
What should be returned is the number of queues allocated for each enabled
TC and the number of queues that can be allocated.

This patch fixes it.

Fixes: 482d2e9c1cc7 ("net: hns3: add support to query tqps number")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index f8cc8d1f0b209..4b9f898a1620c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5922,18 +5922,17 @@ static u32 hclge_get_max_channels(struct hnae3_handle *handle)
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
 
-	return min_t(u32, hdev->rss_size_max * kinfo->num_tc, hdev->num_tqps);
+	return min_t(u32, hdev->rss_size_max,
+		     vport->alloc_tqps / kinfo->num_tc);
 }
 
 static void hclge_get_channels(struct hnae3_handle *handle,
 			       struct ethtool_channels *ch)
 {
-	struct hclge_vport *vport = hclge_get_vport(handle);
-
 	ch->max_combined = hclge_get_max_channels(handle);
 	ch->other_count = 1;
 	ch->max_other = 1;
-	ch->combined_count = vport->alloc_tqps;
+	ch->combined_count = handle->kinfo.rss_size;
 }
 
 static void hclge_get_tqps_and_rss_info(struct hnae3_handle *handle,
-- 
2.20.1



