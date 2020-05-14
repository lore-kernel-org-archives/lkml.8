Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADB6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5659420675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589483525;
	bh=nkDPHy95yzo1/gfV8EpO6saVkkaXsNq4bM8J4dTa9F0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0HBt7aMGHiKjQ5ccG8wfi9vChHlO7/P0UDoM03y0GjBEisXBZk/JRQRDeA2YsW88O
	 /N55e1wSe0bSya8p4EfMAWr/mcRSA71T/ppOBg4wGeFItQnTyfuDLAgn8bdp1lKSCB
	 v7UTDDJXzV4A9GtAp1uqVUafpTC161nMWjO14EKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgENTMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:12:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbgENSwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:52:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5108320727;
        Thu, 14 May 2020 18:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482327;
        bh=nkDPHy95yzo1/gfV8EpO6saVkkaXsNq4bM8J4dTa9F0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VAHsFQo3ACGJrf3CJGUvdHurzaBoDTrqi3u6TxKAV3/tGSGc7MY4bGoWCHMxSfACB
         e5Kyjdj0Hkw2AFF0FYBgQWO0z7sbvQEMTFEow3SPq7Ux3/B0AhT6lBw4QZOKe03lNc
         mlXmzIQFS0SE87TcFsVHltifvkB1pF7v6JBxihVA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Richard Clark <richard.xnu.clark@gmail.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 14/62] aquantia: Fix the media type of AQC100 ethernet controller in the driver
Date:   Thu, 14 May 2020 14:50:59 -0400
Message-Id: <20200514185147.19716-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185147.19716-1-sashal@kernel.org>
References: <20200514185147.19716-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Clark <richard.xnu.clark@gmail.com>

[ Upstream commit 6de556c31061e3b9c36546ffaaac5fdb679a2f14 ]

The Aquantia AQC100 controller enables a SFP+ port, so the driver should
configure the media type as '_TYPE_FIBRE' instead of '_TYPE_TP'.

Signed-off-by: Richard Clark <richard.xnu.clark@gmail.com>
Cc: Igor Russkikh <irusskikh@marvell.com>
Cc: "David S. Miller" <davem@davemloft.net>
Acked-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
index 78b6f32487565..e0625c67eed33 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -56,7 +56,7 @@ static const struct aq_board_revision_s hw_atl_boards[] = {
 	{ AQ_DEVICE_ID_D108,	AQ_HWREV_2,	&hw_atl_ops_b0, &hw_atl_b0_caps_aqc108, },
 	{ AQ_DEVICE_ID_D109,	AQ_HWREV_2,	&hw_atl_ops_b0, &hw_atl_b0_caps_aqc109, },
 
-	{ AQ_DEVICE_ID_AQC100,	AQ_HWREV_ANY,	&hw_atl_ops_b1, &hw_atl_b0_caps_aqc107, },
+	{ AQ_DEVICE_ID_AQC100,	AQ_HWREV_ANY,	&hw_atl_ops_b1, &hw_atl_b0_caps_aqc100, },
 	{ AQ_DEVICE_ID_AQC107,	AQ_HWREV_ANY,	&hw_atl_ops_b1, &hw_atl_b0_caps_aqc107, },
 	{ AQ_DEVICE_ID_AQC108,	AQ_HWREV_ANY,	&hw_atl_ops_b1, &hw_atl_b0_caps_aqc108, },
 	{ AQ_DEVICE_ID_AQC109,	AQ_HWREV_ANY,	&hw_atl_ops_b1, &hw_atl_b0_caps_aqc109, },
-- 
2.20.1

