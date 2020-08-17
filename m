Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D521C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A8E20758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597687798;
	bh=+4eAXHHgB9J1wHKsIJauvFc2fUEKfWI8IAdNFOnR+lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VhVRLFGB7Y9I28SpbdDRQiMs7Kh/LN3CvjJDZR27FmR+TZjjyW1la09qLS4eq0L1k
	 tOoXHCTFk/jMo5yxdIgmI0pbkBHAsA05Bnyf+sZNQIju80tKzSFD+e45QjGBidmN69
	 1voyy9+kBTtNemMGxNQTsIWwxOA96fyQdm3obruA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389939AbgHQSJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:09:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388427AbgHQQHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:07:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 983B520825;
        Mon, 17 Aug 2020 16:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680473;
        bh=+4eAXHHgB9J1wHKsIJauvFc2fUEKfWI8IAdNFOnR+lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lL0f6XNHiOHYRCl4/Pht1Hdj4SB7DQ+g5tG28EfAiHg898Auy5XHphkuWGzIoJxWy
         WaZJjNsGHLRIrB3mxTLriKi3rD5Z9FZIcNHldz9TOZQ7LUbLjk/0/RtVE/M0paO4h1
         QZIbu8CbVzlQoMHfJtqvfjRjRkhDKMUkyG47Y3TM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David VomLehn <vomlehn@texas.net>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 201/270] net: ethernet: aquantia: Fix wrong return value
Date:   Mon, 17 Aug 2020 17:16:42 +0200
Message-Id: <20200817143805.793591651@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

[ Upstream commit 0470a48880f8bc42ce26962b79c7b802c5a695ec ]

In function hw_atl_a0_hw_multicast_list_set(), when an invalid
request is encountered, a negative error code should be returned.

Fixes: bab6de8fd180b ("net: ethernet: aquantia: Atlantic A0 and B0 specific functions")
Cc: David VomLehn <vomlehn@texas.net>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c
index 359a4d3871851..9a0db70c11438 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c
@@ -776,7 +776,7 @@ static int hw_atl_a0_hw_multicast_list_set(struct aq_hw_s *self,
 	int err = 0;
 
 	if (count > (HW_ATL_A0_MAC_MAX - HW_ATL_A0_MAC_MIN)) {
-		err = EBADRQC;
+		err = -EBADRQC;
 		goto err_exit;
 	}
 	for (self->aq_nic_cfg->mc_list_count = 0U;
-- 
2.25.1



