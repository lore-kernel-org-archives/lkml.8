Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A479C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C846720678
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579866100;
	bh=6agRs+YRKKOS8R/DyaannaansL5ChLoutYtVdBZj7gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MfEAR9aBoy67MBCeiwuIQNZ5vOyNf8QxYiVzs7/wWqIIy7xLW/yf0iw7YJaxszG4c
	 x3mUzZROI01tWECFQKyTE32fvWLRflH1eE+5zVW10Tk50OH7ZOg/9bo1WgmpygH5mM
	 z3cqaIwhE0Od0yAyXv+Mfw9H8TxMBJ0Cvlp8PEVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392102AbgAXLlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:41:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:54792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390550AbgAXLRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:17:46 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A601322464;
        Fri, 24 Jan 2020 11:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864666;
        bh=6agRs+YRKKOS8R/DyaannaansL5ChLoutYtVdBZj7gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AxjTktiit9vmvI5o6Nzc3xzmhXYjAwMI5o98jpou01yLd71GEfobcOGMcGZDiwtd2
         BHHyQ7oluWiLk9TtrSUpP8+V6ocwnHuPMKGKcjzvHqjmIEdWStWvwV6m8hwPVs6NrQ
         1FUKOhVJjkuKLXMDNSJbQz9K0PNDG7NFvGW+N9As=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 308/639] net: hns3: fix for vport->bw_limit overflow problem
Date:   Fri, 24 Jan 2020 10:27:58 +0100
Message-Id: <20200124093125.517750014@linuxfoundation.org>
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

From: Yunsheng Lin <linyunsheng@huawei.com>

[ Upstream commit 2566f10676ba996b745e138f54f3e2f974311692 ]

When setting vport->bw_limit to hdev->tm_info.pg_info[0].bw_limit
in hclge_tm_vport_tc_info_update, vport->bw_limit can be as big as
HCLGE_ETHER_MAX_RATE (100000), which can not fit into u16 (65535).

So this patch fixes it by using u32 for vport->bw_limit.

Fixes: 848440544b41 ("net: hns3: Add support of TX Scheduler & Shaper to HNS3 driver")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 260b1e7796908..d14b7018fdf34 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -600,7 +600,7 @@ struct hclge_vport {
 	u16 alloc_rss_size;
 
 	u16 qs_offset;
-	u16 bw_limit;		/* VSI BW Limit (0 = disabled) */
+	u32 bw_limit;		/* VSI BW Limit (0 = disabled) */
 	u8  dwrr;
 
 	struct hclge_tx_vtag_cfg  txvlan_cfg;
-- 
2.20.1



